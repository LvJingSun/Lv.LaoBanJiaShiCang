//
//  N_TiXianRecord.m
//  BusinessCenter
//
//  Created by mac on 2017/4/12.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import "N_TiXianRecord.h"

@implementation N_TiXianRecord

- (instancetype)initWithDict:(NSDictionary *)dic {

    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dic];
        
    }
    
    return self;
    
}

+ (instancetype)N_TiXianRecordWithDict:(NSDictionary *)dic {

    return [[self alloc] initWithDict:dic];
    
}

@end
