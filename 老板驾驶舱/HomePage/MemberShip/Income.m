//
//  Income.m
//  yfdeguyigqfiu
//
//  Created by mac on 16/4/12.
//  Copyright © 2016年 WJL. All rights reserved.
//

#import "Income.h"

@implementation Income

- (instancetype)initWithDict:(NSDictionary *)dic {

    if (self = [super init]) {
        
        [self setValue:dic[@"typeName"] forKey:@"typeName"];
        
        [self setValue:dic[@"count"] forKey:@"count"];
    }
    
    return self;
}

+ (instancetype)modelWithDict:(NSDictionary *)dic {
    
    return [[self alloc] initWithDict:dic];
    
}

@end
