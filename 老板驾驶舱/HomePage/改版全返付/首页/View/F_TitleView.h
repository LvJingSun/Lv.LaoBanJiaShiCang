//
//  F_TitleView.h
//  BusinessCenter
//
//  Created by mac on 2017/3/14.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol F_TitleDelegate <NSObject>

- (void)TitleClick;

@end

@interface F_TitleView : UIView

@property (nonatomic, strong) id<F_TitleDelegate> delegate;

@end
