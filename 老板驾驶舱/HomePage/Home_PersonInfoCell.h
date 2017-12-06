//
//  Home_PersonInfoCell.h
//  BusinessCenter
//
//  Created by mac on 2017/9/28.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Home_PersonInfoCell : UITableViewCell

+ (instancetype)Home_PersonInfoCellWithTableview:(UITableView *)tableview;

@property (nonatomic, weak) UIImageView *iconImg;

@property (nonatomic, weak) UILabel *titleLab;

@property (nonatomic, weak) UILabel *balanceLab;

@property (nonatomic, weak) UIButton *rechargeBtn;

@property (nonatomic, weak) UIButton *balanceBtn;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, copy) dispatch_block_t rechargeBlock;

@property (nonatomic, copy) dispatch_block_t balanceBlock;

@end
