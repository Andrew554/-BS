//
//  MRRecommendCategoryCell.m
//  MR_BSBDJ
//
//  Created by SinObjectC on 16/6/1.
//  Copyright © 2016年 SinObjectC. All rights reserved.
//

#import "MRRecommendCategoryCell.h"
#import "MRRecommendCategory.h"

@interface MRRecommendCategoryCell()

@property (weak, nonatomic) IBOutlet UIView *selectedIndicator;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end


@implementation MRRecommendCategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
    // 初始化设置
    [self setup];
}


- (void)setup {
    
    // 设置背景颜色
    self.backgroundColor = MRRGBColor(244, 244, 244);
    
    // 左边选中标签颜色
    self.selectedIndicator.backgroundColor = MRRGBColor(219, 21, 26);
}

- (void)setCategory:(MRRecommendCategory *)category {
    
    _category = category;
    
    self.nameLabel.text = category.name;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    self.selectedIndicator.hidden = !selected;
    
    self.nameLabel.textColor = self.selected ? MRRGBColor(219, 21, 26) : MRRGBColor(78, 78, 78);
    
}

- (void)layoutSubviews {
    
    // 重新调整textLabel的frame,防止挡住下面的自定义分割线
    self.nameLabel.mr_y = 2;
    self.nameLabel.mr_height = self.mr_height - 2 * self.nameLabel.mr_y;
}

@end
