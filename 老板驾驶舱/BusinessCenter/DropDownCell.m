//
//  DropDownCell.m
//  BusinessCenter
//
//  Created by mac on 2017/4/12.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import "DropDownCell.h"
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define LineColor [UIColor colorWithRed:243/255.f green:243/255.f blue:243/255.f alpha:1.0]

@implementation DropDownCell

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 20)];
        
        self.titleLab = lab;
        
        lab.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:lab];
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.05, CGRectGetMaxY(lab.frame) + 9, SCREEN_WIDTH * 0.9, 1)];
        
        line.backgroundColor = LineColor;
        
        [self addSubview:line];
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.05, 0, SCREEN_WIDTH * 0.9, 40)];
        
        self.clickBtn = btn;
        
//        [btn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:btn];
        
        self.height = CGRectGetMaxY(line.frame);
        
    }
    
    return self;
    
}

//- (void)BtnClick:(UIButton *)sender {
//
//    if ([self.delegate respondsToSelector:@selector(TitleBtnClick:)]) {
//        
//        [self.delegate TitleBtnClick:sender];
//        
//    }
//    
//}

@end
