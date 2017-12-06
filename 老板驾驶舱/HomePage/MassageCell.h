//
//  MassageCell.h
//  BusinessCenter
//
//  Created by mac on 16/5/22.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MassageCell : UITableViewCell

//+ (instancetype)MassageCellWithTableView:(UITableView *)tableview;

@property (nonatomic, weak) UIImageView *iconImageview;

@property (nonatomic, weak) UILabel *nameLabel;

@property (nonatomic, weak) UILabel *timeLabel;

@property (nonatomic, weak) UILabel *proportionLabel;

@property (nonatomic, weak) UILabel *priceLabel;

@property (nonatomic, weak) UIButton *reduceBtn;

@property (nonatomic, weak) UILabel *countLabel;

@property (nonatomic, weak) UIButton *addBtn;

@property (nonatomic, assign) CGFloat height;

@end
