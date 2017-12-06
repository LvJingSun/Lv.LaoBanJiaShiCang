//
//  MR_GetGroupModel.h
//  BusinessCenter
//
//  Created by mac on 2017/9/30.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MR_GetGroupModel : NSObject

//@property (nonatomic, copy) NSString *groupName;
//
////1-展开分组 2-收起分组
//@property (nonatomic, copy) NSString *isOpen;
//
//@property (nonatomic, strong) NSArray *getArr;

@property (nonatomic, copy) NSString *week;

@property (nonatomic, copy) NSString *time;

@property (nonatomic, copy) NSString *balance;

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)MR_GetGroupModelWithDict:(NSDictionary *)dic;

@end
