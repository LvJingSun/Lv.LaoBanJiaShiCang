//
//  CuXiaoYuan.m
//  BusinessCenter
//
//  Created by mac on 2017/1/3.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import "CuXiaoYuan.h"

@implementation CuXiaoYuan

- (instancetype)initWithDict:(NSDictionary *)dic {

    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dic];
        
    }
    
    return self;
    
}

+ (instancetype)CuXiaoYuanWithDict:(NSDictionary *)dic {

    return [[self alloc] initWithDict:dic];
    
}

@end
