//
//  T_ListHeadView.m
//  BusinessCenter
//
//  Created by mac on 2017/11/1.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import "T_ListHeadView.h"
#import "RechargeHeader.h"

@implementation T_ListHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth * 0.1, 25, ScreenWidth * 0.8, 20)];
        
        title.textAlignment = NSTextAlignmentCenter;
        
        title.text = @"提现总额";
        
        title.textColor = [UIColor darkTextColor];
        
        title.font = [UIFont systemFontOfSize:16];
        
        [self addSubview:title];
        
        UILabel *count = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth * 0.1, CGRectGetMaxY(title.frame) + 25, ScreenWidth * 0.8, 40)];
        
        self.countLab = count;
        
        count.textAlignment = NSTextAlignmentCenter;
        
        count.font = [UIFont systemFontOfSize:35];
        
        count.textColor = ThemeColor;
        
        [self addSubview:count];
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(count.frame) + 25, ScreenWidth, 1)];
        
        line.backgroundColor = [UIColor lightGrayColor];
        
        [self addSubview:line];
        
        self.height = CGRectGetMaxY(line.frame);
        
    }
    
    return self;
    
}

@end
