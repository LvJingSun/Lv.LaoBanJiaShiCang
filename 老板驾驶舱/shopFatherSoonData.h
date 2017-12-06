//
//  shopFatherSoonData.h
//  BusinessCenter
//
//  Created by 冯海强 on 13-12-13.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import "BaseData.h"

@interface shopFatherSoonData : BaseData
@property (nonatomic,readonly) NSArray  *CityList;
@property (nonatomic,readonly) NSString *status;
@property (nonatomic,readonly) NSString *msg;

@end


@interface shopFatherSoonDetailData : BaseData

@property (nonatomic,readonly) NSString *CityId;
@property (nonatomic,readonly) NSString *CityName;
@property (nonatomic,readonly) NSString *ParentId;


@end