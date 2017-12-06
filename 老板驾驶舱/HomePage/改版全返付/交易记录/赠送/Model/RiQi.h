//
//  RiQi.h
//  BusinessCenter
//
//  Created by mac on 2017/1/3.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RiQi : NSObject

@property (nonatomic, copy) NSString *CreateDate;

@property (nonatomic, copy) NSString *CreateDateID;

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)RiQiWithDict:(NSDictionary *)dic;

@end
