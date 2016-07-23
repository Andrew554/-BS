//
//  MRRecommendUser.m
//  MR_BSBDJ
//
//  Created by SinObjectC on 16/6/1.
//  Copyright © 2016年 SinObjectC. All rights reserved.
//  分类右边用户

#import "MRRecommendUser.h"

@implementation MRRecommendUser

+ (instancetype)userWithDic:(NSDictionary *)dict {
    
    MRRecommendUser *user = [[self alloc] init];
    
    // KVC设置属性值
//    [user setValuesForKeysWithDictionary:dict];
    user.header = dict[@"header"];
    user.screen_name = dict[@"screen_name"];
    user.fans_count = [dict[@"fans_count"] integerValue];
    
    return user;
}


@end
