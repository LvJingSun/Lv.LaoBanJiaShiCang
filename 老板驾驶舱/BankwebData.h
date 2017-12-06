//
//  BankwebData.h
//  BusinessCenter
//
//  Created by 冯海强 on 13-12-20.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import "BaseData.h"

@interface BankwebData : BaseData

@property (nonatomic,readonly) NSArray  *cNAPSInfo;
@property (nonatomic,readonly) NSString *status;
@property (nonatomic,readonly) NSString *msg;

@end

@interface BankwebDetailData : BaseData

@property (nonatomic,readonly) NSString *OrgValue;
@property (nonatomic,readonly) NSString *OrgName;


@end




