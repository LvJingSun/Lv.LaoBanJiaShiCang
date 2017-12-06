//
//  TiXian_Model.m
//  BusinessCenter
//
//  Created by mac on 2017/11/1.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import "TiXian_Model.h"

@implementation TiXian_Model

- (instancetype)initWithDict:(NSDictionary *)dic {
    
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dic];
        
    }
    
    return self;
    
}

@end
