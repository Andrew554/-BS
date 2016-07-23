//
//  MRRecommendUserCell.h
//  MR_BSBDJ
//
//  Created by SinObjectC on 16/6/1.
//  Copyright © 2016年 SinObjectC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MRRecommendUser;

@interface MRRecommendUserCell : UITableViewCell

/** 用户数据 */
@property(nonatomic, strong)MRRecommendUser *user;

@end
