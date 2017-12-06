//
//  T_ListFrame.h
//  BusinessCenter
//
//  Created by mac on 2017/11/1.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import <Foundation/Foundation.h>
@class T_ListModel;

@interface T_ListFrame : NSObject

@property (nonatomic, assign) CGRect countF;

@property (nonatomic, assign) CGRect timeF;

@property (nonatomic, assign) CGRect statusF;

@property (nonatomic, assign) CGRect lineF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) T_ListModel *listModel;

@end
