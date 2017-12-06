//
//  TiXian_Model.h
//  BusinessCenter
//
//  Created by mac on 2017/11/1.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TiXian_Model : NSObject

@property (nonatomic, copy) NSString *bandName;

@property (nonatomic, copy) NSString *bandCard;

@property (nonatomic, copy) NSString *balance;

@property (nonatomic, copy) NSString *count;

- (instancetype)initWithDict:(NSDictionary *)dic;

@end
