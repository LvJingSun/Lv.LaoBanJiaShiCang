//
//  BigIncomeCell.h
//  BusinessCenter
//
//  Created by mac on 16/5/30.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BigBtnView;

@interface BigIncomeCell : UITableViewCell

+ (instancetype)BigIncomeCellWithTableView:(UITableView *)tableview;

@property (nonatomic, weak) BigBtnView *yonghu;

@property (nonatomic, weak) BigBtnView *xiaoxi;

@property (nonatomic, weak) BigBtnView *xiaoshou;

@property (nonatomic, weak) BigBtnView *huiyuanka;

@property (nonatomic, weak) BigBtnView *kucun;

@property (nonatomic, weak) BigBtnView *yuangong;

@property (nonatomic, weak) BigBtnView *paihao;

@property (nonatomic, weak) BigBtnView *zhiwei;

@property (nonatomic, weak) BigBtnView *dengji;

@property (nonatomic, weak) BigBtnView *huahua;

@property (nonatomic, weak) BigBtnView *quanfanfu;

@property (nonatomic, weak) BigBtnView *yangchebao;

@property (nonatomic, weak) BigBtnView *merchantRed;

@property (nonatomic, assign) CGFloat height;

@end
