//
//  N_TiXianListCell.h
//  BusinessCenter
//
//  Created by mac on 2017/4/12.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>
@class N_TiXianListFrame;

@interface N_TiXianListCell : UITableViewCell

+ (instancetype)N_TiXianListCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) N_TiXianListFrame *frameModel;

@end
