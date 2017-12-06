//
//  RecordCell.h
//  yfdeguyigqfiu
//
//  Created by mac on 16/4/12.
//  Copyright © 2016年 WJL. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RecordFrame;

@interface RecordCell : UITableViewCell

+ (instancetype)RecordCellWithTableView:(UITableView *)tableView;

@property (nonatomic, weak) UILabel *countLab;

@property (nonatomic, weak) UILabel *typeLab;

@property (nonatomic, weak) UILabel *timeLab;

@property (nonatomic, weak) UILabel *addressLab;

@property (nonatomic, weak) UILabel *nameLab;

@property (nonatomic, assign) CGFloat height;

@end
