//
//  BusinessshopCell.h
//  BusinessCenter
//
//  Created by 冯海强 on 13-11-21.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"


@interface BusinessshopCell : UITableViewCell

@property(nonatomic,weak)IBOutlet UILabel*Businessshop_ShopnameLabel;//店名
@property(nonatomic,weak)IBOutlet UILabel*Businessshop_ShopadressLabel;//地址
@property(nonatomic,weak)IBOutlet UILabel*Businessshop_ShoptimeLabel;//营业时间
@property(nonatomic,weak)IBOutlet UILabel*Businessshop_ShopphoneLabel;//电话
@property(nonatomic,weak)IBOutlet UILabel*Businessshop_ShopbusLabel;//公交


@end
