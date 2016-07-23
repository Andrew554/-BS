//
//  MRTabBarController.m
//  MR_BSBDJ
//
//  Created by SinObjectC on 16/5/29.
//  Copyright © 2016年 SinObjectC. All rights reserved.
//

#import "MRTabBarController.h"
#import "MREssenceViewController.h"
#import "MRNewViewController.h"
#import "MRFriendTrendsViewController.h"
#import "MRMeViewController.h"
#import "MRNavigationController.h"
#import "MRTabBar.h"

@interface MRTabBarController ()

@end

@implementation MRTabBarController

- (void)viewDidLoad {
    
    [super viewDidLoad];
   
    // 添加子控制器
    [self addChildController:[[MREssenceViewController alloc] init] imageName:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon" title:@"精华"];
    
    [self addChildController:[[MRNewViewController alloc] init] imageName:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon" title:@"新帖"];
    
    [self addChildController:[[MRFriendTrendsViewController alloc] init] imageName:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon" title:@"关注"];
    
    [self addChildController:[[MRMeViewController alloc] init] imageName:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon" title:@"我"];

    // 使用KVC更换掉系统的UITabBar
    [self setValue:[[MRTabBar alloc] init] forKey:@"tabBar"];
}


/**
 *	@brief	设置TabBarItem主题
 */

+ (void)initialize {
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
}

/**
 *	@brief	添加子控制器
 *
 *	@param 	childVC 	子控制期器
 *	@param 	imageName 	默认图片
 *	@param 	selectedName 	选中图片
 *	@param 	title 	标题
 */
- (void)addChildController:(UIViewController *)childVC imageName:(NSString *)image selectedImage:(NSString *)selectedImage title:(NSString *)title
{
    
    // 设置文字和图片
    childVC.tabBarItem.title = title;
    
    childVC.tabBarItem.image = [UIImage mr_imageOriginalWithName:image];
    
    childVC.tabBarItem.selectedImage = [UIImage mr_imageOriginalWithName:selectedImage];
    
    // 包装一个导航控制器，添加导航控制器为tabBarController的子控制器
    MRNavigationController *nav = [[MRNavigationController alloc] initWithRootViewController:childVC];
    
    [self addChildViewController:nav];
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
