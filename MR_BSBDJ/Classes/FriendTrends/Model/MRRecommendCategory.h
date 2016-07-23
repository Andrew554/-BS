//
//  MRRecommendCategory.h
//  MR_BSBDJ
//
//  Created by SinObjectC on 16/6/1.
//  Copyright © 2016年 SinObjectC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MRRecommendCategory : NSObject

/** id */
@property(nonatomic, assign)NSInteger id;

/** 名字 */
@property(nonatomic, strong)NSString *name;

/** 个数 */
@property(nonatomic, assign)NSInteger count;

/** 相应类别对应的用户数据 */
@property(nonatomic, strong)NSMutableArray *users;

/** 总数 */
@property(nonatomic, assign)NSInteger total;

/** 当前页 */
@property(nonatomic, assign)NSInteger currentPage;

// 字典模型->对象模型
+ (instancetype)categoryWithDic:(NSDictionary *)dict;

@end
