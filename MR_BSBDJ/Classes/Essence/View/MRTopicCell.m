//
//  MRTopicCell.m
//  MR_BSBDJ
//
//  Created by Andrew554 on 16/7/16.
//  Copyright © 2016年 SinObjectC. All rights reserved.
//

#import "MRTopicCell.h"
#import "MRTopic.h"
#import "MRTopicPictureView.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface MRTopicCell ()

/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
/** 昵称 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** 时间 */
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
/** 顶 */
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
/** 踩 */
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
/** 分享 */
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
/** 评论 */
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
/** 段子内容 */
@property (weak, nonatomic) IBOutlet UILabel *text_Label;
/**
 *  图片帖子中间的内容
 */
@property (nonatomic, weak) MRTopicPictureView *pictureView;

@property (weak, nonatomic) IBOutlet UIImageView *is_vip;

@end

@implementation MRTopicCell


- (MRTopicPictureView *)pictureView {
    
    if(!_pictureView) {
        
        MRTopicPictureView *pictureView = [MRTopicPictureView pictureView];
        
        [self.contentView addSubview:pictureView];
        
        _pictureView = pictureView;
    }
    
    return _pictureView;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
}


- (void)setTopic:(MRTopic *)topic {

    _topic = topic;
    
    // 设置数据
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLabel.text = topic.name;
    self.createTimeLabel.text = topic.create_time;
    self.is_vip.hidden = !topic.sina_v;
    
    // 设置按钮文字
    [self setupButtonTitle:self.dingButton count:topic.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiButton count:topic.cai placeholder:@"踩"];
    [self setupButtonTitle:self.shareButton count:topic.repost placeholder:@"分享"];
    [self setupButtonTitle:self.commentButton count:topic.comment placeholder:@"评论"];
    
    // 帖子文字
    self.text_Label.text = topic.text;
    
    if(topic.type == MRTopicCellTypePicture) {  // 如果是图片帖子
        
        // 设置图片的Frame
        self.pictureView.frame = topic.pictureF;
        
        self.pictureView.topic = topic;
    }
    
}


/**
 *  设置按钮文字
 */
- (void)setupButtonTitle:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder {
    
    if(count > 10000) {
        placeholder = [NSString stringWithFormat:@"%.1f万", count/10000.0];
    }else if(count > 0) {
        placeholder = [NSString stringWithFormat:@"%zd", count];
    }
    
    [button setTitle:placeholder forState:UIControlStateNormal];
}


- (void)setFrame:(CGRect)frame {
    
    static CGFloat const margin = 5;
    
    frame.size.width -= 2 * margin;
    frame.origin.x = margin;
    frame.size.height -= margin;
    frame.origin.y += margin;
    
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
