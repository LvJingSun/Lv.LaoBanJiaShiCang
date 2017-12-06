//
//  Y_SendDetailCell.h
//  BusinessCenter
//
//  Created by mac on 2017/8/24.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>
@class New_RecordFrame;

@interface Y_SendDetailCell : UITableViewCell

+ (instancetype)Y_SendDetailCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) New_RecordFrame *frameModel;

@end
