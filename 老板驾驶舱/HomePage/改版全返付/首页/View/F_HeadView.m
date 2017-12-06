//
//  F_HeadView.m
//  BusinessCenter
//
//  Created by mac on 2017/3/14.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import "F_HeadView.h"

#define LightColor [UIColor colorWithRed:134/255. green:134/255. blue:134/255. alpha:1.]
#define DarkColor [UIColor colorWithRed:46/255. green:46/255. blue:46/255. alpha:1.]
#define LineColor [UIColor colorWithRed:241/255. green:241/255. blue:242/255. alpha:1.]
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@implementation F_HeadView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.05, 10, SCREEN_WIDTH * 0.9, 30)];
        
        title.textColor = LightColor;
        
        title.font = [UIFont systemFontOfSize:18];
        
        title.text = @"总资产（个）";
        
        [self addSubview:title];
        
        UILabel *count = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.05, CGRectGetMaxY(title.frame) + 5, SCREEN_WIDTH * 0.9, 60)];
        
        self.countLab = count;
        
        count.textColor = DarkColor;
        
        count.font = [UIFont systemFontOfSize:40];
        
        count.text = @"0.00";
        
        [self addSubview:count];
        
        self.height = CGRectGetMaxY(count.frame) + 10;
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, self.height - 1, SCREEN_WIDTH, 1)];
        
        line.backgroundColor = LineColor;
        
        [self addSubview:line];
        
    }
    
    return self;
    
}

@end
