//
//  MR_SendModel.h
//  BusinessCenter
//
//  Created by mac on 2017/9/29.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MR_SendModel : NSObject

//@property (nonatomic, copy) NSString *date;
//
//@property (nonatomic, copy) NSString *count;
//
//@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *time;

@property (nonatomic, copy) NSString *balance;

@property (nonatomic, copy) NSString *style;

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)MR_SendModelWithDict:(NSDictionary *)dic;

@end
