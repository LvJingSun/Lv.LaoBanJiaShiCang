//
//  N_TiXianListFrame.h
//  BusinessCenter
//
//  Created by mac on 2017/4/12.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import <Foundation/Foundation.h>
@class N_TiXianRecord;

@interface N_TiXianListFrame : NSObject

@property (nonatomic, assign) CGRect typeF;

@property (nonatomic, assign) CGRect dateF;

@property (nonatomic, assign) CGRect yueCountF;

@property (nonatomic, assign) CGRect countF;

@property (nonatomic, assign) CGRect lineF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) N_TiXianRecord *recordModel;

@end
