//
//  ProductTableCell.h
//  BusinessCenter
//
//  Created by 冯海强 on 13-11-18.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"


@interface ProductTableCell : UITableViewCell

@property(nonatomic,weak)IBOutlet UIImageView*Product_photoImage;//产品列表头像
@property(nonatomic,weak)IBOutlet UILabel*Product_NameTitleLable;//名称、标题
//说明
@property(nonatomic,weak)IBOutlet UILabel*Product_NumLablename;//中文说明：数量
@property(nonatomic,weak)IBOutlet UILabel*Product_TimeLablename;//时间(创建、下架)
//

@property(nonatomic,weak)IBOutlet UILabel*Product_NumLable;//数量
@property(nonatomic,weak)IBOutlet UILabel*Product_TimeLable;//时间
//价钱及返利
@property(nonatomic,weak)IBOutlet UILabel*Product_NewMoneylabel;//新价钱
@property(nonatomic,weak)IBOutlet UILabel*Porduct_OldMoneyLable;//旧价钱
@property(nonatomic,weak)IBOutlet UILabel*Porduct_PerMoneyLable;//百分比返利

@end
