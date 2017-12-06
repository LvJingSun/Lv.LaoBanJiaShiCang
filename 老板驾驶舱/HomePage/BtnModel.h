//
//  BtnModel.h
//  BusinessCenter
//
//  Created by mac on 16/4/22.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BtnModel : NSObject

@property (nonatomic, copy) NSString *imageName;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *count;

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)btnWithDict:(NSDictionary *)dic;

@end
