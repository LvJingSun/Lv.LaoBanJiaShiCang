//
//  KeHu.h
//  BusinessCenter
//
//  Created by mac on 2017/1/3.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeHu : NSObject

@property (nonatomic, copy) NSString *Memberid;

@property (nonatomic, copy) NSString *memID;

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)KeHuWithDict:(NSDictionary *)dic;

@end
