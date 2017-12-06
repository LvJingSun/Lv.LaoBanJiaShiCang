//
//  TiXian_Frame.m
//  BusinessCenter
//
//  Created by mac on 2017/11/1.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import "TiXian_Frame.h"
#import "TiXian_Model.h"

#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

@implementation TiXian_Frame

-(void)setTixianModel:(TiXian_Model *)tixianModel {
    
    _tixianModel = tixianModel;
    
    CGFloat titleX = SCREENWIDTH * 0.032;
    
    CGFloat titleY = 40;
    
    CGSize titleSize = [self sizeWithText:@"到账银行卡" font:[UIFont systemFontOfSize:17] maxSize:CGSizeMake(0,30)];
    
    CGFloat titleW = titleSize.width;
    
    CGFloat titleH = 30;
    
    _bandTitleF = CGRectMake(titleX, titleY, titleW, titleH);
    
    CGFloat bandX = CGRectGetMaxX(_bandTitleF) + SCREENWIDTH * 0.05;
    
    CGFloat bandY = 30;
    
    CGFloat bandW = SCREENWIDTH * 0.968 - bandX;
    
    CGFloat bandH = 20;
    
    _bandNameF = CGRectMake(bandX, bandY, bandW, bandH);
    
    CGFloat cardX = bandX;
    
    CGFloat cardY = CGRectGetMaxY(_bandNameF) + 10;
    
    CGFloat cardW = bandW;
    
    CGFloat cardH = bandH;
    
    _bandCardF = CGRectMake(cardX, cardY, cardW, cardH);
    
    CGFloat balancetitleX = titleX;
    
    CGFloat balancetitleY = CGRectGetMaxY(_bandCardF) + 20;
    
    CGFloat balancetitleW = titleW;
    
    CGFloat balancetitleH = 20;
    
    _balanceTitleF = CGRectMake(balancetitleX, balancetitleY, balancetitleW, balancetitleH);
    
    CGFloat balanceX = CGRectGetMaxX(_balanceTitleF) + SCREENWIDTH * 0.05;
    
    CGFloat balanceY = balancetitleY;
    
    CGFloat balanceW = bandW;
    
    CGFloat balanceH = 20;
    
    _balanceF = CGRectMake(balanceX, balanceY, balanceW, balanceH);
    
    CGFloat countX = 0;
    
    CGFloat countY = CGRectGetMaxY(_balanceF) + 30;
    
    CGFloat countW = SCREENWIDTH;
    
    CGFloat countH = 50;
    
    _countF = CGRectMake(countX, countY, countW, countH);
    
    CGFloat sureX = SCREENWIDTH * 0.05;
    
    CGFloat sureY = CGRectGetMaxY(_countF) + 70;
    
    CGFloat sureW = SCREENWIDTH * 0.9;
    
    CGFloat sureH = 45;
    
    _sureF = CGRectMake(sureX, sureY, sureW, sureH);
    
    _height = CGRectGetMaxY(_sureF);
    
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    
    NSDictionary *attrs = @{NSFontAttributeName : font};
    
    return [text boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
    
}

@end
