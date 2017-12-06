//
//  ActivityTableCell.h
//  BusinessCenter
//
//  Created by 冯海强 on 13-11-20.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"


@interface ActivityTableCell : UITableViewCell


@property(nonatomic,weak)IBOutlet UIImageView*Activity_photo;//头像
@property(nonatomic,weak)IBOutlet UILabel*Activity_NameLable;//名称
@property(nonatomic,weak)IBOutlet UILabel*Activity_TimeLable;//时间

@property(nonatomic,weak)IBOutlet UILabel*Activity_AddressLable;//地址

//价钱及返利
@property(nonatomic,weak)IBOutlet UILabel*Activity_NewMoneylabel;//新价钱
@property(nonatomic,weak)IBOutlet UILabel*Activity_OldMoneyLable;//旧价钱
@property(nonatomic,weak)IBOutlet UILabel*Activity_PerMoneyLable;//百分比返利

@end
