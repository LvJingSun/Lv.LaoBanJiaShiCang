//
//  F_SegmCell.h
//  BusinessCenter
//
//  Created by mac on 2017/3/14.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface F_SegmCell : UITableViewCell

+ (instancetype)F_SegmCellWithTableview:(UITableView *)tableview;

@property (nonatomic, weak) UISegmentedControl *segm;

@property (nonatomic, assign) CGFloat height;

@end
