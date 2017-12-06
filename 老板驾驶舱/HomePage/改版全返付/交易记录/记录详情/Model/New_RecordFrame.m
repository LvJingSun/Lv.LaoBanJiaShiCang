//
//  New_RecordFrame.m
//  CashierDeskIphone
//
//  Created by mac on 2017/2/28.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "New_RecordFrame.h"
#import "F_ListModel.h"
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@implementation New_RecordFrame

-(void)setRecord:(F_ListModel *)record {
    
    _record = record;
    
    CGFloat nameX = SCREEN_WIDTH * 0.05;
    
    CGFloat nameY = 30;
    
    CGFloat nameW = SCREEN_WIDTH * 0.9;
    
    CGFloat nameH = 30;
    
    _nameF = CGRectMake(nameX, nameY, nameW, nameH);
    
    CGFloat line1X = nameX;
    
    CGFloat line1Y = CGRectGetMaxY(_nameF) + 30;
    
    CGFloat line1W = nameW;
    
    CGFloat line1H = 1;
    
    _line1F = CGRectMake(line1X, line1Y, line1W, line1H);
    
    CGFloat countX = nameX;
    
    CGFloat countY = CGRectGetMaxY(_line1F) + 10;
    
    CGFloat countW = nameW;
    
    CGFloat countH = 50;
    
    _countF = CGRectMake(countX, countY, countW, countH);
    
    CGFloat picX = SCREEN_WIDTH * 0.45 - 25;
    
    CGFloat picY = CGRectGetMaxY(_countF) + 10;
    
    CGFloat picW = 20;
    
    CGFloat picH = picW;
    
    _picF = CGRectMake(picX, picY, picW, picH);
    
    CGFloat statusX = SCREEN_WIDTH * 0.45;
    
    CGFloat statusY = CGRectGetMaxY(_countF) + 10;
    
    CGFloat statusW = SCREEN_WIDTH * 0.45;
    
    CGFloat statusH = 20;
    
    _statusF = CGRectMake(statusX, statusY, statusW, statusH);
    
    CGFloat line2X = nameX;
    
    CGFloat line2Y = CGRectGetMaxY(_statusF) + 10;
    
    CGFloat line2W = nameW;
    
    CGFloat line2H = 1;
    
    _line2F = CGRectMake(line2X, line2Y, line2W, line2H);
    
    CGFloat p_nameX = SCREEN_WIDTH * 0.05;
    
    CGFloat p_nameY = CGRectGetMaxY(_line2F) + 15;
    
    CGFloat p_nameW = SCREEN_WIDTH * 0.3;
    
    CGFloat p_nameH = 20;
    
    _p_nameF = CGRectMake(p_nameX, p_nameY, p_nameW, p_nameH);
    
    CGFloat proX = SCREEN_WIDTH * 0.4;
    
    CGFloat proY = p_nameY;
    
    CGFloat proW = SCREEN_WIDTH * 0.55;
    
    CGFloat proH = p_nameH;
    
    _productF = CGRectMake(proX, proY, proW, proH);
    
    CGFloat t_countX = p_nameX;
    
    CGFloat t_countY = CGRectGetMaxY(_p_nameF) + 15;
    
    CGFloat t_countW = p_nameW;
    
    CGFloat t_countH = p_nameH;
    
    _t_countF = CGRectMake(t_countX, t_countY, t_countW, t_countH);
    
    CGFloat traX = proX;
    
    CGFloat traY = t_countY;
    
    CGFloat traW = proW;
    
    CGFloat traH = proH;
    
    _tranCountF = CGRectMake(traX, traY, traW, traH);
    
    CGFloat a_countX = p_nameX;
    
    CGFloat a_countY = CGRectGetMaxY(_t_countF) + 15;
    
    CGFloat a_countW = p_nameW;
    
    CGFloat a_countH = p_nameH;
    
    _a_countF = CGRectMake(a_countX, a_countY, a_countW, a_countH);
    
    CGFloat allX = proX;
    
    CGFloat allY = a_countY;
    
    CGFloat allW = proW;
    
    CGFloat allH = proH;
    
    _allCountF = CGRectMake(allX, allY, allW, allH);
    
    CGFloat line3X = nameX;
    
    CGFloat line3Y = CGRectGetMaxY(_a_countF) + 15;
    
    CGFloat line3W = nameW;
    
    CGFloat line3H = 1;
    
    _line3F = CGRectMake(line3X, line3Y, line3W, line3H);
    
    CGFloat c_staffX = t_countX;
    
    CGFloat c_staffY = CGRectGetMaxY(_line3F) + 15;
    
    CGFloat c_staffW = t_countW;
    
    CGFloat c_staffH = t_countH;
    
    _c_staffF = CGRectMake(c_staffX, c_staffY, c_staffW, c_staffH);
    
    CGFloat staffX = traX;
    
    CGFloat staffY = c_staffY;
    
    CGFloat staffW = traW;
    
    CGFloat staffH = traH;
    
    _staffF = CGRectMake(staffX, staffY, staffW, staffH);
    
    CGFloat s_shopX = c_staffX;
    
    CGFloat s_shopY = CGRectGetMaxY(_c_staffF) + 15;
    
    CGFloat s_shopW = c_staffW;
    
    CGFloat s_shopH = c_staffH;
    
    _s_shopF = CGRectMake(s_shopX, s_shopY, s_shopW, s_shopH);
    
    CGFloat shopX = traX;
    
    CGFloat shopY = s_shopY;
    
    CGFloat shopW = traW;
    
    CGFloat shopH = traH;
    
    _shopF = CGRectMake(shopX, shopY, shopW, shopH);
    
    CGFloat c_cuX = c_staffX;
    
    CGFloat c_cuY = CGRectGetMaxY(_s_shopF) + 15;
    
    CGFloat c_cuW = c_staffW;
    
    CGFloat c_cuH = c_staffH;
    
    _c_cuxiaoyuanF = CGRectMake(c_cuX, c_cuY, c_cuW, c_cuH);
    
    CGFloat cuX = traX;
    
    CGFloat cuY = c_cuY;
    
    CGFloat cuW = traW;
    
    CGFloat cuH = traH;
    
    _cuxiaoyuanF = CGRectMake(cuX, cuY, cuW, cuH);
    
    CGFloat t_timeX = c_staffX;
    
    CGFloat t_timeY = CGRectGetMaxY(_c_cuxiaoyuanF) + 15;
    
    CGFloat t_timeW = c_staffW;
    
    CGFloat t_timeH = c_staffH;
    
    _t_timeF = CGRectMake(t_timeX, t_timeY, t_timeW, t_timeH);
    
    CGFloat timeX = traX;
    
    CGFloat timeY = t_timeY;
    
    CGFloat timeW = traW;
    
    CGFloat timeH = traH;
    
    _timeF = CGRectMake(timeX, timeY, timeW, timeH);
    
    CGFloat d_danX = c_staffX;
    
    CGFloat d_danY = CGRectGetMaxY(_t_timeF) + 15;
    
    CGFloat d_danW = c_staffW;
    
    CGFloat d_danH = c_staffH;
    
    _d_danhaoF = CGRectMake(d_danX, d_danY, d_danW, d_danH);
    
    CGFloat danX = traX;
    
    CGFloat danY = d_danY;
    
    CGFloat danW = traW;
    
    CGFloat danH = traH;
    
    _danhaoF = CGRectMake(danX, danY, danW, danH);
    
    CGFloat line4X = nameX;
    
    CGFloat line4Y = CGRectGetMaxY(_danhaoF) + 15;
    
    CGFloat line4W = nameW;
    
    CGFloat line4H = 1;
    
    _line4F = CGRectMake(line4X, line4Y, line4W, line4H);
    
    if (![record.pic1 isEqualToString:@""] && ![record.pic2 isEqualToString:@""]) {
        
        CGFloat p_pic1X = SCREEN_WIDTH * 0.1;
        
        CGFloat p_pic1Y = CGRectGetMaxY(_line4F) + 20;
        
        CGFloat p_pic1W = SCREEN_WIDTH * 0.8;
        
        CGFloat p_pic1H = 20;
        
        _p_pic1F = CGRectMake(p_pic1X, p_pic1Y, p_pic1W, p_pic1H);
        
        CGFloat pic1X = p_pic1X;
        
        CGFloat pic1Y = CGRectGetMaxY(_p_pic1F) + 10;
        
        CGFloat pic1W = p_pic1W;
        
        CGFloat pic1H = 300;
        
        _pic1F = CGRectMake(pic1X, pic1Y, pic1W, pic1H);
        
        CGFloat p_pic2X = SCREEN_WIDTH * 0.1;
        
        CGFloat p_pic2Y = CGRectGetMaxY(_pic1F) + 20;
        
        CGFloat p_pic2W = SCREEN_WIDTH * 0.8;
        
        CGFloat p_pic2H = 20;
        
        _p_pic2F = CGRectMake(p_pic2X, p_pic2Y, p_pic2W, p_pic2H);
        
        CGFloat pic2X = p_pic1X;
        
        CGFloat pic2Y = CGRectGetMaxY(_p_pic2F) + 10;
        
        CGFloat pic2W = p_pic1W;
        
        CGFloat pic2H = 300;
        
        _pic2F = CGRectMake(pic2X, pic2Y, pic2W, pic2H);
        
        _height = CGRectGetMaxY(_pic2F) + 20;
        
    }else if (![record.pic1 isEqualToString:@""] && [record.pic2 isEqualToString:@""]) {
    
        CGFloat p_pic1X = SCREEN_WIDTH * 0.1;
        
        CGFloat p_pic1Y = CGRectGetMaxY(_line4F) + 20;
        
        CGFloat p_pic1W = SCREEN_WIDTH * 0.8;
        
        CGFloat p_pic1H = 20;
        
        _p_pic1F = CGRectMake(p_pic1X, p_pic1Y, p_pic1W, p_pic1H);
        
        CGFloat pic1X = p_pic1X;
        
        CGFloat pic1Y = CGRectGetMaxY(_p_pic1F) + 10;
        
        CGFloat pic1W = p_pic1W;
        
        CGFloat pic1H = 300;
        
        _pic1F = CGRectMake(pic1X, pic1Y, pic1W, pic1H);
        
        _height = CGRectGetMaxY(_pic1F) + 20;
        
    }else if ([record.pic1 isEqualToString:@""] && ![record.pic2 isEqualToString:@""]) {
    
        CGFloat p_pic2X = SCREEN_WIDTH * 0.1;
        
        CGFloat p_pic2Y = CGRectGetMaxY(_line4F) + 20;
        
        CGFloat p_pic2W = SCREEN_WIDTH * 0.8;
        
        CGFloat p_pic2H = 20;
        
        _p_pic2F = CGRectMake(p_pic2X, p_pic2Y, p_pic2W, p_pic2H);
        
        CGFloat pic2X = p_pic2X;
        
        CGFloat pic2Y = CGRectGetMaxY(_p_pic2F) + 10;
        
        CGFloat pic2W = p_pic2W;
        
        CGFloat pic2H = 300;
        
        _pic2F = CGRectMake(pic2X, pic2Y, pic2W, pic2H);
        
        _height = CGRectGetMaxY(_pic2F) + 20;
        
    }else {
    
        _height = CGRectGetMaxY(_line4F) + 20;
        
    }
    
}


@end
