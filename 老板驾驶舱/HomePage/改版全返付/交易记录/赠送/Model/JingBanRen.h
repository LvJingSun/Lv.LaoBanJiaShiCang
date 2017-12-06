//
//  JingBanRen.h
//  BusinessCenter
//
//  Created by mac on 2017/1/3.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JingBanRen : NSObject

@property (nonatomic, copy) NSString *CashierAccount;

@property (nonatomic, copy) NSString *CashierAccountID;

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)JingBanRenWithDict:(NSDictionary *)dic;

@end
