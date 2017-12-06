//
//  ZJSegmentStyle.h
//  ZJScrollPageView
//
//  Created by jasnig on 16/5/6.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJSegmentStyle : NSObject
typedef NS_ENUM(NSInteger, TitleImagePosition) {
    TitleImagePositionLeft,
    TitleImagePositionRight,
    TitleImagePositionTop,
    TitleImagePositionCenter
};
/** 是否显示遮盖 默认为NO */
@property (assign, nonatomic, getter=isShowCover) BOOL showCover;
/** 是否显示滚动条 默认为NO*/
@property (assign, nonatomic, getter=isShowLine) BOOL showLine;
/** 是否缩放标题 不能滚动的时候就不要把缩放和遮盖或者滚动条同时使用, 否则显示效果不好 默认为NO*/
@property (assign, nonatomic, getter=isScaleTitle) BOOL scaleTitle;
/** 是否滚动标题 默认为YES 设置为NO的时候所有的标题将不会滚动, 并且宽度会平分 和系统的segment效果相似 */
@property (assign, nonatomic, getter=isScrollTitle) BOOL scrollTitle;
/** segmentView是否有弹性 默认为NO*/
@property (assign, nonatomic, getter=isSegmentViewBounces) BOOL segmentViewBounces;
/** 是否颜色渐变 默认为NO*/
@property (assign, nonatomic, getter=isGradualChangeTitleColor) BOOL gradualChangeTitleColor;
/** 是否显示附加的按钮 默认为NO*/
@property (assign, nonatomic, getter=isShowExtraButton) BOOL showExtraButton;
/** 内容view是否能滑动 默认为YES*/
@property (assign, nonatomic, getter=isScrollContentView) BOOL scrollContentView;
/** 当设置scrollTitle=NO的时候标题会平分宽度, 如果你希望在滚动的过程中cover或者scrollLine的宽度随着变化设置这个属性为YES 默认为NO*/
@property (assign, nonatomic, getter=isAdjustCoverOrLineWidth) BOOL adjustCoverOrLineWidth;
@property (assign, nonatomic, getter=isShowImage) BOOL showImage;

/** 是否自动调整标题的宽度, 当设置为YES的时候 如果所有的标题的宽度之和小于segmentView的宽度的时候, 会自动调整title的位置, 达到类似"平分"的效果 */
@property (assign, nonatomic, getter=isAutoAdjustTitlesWidth) BOOL autoAdjustTitlesWidth;

/** 设置附加按钮的背景图片 默认为nil*/
@property (strong, nonatomic) NSString *extraBtnBackgroundImageName;
/** 滚动条的高度 默认为2 */
@property (assign, nonatomic) CGFloat scrollLineHeight;
/** 滚动条的颜色 */
@property (strong, nonatomic) UIColor *scrollLineColor;
/** 遮盖的颜色 */
@property (strong, nonatomic) UIColor *coverBackgroundColor;
/** 遮盖的圆角 默认为14*/
@property (assign, nonatomic) CGFloat coverCornerRadius;
/** 遮盖的高度 默认为28*/
@property (assign, nonatomic) CGFloat coverHeight;
/** 标题之间的间隙 默认为15.0 */
@property (assign, nonatomic) CGFloat titleMargin;
/** 标题的字体 默认为14 */
@property (strong, nonatomic) UIFont *titleFont;
/** 标题缩放倍数, 默认1.3 */
@property (assign, nonatomic) CGFloat titleBigScale;
/** 标题一般状态的颜色 */
@property (strong, nonatomic) UIColor *normalTitleColor;
/** 标题选中状态的颜色 */
@property (strong, nonatomic) UIColor *selectedTitleColor;
/** segmentVIew的高度, 这个属性只在使用ZJScrollPageVIew的时候设置生效 */
@property (assign, nonatomic) CGFloat segmentHeight;
/** 标题中图片的位置 */
@property (assign, nonatomic) TitleImagePosition imagePosition;


@end
