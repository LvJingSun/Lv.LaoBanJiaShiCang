//
//  Home_InComeCell.h
//  BusinessCenter
//
//  Created by mac on 2017/11/1.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Home_InComeCell : UITableViewCell

+ (instancetype)Home_InComeCellWithTableview:(UITableView *)tableview;

@property (nonatomic, weak) UILabel *titleLab;

@property (nonatomic, weak) UILabel *countLab;

@property (nonatomic, assign) CGFloat height;

@end
