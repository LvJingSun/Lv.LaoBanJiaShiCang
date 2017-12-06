//
//  MR_SendModel.m
//  BusinessCenter
//
//  Created by mac on 2017/9/29.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import "MR_SendModel.h"

@implementation MR_SendModel

- (instancetype)initWithDict:(NSDictionary *)dic {
    
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dic];
        
    }
    
    return self;
    
}

+ (instancetype)MR_SendModelWithDict:(NSDictionary *)dic {
    
    return [[self alloc] initWithDict:dic];
    
}

@end
