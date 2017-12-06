//
//  ManagerCell.h
//  BusinessCenter
//
//  Created by mac on 16/5/10.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ManagerCell : UITableViewCell

+ (instancetype)managerCellWithTableView:(UITableView *)tableView;

@property (nonatomic, weak) UILabel *nameLab;

@property (nonatomic, weak) UIImageView *picImageView;

@property (nonatomic, weak) UILabel *sellNameLab;

@property (nonatomic, weak) UILabel *countLab;

@property (nonatomic, weak) UILabel *inPriceLab;

@property (nonatomic, weak) UILabel *outPriceLab;

@property (nonatomic, weak) UILabel *supplierLab;

@property (nonatomic, assign) CGFloat height;

@end
