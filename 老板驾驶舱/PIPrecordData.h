//
//  PIPrecordData.h
//  BusinessCenter
//
//  Created by 冯海强 on 13-12-9.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import "BaseData.h"

@interface PIPrecordData : BaseData

@property (nonatomic,readonly) NSArray  *MctWithdrawalList;
@property (nonatomic,readonly) NSString *status;
@property (nonatomic,readonly) NSString *msg;


@end


@interface PiprecordDetailData : BaseData


@property (nonatomic,readonly) NSString *Amount;
@property (nonatomic,readonly) NSString *CreateTime;


@end