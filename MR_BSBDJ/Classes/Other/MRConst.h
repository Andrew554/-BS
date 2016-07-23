
#import <UIKit/UIKit.h>

/** 引用 **/

/** cell模型类型 **/
typedef enum {
    MRTopicCellTypeAll = 1, // 全部
    MRTopicCellTypePicture = 10,    // 图片
    MRTopicCellTypeSatin = 29,  // 段子
    MRTopicCellTypeVoice = 31,  // 音频
    MRTopicCellTypeVideo = 41   // 视频
} MRTopicCellType;

/** 精华-顶部标签栏的高度 **/
UIKIT_EXTERN CGFloat const MRTitleViewH;
/** 精华-顶部标签栏的Y值 **/
UIKIT_EXTERN CGFloat const MRTitleViewY;

/** 精华-cell-间距 **/
UIKIT_EXTERN CGFloat const MRTopicCellMargin;
/** 精华-cell-文字内容的Y值 **/
UIKIT_EXTERN CGFloat const MRTopicCellTextY;
/** 精华-cell-底部工具条的高度 **/
UIKIT_EXTERN CGFloat const MRTopicCellBottomBarH;

/** 精华-cell-图片的最大高度 **/
UIKIT_EXTERN CGFloat const MRTopicCellPictureMaxH;
/** 精华-cell-图片超出最大高度之后的高度 **/
UIKIT_EXTERN CGFloat const MRTopicCellPictureBreakH;
