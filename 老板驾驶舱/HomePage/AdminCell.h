//
//  AdminCell.h
//  BusinessCenter
//
//  Created by mac on 16/5/11.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdminCell : UITableViewCell

@property (nonatomic, weak) UIImageView *picImageView;

@property (nonatomic ,weak) UILabel *nameLab;

@property (nonatomic, weak) UILabel *telLab;

@property (nonatomic, weak) UILabel *titleLab;

@property (nonatomic, assign) CGFloat height;

+ (instancetype)adminCellWithTableview:(UITableView *)tableview;

@end
