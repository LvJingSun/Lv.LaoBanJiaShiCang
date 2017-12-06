//
//  MR_GetModel.h
//  BusinessCenter
//
//  Created by mac on 2017/9/30.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MR_GetModel : NSObject

@property (nonatomic, copy) NSString *time;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, copy) NSString *balance;

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)MR_GetModelWithDict:(NSDictionary *)dic;

@end
