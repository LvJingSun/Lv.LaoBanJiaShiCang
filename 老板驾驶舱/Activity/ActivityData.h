//
//  ActivityData.h
//  BusinessCenter
//
//  Created by 冯海强 on 13-12-11.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//
#import "BaseData.h"

@interface ActivityData : BaseData

@property (nonatomic,readonly) NSArray  *ActivityList;
@property (nonatomic,readonly) NSString *status;
@property (nonatomic,readonly) NSString *msg;

@end

@interface ActivityDetailData : BaseData

@property (nonatomic,readonly) NSArray  *ActivityPosterList;//海报
@property (nonatomic,readonly) NSString *ActivityId;
@property (nonatomic,readonly) NSString *ActivityCode;
@property (nonatomic,readonly) NSString *MerchantId;
@property (nonatomic,readonly) NSString *ActivityName;
@property (nonatomic,readonly) NSString *ActStartDate;
@property (nonatomic,readonly) NSString *ActEndDate;
@property (nonatomic,readonly) NSString *ActStartTime;
@property (nonatomic,readonly) NSString *ActEndtTime;
@property (nonatomic,readonly) NSString *OriginalPrice;
@property (nonatomic,readonly) NSString *Price;
@property (nonatomic,readonly) NSString *Brokerage;
@property (nonatomic,readonly) NSString *BrokerageAmount;
@property (nonatomic,readonly) NSString *Content;
@property (nonatomic,readonly) NSString *Explain;
@property (nonatomic,readonly) NSString *ActivityType;
@property (nonatomic,readonly) NSString *MemberId;
@property (nonatomic,readonly) NSString *NickName;
@property (nonatomic,readonly) NSString *CityId;
@property (nonatomic,readonly) NSString *CityName;
@property (nonatomic,readonly) NSString *AreaId;
@property (nonatomic,readonly) NSString *AreaName;
@property (nonatomic,readonly) NSString *DistrictId;
@property (nonatomic,readonly) NSString *DistrictName;
@property (nonatomic,readonly) NSString *ActivityTags;
@property (nonatomic,readonly) NSString *MapX;
@property (nonatomic,readonly) NSString *MapY;
@property (nonatomic,readonly) NSString *HC;
@property (nonatomic,readonly) NSString *Address;
@property (nonatomic,readonly) NSString *PeoperNumMin;
@property (nonatomic,readonly) NSString *PeoperNumMax;
@property (nonatomic,readonly) NSString *AgeMin;
@property (nonatomic,readonly) NSString *AgeMax;
@property (nonatomic,readonly) NSString *Sex;
@property (nonatomic,readonly) NSString *Status;
@property (nonatomic,readonly) NSString *ViolationdeScription;
@property (nonatomic,readonly) NSString *IsAnyTimeReturn;
@property (nonatomic,readonly) NSString *IsExpiredReturn;
@property (nonatomic,readonly) NSString *IsReservation;
@property (nonatomic,readonly) NSString *KeyVaildDateS;
@property (nonatomic,readonly) NSString *KeyVaildDateE;
@property (nonatomic,readonly) NSString *CreateDate;
@property (nonatomic,readonly) NSString *RegStopTime;


@end


@interface ActivityPhontoData : BaseData

@property (nonatomic,readonly) NSString *BigPoster;
@property (nonatomic,readonly) NSString *MidPoster;
@property (nonatomic,readonly) NSString *SmlPoster;
@property (nonatomic,readonly) NSString *IsFrontCover;
@property (nonatomic,readonly) NSString *Description;


@end

