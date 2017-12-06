//
//  New_YuEFrame.h
//  BusinessCenter
//
//  Created by mac on 2017/4/11.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import <Foundation/Foundation.h>
@class New_TiXianData;

@interface New_YuEFrame : NSObject

@property (nonatomic, assign) CGRect yueTitleF;

@property (nonatomic, assign) CGRect yueCountF;

@property (nonatomic, assign) CGRect line1F;

@property (nonatomic, assign) CGRect cardTitleF;

@property (nonatomic, assign) CGRect cardNumberF;

@property (nonatomic, assign) CGRect line2F;

@property (nonatomic, assign) CGRect hangF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) New_TiXianData *dataModel;

@end
