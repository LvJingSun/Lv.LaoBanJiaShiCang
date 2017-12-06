//
//  InCome_List_Frame.h
//  BusinessCenter
//
//  Created by mac on 2017/11/1.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import <Foundation/Foundation.h>
@class InCome_List_Model;

@interface InCome_List_Frame : NSObject

@property (nonatomic, assign) CGRect countF;

@property (nonatomic, assign) CGRect noTitleF;

@property (nonatomic, assign) CGRect noF;

@property (nonatomic, assign) CGRect typeF;

@property (nonatomic, assign) CGRect nameF;

@property (nonatomic, assign) CGRect timeF;

@property (nonatomic, assign) CGRect lineF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) InCome_List_Model *listmodel;

@end
