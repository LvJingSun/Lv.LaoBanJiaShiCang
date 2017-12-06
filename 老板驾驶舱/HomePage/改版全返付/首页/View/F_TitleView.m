//
//  F_TitleView.m
//  BusinessCenter
//
//  Created by mac on 2017/3/14.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import "F_TitleView.h"
//导航栏颜色
#define NAVColor [UIColor colorWithRed:72/255. green:162/255. blue:245/255. alpha:1.]

@implementation F_TitleView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        CGSize size = self.bounds.size;
        
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width * 0.6, size.height)];
        
        titleLab.textAlignment = NSTextAlignmentRight;
        
        titleLab.font = [UIFont systemFontOfSize:17];
        
        titleLab.textColor = [UIColor darkTextColor];
        
        titleLab.text = @"粉丝宝";
        
        [self addSubview:titleLab];
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(titleLab.frame) + 10, 5, 20, 20)];
        
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        
        [button setTitle:@"?" forState:0];
        
        [button setTitleColor:NAVColor forState:0];
        
        button.layer.masksToBounds = YES;
        
        button.layer.cornerRadius = button.frame.size.width * 0.5;
        
        button.layer.borderColor = NAVColor.CGColor;
        
        button.layer.borderWidth = 1;
        
        [button addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:button];
        
    }
    
    return self;
    
}

- (void)btnClick {
    
    if ([self.delegate respondsToSelector:@selector(TitleClick)]) {
        
        [self.delegate TitleClick];
        
    }
    
}

@end
