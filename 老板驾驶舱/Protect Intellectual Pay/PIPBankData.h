//
//  PIPBankData.h
//  BusinessCenter
//
//  Created by 冯海强 on 13-12-9.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import "BaseData.h"

@interface PIPBankData : BaseData
@property (nonatomic,readonly) NSDictionary  *BZFInfo;
@property (nonatomic,readonly) NSString *status;
@property (nonatomic,readonly) NSString *msg;


@end


@interface PIPBankDetailData : BaseData

@property (nonatomic,readonly) NSString *TotalNumber;
@property (nonatomic,readonly) NSString *TotalAmount;
@property (nonatomic,readonly) NSString *CardNumber;

@end
