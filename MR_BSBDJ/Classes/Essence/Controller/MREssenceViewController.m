//
//  MREssenceViewController.m
//  MR_BSBDJ
//
//  Created by SinObjectC on 16/5/29.
//  Copyright © 2016年 SinObjectC. All rights reserved.
//

#import "MREssenceViewController.h"
#import "MRNavigationController.h"
#import "MRTopicViewController.h"
#import "MRRecommendTagsViewController.h"

#define scrollViewInsetHeight self.view.mr_height - 100 - self.tabBarController.tabBar.mr_height

@interface MREssenceViewController () <UIScrollViewDelegate>

/**
 *  标题标签
 */
@property (nonatomic, weak) UIView *titleView;

/**
 *  选中按钮
 */
@property (nonatomic, weak) UIButton *selectedBtn;

/**
 *  指示器
 */
@property (nonatomic, weak) UIView *indicatorView;

/**
 *  contentView
 */
@property (nonatomic, weak) UIScrollView *contentView;

@end

@implementation MREssenceViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // 设置背景颜色
    self.view.backgroundColor = MRGlobalBg;
    
    // 初始化导航栏
    [self setUpNav];
    
    // 添加子控制器
    [self addChildVcs];
    
    // 初始化内容视图
    [self setContentView];
    
    // 初始顶部标签栏
    [self setUpTitles];
}


/**
 *  初始顶部标签栏
 */
- (void)setUpTitles
{
    // 标签栏整体
    UIView *titleView = [[UIView alloc] init];
    titleView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    titleView.mr_y = 64;
    titleView.mr_width = self.view.mr_width;
    titleView.mr_height = 36;
    [self.view addSubview:titleView];
    self.titleView = titleView;
    
    // 底部的红色指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.mr_height = 2;
    indicatorView.mr_y = titleView.mr_height - indicatorView.mr_height;
    [titleView addSubview:indicatorView];
    self.indicatorView = indicatorView;
    
    // 内部子标签
    NSArray *titles = @[@"图片", @"全部", @"视频", @"声音", @"段子"];
    NSInteger count = titles.count;
    CGFloat width = self.view.mr_width / count;
    CGFloat height = titleView.mr_height - 2;
    
    for (NSInteger i = 0; i < count; i++) {
        
        UIButton *button = [[UIButton alloc] init];
        button.mr_x = i * width;
        button.mr_width = width;
        button.mr_height = height;
        
        button.tag = i;
        
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [button setTitle:titles[i] forState:UIControlStateNormal];
//        [button layoutIfNeeded];    // 强制布局(强制更新子控件的frame)
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [titleView addSubview:button];
        
        // 默认选中第一个按钮
        if(i == 0) {
            button.enabled = NO;
            self.selectedBtn = button;
            
            [button.titleLabel sizeToFit]; // 让按钮根据文字内容设置尺寸
            self.indicatorView.mr_width = button.titleLabel.mr_width;
            self.indicatorView.mr_centerX = button.mr_centerX;
        }
    }
}


/**
 *  初始化内容视图
 */
- (void)setContentView {
    
    // 取消自动设置UIScrollView的contentInset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.frame = self.view.bounds;
    contentView.delegate = self;
    contentView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.2];
    contentView.pagingEnabled = YES;
    contentView.bounces = NO;
    contentView.showsHorizontalScrollIndicator = NO;
    contentView.contentSize = CGSizeMake(5 * self.view.mr_width, scrollViewInsetHeight);
    [self.view addSubview:contentView];
    self.contentView = contentView;
    
    [self scrollViewDidEndScrollingAnimation:contentView];
}


/**
 *  添加子控制器
 */
- (void)addChildVcs {
    
    // 图片
    MRTopicViewController *pictureVc = [[MRTopicViewController alloc] init];
    pictureVc.cellType = MRTopicCellTypePicture;
    [self addChildViewController:pictureVc];
    
    // 全部
    MRTopicViewController *allVc = [[MRTopicViewController alloc] init];
    allVc.cellType = MRTopicCellTypeAll;
    [self addChildViewController:allVc];
    
    // 视频
    MRTopicViewController *videoVc = [[MRTopicViewController alloc] init];
    videoVc.cellType = MRTopicCellTypeVideo;
    [self addChildViewController:videoVc];
    
    // 声音
    MRTopicViewController *voiceVc = [[MRTopicViewController alloc] init];
    voiceVc.cellType = MRTopicCellTypeVoice;
    [self addChildViewController:voiceVc];
    
    // 段子
    MRTopicViewController *satinVc = [[MRTopicViewController alloc] init];
    satinVc.cellType = MRTopicCellTypeSatin;
    [self addChildViewController:satinVc];
}


// 选中按钮的点击事件
- (void)titleClick:(UIButton *)button {
    
    NSInteger index = button.tag;
    
    // 修改选中按钮状态
    self.selectedBtn.enabled = YES;
    button.enabled = NO;
    self.selectedBtn = button;
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.indicatorView.mr_width = button.titleLabel.mr_width;
        self.indicatorView.mr_centerX = button.mr_centerX;
    
    }];
    
    // 滚动
    CGPoint offSet = self.contentView.contentOffset;
    offSet.x = index * self.contentView.mr_width;
    
    // 只有当scrollView偏移量前后不同的时候才会回调scrollViewDidEndScrollingAnimation方法,若两次的偏移量相同,则不会回调
    [self.contentView setContentOffset:offSet animated:YES];
}


/**
 *  初始化导航栏
 */
- (void)setUpNav {
    
    // 设置导航栏标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    //设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithButtonImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
}


- (void)tagClick {
    
    MRRecommendTagsViewController *tagVc = [[MRRecommendTagsViewController alloc] init];
    [self.navigationController pushViewController:tagVc animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - <UIScrollViewDelegate>

// 当每次scrollView切换的时候就会调用
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    CGFloat width = scrollView.mr_width;
    
    // 计算下标
    NSInteger index = scrollView.contentOffset.x / width;
    
    // 拿到对应下标的控制器
    UITableViewController *willShowVc = self.childViewControllers[index];
    
    if([willShowVc isViewLoaded]) { // 如果已经显示, 直接返回
        return;
    }
    
    willShowVc.view.mr_x = index * width;
    willShowVc.view.mr_y = 0;   // 设置控制器view的y值为0, 控制器view的默认y为20(状态栏高度)
    willShowVc.view.mr_height = self.view.mr_height;

    [scrollView addSubview:willShowVc.view];
}


// 当手指拖动scrollView滑动的时候调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [self scrollViewDidEndScrollingAnimation:_contentView];
    
    CGFloat width = scrollView.mr_width;
    
    // 计算下标
    NSInteger index = scrollView.contentOffset.x / width;
    
    UIButton *btn = self.titleView.subviews[index + 1];
    
    [self titleClick:btn];
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
