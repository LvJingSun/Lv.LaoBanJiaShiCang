//
//  BtnModel.m
//  BusinessCenter
//
//  Created by mac on 16/4/22.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import "BtnModel.h"

@implementation BtnModel

- (instancetype)initWithDict:(NSDictionary *)dic {

    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dic];
        
    }
    
    return self;
    
}

+ (instancetype)btnWithDict:(NSDictionary *)dic {

    return [[self alloc] initWithDict:dic];
    
}

@end
