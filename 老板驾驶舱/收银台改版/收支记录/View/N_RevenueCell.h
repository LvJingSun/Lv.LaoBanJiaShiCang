//
//  N_RevenueCell.h
//  BusinessCenter
//
//  Created by mac on 2017/4/13.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>
@class N_RevenueFrame;

@interface N_RevenueCell : UITableViewCell

+ (instancetype)N_RevenueCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) N_RevenueFrame *frameModel;

@end
