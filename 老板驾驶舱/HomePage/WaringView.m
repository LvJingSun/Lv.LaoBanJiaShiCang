//
//  WaringView.m
//  BusinessCenter
//
//  Created by mac on 16/4/22.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import "WaringView.h"

@interface WaringView ()

@property (nonatomic, weak) UILabel *scrLab;

@property (nonatomic, assign) int i;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation WaringView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        UILabel *contentLab = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, frame.size.width - 5, frame.size.height)];
        
        contentLab.textColor = [UIColor blackColor];
        
        contentLab.font = [UIFont systemFontOfSize:12];
        
        self.scrLab = contentLab;
        
        [self addSubview:contentLab];
        
    }
    
    return self;
    
}

- (void)setWaringArr:(NSArray *)waringArr {

    _waringArr = waringArr;
    
    self.i = -1;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2. target:self selector:@selector(scrollTopView) userInfo:nil repeats:YES];
    
}

- (void)scrollTopView {
    
    if (self.waringArr.count > 0) {
        
        self.i ++;
        
        if (self.i >= self.waringArr.count) {
            
            self.i = 0;
            
        }
        
        self.scrLab.text = self.waringArr[self.i];
        
        CATransition *trasition = [CATransition animation];
        
        trasition.duration = 0.5f;
        
        trasition.type = @"cube";
        
        trasition.subtype = kCATransitionFromTop;
        
        [self.layer addAnimation:trasition forKey:nil];
        
    }
    
}


@end
