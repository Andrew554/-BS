//
//  MRPictureView.h
//  MR_BSBDJ
//
//  Created by Andrew554 on 16/7/19.
//  Copyright © 2016年 SinObjectC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MRTopic;

@interface MRTopicPictureView : UIView

/**
 *  段子数据
 */
@property (nonatomic, strong) MRTopic *topic;


+ (instancetype)pictureView;

@end
