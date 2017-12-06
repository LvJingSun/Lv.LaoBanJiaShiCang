//
//  MR_GetFrame.h
//  BusinessCenter
//
//  Created by mac on 2017/9/30.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MR_GetModel;

@interface MR_GetFrame : NSObject

@property (nonatomic, assign) CGRect nameF;

@property (nonatomic, assign) CGRect timeF;

@property (nonatomic, assign) CGRect lineF;

@property (nonatomic, assign) CGRect countF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) MR_GetModel *getModel;

@end
