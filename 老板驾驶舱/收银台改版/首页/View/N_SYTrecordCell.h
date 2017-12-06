//
//  New_RecordCell.h
//  BusinessCenter
//
//  Created by mac on 2017/4/11.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface N_SYTrecordCell : UITableViewCell

+ (instancetype)N_SYTrecordCellWithTableview:(UITableView *)tableview;

@property (nonatomic, weak) UILabel *titleLab;

@property (nonatomic, assign) CGFloat height;

@end
