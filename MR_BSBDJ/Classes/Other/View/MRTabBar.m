//
//  MRTabBar.m
//  MR_BSBDJ
//
//  Created by SinObjectC on 16/5/29.
//  Copyright © 2016年 SinObjectC. All rights reserved.
//

#import "MRTabBar.h"

@interface MRTabBar()

/** 发布按钮 */
@property(nonatomic, strong)UIButton *publishButton;

@end


@implementation MRTabBar

- (instancetype)initWithFrame:(CGRect)frame {
    
    if(self = [super initWithFrame:frame]) {
        // 设置tabbar的背景图片
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar_light"]];
        
        // 添加发布按钮
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        
        publishButton.mr_size = publishButton.currentBackgroundImage.size;
        
        [self addSubview:publishButton];
        
        self.publishButton = publishButton;
    }
    
    return self;
}


/**
 *  设置布局
 */
- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGFloat width = self.mr_width;
    CGFloat height = self.mr_height;
    
    // 设置发布按钮的frame
    self.publishButton.center = CGPointMake(width * 0.5, height * 0.5);
    
    // 设置其他UITabBarButton的frame
    CGFloat buttonY = 0;
    CGFloat buttonW = width / 5;
    CGFloat buttonH = height;
    NSInteger index = 0;
    
    for (UIView *button in self.subviews) {
        
        // 如果不是UITabBarButton或者是发布按钮则跳过
        if(![button isKindOfClass:[UIControl class]] || button == self.publishButton) {
            
            continue;
        }
        
        // 计算按钮的x值
        CGFloat buttonX = buttonW * ((index > 1) ? (index + 1) : index);
        
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        // 增加索引
        index++;
    }
}


@end
