//
//  MRRecommendTagCell.m
//  MR_BSBDJ
//
//  Created by SinObjectC on 16/6/3.
//  Copyright © 2016年 SinObjectC. All rights reserved.
//

#import "MRRecommendTagCell.h"
#import "MRRecommendTag.h"
#import "UIImageView+WebCache.h"
#import "MRRecommendTag.h"

@interface MRRecommendTagCell ()

@property (weak, nonatomic) IBOutlet UIImageView *nameImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@end

@implementation MRRecommendTagCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // 初始化数据
    [self setup];
}

/**
 * 初始化数据
 */
- (void)setup {
    
    // self.nameImage.clicpToBounds = YES;
    self.nameImage.layer.masksToBounds = YES;
    
}


- (void)setRecommend_tag:(MRRecommendTag *)recommend_tag {
    
    _recommend_tag = recommend_tag;
    
    [self.nameImage sd_setImageWithURL:[NSURL URLWithString:self.recommend_tag.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    self.nameLabel.text = self.recommend_tag.theme_name;
    
    NSString *subNumber = nil;
    
    if(self.recommend_tag.sub_number < 10000) {
        subNumber = [NSString stringWithFormat:@"%zd人已订阅", self.recommend_tag.sub_number];
    }else {
        subNumber = [NSString stringWithFormat:@"%.1f万人已订阅", self.recommend_tag.sub_number / 10000.0];
    }
    
    self.detailLabel.text = subNumber;
}


// 设置contentView的frame, 让cell左右两边有间隔
- (void)setFrame:(CGRect)frame {
    
    frame.origin.x = 7;
    
    frame.size.width -= 2 * frame.origin.x;
    
    frame.size.height -= 2;
    
    [super setFrame:frame];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
