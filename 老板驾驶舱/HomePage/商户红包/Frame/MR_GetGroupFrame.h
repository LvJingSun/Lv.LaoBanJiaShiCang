//
//  MR_GetGroupFrame.h
//  BusinessCenter
//
//  Created by mac on 2017/10/13.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MR_GetGroupModel;

@interface MR_GetGroupFrame : NSObject

@property (nonatomic, assign) CGRect titleF;

@property (nonatomic, assign) CGRect balanceF;

@property (nonatomic, assign) CGRect lineF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) MR_GetGroupModel *groupModel;

@end
