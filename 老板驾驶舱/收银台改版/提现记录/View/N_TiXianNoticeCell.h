//
//  N_TiXianNoticeCell.h
//  BusinessCenter
//
//  Created by mac on 2017/4/12.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface N_TiXianNoticeCell : UITableViewCell

+ (instancetype)N_TiXianNoticeCellWithTableview:(UITableView *)tableview;

@property (nonatomic, weak) UILabel *noticeLab;

@property (nonatomic, assign) CGFloat height;

@end
