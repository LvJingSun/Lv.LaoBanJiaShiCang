//
//  F_BrokenLineCell.h
//  BusinessCenter
//
//  Created by mac on 2017/3/14.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>
@class F_BrokenLineView;

@interface F_BrokenLineCell : UITableViewCell

+ (instancetype)F_BrokenLineCellWithTableview:(UITableView *)tableview;

@property (nonatomic, weak) UILabel *titleLab;

@property (nonatomic, weak) UIButton *changeBtn;

@property (nonatomic, weak) F_BrokenLineView *lineView;

@property (nonatomic, assign) CGFloat height;

@end
