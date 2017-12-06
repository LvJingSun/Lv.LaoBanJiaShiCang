//
//  Manager.m
//  BusinessCenter
//
//  Created by mac on 16/5/10.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import "Manager.h"

@implementation Manager

- (instancetype)initWithDict:(NSDictionary *)dic {

    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dic];
        
    }
    
    return self;
    
}

+ (instancetype)manageWithDict:(NSDictionary *)dic {

    return [[self alloc] initWithDict:dic];
    
}

@end
