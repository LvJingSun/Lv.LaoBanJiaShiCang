//
//  Manager.h
//  BusinessCenter
//
//  Created by mac on 16/5/10.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Manager : NSObject

@property (nonatomic, copy) NSString *pic;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *manage;

@property (nonatomic, copy) NSString *count;

@property (nonatomic, copy) NSString *inPrice;

@property (nonatomic, copy) NSString *outPrice;

@property (nonatomic, copy) NSString *supplier;

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)manageWithDict:(NSDictionary *)dic;

@end
