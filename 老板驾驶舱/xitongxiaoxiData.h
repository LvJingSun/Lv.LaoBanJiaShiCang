//
//  xitongxiaoxiData.h
//  BusinessCenter
//
//  Created by 冯海强 on 13-12-6.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import "BaseData.h"

@interface xitongxiaoxiData : BaseData

@property (nonatomic,readonly) NSArray  *MerchantMessageList;
@property (nonatomic,readonly) NSString *status;
@property (nonatomic,readonly) NSString *msg;

@end


@interface xitongxiaoxiDetailData : BaseData

@property (nonatomic,readonly) NSString *MsgTitle;
@property (nonatomic,readonly) NSString *MsgCot;
@property (nonatomic,readonly) NSString *CreateDate;
@property (nonatomic,readonly) NSString *MsgLink;
@property (nonatomic,readonly) NSString *NickName;


@end