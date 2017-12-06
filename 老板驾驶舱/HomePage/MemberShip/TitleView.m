//
//  TitleView.m
//  BusinessCenter
//
//  Created by mac on 16/5/12.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import "TitleView.h"
#define size ([UIScreen mainScreen].bounds.size)

@implementation TitleView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        CGFloat todayLabX = size.width * 0.1;
        
        CGFloat todayLabY = 10;
        
        CGFloat todayLabW = size.width * 0.3;
        
        CGFloat todayLabH = 20;
        
        UILabel *todayLab = [[UILabel alloc] initWithFrame:CGRectMake(todayLabX, todayLabY, todayLabW, todayLabH)];
        
        todayLab.text = @"今日";
        
        todayLab.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:todayLab];
        
        CGFloat todayMoneyX = todayLabX;
        
        CGFloat todayMoneyY = CGRectGetMaxY(todayLab.frame) + 10;
        
        CGFloat todayMoneyW = todayLabW;
        
        CGFloat todayMoneyH = todayLabH;
        
        UILabel *todayMoney = [[UILabel alloc] initWithFrame:CGRectMake(todayMoneyX, todayMoneyY, todayMoneyW, todayMoneyH)];
        
        self.todayMoneyLab = todayMoney;
        
        todayMoney.textColor = [UIColor lightGrayColor];
        
        todayMoney.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:todayMoney];
        
        UILabel *todayOutMoney = [[UILabel alloc] initWithFrame:CGRectMake(todayMoneyX, CGRectGetMaxY(todayMoney.frame) + 10, todayMoneyW, todayMoneyH)];
        
        self.todayMoneyOutLab = todayOutMoney;
        
        todayOutMoney.textColor = [UIColor lightGrayColor];
        
        todayOutMoney.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:todayOutMoney];
        
        UILabel *weekLab = [[UILabel alloc] initWithFrame:CGRectMake(size.width * 0.6, 10, size.width * 0.3, 20)];
        
        weekLab.textAlignment = NSTextAlignmentCenter;
        
        weekLab.text = @"本周";
        
        [self addSubview:weekLab];
        
        UILabel *weekMoney = [[UILabel alloc] initWithFrame:CGRectMake(size.width * 0.6, 40, size.width * 0.3, 20)];
        
        self.weekMoneyLab = weekMoney;
        
        weekMoney.textColor = [UIColor lightGrayColor];
        
        weekMoney.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:weekMoney];
        
        UILabel *weekOutMoney = [[UILabel alloc] initWithFrame:CGRectMake(size.width * 0.6, 70, size.width * 0.3, 20)];
        
        self.weekMoneyOutLab = weekOutMoney;
        
        weekOutMoney.textColor = [UIColor lightGrayColor];
        
        weekOutMoney.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:weekOutMoney];
        
        UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(todayOutMoney.frame) + 10, size.width, 1)];
        
        line1.backgroundColor = [UIColor grayColor];
        
        [self addSubview:line1];
        
        UILabel *monthLab = [[UILabel alloc] initWithFrame:CGRectMake(size.width * 0.1, CGRectGetMaxY(line1.frame) + 10, size.width * 0.3, 20)];
        
        monthLab.textAlignment = NSTextAlignmentCenter;
        
        monthLab.text = @"本月";
        
        [self addSubview:monthLab];
        
        UILabel *monthMoney = [[UILabel alloc] initWithFrame:CGRectMake(size.width * 0.1, CGRectGetMaxY(monthLab.frame) + 10, size.width * 0.3, 20)];
        
        self.monthMoneyLab = monthMoney;
        
        monthMoney.textColor = [UIColor lightGrayColor];
        
        monthMoney.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:monthMoney];
        
        UILabel *monthOutMoney = [[UILabel alloc] initWithFrame:CGRectMake(size.width * 0.1, CGRectGetMaxY(monthMoney.frame) + 10, size.width * 0.3, 20)];
        
        self.monthMoneyOutLab = monthOutMoney;
        
        monthOutMoney.textColor = [UIColor lightGrayColor];
        
        monthOutMoney.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:monthOutMoney];
        
        UILabel *allLab = [[UILabel alloc] initWithFrame:CGRectMake(size.width * 0.6, CGRectGetMaxY(line1.frame) + 10, size.width * 0.3, 20)];
        
        allLab.textAlignment = NSTextAlignmentCenter;
        
        allLab.text = @"全部";
        
        [self addSubview:allLab];
        
        UILabel *allMoney = [[UILabel alloc] initWithFrame:CGRectMake(size.width * 0.6, CGRectGetMaxY(allLab.frame) + 10, size.width * 0.3, 20)];
        
        self.allMoneyLab = allMoney;
        
        allMoney.textColor = [UIColor lightGrayColor];
        
        allMoney.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:allMoney];
        
        UILabel *allOutMoney = [[UILabel alloc] initWithFrame:CGRectMake(size.width * 0.6, CGRectGetMaxY(allMoney.frame) + 10, size.width * 0.3, 20)];
        
        self.allMoneyOutLab = allOutMoney;
        
        allOutMoney.textColor = [UIColor lightGrayColor];
        
        allOutMoney.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:allOutMoney];
        
        UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(size.width * 0.5, 0, 1, 201)];
        
        line2.backgroundColor = [UIColor grayColor];
        
        [self addSubview:line2];
        
        UILabel *line3 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(monthOutMoney.frame) + 10, size.width, 1)];
        
        line3.backgroundColor = [UIColor grayColor];
        
        [self addSubview:line3];
        
    }
    
    return self;
    
}

@end
