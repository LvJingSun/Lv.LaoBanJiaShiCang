//
//  T_ListModel.h
//  BusinessCenter
//
//  Created by mac on 2017/11/1.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface T_ListModel : NSObject

@property (nonatomic, copy) NSString *balance;

@property (nonatomic, copy) NSString *time;

@property (nonatomic, copy) NSString *status;

- (instancetype)initWithDict:(NSDictionary *)dic;

@end
