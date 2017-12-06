//
//  T_ListFrame.m
//  BusinessCenter
//
//  Created by mac on 2017/11/1.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import "T_ListFrame.h"
#import "T_ListModel.h"
#import "RechargeHeader.h"

@implementation T_ListFrame

-(void)setListModel:(T_ListModel *)listModel {
    
    _listModel = listModel;
    
    CGFloat countX = ScreenWidth * 0.05;
    
    CGFloat countY = 10;
    
    CGFloat countW = ScreenWidth * 0.5;
    
    CGFloat countH = 20;
    
    _countF = CGRectMake(countX, countY, countW, countH);
    
    CGFloat timeX = countX;
    
    CGFloat timeY = CGRectGetMaxY(_countF) + 10;
    
    CGFloat timeW = countW;
    
    CGFloat timeH = 15;
    
    _timeF = CGRectMake(timeX, timeY, timeW, timeH);
    
    CGFloat statusX = ScreenWidth * 0.6;
    
    CGFloat statusY = 20;
    
    CGFloat statusW = ScreenWidth * 0.35;
    
    CGFloat statusH = 25;
    
    _statusF = CGRectMake(statusX, statusY, statusW, statusH);
    
    _lineF = CGRectMake(0, CGRectGetMaxY(_timeF) + 9.5, ScreenWidth, 0.5);
    
    _height = CGRectGetMaxY(_lineF);
    
}

@end
