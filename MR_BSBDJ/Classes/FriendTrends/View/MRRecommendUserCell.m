//
//  MRRecommendUserCell.m
//  MR_BSBDJ
//
//  Created by SinObjectC on 16/6/1.
//  Copyright © 2016年 SinObjectC. All rights reserved.
//

#import "MRRecommendUserCell.h"
#import "MRRecommendUser.h"
#import "UIImageView+WebCache.h"

@interface MRRecommendUserCell()
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *fansLable;

@end

@implementation MRRecommendUserCell


- (void)setUser:(MRRecommendUser *)user {
    
    _user = user;
    
    self.nameLabel.text = user.screen_name;
    self.fansLable.text = [NSString stringWithFormat:@"%zd人已关注", user.fans_count];
    [self.headerImage sd_setImageWithURL:[NSURL URLWithString:user.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
}

- (void)awakeFromNib {
    [super awakeFromNib];
   
    // 初始化数据
    [self setup];
}

/**
 *	@brief	初始化数据
 */
- (void)setup {
    
    // 设置image的图层超出父图层的截取掉
    self.headerImage.layer.masksToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
