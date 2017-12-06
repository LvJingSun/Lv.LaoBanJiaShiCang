//
//  MR_GetGroupFrame.m
//  BusinessCenter
//
//  Created by mac on 2017/10/13.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import "MR_GetGroupFrame.h"
#import "MR_GetGroupModel.h"

#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

@implementation MR_GetGroupFrame

-(void)setGroupModel:(MR_GetGroupModel *)groupModel {
    
    _groupModel = groupModel;
    
    CGFloat titleX = SCREENWIDTH * 0.05;
    
    CGFloat titleY = 15;
    
    CGFloat titleW = SCREENWIDTH * 0.3;
    
    CGFloat titleH = 30;
    
    _titleF = CGRectMake(titleX, titleY, titleW, titleH);
    
    CGFloat balanceX = SCREENWIDTH * 0.5;
    
    CGFloat balanceY = titleY;
    
    CGFloat balanceW = SCREENWIDTH * 0.4;
    
    CGFloat balanceH = titleH;
    
    _balanceF = CGRectMake(balanceX, balanceY, balanceW, balanceH);
    
    CGFloat lineX = 0;
    
    CGFloat lineY = CGRectGetMaxY(_titleF) + titleY;
    
    CGFloat lineW = SCREENWIDTH;
    
    CGFloat lineH = 0.5;
    
    _lineF = CGRectMake(lineX, lineY, lineW, lineH);
    
    _height = CGRectGetMaxY(_lineF);
    
}

@end
