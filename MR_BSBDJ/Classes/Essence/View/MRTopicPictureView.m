//
//  MRPictureView.m
//  MR_BSBDJ
//
//  Created by Andrew554 on 16/7/19.
//  Copyright © 2016年 SinObjectC. All rights reserved.
//

#import "MRTopicPictureView.h"
#import "MRTopic.h"
#import "MRProgressVIew.h"
#import <UIImageView+WebCache.h>
#import "MRPictureViewController.h"

@interface MRTopicPictureView()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIImageView *gifView;

@property (weak, nonatomic) IBOutlet UIButton *seeBig;

@property (weak, nonatomic) IBOutlet MRProgressVIew *progressView;

@end

@implementation MRTopicPictureView

- (void)awakeFromNib {
    
    // 图片设置宽度之后因为太大出现超出屏幕的怪现象
    self.autoresizingMask = UIViewAutoresizingNone;

    self.imageView.layer.masksToBounds = YES;
    
    // 添加点击事件
    self.imageView.userInteractionEnabled = YES;
    
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick:)]];
}


+ (instancetype)pictureView {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}


- (void)setTopic:(MRTopic *)topic {
    
    _topic = topic;
    
    [self.progressView setProgress:topic.progress animated:YES];
    
    // 设置图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.middle_picture] placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        self.progressView.hidden = NO;
        
        CGFloat progressValue = 1.0 * receivedSize / expectedSize;
        
        self.topic.progress = progressValue;
        
        [self.progressView setProgress:self.topic.progress];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        self.progressView.hidden = YES;
        
        if(topic.isBreak) { // 如果是大图片才需要绘制
            // 开启图形上下文
            UIGraphicsBeginImageContextWithOptions(_topic.pictureF.size, YES, 0.0);
            
            CGFloat width = topic.pictureF.size.width;
            
            CGFloat height = width * image.size.height / image.size.width;
            
            // 将下载完的图片绘制到上下文中
            [image drawInRect:CGRectMake(0, 0, width, height)];
            
            // 获取图片
            self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
            
            // 结束图形上下文
            UIGraphicsEndImageContext();
        }
        
    }];
    
    self.gifView.hidden = !topic.isGif;
    
    if(topic.isBreak) { // 大图
        
        self.seeBig.hidden = NO;
        
    }else { // 非大图
        
        self.seeBig.hidden = YES;
        
        self.imageView.contentMode = UIViewContentModeScaleToFill;
    }
}

/**
 * 图片点击事件
 */
- (void)imageClick:(UIImageView *)imageV {
    
    MRPictureViewController *pictureVc = [[MRPictureViewController alloc] init]
    ;
    
    pictureVc.topic = self.topic;
    
    pictureVc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:pictureVc animated:YES completion:nil];
}

@end
