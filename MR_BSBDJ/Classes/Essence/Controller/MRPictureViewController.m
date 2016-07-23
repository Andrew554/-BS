//
//  MRPictureViewController.m
//  MR_BSBDJ
//
//  Created by Andrew554 on 16/7/22.
//  Copyright © 2016年 SinObjectC. All rights reserved.
//

#import "MRPictureViewController.h"
#import <UIImageView+WebCache.h>
#import "MRProgressVIew.h"
#import <SVProgressHUD.h>
#import "MRTopic.h"

@interface MRPictureViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

/**
 *  图片
 */
@property (nonatomic, weak) UIImageView *imageView;

@property (weak, nonatomic) IBOutlet MRProgressVIew *progressView;

@end

@implementation MRPictureViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // 添加图片
    UIImageView *imageView = [[UIImageView alloc] init];
    
    imageView.userInteractionEnabled = YES;
    
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back:)]];
    
    self.imageView = imageView;
    
    [self.scrollView addSubview:imageView];
    
    CGFloat pictureW = MRScreenW;
    
    CGFloat pictureH = pictureW * self.topic.height / self.topic.width;
    
    if(self.topic.height > MRScreenH) { // 大图
        
        imageView.frame = CGRectMake(0, 0, pictureW, pictureH);
        
        self.scrollView.contentSize = CGSizeMake(0, pictureH);
        
    }else { // 非大图
        
        pictureH = self.topic.height;
        
        imageView.mr_size = CGSizeMake(pictureW, pictureH);
        
        imageView.mr_centerY = self.view.mr_centerY;
    }

    // 显示已经下载的进度
    [self.progressView setProgress:self.topic.progress animated:NO];
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.middle_picture] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        CGFloat progressValue = 1.0 * receivedSize / expectedSize;
        
        self.topic.progress = progressValue;
        
        [self.progressView setProgress:self.topic.progress];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        self.progressView.hidden = YES;
        
    }];
    
}


/**
 *  返回
 */
- (IBAction)back:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

/**
 *  保存
 */
- (IBAction)saveImage:(UIButton *)sender {
    
    if(self.imageView.image == nil) {
        
        [SVProgressHUD showInfoWithStatus:@"图片还未下载完成!"];
        
    }else {
        // 保存图片到相册
        UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
}

// 保存图片回调
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    
    if(error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败!"];
    }else {
        [SVProgressHUD showSuccessWithStatus:@"保存成功!"];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
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
