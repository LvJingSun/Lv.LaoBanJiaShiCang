//
//  ProjectCell.h
//  BusinessCenter
//
//  Created by mac on 16/5/20.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProjectCell : UITableViewCell

+ (instancetype)ProjectCellWithTableView:(UITableView *)tableview;

@property (nonatomic, weak) UIImageView *ProjectImageView;

@property (nonatomic, weak) UILabel *ProjectNameLab;

@property (nonatomic, weak) UILabel *ProjectPriceLab;

@property (nonatomic, weak) UILabel *ProjectTimeLab;

@property (nonatomic, weak) UILabel *ProjectBeginLab;

@property (nonatomic, weak) UILabel *ProjectFinishLab;

@property (nonatomic, assign) CGFloat height;

@end
