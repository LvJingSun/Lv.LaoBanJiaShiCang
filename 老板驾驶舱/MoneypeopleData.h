//
//  MoneypeopleData.h
//  BusinessCenter
//
//  Created by 冯海强 on 13-12-16.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import "BaseData.h"

@interface MoneypeopleData : BaseData

@property (nonatomic,readonly) NSArray  *CashierInfoList;
@property (nonatomic,readonly) NSString *status;
@property (nonatomic,readonly) NSString *msg;

@end

@interface MoneypeopleDetailData : BaseData

@property (nonatomic,readonly) NSString *CashierAccountID;
@property (nonatomic,readonly) NSString *LoginIp;
@property (nonatomic,readonly) NSString *LoginTime;
@property (nonatomic,readonly) NSString *CreateTime;
@property (nonatomic,readonly) NSString *ShopId;
@property (nonatomic,readonly) NSString *ShopName;
@property (nonatomic,readonly) NSString *Account;
@property (nonatomic,readonly) NSString *Status;
@property (nonatomic,readonly) NSString *Name;
@property (nonatomic,readonly) NSString *PhotoHead;
@property (nonatomic,readonly) NSString *Phone;


@end