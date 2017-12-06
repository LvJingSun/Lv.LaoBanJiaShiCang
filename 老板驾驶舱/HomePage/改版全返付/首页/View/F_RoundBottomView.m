//
//  F_RoundBottomView.m
//  BusinessCenter
//
//  Created by mac on 2017/3/20.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import "F_RoundBottomView.h"

#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
#define Round1Color [UIColor colorWithRed:242/255. green:89/255. blue:68/255. alpha:1.]
#define Round2Color [UIColor colorWithRed:29/255. green:172/255. blue:145/255. alpha:1.]
#define Round3Color [UIColor colorWithRed:0/255. green:165/255. blue:230/255. alpha:1.]
#define Round4Color [UIColor colorWithRed:52/255. green:116/255. blue:196/255. alpha:1.]
#define Round5Color [UIColor colorWithRed:245/255. green:153/255. blue:1/255. alpha:1.]
#define Round6Color [UIColor colorWithRed:190/255. green:149/255. blue:228/255. alpha:1.]

@implementation F_RoundBottomView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
    }
    
    return self;
    
}

-(void)setArray:(NSArray *)array {

    _array = array;
    
    [self DrawFlag];
    
}

- (void)DrawFlag {
    
    NSInteger i = self.array.count;

    switch (i) {
        case 1:
        {
        
            [self drawOneFlag];
            
        }
            break;
            
        case 2:
        {
            
            [self drawTwoFlag];
            
        }
            break;
            
        case 3:
        {
            
            [self drawThreeFlag];
            
        }
            break;
            
        case 4:
        {
            
            [self drawFourFlag];
            
        }
            break;
            
        case 5:
        {
            
            [self drawFiveFlag];
            
        }
            break;
            
        case 6:
        {
            
            [self drawSixFlag];
            
        }
            break;
            
        default:
            break;
    }
    
}

- (void)drawOneFlag {

    CGFloat lab1x = SCREENWIDTH * 0.05;
    
    CGFloat labW = 10;
    
    CGFloat textW = SCREENWIDTH * 0.4 - labW - 5;
    
    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(lab1x, 20, labW, labW)];
    
    lab1.backgroundColor = Round1Color;
    
    [self addSubview:lab1];
    
    UILabel *t1 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lab1.frame) + 5, 20, textW, labW)];
    
    t1.text = [NSString stringWithFormat:@"%@",self.array[0]];
    
    t1.textColor = [UIColor darkGrayColor];
    
    t1.font = [UIFont systemFontOfSize:14];
    
    [self addSubview:t1];
    
    self.height = CGRectGetMaxY(t1.frame);
    
}

- (void)drawTwoFlag {
    
    CGFloat lab1x = SCREENWIDTH * 0.05;
    
    CGFloat lab2x = SCREENWIDTH * 0.5;
    
    CGFloat labW = 10;
    
    CGFloat textW = SCREENWIDTH * 0.4 - labW - 5;
    
    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(lab1x, 20, labW, labW)];
    
    lab1.backgroundColor = Round1Color;
    
    [self addSubview:lab1];
    
    UILabel *t1 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lab1.frame) + 5, 20, textW, labW)];
    
    t1.text = [NSString stringWithFormat:@"%@",self.array[0]];
    
    t1.textColor = [UIColor darkGrayColor];
    
    t1.font = [UIFont systemFontOfSize:14];
    
    [self addSubview:t1];
    
    UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(lab2x, 20, labW, labW)];
    
    lab2.backgroundColor = Round2Color;
    
    [self addSubview:lab2];
    
    UILabel *t2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lab2.frame) + 5, 20, textW, labW)];
    
    t2.text = [NSString stringWithFormat:@"%@",self.array[1]];
    
    t2.textColor = [UIColor darkGrayColor];
    
    t2.font = [UIFont systemFontOfSize:14];
    
    [self addSubview:t2];
    
    self.height = CGRectGetMaxY(t2.frame);
    
}

- (void)drawThreeFlag {
    
    CGFloat lab1x = SCREENWIDTH * 0.05;
    
    CGFloat lab2x = SCREENWIDTH * 0.5;
    
    CGFloat labW = 10;
    
    CGFloat textW = SCREENWIDTH * 0.4 - labW - 5;
    
    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(lab1x, 20, labW, labW)];
    
    lab1.backgroundColor = Round1Color;
    
    [self addSubview:lab1];
    
    UILabel *t1 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lab1.frame) + 5, 20, textW, labW)];
    
    t1.text = [NSString stringWithFormat:@"%@",self.array[0]];
    
    t1.textColor = [UIColor darkGrayColor];
    
    t1.font = [UIFont systemFontOfSize:14];
    
    [self addSubview:t1];
    
    UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(lab2x, 20, labW, labW)];
    
    lab2.backgroundColor = Round2Color;
    
    [self addSubview:lab2];
    
    UILabel *t2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lab2.frame) + 5, 20, textW, labW)];
    
    t2.text = [NSString stringWithFormat:@"%@",self.array[1]];
    
    t2.textColor = [UIColor darkGrayColor];
    
    t2.font = [UIFont systemFontOfSize:14];
    
    [self addSubview:t2];
    
    UILabel *lab3 = [[UILabel alloc] initWithFrame:CGRectMake(lab1x, CGRectGetMaxY(lab1.frame) + 10, labW, labW)];
    
    lab3.backgroundColor = Round3Color;
    
    [self addSubview:lab3];
    
    UILabel *t3 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lab3.frame) + 5, CGRectGetMaxY(lab1.frame) + 10, textW, labW)];
    
    t3.text = [NSString stringWithFormat:@"%@",self.array[2]];
    
    t3.textColor = [UIColor darkGrayColor];
    
    t3.font = [UIFont systemFontOfSize:14];
    
    [self addSubview:t3];
    
    self.height = CGRectGetMaxY(t3.frame);
    
}

- (void)drawFourFlag {
    
    CGFloat lab1x = SCREENWIDTH * 0.05;
    
    CGFloat lab2x = SCREENWIDTH * 0.5;
    
    CGFloat labW = 10;
    
    CGFloat textW = SCREENWIDTH * 0.4 - labW - 5;
    
    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(lab1x, 20, labW, labW)];
    
    lab1.backgroundColor = Round1Color;
    
    [self addSubview:lab1];
    
    UILabel *t1 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lab1.frame) + 5, 20, textW, labW)];
    
    t1.text = [NSString stringWithFormat:@"%@",self.array[0]];
    
    t1.textColor = [UIColor darkGrayColor];
    
    t1.font = [UIFont systemFontOfSize:14];
    
    [self addSubview:t1];
    
    UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(lab2x, 20, labW, labW)];
    
    lab2.backgroundColor = Round2Color;
    
    [self addSubview:lab2];
    
    UILabel *t2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lab2.frame) + 5, 20, textW, labW)];
    
    t2.text = [NSString stringWithFormat:@"%@",self.array[1]];
    
    t2.textColor = [UIColor darkGrayColor];
    
    t2.font = [UIFont systemFontOfSize:14];
    
    [self addSubview:t2];
    
    UILabel *lab3 = [[UILabel alloc] initWithFrame:CGRectMake(lab1x, CGRectGetMaxY(lab1.frame) + 10, labW, labW)];
    
    lab3.backgroundColor = Round3Color;
    
    [self addSubview:lab3];
    
    UILabel *t3 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lab3.frame) + 5, CGRectGetMaxY(lab1.frame) + 10, textW, labW)];
    
    t3.text = [NSString stringWithFormat:@"%@",self.array[2]];
    
    t3.textColor = [UIColor darkGrayColor];
    
    t3.font = [UIFont systemFontOfSize:14];
    
    [self addSubview:t3];
    
    UILabel *lab4 = [[UILabel alloc] initWithFrame:CGRectMake(lab2x, CGRectGetMaxY(lab1.frame) + 10, labW, labW)];
    
    lab4.backgroundColor = Round4Color;
    
    [self addSubview:lab4];
    
    UILabel *t4 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lab4.frame) + 5, CGRectGetMaxY(lab1.frame) + 10, textW, labW)];
    
    t4.text = [NSString stringWithFormat:@"%@",self.array[3]];
    
    t4.textColor = [UIColor darkGrayColor];
    
    t4.font = [UIFont systemFontOfSize:14];
    
    [self addSubview:t4];
    
    self.height = CGRectGetMaxY(t4.frame);
    
}

- (void)drawFiveFlag {
    
    CGFloat lab1x = SCREENWIDTH * 0.05;
    
    CGFloat lab2x = SCREENWIDTH * 0.5;
    
    CGFloat labW = 10;
    
    CGFloat textW = SCREENWIDTH * 0.4 - labW - 5;
    
    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(lab1x, 20, labW, labW)];
    
    lab1.backgroundColor = Round1Color;
    
    [self addSubview:lab1];
    
    UILabel *t1 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lab1.frame) + 5, 20, textW, labW)];
    
    t1.text = [NSString stringWithFormat:@"%@",self.array[0]];
    
    t1.textColor = [UIColor darkGrayColor];
    
    t1.font = [UIFont systemFontOfSize:14];
    
    [self addSubview:t1];
    
    UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(lab2x, 20, labW, labW)];
    
    lab2.backgroundColor = Round2Color;
    
    [self addSubview:lab2];
    
    UILabel *t2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lab2.frame) + 5, 20, textW, labW)];
    
    t2.text = [NSString stringWithFormat:@"%@",self.array[1]];
    
    t2.textColor = [UIColor darkGrayColor];
    
    t2.font = [UIFont systemFontOfSize:14];
    
    [self addSubview:t2];
    
    UILabel *lab3 = [[UILabel alloc] initWithFrame:CGRectMake(lab1x, CGRectGetMaxY(lab1.frame) + 10, labW, labW)];
    
    lab3.backgroundColor = Round3Color;
    
    [self addSubview:lab3];
    
    UILabel *t3 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lab3.frame) + 5, CGRectGetMaxY(lab1.frame) + 10, textW, labW)];
    
    t3.text = [NSString stringWithFormat:@"%@",self.array[2]];
    
    t3.textColor = [UIColor darkGrayColor];
    
    t3.font = [UIFont systemFontOfSize:14];
    
    [self addSubview:t3];
    
    UILabel *lab4 = [[UILabel alloc] initWithFrame:CGRectMake(lab2x, CGRectGetMaxY(lab1.frame) + 10, labW, labW)];
    
    lab4.backgroundColor = Round4Color;
    
    [self addSubview:lab4];
    
    UILabel *t4 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lab4.frame) + 5, CGRectGetMaxY(lab1.frame) + 10, textW, labW)];
    
    t4.text = [NSString stringWithFormat:@"%@",self.array[3]];
    
    t4.textColor = [UIColor darkGrayColor];
    
    t4.font = [UIFont systemFontOfSize:14];
    
    [self addSubview:t4];
    
    UILabel *lab5 = [[UILabel alloc] initWithFrame:CGRectMake(lab1x, CGRectGetMaxY(lab3.frame) + 10, labW, labW)];
    
    lab5.backgroundColor = Round5Color;
    
    [self addSubview:lab5];
    
    UILabel *t5 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lab5.frame) + 5, CGRectGetMaxY(lab3.frame) + 10, textW, labW)];
    
    t5.text = [NSString stringWithFormat:@"%@",self.array[4]];
    
    t5.textColor = [UIColor darkGrayColor];
    
    t5.font = [UIFont systemFontOfSize:14];
    
    [self addSubview:t5];
    
    self.height = CGRectGetMaxY(t5.frame);
    
}

- (void)drawSixFlag {
    
    CGFloat lab1x = SCREENWIDTH * 0.05;
    
    CGFloat lab2x = SCREENWIDTH * 0.5;
    
    CGFloat labW = 10;
    
    CGFloat textW = SCREENWIDTH * 0.4 - labW - 5;
    
    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(lab1x, 20, labW, labW)];
    
    lab1.backgroundColor = Round1Color;
    
    [self addSubview:lab1];
    
    UILabel *t1 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lab1.frame) + 5, 20, textW, labW)];
    
    t1.text = [NSString stringWithFormat:@"%@",self.array[0]];
    
    t1.textColor = [UIColor darkGrayColor];
    
    t1.font = [UIFont systemFontOfSize:14];
    
    [self addSubview:t1];
    
    UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(lab2x, 20, labW, labW)];
    
    lab2.backgroundColor = Round2Color;
    
    [self addSubview:lab2];
    
    UILabel *t2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lab2.frame) + 5, 20, textW, labW)];
    
    t2.text = [NSString stringWithFormat:@"%@",self.array[1]];
    
    t2.textColor = [UIColor darkGrayColor];
    
    t2.font = [UIFont systemFontOfSize:14];
    
    [self addSubview:t2];
    
    UILabel *lab3 = [[UILabel alloc] initWithFrame:CGRectMake(lab1x, CGRectGetMaxY(lab1.frame) + 10, labW, labW)];
    
    lab3.backgroundColor = Round3Color;
    
    [self addSubview:lab3];
    
    UILabel *t3 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lab3.frame) + 5, CGRectGetMaxY(lab1.frame) + 10, textW, labW)];
    
    t3.text = [NSString stringWithFormat:@"%@",self.array[2]];
    
    t3.textColor = [UIColor darkGrayColor];
    
    t3.font = [UIFont systemFontOfSize:14];
    
    [self addSubview:t3];
    
    UILabel *lab4 = [[UILabel alloc] initWithFrame:CGRectMake(lab2x, CGRectGetMaxY(lab1.frame) + 10, labW, labW)];
    
    lab4.backgroundColor = Round4Color;
    
    [self addSubview:lab4];
    
    UILabel *t4 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lab4.frame) + 5, CGRectGetMaxY(lab1.frame) + 10, textW, labW)];
    
    t4.text = [NSString stringWithFormat:@"%@",self.array[3]];
    
    t4.textColor = [UIColor darkGrayColor];
    
    t4.font = [UIFont systemFontOfSize:14];
    
    [self addSubview:t4];
    
    UILabel *lab5 = [[UILabel alloc] initWithFrame:CGRectMake(lab1x, CGRectGetMaxY(lab3.frame) + 10, labW, labW)];
    
    lab5.backgroundColor = Round5Color;
    
    [self addSubview:lab5];
    
    UILabel *t5 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lab5.frame) + 5, CGRectGetMaxY(lab3.frame) + 10, textW, labW)];
    
    t5.text = [NSString stringWithFormat:@"%@",self.array[4]];
    
    t5.textColor = [UIColor darkGrayColor];
    
    t5.font = [UIFont systemFontOfSize:14];
    
    [self addSubview:t5];
    
    UILabel *lab6 = [[UILabel alloc] initWithFrame:CGRectMake(lab2x, CGRectGetMaxY(lab3.frame) + 10, labW, labW)];
    
    lab6.backgroundColor = Round6Color;
    
    [self addSubview:lab6];
    
    UILabel *t6 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lab6.frame) + 5, CGRectGetMaxY(lab3.frame) + 10, textW, labW)];
    
    t6.text = [NSString stringWithFormat:@"%@",self.array[5]];
    
    t6.textColor = [UIColor darkGrayColor];
    
    t6.font = [UIFont systemFontOfSize:14];
    
    [self addSubview:t6];
    
    self.height = CGRectGetMaxY(t6.frame);
    
}

@end
