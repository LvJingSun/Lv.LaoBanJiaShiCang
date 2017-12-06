//
//  BankData.h
//  BusinessCenter
//
//  Created by 冯海强 on 13-12-19.
//  Copyright (c) 2013年 冯海强. All rights reserved.


#import "BaseData.h"

@interface BankData : BaseData

@property (nonatomic,readonly) NSDictionary  *MctBankCard;
@property (nonatomic,readonly) NSString *status;
@property (nonatomic,readonly) NSString *msg;

@end

@interface BankDetailData : BaseData

@property (nonatomic,readonly) NSString *BankCardChangeApplicationID;
@property (nonatomic,readonly) NSString *OldAccountCategory;
@property (nonatomic,readonly) NSString *OldCardName;
@property (nonatomic,readonly) NSString *OldBankCode;//
@property (nonatomic,readonly) NSString *OldBankName;
@property (nonatomic,readonly) NSString *OldBranchCode;
@property (nonatomic,readonly) NSString *OldBranchName;
@property (nonatomic,readonly) NSString *OldCardNumber;
@property (nonatomic,readonly) NSString *NewAccountCategory;//
@property (nonatomic,readonly) NSString *NewCardName;
@property (nonatomic,readonly) NSString *NewBankCode;
@property (nonatomic,readonly) NSString *NewBankName;
@property (nonatomic,readonly) NSString *NewBranchCode;
@property (nonatomic,readonly) NSString *NewBranchName;
@property (nonatomic,readonly) NSString *NewCardNumber;
@property (nonatomic,readonly) NSString *NewReasonChange;
@property (nonatomic,readonly) NSString *NewStatus;//
@property (nonatomic,readonly) NSString *NewAppFormPhoto;
@property (nonatomic,readonly) NSString *NewFeedBackMsg;

@end







