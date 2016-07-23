//
//  MRRecommendTag.h
//  MR_BSBDJ
//
//  Created by SinObjectC on 16/6/3.
//  Copyright © 2016年 SinObjectC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MRRecommendTag : NSObject

/** name */
@property(nonatomic, strong)NSString *theme_name;

/** image */
@property(nonatomic, strong)NSString *image_list;

/** number */
@property(nonatomic, assign)NSInteger sub_number;

+ (NSArray *)tagsWithArray:(NSArray *)array;

+ (instancetype)tagWithDict:(NSDictionary *)dict;

- (void)setValue:(id)value forUndefinedKey:(NSString *)key;

@end
