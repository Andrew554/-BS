//
//  MRRecommendTag.m
//  MR_BSBDJ
//
//  Created by SinObjectC on 16/6/3.
//  Copyright © 2016年 SinObjectC. All rights reserved.
//

#import "MRRecommendTag.h"

@implementation MRRecommendTag

+ (instancetype)tagWithDict:(NSDictionary *)dict {
    
    MRRecommendTag *tag = [[self alloc] init];
    
    [tag setValuesForKeysWithDictionary:dict];
    
    return tag;
}

+ (NSArray *)tagsWithArray:(NSArray *)array {
    
    NSMutableArray *tags = [NSMutableArray array];
    
    for (int i = 0; i < array.count; i++) {
        
        [tags addObject:[self tagWithDict: array[i]]];
    }
    
    return tags;
}

// 解决模型中未定义字典中的字段
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end
