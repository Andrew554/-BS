//
//  MRRecommendUser.h
//  MR_BSBDJ
//
//  Created by SinObjectC on 16/6/1.
//  Copyright © 2016年 SinObjectC. All rights reserved.
//  分类右边用户

#import <Foundation/Foundation.h>

@interface MRRecommendUser : NSObject

/** 头像 */
@property(nonatomic, copy)NSString *header;

/** 粉丝数 */
@property(nonatomic, assign)NSInteger fans_count;

/** 昵称 */
@property(nonatomic, copy)NSString *screen_name;

+ (instancetype)userWithDic:(NSDictionary *)dict;

@end
