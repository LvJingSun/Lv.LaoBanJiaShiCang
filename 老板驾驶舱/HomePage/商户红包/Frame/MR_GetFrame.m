//
//  MR_GetFrame.m
//  BusinessCenter
//
//  Created by mac on 2017/9/30.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import "MR_GetFrame.h"
#import "MR_GetModel.h"

#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

@implementation MR_GetFrame

-(void)setGetModel:(MR_GetModel *)getModel {
    
    _getModel = getModel;
    
    CGFloat nameX = SCREENWIDTH * 0.05;
    
    CGFloat nameY = 10;
    
    CGFloat nameW = SCREENWIDTH * 0.35;
    
    CGFloat nameH = 25;
    
    _nameF = CGRectMake(nameX, nameY, nameW, nameH);
    
    CGFloat timeX = nameX;
    
    CGFloat timeY = CGRectGetMaxY(_nameF);
    
    CGFloat timeW = nameW;
    
    CGFloat timeH = 10;
    
    _timeF = CGRectMake(timeX, timeY, timeW, timeH);
    
    CGFloat countX = CGRectGetMaxX(_nameF);
    
    CGFloat countY = nameY;
    
    CGFloat countW = SCREENWIDTH * 0.55;
    
    CGFloat countH = CGRectGetMaxY(_timeF) - countY;
    
    _countF = CGRectMake(countX, countY, countW, countH);
    
    CGFloat lineX = 0;
    
    CGFloat lineY = CGRectGetMaxY(_timeF) + nameY;
    
    CGFloat lineW = SCREENWIDTH;
    
    CGFloat lineH = 0.5;
    
    _lineF = CGRectMake(lineX, lineY, lineW, lineH);
    
    _height = CGRectGetMaxY(_lineF);
    
}

@end
