//
//  New_RecordFrame.h
//  CashierDeskIphone
//
//  Created by mac on 2017/2/28.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

@class F_ListModel;

@interface New_RecordFrame : NSObject

//交易对象
@property (nonatomic, assign) CGRect nameF;

@property (nonatomic, assign) CGRect line1F;

//金种子数量
@property (nonatomic, assign) CGRect countF;

//图片状态
@property (nonatomic, assign) CGRect picF;
@property (nonatomic, assign) CGRect statusF;

@property (nonatomic, assign) CGRect line2F;

//商品信息标题
@property (nonatomic, assign) CGRect p_nameF;

//商品名称
@property (nonatomic, assign) CGRect productF;

//交易金额标题
@property (nonatomic, assign) CGRect t_countF;

//交易金额
@property (nonatomic, assign) CGRect tranCountF;

//全返金额标题
@property (nonatomic, assign) CGRect a_countF;

//全返金额
@property (nonatomic, assign) CGRect allCountF;

@property (nonatomic, assign) CGRect line3F;

//操作员工标题
@property (nonatomic, assign) CGRect c_staffF;

//操作员工
@property (nonatomic, assign) CGRect staffF;

//所属店铺标题
@property (nonatomic, assign) CGRect s_shopF;

//所属店铺
@property (nonatomic, assign) CGRect shopF;

//促销员标题
@property (nonatomic, assign) CGRect c_cuxiaoyuanF;

//促销员
@property (nonatomic, assign) CGRect cuxiaoyuanF;

//时间标题
@property (nonatomic, assign) CGRect t_timeF;

//时间
@property (nonatomic, assign) CGRect timeF;

//单号标题
@property (nonatomic, assign) CGRect d_danhaoF;

//单号
@property (nonatomic, assign) CGRect danhaoF;

@property (nonatomic, assign) CGRect line4F;

//图片1标题
@property (nonatomic, assign) CGRect p_pic1F;

//图片1
@property (nonatomic, assign) CGRect pic1F;

//图片2标题
@property (nonatomic, assign) CGRect p_pic2F;

//图片2
@property (nonatomic, assign) CGRect pic2F;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) F_ListModel *record;

@end
