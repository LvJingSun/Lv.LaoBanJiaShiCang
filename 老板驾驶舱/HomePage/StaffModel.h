//
//  StaffModel.h
//  BusinessCenter
//
//  Created by mac on 16/4/25.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StaffModel : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *img;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *tel;

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)modelWithDict:(NSDictionary *)dic;

@end
