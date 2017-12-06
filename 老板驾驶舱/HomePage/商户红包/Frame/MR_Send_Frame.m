//
//  MR_Send_Frame.m
//  BusinessCenter
//
//  Created by mac on 2017/10/10.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import "MR_Send_Frame.h"
#import "MR_SendModel.h"

#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

@implementation MR_Send_Frame

-(void)setSend_model:(MR_SendModel *)send_model {
    
    _send_model = send_model;
    
    CGFloat dateX = SCREENWIDTH * 0.05;
    
    CGFloat dateY = 15;
    
    CGFloat dateW = SCREENWIDTH * 0.45;
    
    CGFloat dateH = 30;
    
    _dateF = CGRectMake(dateX, dateY, dateW, dateH);
    
    CGFloat countX = CGRectGetMaxX(_dateF);
    
    CGFloat countW = SCREENWIDTH * 0.25;
    
    _countF = CGRectMake(countX, dateY, countW, dateH);
    
    CGFloat statusX = CGRectGetMaxX(_countF);
    
    CGFloat statusW = SCREENWIDTH * 0.2;
    
    _statusF = CGRectMake(statusX, dateY, statusW, dateH);
    
    CGFloat lineX = 0;
    
    CGFloat lineY = CGRectGetMaxY(_dateF) + dateY;
    
    CGFloat lineW = SCREENWIDTH;
    
    CGFloat lineH = 0.5;
    
    _lineF = CGRectMake(lineX, lineY, lineW, lineH);
    
    _height = CGRectGetMaxY(_lineF);
    
}

@end
