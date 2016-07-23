//
//  MRTopicCell.h
//  MR_BSBDJ
//
//  Created by Andrew554 on 16/7/16.
//  Copyright © 2016年 SinObjectC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MRTopic;

@interface MRTopicCell : UITableViewCell

/**
 *  段子数据
 */
@property (nonatomic, strong) MRTopic *topic;

@end
