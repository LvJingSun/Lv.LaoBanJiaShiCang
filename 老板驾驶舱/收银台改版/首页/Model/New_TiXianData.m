//
//  New_TiXianData.m
//  BusinessCenter
//
//  Created by mac on 2017/4/11.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import "New_TiXianData.h"

@implementation New_TiXianData

- (instancetype)initWithDict:(NSDictionary *)dic {

    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dic];
        
    }
    
    return self;
    
}

+ (instancetype)New_TiXianDataWithDict:(NSDictionary *)dic {

    return [[self alloc] initWithDict:dic];
    
}

@end
