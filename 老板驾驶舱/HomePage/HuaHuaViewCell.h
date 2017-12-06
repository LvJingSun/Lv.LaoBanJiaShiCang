//
//  HuaHuaViewCell.h
//  BusinessCenter
//
//  Created by mac on 16/8/2.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HuaHuaViewCell : UITableViewCell

+ (instancetype)HuaHuaViewCellWithTableview:(UITableView *)tableview;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, weak) UILabel *countLab;

@property (nonatomic, weak) UILabel *nameLab;

@property (nonatomic, weak) UILabel *timeLab;

@property (nonatomic, weak) UILabel *jingbanrenLab;

@property (nonatomic, weak) UILabel *shopLab;

@end
