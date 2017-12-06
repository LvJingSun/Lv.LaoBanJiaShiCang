//
//  CuXiaoYuan.h
//  BusinessCenter
//
//  Created by mac on 2017/1/3.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CuXiaoYuan : NSObject

@property (nonatomic, copy) NSString *Cuxiaoyuan;

@property (nonatomic, copy) NSString *CuxiaoyuanID;

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)CuXiaoYuanWithDict:(NSDictionary *)dic;

@end
