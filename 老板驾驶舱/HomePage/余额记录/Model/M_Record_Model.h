//
//  M_Record_Model.h
//  HuiHui
//
//  Created by mac on 2017/10/12.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface M_Record_Model : NSObject

//1-充值 2-支出
@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *titlestyle;

@property (nonatomic, copy) NSString *createtime;

@property (nonatomic, copy) NSString *balance;

//@property (nonatomic, copy) NSString *date;
//
//@property (nonatomic, copy) NSString *count;

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)M_Record_ModelWithDict:(NSDictionary *)dic;

@end
