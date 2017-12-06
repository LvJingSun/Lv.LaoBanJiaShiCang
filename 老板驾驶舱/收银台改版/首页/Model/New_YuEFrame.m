//
//  New_YuEFrame.m
//  BusinessCenter
//
//  Created by mac on 2017/4/11.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import "New_YuEFrame.h"
#import "New_TiXianData.h"
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define CardFont [UIFont systemFontOfSize:15]

@implementation New_YuEFrame

- (void)setDataModel:(New_TiXianData *)dataModel {

    _dataModel = dataModel;
    
    CGFloat titleX = SCREEN_WIDTH * 0.05;
    
    CGFloat titleY = 15;
    
    CGFloat titleW = SCREEN_WIDTH * 0.9;
    
    CGFloat titleH = 15;
    
    _yueTitleF = CGRectMake(titleX, titleY, titleW, titleH);
    
    CGFloat countX = titleX;
    
    CGFloat countY = CGRectGetMaxY(_yueTitleF) + 15;
    
    CGFloat countW = SCREEN_WIDTH * 0.9;
    
    CGFloat countH = 40;
    
    _yueCountF = CGRectMake(countX, countY, countW, countH);
    
    CGFloat line1X = SCREEN_WIDTH * 0.05;
    
    CGFloat line1Y = CGRectGetMaxY(_yueCountF) + 15;
    
    CGFloat line1W = SCREEN_WIDTH * 0.9;
    
    CGFloat line1H = 1;
    
    _line1F = CGRectMake(line1X, line1Y, line1W, line1H);
    
    CGFloat cardTitleX = SCREEN_WIDTH * 0.05;
    
    CGFloat cardTitleY = CGRectGetMaxY(_line1F) + 10;
    
    CGFloat cardTitleH = 15;
    
    CGSize size = [self sizeWithText:@"收款账号:" font:CardFont maxSize:CGSizeMake(0, cardTitleH)];
    
    _cardTitleF = CGRectMake(cardTitleX, cardTitleY, size.width, cardTitleH);
    
    CGFloat cardX = CGRectGetMaxX(_cardTitleF) + 10;
    
    CGFloat cardY = cardTitleY;
    
    CGFloat cardW = SCREEN_WIDTH * 0.95 - cardX;
    
    CGFloat cardH = cardTitleH;
    
    _cardNumberF = CGRectMake(cardX, cardY, cardW, cardH);
    
    CGFloat line2X = 0;
    
    CGFloat line2Y = CGRectGetMaxY(_cardNumberF) + 10;
    
    CGFloat line2W = SCREEN_WIDTH;
    
    CGFloat line2H = 1;
    
    _line2F = CGRectMake(line2X, line2Y, line2W, line2H);
    
    CGFloat hangX = 0;
    
    CGFloat hangY = CGRectGetMaxY(_line2F);
    
    CGFloat hangW = SCREEN_WIDTH;
    
    CGFloat hangH = 10;
    
    _hangF = CGRectMake(hangX, hangY, hangW, hangH);
    
    _height = CGRectGetMaxY(_hangF);
    
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    
    NSDictionary *attrs = @{NSFontAttributeName : font};
    
    return [text boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
    
}

@end
