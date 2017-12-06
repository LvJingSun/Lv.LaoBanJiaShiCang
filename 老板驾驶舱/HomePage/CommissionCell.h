//
//  CommissionCell.h
//  BusinessCenter
//
//  Created by mac on 16/5/20.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommissionCell : UITableViewCell

+ (instancetype)CommissionCellWithTableView:(UITableView *)tableview;

@property (nonatomic, weak) UILabel *CommissionNameLabel;

@property (nonatomic, weak) UILabel *CommissionDateLabel;

@property (nonatomic, weak) UILabel *CommissionCountLabel;

@property (nonatomic, assign) CGFloat height;

@end
