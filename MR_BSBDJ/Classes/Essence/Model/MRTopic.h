//
//  MRTopic.h
//  MR_BSBDJ
//
//  Created by Andrew554 on 16/7/16.
//  Copyright © 2016年 SinObjectC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MRTopic : NSObject

/**
 * 头像
 */
@property (nonatomic, copy) NSString *profile_image;

/**
 * name
 */
@property (nonatomic, copy) NSString *name;

/**
 * 时间
 */
@property (nonatomic, copy) NSString *create_time;

/**
 * 正文
 */
@property (nonatomic, copy) NSString *text;

/**
 *  顶
 */
@property (nonatomic, assign) NSInteger ding;

/**
 *  踩
 */
@property (nonatomic, assign) NSInteger cai;

/**
 *  转发
 */
@property (nonatomic, assign) NSInteger repost;

/**
 *  评论
 */
@property (nonatomic, assign) NSInteger comment;

/**
 * 小图
 */
@property (nonatomic, copy) NSString *small_picture;

/**
 * 大图
 */
@property (nonatomic, copy) NSString *large_picture;

/**
 * 中图
 */
@property (nonatomic, copy) NSString *middle_picture;

/**
 *  显示图片宽度
 */
@property (nonatomic, assign) CGFloat width;

/**
 *  显示图片高度
 */
@property (nonatomic, assign) CGFloat height;

/** 是否为新浪会员 */
@property (assign, nonatomic, getter=isSina_v) BOOL sina_v;

/**
 *  是否是gif图片
 */
@property (nonatomic, assign, getter=isGif) BOOL is_gif;

/**
 *  帖子类型
 */
@property (nonatomic, assign) MRTopicCellType type;

/************ 额外的属性 ************/
/** cell 的高度 **/
@property (nonatomic, assign, readonly) CGFloat cellHeight;
/** cell 的frame **/
@property (nonatomic, assign, readonly) CGRect pictureF;
/** 是否超出高度 **/
@property (nonatomic, assign, getter=isBreak) BOOL breakHeight;
/** 加载进度 **/
@property (nonatomic, assign) CGFloat progress;

@end
