//
//  InCome_List_Frame.m
//  BusinessCenter
//
//  Created by mac on 2017/11/1.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import "InCome_List_Frame.h"
#import "InCome_List_Model.h"
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

@implementation InCome_List_Frame

-(void)setListmodel:(InCome_List_Model *)listmodel {
    
    _listmodel = listmodel;
    
    CGFloat titleX = SCREENWIDTH * 0.25;
    
    CGFloat titleY = 10;
    
    CGFloat titleW = SCREENWIDTH * 0.2;
    
    CGFloat titleH = 15;
    
    _noTitleF = CGRectMake(titleX, titleY, titleW, titleH);
    
    CGFloat noX = CGRectGetMaxX(_noTitleF);
    
    CGFloat noY = titleY;
    
    CGFloat noW = SCREENWIDTH * 0.518;
    
    CGFloat noH = titleH;
    
    _noF = CGRectMake(noX, noY, noW, noH);
    
    CGFloat typeX = titleX;
    
    CGFloat typeY = CGRectGetMaxY(_noTitleF) + 10;
    
    CGFloat typeW = SCREENWIDTH * 0.968 - typeX;
    
    CGFloat typeH = 15;
    
    _typeF = CGRectMake(typeX, typeY, typeW, typeH);
    
    CGFloat nameX = typeX;
    
    CGFloat nameY = CGRectGetMaxY(_typeF) + 10;
    
    CGFloat nameW = typeW;
    
    CGFloat nameH = typeH;
    
    _nameF = CGRectMake(nameX, nameY, nameW, nameH);
    
    CGFloat timeX = typeX;
    
    CGFloat timeY = CGRectGetMaxY(_nameF) + 10;
    
    CGFloat timeW = typeW;
    
    CGFloat timeH = typeH;
    
    _timeF = CGRectMake(timeX, timeY, timeW, timeH);
    
    CGFloat lineX = 0;
    
    CGFloat lineY = CGRectGetMaxY(_timeF) + 9.5;
    
    CGFloat lineW = SCREENWIDTH;
    
    CGFloat lineH = 0.5;
    
    _lineF = CGRectMake(lineX, lineY, lineW, lineH);
    
    _height = CGRectGetMaxY(_lineF);
    
    CGFloat countX = SCREENWIDTH * 0.032;
    
    CGFloat countH = 20;
    
    CGFloat countY = (_height - countH) * 0.5;
    
    CGFloat countW = SCREENWIDTH * 0.218;
    
    _countF = CGRectMake(countX, countY, countW, countH);
    
}

@end
