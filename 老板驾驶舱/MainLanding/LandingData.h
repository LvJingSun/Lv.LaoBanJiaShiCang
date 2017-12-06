//
//  LandingData.h
//  BusinessCenter
//
//  Created by 冯海强 on 13-12-19.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import "BaseData.h"

@interface LandingData : BaseData
@property (nonatomic,readonly) NSDictionary  *member;
@property (nonatomic,readonly) NSString *status;
@property (nonatomic,readonly) NSString *msg;
@property (nonatomic,readonly) NSString *sDatetime;

@property (nonatomic,readonly) NSString *Istype;

@property (nonatomic,readonly) NSString *Anzhuo;

@property (nonatomic,readonly) NSString *Iphone;

@property (nonatomic,readonly) NSString *Phone;


@end

@interface landingDetailData : BaseData

@property (nonatomic,readonly) NSString *PhotoMidUrl;
@property (nonatomic,readonly) NSString *memberId;
@property (nonatomic,readonly) NSString *account;
@property (nonatomic,readonly) NSString *name;
@property (nonatomic,readonly) NSString *nick;
@property (nonatomic,readonly) NSString *versionNumber;
@property (nonatomic,readonly) NSString *appPkgUrl;
@property (nonatomic,readonly) NSString *coreIntro;

@end
