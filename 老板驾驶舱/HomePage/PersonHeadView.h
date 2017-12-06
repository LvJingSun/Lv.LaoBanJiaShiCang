//
//  PersonHeadView.h
//  BusinessCenter
//
//  Created by mac on 16/5/13.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BackBtnClickDelegate <NSObject>

- (void)BackBtnClick;

@end

@interface PersonHeadView : UIView

@property (nonatomic, weak) UILabel *nameLab;

@property (nonatomic, weak) UIImageView *headImageview;

@property (nonatomic, assign) id<BackBtnClickDelegate> delegate;

@property (nonatomic, weak) UIButton *setBtn;

@property (nonatomic, weak) UIImageView *statusIconImageview;

@property (nonatomic, weak) UILabel *timerLabel;

@property (nonatomic, weak) UIImageView *icon;

@end
