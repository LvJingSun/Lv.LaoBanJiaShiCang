//
//  F_DateRecord.h
//  BusinessCenter
//
//  Created by mac on 2017/3/20.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface F_DateRecord : NSObject

+ (instancetype)F_DateRecordWithDict:(NSDictionary *)dic;

- (instancetype)initWithDict:(NSDictionary *)dic;

@property (nonatomic, assign) int ID;

@property (nonatomic, assign) float Num;

@property (nonatomic, copy) NSString *MctID;

@property (nonatomic, copy) NSString *DTime;

@end
