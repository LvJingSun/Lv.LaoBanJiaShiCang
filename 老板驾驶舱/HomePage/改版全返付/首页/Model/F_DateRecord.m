//
//  F_DateRecord.m
//  BusinessCenter
//
//  Created by mac on 2017/3/20.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import "F_DateRecord.h"

@implementation F_DateRecord

+ (instancetype)F_DateRecordWithDict:(NSDictionary *)dic {

    return [[self alloc] initWithDict:dic];
    
}

- (instancetype)initWithDict:(NSDictionary *)dic {

    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dic];
        
    }
    
    return self;
    
}

@end
