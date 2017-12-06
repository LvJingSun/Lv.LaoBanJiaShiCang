//
//  MR_Send_Frame.h
//  BusinessCenter
//
//  Created by mac on 2017/10/10.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MR_SendModel;

@interface MR_Send_Frame : NSObject

@property (nonatomic, assign) CGRect dateF;

@property (nonatomic, assign) CGRect countF;

@property (nonatomic, assign) CGRect statusF;

@property (nonatomic, assign) CGRect lineF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) MR_SendModel *send_model;

@end
