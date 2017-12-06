//
//  EditStaffController.h
//  BusinessCenter
//
//  Created by mac on 16/5/11.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditStaffController : UIViewController

@property (nonatomic, copy) NSString *memberID;

@property (nonatomic, copy) NSString *yuanGongID;

@property (nonatomic, copy) NSString *merchantShopID;

@property (nonatomic, copy) NSString *realName;

@property (nonatomic, copy) NSString *role;

@property (nonatomic, copy) NSString *zhiWeiID;

@property (nonatomic, copy) NSString *nickName;

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, copy) NSString *account;

@property (nonatomic, copy) NSString *yongJinLevelID;

@property (nonatomic, copy) NSString *jiBenGongZi;

@property (nonatomic, copy) NSString *YongJinLevelMengCheng;

@property (nonatomic, copy) NSString *touXiangImage;

@property (nonatomic, strong) NSArray *shangpuArray;

@property (nonatomic, strong) NSArray *positionArray;

@property (nonatomic, strong) NSArray *levelArray;

@end
