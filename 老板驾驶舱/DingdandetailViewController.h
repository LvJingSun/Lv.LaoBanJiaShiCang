//
//  DingdandetailViewController.h
//  BusinessCenter
//
//  Created by 冯海强 on 14-4-9.
//  Copyright (c) 2014年 冯海强. All rights reserved.
//

#import "BaseViewController.h"
#import "DingdangData.h"

@interface DingdandetailViewController : BaseViewController

@property(nonatomic,strong)DingdangDetailData*Dingdandetail;


@property(nonatomic,weak) IBOutlet UILabel  *NickNamelabel;
@property(nonatomic,weak) IBOutlet UILabel  *UseDescriptlabel;
@property(nonatomic,weak) IBOutlet UILabel  *UnitPricelabel;
@property(nonatomic,weak) IBOutlet UILabel  *TotalAmountlabel;
@property(nonatomic,weak) IBOutlet UILabel  *OrdersCodelabel;
@property(nonatomic,weak) IBOutlet UILabel  *Amountlabel;


@end
