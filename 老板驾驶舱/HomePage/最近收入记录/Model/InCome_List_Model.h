//
//  InCome_List_Model.h
//  BusinessCenter
//
//  Created by mac on 2017/11/1.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InCome_List_Model : NSObject

@property (nonatomic, copy) NSString *OrderNumber;

@property (nonatomic, copy) NSString *NickName;

@property (nonatomic, copy) NSString *TransactionDate;

@property (nonatomic, copy) NSString *Amount;

@property (nonatomic, copy) NSString *Description;

@property (nonatomic, copy) NSString *Type;

- (instancetype)initWithDict:(NSDictionary *)dic;

@end
