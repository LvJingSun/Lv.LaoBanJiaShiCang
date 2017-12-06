//
//  BasicData.h
//  BusinessCenter
//
//  Created by 冯海强 on 13-12-12.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import "BaseData.h"

@interface BasicData : BaseData

@property (nonatomic,readonly) NSDictionary  *Merchant;
@property (nonatomic,readonly) NSString *status;
@property (nonatomic,readonly) NSString *msg;

@end


@interface BasicDetailData : BaseData

@property (nonatomic,readonly) NSString *status;
@property (nonatomic,readonly) NSString *msg;

@property (nonatomic,readonly) NSArray *MctShopList;//店铺
@property (nonatomic,readonly) NSString *ParentClassName;
@property (nonatomic,readonly) NSString *ParentClassId;
@property (nonatomic,readonly) NSString *ClassName;
@property (nonatomic,readonly) NSString *CityName;
@property (nonatomic,readonly) NSString *AccountCategory;
@property (nonatomic,readonly) NSString *ModifyDate;
@property (nonatomic,readonly) NSString *MerchantId;
@property (nonatomic,readonly) NSString *MerchantCode;
@property (nonatomic,readonly) NSString *ClassId;
@property (nonatomic,readonly) NSString *AllName;
@property (nonatomic,readonly) NSString *Abbreviation;
@property (nonatomic,readonly) NSString *Tel;
@property (nonatomic,readonly) NSString *EnName;
@property (nonatomic,readonly) NSString *WebSite;
@property (nonatomic,readonly) NSString *MerchantTags;
@property (nonatomic,readonly) NSString *Cityid;
@property (nonatomic,readonly) NSString *Briefintro;
@property (nonatomic,readonly) NSString *Status;
@property (nonatomic,readonly) NSString *Businesslicense;
@property (nonatomic,readonly) NSString *Taxcertificate;
@property (nonatomic,readonly) NSString *Legal;
@property (nonatomic,readonly) NSString *Officialcontacts;
@property (nonatomic,readonly) NSString *OfficialcontactsPhone;
@property (nonatomic,readonly) NSString *Treasurer;
@property (nonatomic,readonly) NSString *TreasurerPhone;
@property (nonatomic,readonly) NSString *Fax;
@property (nonatomic,readonly) NSString *OfficialMail;
@property (nonatomic,readonly) NSString *MemberBankcardID;
@property (nonatomic,readonly) NSString *BankId;
@property (nonatomic,readonly) NSString *BankName;
@property (nonatomic,readonly) NSString *BankCode;
@property (nonatomic,readonly) NSString *BranchCode;
@property (nonatomic,readonly) NSString *BranchName;
@property (nonatomic,readonly) NSString *BankcardName;
@property (nonatomic,readonly) NSString *CardNumber;
@property (nonatomic,readonly) NSString *IdCard;
@property (nonatomic,readonly) NSString *ApplactionFormPhoto;
@property (nonatomic,readonly) NSString *BusinesslicensePhoto;
@property (nonatomic,readonly) NSString *Logo;
@property (nonatomic,readonly) NSString *ResMemSex;
@property (nonatomic,readonly) NSString *ResMemRealName;
@property (nonatomic,readonly) NSString *MemberId;
@property (nonatomic,readonly) NSString *ResMemAccount;


@end

@interface ShopDetailData : BaseData

@property (nonatomic,readonly) NSString *Districtame;
@property (nonatomic,readonly) NSString *Areaname;
@property (nonatomic,readonly) NSString *Hc;
@property (nonatomic,readonly) NSString *Businfo;
@property (nonatomic,readonly) NSString *Districtid;
@property (nonatomic,readonly) NSString *Areaid;
@property (nonatomic,readonly) NSString *Cityid;
@property (nonatomic,readonly) NSString *Merchantid;
@property (nonatomic,readonly) NSString *Modifydate;
@property (nonatomic,readonly) NSString *MerchantShopId;
@property (nonatomic,readonly) NSString *Logo;
@property (nonatomic,readonly) NSString *MctName;
@property (nonatomic,readonly) NSString *ShopName;
@property (nonatomic,readonly) NSString *CityName;
@property (nonatomic,readonly) NSString *Address;
@property (nonatomic,readonly) NSString *OpeningHours;
@property (nonatomic,readonly) NSString *BeenCount;
@property (nonatomic,readonly) NSString *InterestedCount;
@property (nonatomic,readonly) NSString *Phone;
@property (nonatomic,readonly) NSString *MapX;
@property (nonatomic,readonly) NSString *MapY;

@end