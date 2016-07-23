//
//  MRRecommendCategory.m
//  MR_BSBDJ
//
//  Created by SinObjectC on 16/6/1.
//  Copyright © 2016年 SinObjectC. All rights reserved.
//  我的关注模块分类

#import "MRRecommendCategory.h"

@implementation MRRecommendCategory


+ (instancetype)categoryWithDic:(NSDictionary *)dict {
    
    MRRecommendCategory *category = [[self alloc] init];
    
    // KVC设置属性值
    [category setValuesForKeysWithDictionary:dict];
    
    return category;
}


- (NSMutableArray *)users {
    
    if(!_users) {

        _users = [NSMutableArray array];
        
    }
    
    return _users;
}

@end
