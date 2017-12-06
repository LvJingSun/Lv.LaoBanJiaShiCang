//
//  RowNumCell.h
//  BusinessCenter
//
//  Created by mac on 16/5/13.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RowNumCell : UITableViewCell

@property (nonatomic, weak) UIImageView *picImageView;

@property (nonatomic ,weak) UILabel *nameLab;

@property (nonatomic, weak) UILabel *telLab;

@property (nonatomic, weak) UILabel *titleLab;

//@property (nonatomic, weak) UIImageView *blankImageview;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, weak) UILabel *countLab;

@property (nonatomic, weak) UIImageView *statusIcon;

@property (nonatomic, weak) UILabel *statusLabel;

+ (instancetype)adminCellWithTableview:(UITableView *)tableview;

@end
