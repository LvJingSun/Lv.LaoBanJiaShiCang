//
//  Y_SendCell.h
//  BusinessCenter
//
//  Created by mac on 2017/8/24.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SendFrameModel;

@interface Y_SendCell : UITableViewCell

+ (instancetype)Y_SendCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) SendFrameModel *frameModel;

@end
