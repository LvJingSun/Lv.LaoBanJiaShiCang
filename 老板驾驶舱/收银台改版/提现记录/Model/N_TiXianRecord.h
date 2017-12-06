//
//  N_TiXianRecord.h
//  BusinessCenter
//
//  Created by mac on 2017/4/12.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface N_TiXianRecord : NSObject

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)N_TiXianRecordWithDict:(NSDictionary *)dic;

@property (nonatomic, copy) NSString *Amount;

@property (nonatomic, copy) NSString *CreateTime;

@property (nonatomic, copy) NSString *Type;

@end
