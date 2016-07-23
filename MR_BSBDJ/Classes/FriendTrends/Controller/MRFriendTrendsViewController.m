//
//  MRFriendTrendsViewController.m
//  MR_BSBDJ
//
//  Created by SinObjectC on 16/5/29.
//  Copyright © 2016年 SinObjectC. All rights reserved.
//

#import "MRFriendTrendsViewController.h"
#import "MRRecommendViewController.h"
#import "MRLoginViewController.h"

@interface MRFriendTrendsViewController ()

@end

@implementation MRFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置背景颜色
    self.view.backgroundColor = MRGlobalBg;
    
    [self setUpNav];

}


// 初始化导航栏
- (void)setUpNav {
    
    // 设置导航栏标题
    self.navigationItem.title = @"我的关注";
    
    //设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithButtonImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(friendClick)];
}


// 点击头像Item 推荐关注
- (void)friendClick {
    
    MRRecommendViewController *recommendVc = [[MRRecommendViewController alloc] init];
    
    [self.navigationController pushViewController:recommendVc animated:YES];
    
}


/**
 *  立即登录
 */
- (IBAction)loginClick:(UIButton *)sender {
    
    MRLoginViewController *loginVc = [[MRLoginViewController alloc] init];
    loginVc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:loginVc animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
