//
//  BasicFatherSoonData.h
//  BusinessCenter
//
//  Created by 冯海强 on 13-12-12.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import "BaseData.h"

@interface BasicFatherSoonData : BaseData

@property (nonatomic,readonly) NSArray  *MerchantClassList;
@property (nonatomic,readonly) NSString *status;
@property (nonatomic,readonly) NSString *msg;

@end


@interface BasicFatherSoonDetailData : BaseData

@property (nonatomic,readonly) NSString *ClassID;
@property (nonatomic,readonly) NSString *ClassName;


@end
