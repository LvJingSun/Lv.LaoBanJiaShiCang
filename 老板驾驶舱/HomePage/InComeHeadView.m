//
//  InComeHeadView.m
//  BusinessCenter
//
//  Created by mac on 2017/11/1.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import "InComeHeadView.h"
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

@implementation InComeHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        CGFloat shiX = 0;
        
        CGFloat shiY = 0;
        
        CGFloat shiW = SCREENWIDTH * 0.5;
        
        CGFloat shiH = 40;
        
        UIButton *shishi = [[UIButton alloc] initWithFrame:CGRectMake(shiX, shiY, shiW, shiH)];
        
        self.shishibtn = shishi;
        
        [shishi setTitle:@"实时账户" forState:0];
        
        [shishi setTitleColor:[UIColor blackColor] forState:0];
        
        [shishi addTarget:self action:@selector(shiClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:shishi];
        
        UILabel *shiline = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH * 0.05, CGRectGetMaxY(shishi.frame), SCREENWIDTH * 0.4, 3)];
        
        self.shishiline = shiline;
        
        shiline.backgroundColor = [UIColor redColor];
        
        shiline.hidden = YES;
        
        [self addSubview:shiline];
        
        CGFloat redX = CGRectGetMaxX(shishi.frame);
        
        CGFloat redY = shiY;
        
        CGFloat redW = shiW;
        
        CGFloat redH = shiH;
        
        UIButton *redbage = [[UIButton alloc] initWithFrame:CGRectMake(redX, redY, redW, redH)];
        
        self.hongbaobtn = redbage;
        
        [redbage setTitle:@"红包账户" forState:0];
        
        [redbage setTitleColor:[UIColor blackColor] forState:0];
        
        [redbage addTarget:self action:@selector(hongbaoClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:redbage];
        
        UILabel *hongbaoline = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH * 0.55, CGRectGetMaxY(redbage.frame), SCREENWIDTH * 0.4, 3)];
        
        self.hongbaoline = hongbaoline;
        
        hongbaoline.backgroundColor = [UIColor redColor];
        
        hongbaoline.hidden = YES;
        
        [self addSubview:hongbaoline];
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(hongbaoline.frame), SCREENWIDTH, 0.5)];
        
        line.backgroundColor = [UIColor lightGrayColor];
        
        [self addSubview:line];
        
        self.height = CGRectGetMaxY(line.frame);
        
    }
    
    return self;
    
}

- (void)shiClick {
    
    if (self.shishiBlock) {
        
        self.shishiBlock();
        
    }
    
}

- (void)hongbaoClick {
    
    if (self.hongbaoBlock) {
        
        self.hongbaoBlock();
        
    }
    
}

@end
