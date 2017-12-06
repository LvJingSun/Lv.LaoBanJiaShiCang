//
//  Product.m
//  BusinessCenter
//
//  Created by mac on 16/4/25.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import "Product.h"

@implementation Product

- (instancetype)initWithDict:(NSDictionary *)dic {

    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dic];
        
    }
    
    return self;
    
}

+ (instancetype)modelWithDIct:(NSDictionary *)dic {

    return [[self alloc] initWithDict:dic];
    
}

@end
