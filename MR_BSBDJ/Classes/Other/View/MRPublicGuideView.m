//
//  MRPublicGuideView.m
//  MR_BSBDJ
//
//  Created by Andrew554 on 16/7/15.
//  Copyright © 2016年 SinObjectC. All rights reserved.
//

#import "MRPublicGuideView.h"


@implementation MRPublicGuideView

+ (instancetype)guideView {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}


/**
 *  显示推送引导
 */
+ (void)showGuideView {
    
    NSString *key = @"CFBundleShortVersionString";
    
    // 获取当前的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    // 获取沙盒中的版本号
    NSString *sanboxVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    
    if(![currentVersion isEqualToString:sanboxVersion]) {
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        MRPublicGuideView *guideView = [MRPublicGuideView guideView];
        guideView.frame = window.bounds;
        
        [window addSubview:guideView];
        
        // 存储版本号
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
}


// 关闭推送引导
- (IBAction)close:(UIButton *)sender {
    
    [self removeFromSuperview];
    
}

@end
