//
//  F_RoundCell.h
//  BusinessCenter
//
//  Created by mac on 2017/3/14.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface F_RoundCell : UITableViewCell

+ (instancetype)F_RoundCellWithTableview:(UITableView *)tableview;

@property (nonatomic, weak) UILabel *countLab;

@property (nonatomic, assign) CGFloat height;

@end
