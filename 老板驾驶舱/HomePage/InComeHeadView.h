//
//  InComeHeadView.h
//  BusinessCenter
//
//  Created by mac on 2017/11/1.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InComeHeadView : UIView

@property (nonatomic, weak) UIButton *shishibtn;

@property (nonatomic, weak) UILabel *shishiline;

@property (nonatomic, weak) UIButton *hongbaobtn;

@property (nonatomic, weak) UILabel *hongbaoline;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, copy) dispatch_block_t shishiBlock;

@property (nonatomic, copy) dispatch_block_t hongbaoBlock;

@end
