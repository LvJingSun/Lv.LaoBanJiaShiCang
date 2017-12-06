//
//  Income.h
//  yfdeguyigqfiu
//
//  Created by mac on 16/4/12.
//  Copyright © 2016年 WJL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Income : NSObject

@property (nonatomic, copy) NSString *typeName;

@property (nonatomic, copy) NSString *count;

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)modelWithDict:(NSDictionary *)dic;

@end
