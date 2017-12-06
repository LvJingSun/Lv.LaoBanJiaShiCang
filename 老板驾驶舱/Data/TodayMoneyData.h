//
//  TodayMoneyData.h
//  BusinessCenter
//
//  Created by 冯海强 on 13-12-6.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import "BaseData.h"

@interface TodayMoneyData : BaseData


@property (nonatomic,readonly) NSArray  *MerchantTranRcdsList;
@property (nonatomic,readonly) NSString *status;
@property (nonatomic,readonly) NSString *msg;

@end


@interface TodayDetailData : BaseData

@property (nonatomic,readonly) NSString *TransactionDate;
@property (nonatomic,readonly) NSString *Amount;
@property (nonatomic,readonly) NSString *Description;

@end