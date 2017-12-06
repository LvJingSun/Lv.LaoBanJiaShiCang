//
//  New_TiXianData.h
//  BusinessCenter
//
//  Created by mac on 2017/4/11.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface New_TiXianData : NSObject

//提现总金额
@property (nonatomic, copy) NSString *TotalNumber;
//提现次数
@property (nonatomic, copy) NSString *TotalAmount;
//收款账号
@property (nonatomic, copy) NSString *CardNumber;

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)New_TiXianDataWithDict:(NSDictionary *)dic;

@end
