//
//  SendFrameModel.h
//  BusinessCenter
//
//  Created by mac on 2017/3/15.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import <Foundation/Foundation.h>
@class F_ListModel;

@interface SendFrameModel : NSObject

@property (nonatomic, assign) CGRect kehuF;

@property (nonatomic, assign) CGRect picF;

@property (nonatomic, assign) CGRect jingbanF;

@property (nonatomic, assign) CGRect xiaofeiF;

@property (nonatomic, assign) CGRect timeF;

@property (nonatomic, assign) CGRect countF;

@property (nonatomic, assign) CGRect cuxiaoF;

@property (nonatomic, assign) CGRect chexiaoF;

@property (nonatomic, assign) CGRect lineF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) F_ListModel *model;

@end
