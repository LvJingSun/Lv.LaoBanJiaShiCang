//
//  ActMemberData.h
//  BusinessCenter
//
//  Created by 冯海强 on 13-12-11.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import "BaseData.h"

@interface MemberData : BaseData


@property (nonatomic,readonly) NSArray  *ActMemberList;
@property (nonatomic,readonly) NSString *status;
@property (nonatomic,readonly) NSString *msg;

@end

@interface MemberDetailData : BaseData

@property (nonatomic,readonly) NSString *PhotoHead;
@property (nonatomic,readonly) NSString *NickName;
@property (nonatomic,readonly) NSString *FenSi;
@property (nonatomic,readonly) NSString *GuanZhu;
@property (nonatomic,readonly) NSString *FenXiang;

@end