//  MRRecommendViewController.m
//  MR_BSBDJ
//
//  Created by SinObjectC on 16/6/1.
//  Copyright © 2016年 SinObjectC. All rights reserved.
//

#import "MRRecommendViewController.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "MRRecommendCategory.h"
#import "MRRecommendCategoryCell.h"
#import "MRRecommendUserCell.h"
#import "MRRecommendUser.h"
#import "MJRefresh.h"

// 选中的分类
#define MRSelectedCategory self.categories[self.categoryTableView.indexPathForSelectedRow.row]

@interface MRRecommendViewController ()<UITableViewDelegate, UITableViewDataSource>

/** 左边的类别数据 */
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;

/** 右边的用户数据 */
@property (weak, nonatomic) IBOutlet UITableView *userTableView;

/** 分类标签数组 */
@property(nonatomic, strong)NSArray *categories;

/** 用户数据 */
@property(nonatomic, strong)NSArray *users;

/** 网络请求管理 */
@property(nonatomic, strong)AFHTTPSessionManager *manager;

@end


@implementation MRRecommendViewController

// 重用标识字符
static NSString * const categoryCellID = @"categoryCell";
static NSString * const userCellID = @"userCell";

- (AFHTTPSessionManager *)manager {
    
    if(!_manager) {
        
        _manager = [AFHTTPSessionManager manager];
    }
    
    return _manager;
}

// 懒加载分类标签数组
- (NSArray *)categories {
    
    if(!_categories) {
        
        _categories = [NSArray array];
        
    }
    
    return _categories;
}

- (NSArray *)users {
    
    if(!_users) {
        
        _users = [NSArray array];
        
    }
    
    return _users;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
   
    // 初始化设置
    [self setup];

    // 添加刷新控件
    [self setupRefresh];
    
    // 加载左侧的类别数据
    [self loadCategories];
}


/**
 *	@brief	初始化设置
 */
- (void)setup {

    // 设置标题
    self.title = @"推荐关注";
    
    // 设置背景色
    self.view.backgroundColor = MRGlobalBg;
    
    // 设置inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = self.categoryTableView.contentInset;
    self.userTableView.rowHeight = 60;
    
    // 取消UITableViewCell的默认分割线
    self.categoryTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.userTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 注册cell
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([MRRecommendCategoryCell class])  bundle:nil] forCellReuseIdentifier:categoryCellID];
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([MRRecommendUserCell class])  bundle:nil] forCellReuseIdentifier:userCellID];
    
}

/**
 *	@brief	添加下拉刷新
 */
- (void)setupRefresh {

    self.userTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUser)];
    
    self.userTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];

}


/**
 *	@brief	加载左侧的类别数据
 */
- (void)loadCategories {
    
    // 设置参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    
    // 显示指示器
    [SVProgressHUD show];
    
    // 发送请求
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [SVProgressHUD dismiss];
    
        // 服务器返回数据
        NSArray *array = responseObject[@"list"];
        
        self.categories = [self categoriesWithArray:array];
        
        // 刷新表格
        [self.categoryTableView reloadData];
        
        // 获取第一行的用户数据
        [self tableView:self.categoryTableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        
        // 默认选中第一行
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        // 显示失败信息
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
        
        [self.userTableView.mj_header endRefreshing];
        
        [self.userTableView.mj_footer endRefreshing];
    }];

}


/**
 *	@brief	加载右侧用户数据
 */
- (void)loadUsersWithCategoryIndex {

    MRRecommendCategory *category = MRSelectedCategory;
    
    // 判断是否请求过数据
    if(category.users.count) { // count不为0, 说明有数据
        
        // 显示曾经的数据
        [self.userTableView reloadData];

    }else {
        
        // 进入下拉刷新状态
        [self.userTableView.mj_header beginRefreshing];
        
    }
}


/**
 *	@brief	上拉刷新
 */
- (void)loadNewUser {

    MRRecommendCategory *category = MRSelectedCategory;
    
    // 设置第一次请求页数为1
    category.currentPage = 1;
    
    // 先刷新列表不让显示在上一次的浏览上
    [self.userTableView reloadData];
    
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        
        params[@"a"] = @"list";
        params[@"c"] = @"subscribe";
        params[@"category_id"] = @(category.id);
        params[@"page"] = @(category.currentPage);
        
        // 显示指示器
        [SVProgressHUD show];
        
        // 获取用户数据
        [self.manager GET:API parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            // 关闭指示器
            [SVProgressHUD dismiss];
            
            // 删除所有旧数据数据
            [category.users removeAllObjects];
            
            // 将对应类别的用户添加给对应类别
            [category.users addObjectsFromArray:[self usersWithArray:responseObject[@"list"]]];
            category.total = [responseObject[@"total"] integerValue];
            
            // 刷新右边的表格
            [self.userTableView reloadData];
            
            // 结束刷新
            [self.userTableView.mj_header endRefreshing];
            
            // 检测状态
            [self checkFooterState];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            [SVProgressHUD showErrorWithStatus:@"用户信息加载失败!"];
            
            [self.userTableView.mj_header endRefreshing];
            
            [self.userTableView.mj_footer endRefreshing];
        }];
        
    });
}

/**
 *	@brief	上拉加载更多用户数据
 */
- (void)loadMoreUsers {
    
    // 先刷新列表不让显示在上一次的浏览上
    [self.userTableView reloadData];
    
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{

        // 获取选中的分类
        MRRecommendCategory *category = MRSelectedCategory;
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"list";
        params[@"c"] = @"subscribe";
        params[@"category_id"] = @(category.id);
        params[@"page"] = @(++category.currentPage);
        
        // 显示指示器
        [SVProgressHUD show];
        
        // 获取用户数据
        [self.manager GET:API parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            // 关闭指示器
            [SVProgressHUD dismiss];
            
            // 将对应类别的用户添加给对应类别
            [category.users addObjectsFromArray:[self usersWithArray:responseObject[@"list"]]];
            
            // 刷新右边的表格
            [self.userTableView reloadData];
            
            // 检测状态
            [self checkFooterState];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            [SVProgressHUD showErrorWithStatus:@"用户信息加载失败!"];
            
            [self.userTableView.mj_header endRefreshing];
            
            [self.userTableView.mj_footer endRefreshing];
        }];
    });
}


/**
 *	@brief	时刻检测footer状态
 */
- (void)checkFooterState {
    
    MRRecommendCategory *category = MRSelectedCategory;
    
    if(category.users.count == category.total) {    // 全部加载完成
        
        // 提示没有更多数据
        [self.userTableView.mj_footer endRefreshingWithNoMoreData];
    }else {
        
        [self.userTableView.mj_footer endRefreshing];
    }
}
/**
 *	@brief	将数组模型转换成分类模型数组
 */
- (NSArray *)categoriesWithArray:(NSArray *)array {

    NSMutableArray *arr = [NSMutableArray array];
    
    for (int i = 0; i < array.count; i++) {
        
        MRRecommendCategory *category = [MRRecommendCategory categoryWithDic:array[i]];
        
        [arr addObject:category];
    }
    
    return arr;
}

/**
 *	@brief	将数组模型转换成用户模型数组
 */
- (NSArray *)usersWithArray:(NSArray *)array {
    
    NSMutableArray *arr = [NSMutableArray array];
    
    for (int i = 0; i < array.count; i++) {
        
        MRRecommendUser *user = [MRRecommendUser userWithDic:array[i]];
        
        [arr addObject:user];
    }
    
    return arr;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(tableView == self.categoryTableView) {   // 左边的类别表格
    
        return self.categories.count;
        
    }else {     // 右边的用户表格

        if(self.categories.count == 0) {
            
            return 0;
            
        }else {

            NSInteger count = [MRSelectedCategory users].count;
            
            // 每次刷新右边数据时，都控制footer显示或者隐藏
            self.userTableView.mj_footer.hidden = (count == 0);

            [self checkFooterState];
                
            return count;
            
        }
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(tableView == self.categoryTableView) {
    
        MRRecommendCategoryCell *categoryCell = [tableView dequeueReusableCellWithIdentifier:categoryCellID];
    
        // 设置数据
        categoryCell.category = self.categories[indexPath.row];
        
        return categoryCell;
        
    }else {
        
        MRRecommendUserCell *userCell = [tableView dequeueReusableCellWithIdentifier:userCellID];

        MRRecommendCategory *c = MRSelectedCategory;

        // 设置用户数据
        userCell.user = c.users[indexPath.row];
        
        return userCell;
    }
}


#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 结束刷新
    [self.userTableView.mj_footer endRefreshing];
    
    if(tableView == self.categoryTableView) {
    
        // 发送请求给服务器，加载右侧的用户数据
        [self loadUsersWithCategoryIndex];

    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
