//
//  ProductData.h
//  BusinessCenter
//
//  Created by 冯海强 on 13-12-6.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import "BaseData.h"

@interface ProductData : BaseData

@property (nonatomic,readonly) NSArray  *ProductsList;
@property (nonatomic,readonly) NSString *status;
@property (nonatomic,readonly) NSString *msg;


@end


@interface ProductDetailData : BaseData

@property (nonatomic,readonly) NSArray  *ProductPostersList;//海报

@property (nonatomic,readonly) NSString *PClassValue;
@property (nonatomic,readonly) NSString *PClassId;
@property (nonatomic,readonly) NSString *ServiceId;
@property (nonatomic,readonly) NSString *MerchantId;
@property (nonatomic,readonly) NSString *SvcName;
@property (nonatomic,readonly) NSString *SvcSimpleName;
@property (nonatomic,readonly) NSString *ServiceCode;
@property (nonatomic,readonly) NSString *ClassId;
@property (nonatomic,readonly) NSString *ClassValue;
@property (nonatomic,readonly) NSString *SvcSoldAmount;
@property (nonatomic,readonly) NSString *Quantity;
@property (nonatomic,readonly) NSString *CreateDate;
@property (nonatomic,readonly) NSString *ShelfTime;
@property (nonatomic,readonly) NSString *Price;
@property (nonatomic,readonly) NSString *OriginalPrice;
@property (nonatomic,readonly) NSString *Commissionrate;
@property (nonatomic,readonly) NSString *KeyvaildDateS;
@property (nonatomic,readonly) NSString *KeyvaildDateE;
@property (nonatomic,readonly) NSString *Introduction;
@property (nonatomic,readonly) NSString *Explain;
@property (nonatomic,readonly) NSString *Tags;
@property (nonatomic,readonly) NSString *IsAnytimeReturn;
@property (nonatomic,readonly) NSString *IsExpiredReturn;
@property (nonatomic,readonly) NSString *ViolationDescription;
@property (nonatomic,readonly) NSString *IsReservation;
@property (nonatomic,readonly) NSString *Status;
@property (nonatomic,readonly) NSString *MemberId;
@property (nonatomic,readonly) NSString *ResNickName;
@property (nonatomic,readonly) NSString *CreateBy;

@end


@interface ProductPhontoData : BaseData

@property (nonatomic,readonly) NSString *BigPoster;
@property (nonatomic,readonly) NSString *MidPoster;
@property (nonatomic,readonly) NSString *SmlPoster;
@property (nonatomic,readonly) NSString *IsFrontCover;
@property (nonatomic,readonly) NSString *Description;


@end

