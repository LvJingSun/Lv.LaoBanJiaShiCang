//
//  F_RoundView.m
//  BusinessCenter
//
//  Created by mac on 2017/3/14.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import "F_RoundView.h"

#define Round1Color [UIColor colorWithRed:242/255. green:89/255. blue:68/255. alpha:1.]
#define Round2Color [UIColor colorWithRed:29/255. green:172/255. blue:145/255. alpha:1.]
#define Round3Color [UIColor colorWithRed:0/255. green:165/255. blue:230/255. alpha:1.]
#define Round4Color [UIColor colorWithRed:52/255. green:116/255. blue:196/255. alpha:1.]
#define Round5Color [UIColor colorWithRed:245/255. green:153/255. blue:1/255. alpha:1.]
#define Round6Color [UIColor colorWithRed:190/255. green:149/255. blue:228/255. alpha:1.]
#define R_D 120.f
#define R_W 50.f
#define centerX self.frame.size.width * 0.5
#define centerY self.frame.size.height * 0.5
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

@interface F_RoundView () <CAAnimationDelegate>

@property (nonatomic, weak) UIBezierPath *path;

@property (nonatomic, strong) CAShapeLayer *lineChartLayer;

@end

@implementation F_RoundView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
    }
    
    return self;
    
}

-(void)setDataArr:(NSArray *)dataArr {
    
    _dataArr = dataArr;
    
    [self drawRound];
    
}

- (void)drawRound {
    
    CGFloat start = 0.0 ;
    
    CGFloat end;
    
    CGFloat all = [self AllWithArray:self.dataArr];
    
    if (all == 0) {
        
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width - 170) * 0.5, 20, 170, 120)];
        
        image.image = [UIImage imageNamed:@"nodata.jpeg"];
        
        [self addSubview:image];
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(image.frame) + 10, self.frame.size.width, 20)];
        
        lab.text = @"暂无数据";
        
        lab.font = [UIFont systemFontOfSize:16];
        
        lab.textColor = [UIColor lightGrayColor];
        
        lab.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:lab];
        
    }else {
    
        for (int i = 0; i < self.dataArr.count; i ++) {
            
            end = [self.dataArr[i] floatValue] / all + start;
            
            CAShapeLayer *circleLayer = [CAShapeLayer layer];
            
            circleLayer.strokeStart = start;
            
            circleLayer.strokeEnd = end;
            
            UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(centerX - R_D * 0.5, (centerY * 2 - R_D) * 0.5, R_D, R_D)];
            
            circleLayer.path = circlePath.CGPath;
            
            circleLayer.fillColor = [UIColor clearColor].CGColor;
            
            circleLayer.lineWidth = R_W;
            
            if (i == 0) {
                
                circleLayer.strokeColor = Round1Color.CGColor;
                
            }else if (i == 1) {
                
                circleLayer.strokeColor = Round2Color.CGColor;
                
            }else if (i == 2) {
                
                circleLayer.strokeColor = Round3Color.CGColor;
                
            }else if (i == 3) {
                
                circleLayer.strokeColor = Round4Color.CGColor;
                
            }else if (i == 4) {
                
                circleLayer.strokeColor = Round5Color.CGColor;
                
            }else if (i == 5) {
                
                circleLayer.strokeColor = Round6Color.CGColor;
                
            }
            
            [self.layer addSublayer:circleLayer];
            
            CABasicAnimation *pathAnima = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
            
            pathAnima.fromValue = @(start); //开始动画位置
            
            pathAnima.toValue = @(end); //结束动画位置
            
            pathAnima.autoreverses = NO;
            
            pathAnima.duration = 1.0;
            
            pathAnima.removedOnCompletion=NO;
            
            [circleLayer addAnimation:pathAnima forKey:@"strokeEnd"];
            
            if ([self.dataArr[i] floatValue] != 0.0) {
                
                CGFloat Rx = centerX + cosf(((end - start) * 0.5 + start) * 360 * M_PI / 180) * R_D * 0.5 * 1.5;
                
                CGFloat Ry = centerY + sinf(((end - start) * 0.5 + start) * 360 * M_PI / 180) * R_D * 0.5 * 1.5;
                
                UILabel *line = [[UILabel alloc] init];
                
                UILabel *countLab = [[UILabel alloc] init];
                
                if (Rx >= centerX) {
                    
                    line.frame = CGRectMake(Rx, Ry, centerX + R_D * 0.5 + 40 - Rx, 1);
                    
                    countLab.frame = CGRectMake(CGRectGetMaxX(line.frame) + 5, Ry - 10, SCREENWIDTH * 0.95 - CGRectGetMaxX(line.frame) - 5, 20);
                    
                    countLab.textAlignment = NSTextAlignmentLeft;
                    
                }else {
                    
                    line.frame = CGRectMake(centerX - R_D * 0.5 - 40, Ry, Rx - (centerX - R_D * 0.5 - 40), 1);
                    
                    countLab.frame = CGRectMake(SCREENWIDTH * 0.05, Ry - 10, line.frame.origin.x - 5 - SCREENWIDTH * 0.05, 20);
                    
                    countLab.textAlignment = NSTextAlignmentRight;
                    
                }
                
                if (i == 0) {
                    
                    line.backgroundColor = Round1Color;
                    
                    countLab.textColor = Round1Color;
                    
                }else if (i == 1) {
                    
                    line.backgroundColor = Round2Color;
                    
                    countLab.textColor = Round2Color;
                    
                }else if (i == 2) {
                    
                    line.backgroundColor = Round3Color;
                    
                    countLab.textColor = Round3Color;
                    
                }else if (i == 3) {
                    
                    line.backgroundColor = Round4Color;
                    
                    countLab.textColor = Round4Color;
                    
                }else if (i == 4) {
                    
                    line.backgroundColor = Round5Color;
                    
                    countLab.textColor = Round5Color;
                    
                }else if (i == 5) {
                    
                    line.backgroundColor = Round6Color;
                    
                    countLab.textColor = Round6Color;
                    
                }
                
                countLab.text = [NSString stringWithFormat:@"%@",self.dataArr[i]];
                
                countLab.font = [UIFont systemFontOfSize:12];
                
                [self addSubview:line];
                
                [self addSubview:countLab];
                
            }
            
            start = end;
            
        }
        
    }
    
    
    
}

- (CGFloat)AllWithArray:(NSArray *)array {

    CGFloat all = 0.0;
    
    for (int i = 0; i < array.count; i ++) {
        
        all = all + [array[i] floatValue];
        
    }
    
    return all;
    
}


@end
