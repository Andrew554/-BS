//
//  MRRecommendCategoryCell.h
//  MR_BSBDJ
//
//  Created by SinObjectC on 16/6/1.
//  Copyright © 2016年 SinObjectC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MRRecommendCategory;

@interface MRRecommendCategoryCell : UITableViewCell

/** 类别模型 */
@property(nonatomic, strong)MRRecommendCategory *category;

@end
