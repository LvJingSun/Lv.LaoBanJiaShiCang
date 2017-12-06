//
//  N_RevenueModel.m
//  BusinessCenter
//
//  Created by mac on 2017/4/13.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import "N_RevenueModel.h"

@implementation N_RevenueModel

- (instancetype)initWithDict:(NSDictionary *)dic {

    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dic];
        
    }
    
    return self;
    
}

+ (instancetype)N_RevenueModelWithDict:(NSDictionary *)dic {

    return [[self alloc] initWithDict:dic];
    
}

@end
