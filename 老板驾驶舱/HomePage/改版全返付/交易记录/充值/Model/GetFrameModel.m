//
//  GetFrameModel.m
//  BusinessCenter
//
//  Created by mac on 2017/3/15.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import "GetFrameModel.h"
#import "F_ListModel.h"
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@implementation GetFrameModel

-(void)setListmodel:(F_ListModel *)listmodel {

    _listmodel = listmodel;
    
    CGFloat typeX = SCREEN_WIDTH * 0.05;
    
    CGFloat typeY = 10;
    
    CGFloat typeW = SCREEN_WIDTH * 0.45;
    
    CGFloat typeH = 15;
    
    _typeF = CGRectMake(typeX, typeY, typeW, typeH);
    
    CGFloat countX = SCREEN_WIDTH * 0.5;
    
    CGFloat countY = typeY;
    
    CGFloat countW = SCREEN_WIDTH * 0.45;
    
    CGFloat countH = typeH;
    
    _countF = CGRectMake(countX, countY, countW, countH);
    
    CGFloat timeX = typeX;
    
    CGFloat timeY = CGRectGetMaxY(_typeF) + 5;
    
    CGFloat timeW = typeW;
    
    CGFloat timeH = 15;
    
    _timeF = CGRectMake(timeX, timeY, timeW, timeH);
    
    CGFloat sourceX = countX;
    
    CGFloat sourceY = timeY;
    
    CGFloat sourceW = countW;
    
    CGFloat sourceH = timeH;
    
    _sourceF = CGRectMake(sourceX, sourceY, sourceW, sourceH);
    
    CGFloat lineX = 0;
    
    CGFloat lineY = CGRectGetMaxY(_timeF) + 9.5;
    
    CGFloat lineW = SCREEN_WIDTH;
    
    CGFloat lineH = 0.5;
    
    _lineF = CGRectMake(lineX, lineY, lineW, lineH);
    
    _height = CGRectGetMaxY(_lineF);
    
}

@end
