//
//  salesrecordData.h
//  BusinessCenter
//
//  Created by 冯海强 on 13-12-6.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import "BaseData.h"

@interface salesrecordData : BaseData

@property (nonatomic,readonly) NSArray  *OrderList;
@property (nonatomic,readonly) NSString *status;
@property (nonatomic,readonly) NSString *msg;

@end


@interface salesrecordDetailData : BaseData

@property (nonatomic,readonly) NSString *OrdCode;
@property (nonatomic,readonly) NSString *NickName;
@property (nonatomic,readonly) NSString *SvcName;
@property (nonatomic,readonly) NSString *ServiceID;
@property (nonatomic,readonly) NSString *UnitPrice;
@property (nonatomic,readonly) NSString *Amount;
@property (nonatomic,readonly) NSString *TotalAmount;

@end