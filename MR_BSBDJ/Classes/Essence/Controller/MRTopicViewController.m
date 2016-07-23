//
//  MRtopicViewController.m
//  MR_BSBDJ
//
//  Created by Andrew554 on 16/7/15.
//  Copyright © 2016年 SinObjectC. All rights reserved.
//


#import <SDWebImage/UIImageView+WebCache.h>
#import "MRtopicViewController.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import "MRTopicCell.h"
#import <MJRefresh.h>
#import "MRTopic.h"

@interface MRTopicViewController ()

/**
 *  段子
 */
@property (nonatomic, strong) NSMutableArray *topics;

/**
 *  页码
 */
@property (nonatomic, assign) NSInteger page;

/**
 * maxtime
 */
@property (nonatomic, copy) NSString *maxtime;

/**
 *  记录上一次的网络请求参数
 */
@property (nonatomic, strong) NSMutableDictionary *params;

@end

@implementation MRTopicViewController

static NSString * const cellID = @"topicCell";

- (NSMutableArray *)topics {
    
    if(!_topics) {
        
        _topics = [NSMutableArray array];
        
    }
    
    return _topics;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // 初始化表格
    [self setupTable];
    
    // 添加刷新控件
    [self setupRefresh];
    
}


/**
 * 初始化表格
 */
- (void)setupTable {
    
    // 设置表格的内边距
    CGFloat top = MRTitleViewH + MRTitleViewY;
    CGFloat bottom = self.tabBarController.tabBar.mr_height;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    
    // 设置tableView滚动条的内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    // 其他
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    // 注册Cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MRTopicCell class]) bundle:nil] forCellReuseIdentifier:cellID];
}


/**
 * 添加刷新控件
 */
- (void)setupRefresh {
    
    // 下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    
    // 下拉刷新控件自动改变透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
    // 上拉刷新
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
    
    [self.tableView.mj_header beginRefreshing];
}


#pragma mark - 数据处理
/**
 * 加载新的帖子数据
 */
- (void)loadNewTopics {
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(self.cellType);
    self.params = params;
    
    // 发送请求
    [[AFHTTPSessionManager manager] GET:API parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        
        if(self.params != params) return;
        
        // 储存maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        // 字典 -> 模型
        self.topics = [MRTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新
        [self.tableView.mj_header endRefreshing];
        
        // 页码
        self.page++;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        MRLog(@"%@", error);
        
        // 结束刷新
        [self.tableView.mj_header endRefreshing];
        
    }];
}

/**
 * 加载更多的帖子数据
 */
- (void)loadMoreTopics
{
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"data_id"] = @(self.cellType);
    params[@"maxtime"] = self.maxtime;
    params[@"page"] = @(self.page);
    self.params = params;
    
    // 发送请求
    [[AFHTTPSessionManager manager] GET:API parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        
        if(self.params != params) return;
        
        // 储存maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        // 字典 -> 模型
        NSArray *topics = [MRTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.topics addObjectsFromArray:topics];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新
        [self.tableView.mj_footer endRefreshing];
        
        // 页码
        self.page++;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        MRLog(@"%@", error);
        
        // 结束刷新
        [self.tableView.mj_footer endRefreshing];
    }];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    self.tableView.mj_footer.hidden = (self.topics.count == 0);
    
    return self.topics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MRTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    MRTopic *topic = self.topics[indexPath.row];
    
    cell.topic = topic;
    
    return cell;
}


#pragma mark - Table View Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 取出段子模型
    MRTopic *topic = self.topics[indexPath.row];
    
    // 返回模型cell高度
    return topic.cellHeight;
}


//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    // 取消选中
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    
//}

@end
