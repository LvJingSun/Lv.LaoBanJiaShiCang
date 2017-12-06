//
//  DetailMemberView.m
//  BusinessCenter
//
//  Created by mac on 16/5/12.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import "DetailMemberView.h"
#define size ([UIScreen mainScreen].bounds.size)

@implementation DetailMemberView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        CGFloat todayLabX = size.width * 0.05;
        
        CGFloat todayLabY = 10;
        
        CGFloat todayLabW = size.width * 0.4;
        
        CGFloat todayLabH = 20;
        
        UILabel *todayLab = [[UILabel alloc] initWithFrame:CGRectMake(todayLabX, todayLabY, todayLabW, todayLabH)];
        
        todayLab.text = @"今日";
        
        todayLab.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:todayLab];
        
        CGFloat todayMoneyX = todayLabX;
        
        CGFloat todayMoneyY = CGRectGetMaxY(todayLab.frame) + 10;
        
        CGFloat todayMoneyW = todayLabW;
        
        CGFloat todayMoneyH = todayLabH;
        
        UILabel *todayIn = [[UILabel alloc] initWithFrame:CGRectMake(todayMoneyX, todayMoneyY, todayMoneyW, todayMoneyH)];
        
        self.todayInLab = todayIn;
        
        todayIn.textColor = [UIColor lightGrayColor];
        
        todayIn.textAlignment = NSTextAlignmentCenter;
        
        todayIn.text = @"50.00";
        
        [self addSubview:todayIn];
        
        UILabel *todayOut = [[UILabel alloc] initWithFrame:CGRectMake(todayMoneyX, CGRectGetMaxY(todayIn.frame) + 10, todayMoneyW, todayMoneyH)];
        
        self.todayOutLab = todayOut;
        
        todayOut.textColor = [UIColor lightGrayColor];
        
        todayOut.textAlignment = NSTextAlignmentCenter;
        
        todayOut.text = @"50.00";
        
        [self addSubview:todayOut];
        
        UILabel *weekLab = [[UILabel alloc] initWithFrame:CGRectMake(size.width * 0.55, 10, size.width * 0.4, 20)];
        
        weekLab.textAlignment = NSTextAlignmentCenter;
        
        weekLab.text = @"本周";
        
        [self addSubview:weekLab];
        
        UILabel *weekIn = [[UILabel alloc] initWithFrame:CGRectMake(size.width * 0.55, 40, size.width * 0.4, 20)];
        
        self.weekInLab = weekIn;
        
        weekIn.textColor = [UIColor lightGrayColor];
        
        weekIn.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:weekIn];
        
        UILabel *weekOut = [[UILabel alloc] initWithFrame:CGRectMake(size.width * 0.55, CGRectGetMaxY(weekIn.frame) + 10, size.width * 0.4, 20)];
        
        self.weekOutLab = weekOut;
        
        weekOut.textColor = [UIColor lightGrayColor];
        
        weekOut.textAlignment = NSTextAlignmentCenter;
        
        weekOut.text = @"50.00";
        
        [self addSubview:weekOut];
        
        UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(todayOut.frame) + 10, size.width, 1)];
        
        line1.backgroundColor = [UIColor grayColor];
        
        [self addSubview:line1];
        
        UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(size.width * 0.5, 0, 1, 202)];
        
        line2.backgroundColor = [UIColor grayColor];
        
        [self addSubview:line2];
        
        UILabel *line3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 201, size.width, 1)];
        
        line3.backgroundColor = [UIColor grayColor];
        
        [self addSubview:line3];
        
        UILabel *monthLab = [[UILabel alloc] initWithFrame:CGRectMake(size.width * 0.05, CGRectGetMaxY(line1.frame) + 10, size.width * 0.4, 20)];
        
        monthLab.textAlignment = NSTextAlignmentCenter;
        
        monthLab.text = @"本月";
        
        [self addSubview:monthLab];
        
        UILabel *monthIn = [[UILabel alloc] initWithFrame:CGRectMake(size.width * 0.05, CGRectGetMaxY(monthLab.frame) + 10, size.width * 0.4, 20)];
        
        self.monthInLab = monthIn;
        
        monthIn.textColor = [UIColor lightGrayColor];
        
        monthIn.textAlignment = NSTextAlignmentCenter;
        
        monthIn.text = @"50.00";
        
        [self addSubview:monthIn];
        
        UILabel *monthOut = [[UILabel alloc] initWithFrame:CGRectMake(size.width * 0.05, CGRectGetMaxY(monthIn.frame) + 10, size.width * 0.4, 20)];
        
        self.monthOutLab = monthOut;
        
        monthOut.textColor = [UIColor lightGrayColor];
        
        monthOut.textAlignment = NSTextAlignmentCenter;
        
        monthOut.text = @"50.00";
        
        [self addSubview:monthOut];
        
        UILabel *allLab = [[UILabel alloc] initWithFrame:CGRectMake(size.width * 0.55, CGRectGetMaxY(line1.frame) + 10, size.width * 0.4, 20)];
        
        allLab.textAlignment = NSTextAlignmentCenter;
        
        allLab.text = @"全部";
        
        [self addSubview:allLab];
        
        UILabel *allIn = [[UILabel alloc] initWithFrame:CGRectMake(size.width * 0.55, CGRectGetMaxY(allLab.frame) + 10, size.width * 0.4, 20)];
        
        self.allInLab = allIn;
        
        allIn.textColor = [UIColor lightGrayColor];
        
        allIn.textAlignment = NSTextAlignmentCenter;
        
        allIn.text = @"50.00";
        
        [self addSubview:allIn];
        
        UILabel *allOut = [[UILabel alloc] initWithFrame:CGRectMake(size.width * 0.55, CGRectGetMaxY(allIn.frame) + 10, size.width * 0.4, 20)];
        
        self.allOutLab = allOut;
        
        allOut.textColor = [UIColor lightGrayColor];
        
        allOut.textAlignment = NSTextAlignmentCenter;
        
        allOut.text = @"50.00";
        
        [self addSubview:allOut];
        

        
    }
    
    return self;
    
}

@end
