//
//  MR_GetGroupModel.m
//  BusinessCenter
//
//  Created by mac on 2017/9/30.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import "MR_GetGroupModel.h"
#import "MR_GetModel.h"

@implementation MR_GetGroupModel

- (instancetype)initWithDict:(NSDictionary *)dic {
    
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dic];
        
    }
    
    return self;
    
}

+ (instancetype)MR_GetGroupModelWithDict:(NSDictionary *)dic {
    
    return [[self alloc] initWithDict:dic];
    
}

@end
