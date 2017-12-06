//
//  AccountController.h
//  BusinessCenter
//
//  Created by mac on 16/5/23.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountController : UIViewController

@property (nonatomic, copy) NSString *memberID;

@property (nonatomic, copy) NSString *yuanGongID;

@property (nonatomic, copy) NSString *merchantShopID;

@property (nonatomic, copy) NSString *account;

@property (nonatomic, copy) NSString *password;

@property (nonatomic, copy) NSString *realName;

@property (nonatomic, copy) NSString *role;

@property (nonatomic, copy) NSString *zhiWeiID;

@property (nonatomic, copy) NSString *nickName;

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, copy) NSString *yongJinLevelID;

@property (nonatomic, copy) NSString *jiBenGongZi;

@property (nonatomic, strong) NSDictionary *touXiangDic;

@end
