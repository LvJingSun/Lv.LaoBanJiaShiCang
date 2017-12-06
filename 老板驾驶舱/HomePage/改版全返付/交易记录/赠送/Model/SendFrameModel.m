//
//  SendFrameModel.m
//  BusinessCenter
//
//  Created by mac on 2017/3/15.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import "SendFrameModel.h"
#import "F_ListModel.h"
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define NameFont [UIFont systemFontOfSize:20]

@implementation SendFrameModel

-(void)setModel:(F_ListModel *)model {

    _model = model;
    
    CGFloat kehuX = SCREEN_WIDTH * 0.05;
    
    CGFloat kehuY = 10;
    
    CGFloat kehuH = 30;
    
    CGSize size = [self sizeWithText:model.Memberid font:NameFont maxSize:CGSizeMake(0, kehuH)];
    
    CGFloat kehuW = size.width;
    
    _kehuF = CGRectMake(kehuX, kehuY, kehuW, kehuH);
    
    CGFloat picX = CGRectGetMaxX(_kehuF) + 5;
    
    CGFloat picW = 20;
    
    CGFloat picH = picW;
    
    CGFloat picY = (kehuH - picH) * 0.5 + kehuY;
    
    _picF = CGRectMake(picX, picY, picW, picH);
    
    CGFloat cheX = CGRectGetMaxX(_picF) + 10;
    
    CGFloat cheH = 20;
    
    CGFloat cheY = (picH - cheH) * 0.5 + picY;
    
    CGFloat cheW = SCREEN_WIDTH * 0.95 - cheX;
    
    _chexiaoF = CGRectMake(cheX, cheY, cheW, cheH);
    
    CGFloat xiaoX = kehuX;
    
    CGFloat xiaoY = CGRectGetMaxY(_kehuF) + 10;
    
    CGFloat xiaoW = SCREEN_WIDTH * 0.45;
    
    CGFloat xiaoH = 13;
    
    _xiaofeiF = CGRectMake(xiaoX, xiaoY, xiaoW, xiaoH);
    
    CGFloat cuX = kehuX;
    
    CGFloat cuY = CGRectGetMaxY(_xiaofeiF) + 8;
    
    CGFloat cuW = xiaoW;
    
    CGFloat cuH = xiaoH;
    
    _cuxiaoF = CGRectMake(cuX, cuY, cuW, cuH);
    
    CGFloat countX = SCREEN_WIDTH * 0.5;
    
    CGFloat countY = CGRectGetMaxY(_kehuF);
    
    CGFloat countW = SCREEN_WIDTH * 0.45;
    
    CGFloat countH = CGRectGetMaxY(_cuxiaoF) - countY;
    
    _countF = CGRectMake(countX, countY, countW, countH);
    
    CGFloat timeX = kehuX;
    
    CGFloat timeY = CGRectGetMaxY(_cuxiaoF) + 8;
    
    CGFloat timeW = xiaoW;
    
    CGFloat timeH = 10;
    
    _timeF = CGRectMake(timeX, timeY, timeW, timeH);
    
    CGFloat jingX = SCREEN_WIDTH * 0.5;
    
    CGFloat jingY = timeY;
    
    CGFloat jingW = timeW;
    
    CGFloat jingH = timeH;
    
    _jingbanF = CGRectMake(jingX, jingY, jingW, jingH);
    
    CGFloat lineX = 0;
    
    CGFloat lineY = CGRectGetMaxY(_timeF) + 9.5;
    
    CGFloat lingW = SCREEN_WIDTH;
    
    CGFloat lineH = 0.5;
    
    _lineF = CGRectMake(lineX, lineY, lingW, lineH);
    
    _height = CGRectGetMaxY(_lineF);
    
    
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    
    NSDictionary *attrs = @{NSFontAttributeName : font};
    
    return [text boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
    
}

@end
