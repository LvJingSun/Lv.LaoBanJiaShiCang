//
//  RevenueTitleView.h
//  BusinessCenter
//
//  Created by mac on 2017/4/12.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>

//@protocol N_TitleDelegate <NSObject>
//
//- (void)N_TitleCkick:(UIButton *)sender;
//
//@end

@interface RevenueTitleView : UIView

//@property (nonatomic, strong) id<N_TitleDelegate> delegate;
//
//@property (nonatomic, assign) BOOL isZhanKai;

@property (nonatomic, weak) UIImageView *imageview;

@property (nonatomic, weak) UILabel *titleLab;

@property (nonatomic, weak) UIButton *clickBtn;

@end
