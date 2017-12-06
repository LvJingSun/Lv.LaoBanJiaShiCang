//
//  SendListCell.h
//  BusinessCenter
//
//  Created by mac on 2017/3/15.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SendFrameModel;

@interface SendListCell : UITableViewCell

+ (instancetype)SendListCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) SendFrameModel *frameModel;

@end
