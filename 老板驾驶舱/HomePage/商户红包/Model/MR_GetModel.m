//
//  MR_GetModel.m
//  BusinessCenter
//
//  Created by mac on 2017/9/30.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import "MR_GetModel.h"

@implementation MR_GetModel

- (instancetype)initWithDict:(NSDictionary *)dic {
    
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dic];
        
    }
    
    return self;
    
}

+ (instancetype)MR_GetModelWithDict:(NSDictionary *)dic {
    
    return [[self alloc] initWithDict:dic];
    
}

@end
