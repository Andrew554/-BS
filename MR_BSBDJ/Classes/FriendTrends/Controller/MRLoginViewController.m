//
//  MRLoginViewController.m
//  MR_BSBDJ
//
//  Created by Andrew554 on 16/7/10.
//  Copyright © 2016年 SinObjectC. All rights reserved.
//

#import "MRLoginViewController.h"

@interface MRLoginViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *bgView;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
/**
 *  登录框左边的约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewLeftMargin;
@end

@implementation MRLoginViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.view insertSubview:self.bgView atIndex:0];
    
    [self.loginBtn setBackgroundImage:[[UIImage imageNamed:@"loginBtnBg"] stretchableImageWithLeftCapWidth:0.5 topCapHeight:0.5] forState:UIControlStateNormal];
    
}


/**
 *  关闭
 */
- (IBAction)closeBtnClick:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


/**
 *  注册账号
 */
- (IBAction)registeAccountClick:(UIButton *)btn {
    
    // 收起键盘
    [self.view endEditing:YES];
    
    if(self.loginViewLeftMargin.constant == 0) { // 登录框
        
        self.loginViewLeftMargin.constant = -self.view.mr_width;
        
        btn.selected = YES;
        
    }else { // 注册框
        
        self.loginViewLeftMargin.constant = 0;
        
        btn.selected = NO;
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}

/**
 *  设置状态栏的主题为白色
 */
- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
}
@end
