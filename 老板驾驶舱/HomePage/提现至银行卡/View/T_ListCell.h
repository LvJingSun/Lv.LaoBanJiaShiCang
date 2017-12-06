//
//  T_ListCell.h
//  BusinessCenter
//
//  Created by mac on 2017/11/1.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>
@class T_ListFrame;

@interface T_ListCell : UITableViewCell

+ (instancetype)T_ListCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) T_ListFrame *frameModel;

@end
