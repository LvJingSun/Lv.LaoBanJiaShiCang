//
//  DelegatepeopleData.h
//  BusinessCenter
//
//  Created by 冯海强 on 13-12-17.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import "BaseData.h"

@interface DelegatepeopleData : BaseData

@property (nonatomic,readonly) NSDictionary  *ResMember;
@property (nonatomic,readonly) NSString *status;
@property (nonatomic,readonly) NSString *msg;

@end

@interface DelegateDetailData : BaseData

@property (nonatomic,readonly) NSString *NewAgentChangeApplicationID;
@property (nonatomic,readonly) NSString *OldRealName;
@property (nonatomic,readonly) NSString *OldMemberID;
@property (nonatomic,readonly) NSString *OldNickName;
@property (nonatomic,readonly) NSString *OldPhone;
@property (nonatomic,readonly) NSString *OldEmail;
@property (nonatomic,readonly) NSString *OldSex;
@property (nonatomic,readonly) NSString *NewRealName;
@property (nonatomic,readonly) NSString *NewMemberID;
@property (nonatomic,readonly) NSString *NewNickName;
@property (nonatomic,readonly) NSString *NewPhone;
@property (nonatomic,readonly) NSString *NewEmail;
@property (nonatomic,readonly) NSString *NewSex;
@property (nonatomic,readonly) NSString *NewReasonChange;
@property (nonatomic,readonly) NSString *NewFeedBackMsg;
@property (nonatomic,readonly) NSString *NewStatus;
@property (nonatomic,readonly) NSString *NewAppFormPhoto;

@end

