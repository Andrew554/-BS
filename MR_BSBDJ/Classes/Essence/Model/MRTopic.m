//
//  MRTopic.m
//  MR_BSBDJ
//
//  Created by Andrew554 on 16/7/16.
//  Copyright © 2016年 SinObjectC. All rights reserved.
//

#import "MRTopic.h"
#import "NSDate+MRExtension.h"
#import <MJExtension/MJExtension.h>

@implementation MRTopic {

    @private
    CGFloat _cellHeight;
    
}


+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{
             @"small_picture": @"image0",
             @"large_picture": @"image1",
             @"middle_picture": @"image2"
            };
}


- (NSString *)create_time {
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 设置国际化
    fmt.locale = [NSLocale localeWithLocaleIdentifier:@"zh_CN"];
    // 设置日期格式
    [fmt setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    // 帖子的创建时间日期
    NSDate *createDate = [fmt dateFromString:_create_time];
    
    // 当前时间
    NSDate *nowDate = [NSDate date];

    // 日历对象
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // 时间对比组件
    NSDateComponents *comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond fromDate:createDate toDate:nowDate options:0];
    
    if([createDate isThisYear]) {   // 今年
        
        if([createDate isToday]) {  // 今天
            
            if(comps.hour > 1) {    // 几个小时前
                return [NSString stringWithFormat:@"%d个小时前", (int)comps.hour];
            }else if(comps.minute > 1)  {   // 几分钟前
                return [NSString stringWithFormat:@"%d分钟前", (int)comps.minute];
            }else { // 今天的其他时间: 刚刚
                return @"刚刚";
            }
            
        }else if([createDate isYesterday]) {    // 昨天
            
            [fmt setDateFormat:@"昨天 HH:mm"];
            
            return [fmt stringFromDate:createDate];
            
        }else { // 今年的其他时间
            
            [fmt setDateFormat:@"MM-dd HH:mm"];
            
            return [fmt stringFromDate:createDate];
        }

    }else { // 非今年
        
        [fmt setDateFormat:@"yyyy-MM-dd HH:mm"];
        
        return [fmt stringFromDate:createDate];
    }
}


- (CGFloat)cellHeight {
    
    if(!_cellHeight) {

        // 文字的最大尺寸
        CGSize maxSize = CGSizeMake(MRScreenW - 4 * MRTopicCellMargin, MAXFLOAT);
        
        // 计算文字的高度
        CGFloat textH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]} context:nil].size.height;
        
        // cell的高度
        _cellHeight = MRTopicCellTextY + textH + MRTopicCellMargin;
        
        // 根据段子的类型来计算图片cell的高度
        if(self.type == MRTopicCellTypePicture) {   // 图片帖子
            
            // 图片显示出来的宽度
            CGFloat pictureW = maxSize.width;
            
            // 显示出来的图片高度
            CGFloat pictureH = pictureW * self.height / self.width;
            
            if(pictureH > MRTopicCellPictureMaxH) { // 大图
                
                pictureH = MRTopicCellPictureBreakH;
                
                _breakHeight = YES;
                
            }else { // 非大图
                
                _breakHeight = NO;
                
            }
            
            // 计算图片控件的Frame
            CGFloat pictureX = MRTopicCellMargin;
            CGFloat pictureY = MRTopicCellTextY + textH + MRTopicCellMargin;
            
            _pictureF = CGRectMake(pictureX, pictureY, pictureW, pictureH);
            
            _cellHeight += pictureH + MRTopicCellMargin;
            
        }
        
        // 底部工具条
        _cellHeight += MRTopicCellBottomBarH + MRTopicCellMargin;
    }
    
    return _cellHeight;
}


@end
