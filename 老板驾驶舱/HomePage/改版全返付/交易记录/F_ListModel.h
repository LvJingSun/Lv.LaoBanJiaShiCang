//
//  F_ListModel.h
//  BusinessCenter
//
//  Created by mac on 2017/3/15.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface F_ListModel : NSObject

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)F_ListModelWithDict:(NSDictionary *)dic;

@property (nonatomic, copy) NSString *TranRcdsid;

@property (nonatomic, copy) NSString *Jinzhongzi;

@property (nonatomic, copy) NSString *MerchantID;

@property (nonatomic, copy) NSString *info;

@property (nonatomic, copy) NSString *Memberid;

@property (nonatomic, copy) NSString *TransactionType;

@property (nonatomic, copy) NSString *CashierAccountID;

@property (nonatomic, copy) NSString *MerchantShopID;

@property (nonatomic, copy) NSString *CreateDate;

@property (nonatomic, copy) NSString *TransactionDESC;

@property (nonatomic, copy) NSString *TranAccount;

@property (nonatomic, copy) NSString *goodsname;

@property (nonatomic, copy) NSString *cuxiao;

@property (nonatomic, copy) NSString *pic1;

@property (nonatomic, copy) NSString *pic2;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *nstatus;

@property (nonatomic, copy) NSString *allaccount;

@property (nonatomic, copy) NSString *CarNo;

@property (nonatomic, copy) NSString *Brandname;

@property (nonatomic, copy) NSString *TranType;

@property (nonatomic, copy) NSString *jifen;

@property (nonatomic, assign) BOOL isMerchantRed;

@end
