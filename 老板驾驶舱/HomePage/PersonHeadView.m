//
//  PersonHeadView.m
//  BusinessCenter
//
//  Created by mac on 16/5/13.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import "PersonHeadView.h"
#define Size ([UIScreen mainScreen].bounds.size)

@implementation PersonHeadView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithRed:3/255. green:168/255. blue:226/255. alpha:1.];
        
        UIImageView *headImageview = [[UIImageView alloc] initWithFrame:CGRectMake((Size.width - 60) * 0.5, (self.bounds.size.height - 60) * 0.5, 60, 60)];
        
        self.headImageview = headImageview;
        
        [self setLayer:headImageview andcornerRadius:5];
        
        headImageview.backgroundColor = [UIColor blackColor];
        
        [self addSubview:headImageview];
        
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        backBtn.frame = CGRectMake(10, 30, 30, 20);
        
        [backBtn setTitle:@"返回" forState:UIControlStateNormal];
        
        backBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [backBtn addTarget:self action:@selector(BtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:backBtn];
        
        UIButton *setBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        setBtn.frame = CGRectMake(Size.width - 40, 30, 30, 20);
        
        [setBtn setImage:[UIImage imageNamed:@"6.png"] forState:UIControlStateNormal];
        
        self.setBtn = setBtn;
        
        [self addSubview:setBtn];
        
        UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(Size.width * 0.3, CGRectGetMaxY(headImageview.frame) + 20, Size.width * 0.4, 20)];
        
        nameLab.textColor = [UIColor darkGrayColor];
        
        nameLab.textAlignment = NSTextAlignmentCenter;
        
        self.nameLab = nameLab;
        
        [self addSubview:nameLab];
        
        UIImageView *statusIcon = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(headImageview.frame) + 20, (self.bounds.size.height - 60) * 0.5 + 20, 60, 60)];
        
        self.statusIconImageview = statusIcon;
        
        [self addSubview:statusIcon];
        
        UILabel *timerLabel = [[UILabel alloc] initWithFrame:CGRectMake(Size.width * 0.6, CGRectGetMaxY(headImageview.frame) + 20, Size.width * 0.3, 20)];
        
        self.timerLabel = timerLabel;
        
        timerLabel.textAlignment = NSTextAlignmentRight;
        
        timerLabel.font = [UIFont systemFontOfSize:15];
        
        timerLabel.textColor = [UIColor whiteColor];
        
        [self addSubview:timerLabel];
        
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(Size.width * 0.92, CGRectGetMaxY(headImageview.frame) + 20, Size.width * 0.06, 20)];
        
        icon.image = [UIImage imageNamed:@"time.png"];
        
        self.icon = icon;
        
        [self addSubview:icon];
        
    }
    
    return self;
    
}

- (void)BtnClick {

    if ([self.delegate respondsToSelector:@selector(BackBtnClick)]) {
        
        [self.delegate BackBtnClick];
        
    }
}

//设置头像圆形
-(void)setLayer:(UIView *)View andcornerRadius:(CGFloat)cornerRadius;{
    View.layer.masksToBounds = YES;
    View.layer.cornerRadius = View.frame.size.width/2; //圆角（圆形)
    //防止掉帧（列表不卡了）
    View.layer.shouldRasterize = YES;
    View.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

@end
