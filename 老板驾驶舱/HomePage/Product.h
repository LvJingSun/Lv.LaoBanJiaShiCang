//
//  Product.h
//  BusinessCenter
//
//  Created by mac on 16/4/25.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *img;

@property (nonatomic, copy) NSString *count;

@property (nonatomic, copy) NSString *inPrice;

@property (nonatomic, copy) NSString *outPrice;

@property (nonatomic, copy) NSString *remarks;

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)modelWithDIct:(NSDictionary *)dic;

@end
