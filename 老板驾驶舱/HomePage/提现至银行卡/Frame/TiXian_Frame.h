//
//  TiXian_Frame.h
//  BusinessCenter
//
//  Created by mac on 2017/11/1.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TiXian_Model;

@interface TiXian_Frame : NSObject

@property (nonatomic, assign) CGRect bandTitleF;

@property (nonatomic, assign) CGRect bandNameF;

@property (nonatomic, assign) CGRect bandCardF;

@property (nonatomic, assign) CGRect balanceTitleF;

@property (nonatomic, assign) CGRect balanceF;

@property (nonatomic, assign) CGRect countF;

@property (nonatomic, assign) CGRect sureF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) TiXian_Model *tixianModel;

@end
