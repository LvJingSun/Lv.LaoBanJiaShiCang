//
//  N_TiXianListFrame.m
//  BusinessCenter
//
//  Created by mac on 2017/4/12.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import "N_TiXianListFrame.h"
#import "N_TiXianRecord.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@implementation N_TiXianListFrame

-(void)setRecordModel:(N_TiXianRecord *)recordModel {

    _recordModel = recordModel;
    
    CGFloat typeX = SCREEN_WIDTH * 0.05;
    
    CGFloat typeY = 10;
    
    CGFloat typeW = SCREEN_WIDTH * 0.35;
    
    CGFloat typeH = 15;
    
    _typeF = CGRectMake(typeX, typeY, typeW, typeH);
    
    CGFloat dateX = SCREEN_WIDTH * 0.4;
    
    CGFloat dateY = 10;
    
    CGFloat dateW = SCREEN_WIDTH * 0.55;
    
    CGFloat dateH = 15;
    
    _dateF = CGRectMake(dateX, dateY, dateW, dateH);
    
    CGFloat yueX = SCREEN_WIDTH * 0.05;
    
    CGFloat yueY = CGRectGetMaxY(_typeF) + 5;
    
    CGFloat yueW = SCREEN_WIDTH * 0.45;
    
    CGFloat yueH = 15;
    
    _yueCountF = CGRectMake(yueX, yueY, yueW, yueH);
    
    CGFloat countX = SCREEN_WIDTH * 0.5;
    
    CGFloat countY = CGRectGetMaxY(_dateF) + 5;
    
    CGFloat countW = SCREEN_WIDTH * 0.45;
    
    CGFloat countH = 15;
    
    _countF = CGRectMake(countX, countY, countW, countH);
    
    CGFloat lineX = 0;
    
    CGFloat lineY = CGRectGetMaxY(_countF) + 10;
    
    CGFloat lineW = SCREEN_WIDTH;
    
    CGFloat lineH = 1;
    
    _lineF = CGRectMake(lineX, lineY, lineW, lineH);
    
    _height = CGRectGetMaxY(_lineF);
    
}

@end
