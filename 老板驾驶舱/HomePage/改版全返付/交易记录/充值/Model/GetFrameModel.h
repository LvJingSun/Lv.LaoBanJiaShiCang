//
//  GetFrameModel.h
//  BusinessCenter
//
//  Created by mac on 2017/3/15.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import <Foundation/Foundation.h>
@class F_ListModel;

@interface GetFrameModel : NSObject

//交易类型
@property (nonatomic, assign) CGRect typeF;

//金种子数量
@property (nonatomic, assign) CGRect countF;

//交易时间
@property (nonatomic, assign) CGRect timeF;

//来源
@property (nonatomic, assign) CGRect sourceF;

//线
@property (nonatomic, assign) CGRect lineF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) F_ListModel *listmodel;

@end
