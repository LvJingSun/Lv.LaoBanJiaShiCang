//
//  DianPu.h
//  BusinessCenter
//
//  Created by mac on 2017/1/3.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DianPu : NSObject

@property (nonatomic, copy) NSString *MerchantShop;

@property (nonatomic, copy) NSString *MerchantShopID;

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)DianPuWithDict:(NSDictionary *)dic;

@end
