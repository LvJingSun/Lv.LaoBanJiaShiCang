//
//  N_RevenueModel.h
//  BusinessCenter
//
//  Created by mac on 2017/4/13.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface N_RevenueModel : NSObject

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)N_RevenueModelWithDict:(NSDictionary *)dic;

@property (nonatomic, copy) NSString *TransactionDate;

@property (nonatomic, copy) NSString *Amount;

@property (nonatomic, copy) NSString *Type;

@property (nonatomic, copy) NSString *Description;

@end
