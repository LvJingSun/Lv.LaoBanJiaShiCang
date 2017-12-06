//
//  BigBtnView.m
//  BusinessCenter
//
//  Created by mac on 16/5/30.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import "BigBtnView.h"

@implementation BigBtnView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, frame.size.width - 40, frame.size.height - 30)];
        
        self.iconImageview = icon;
        
        [self addSubview:icon];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(icon.frame), frame.size.width, 20)];
        
        label.font = [UIFont systemFontOfSize:11.0f];
        
        label.textColor = [UIColor grayColor];
        
        label.textAlignment = NSTextAlignmentCenter;
        
        self.titleLabel = label;
        
        [self addSubview:label];
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        
        self.button = button;
        
        [self addSubview:button];

    }
    
    return self;
    
}

@end
