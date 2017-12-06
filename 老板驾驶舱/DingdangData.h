//
//  DingdangData.h
//  BusinessCenter
//
//  Created by 冯海强 on 13-12-9.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import "BaseData.h"

@interface DingdangData : BaseData

@property (nonatomic,readonly) NSArray  *PrOrderList;
@property (nonatomic,readonly) NSString *status;
@property (nonatomic,readonly) NSString *msg;

@end


@interface DingdangDetailData : BaseData

@property (nonatomic,readonly) NSString *OrdersCode;
@property (nonatomic,readonly) NSString *NickName;
@property (nonatomic,readonly) NSString *UseDescript;
@property (nonatomic,readonly) NSString *Amount;
@property (nonatomic,readonly) NSString *UseDate;
@property (nonatomic,readonly) NSString *UnitPrice;
@property (nonatomic,readonly) NSString *TotalAmount;

@end



