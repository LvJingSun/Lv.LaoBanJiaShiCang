//
//  YongjinDetailHeadView.m
//  BusinessCenter
//
//  Created by mac on 16/5/20.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import "YongjinDetailHeadView.h"
#define Size ([UIScreen mainScreen].bounds.size)

@implementation YongjinDetailHeadView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        CGFloat nameX = Size.width * 0.05;
        
        CGFloat nameY = 10;
        
        CGFloat nameW = Size.width * 0.4;
        
        CGFloat nameH = 20;
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameX, nameY, nameW, nameH)];
        
        self.nameLabel = nameLabel;
        
        [self addSubview:nameLabel];
        
        UILabel *countlabel = [[UILabel alloc] initWithFrame:CGRectMake(nameX, CGRectGetMaxY(nameLabel.frame) + 10, nameW, nameH)];
        
        self.countLabel = countlabel;
        
        countlabel.textColor = [UIColor colorWithRed:125/255. green:125/255. blue:125/255. alpha:1.];
        
        countlabel.font = [UIFont systemFontOfSize:12];
        
        [self addSubview:countlabel];
        
        UILabel *yongjinLabel = [[UILabel alloc] initWithFrame:CGRectMake(Size.width * 0.5, 15, Size.width * 0.45, 40)];
        
        self.yongjinLabel = yongjinLabel;
        
        yongjinLabel.font = [UIFont systemFontOfSize:18];
        
        yongjinLabel.textAlignment = NSTextAlignmentCenter;
        
        yongjinLabel.textColor = [UIColor colorWithRed:3/255. green:168/255. blue:226/255. alpha:1.];
        
        [self addSubview:yongjinLabel];
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 69, Size.width, 1)];
        
        line.backgroundColor = [UIColor colorWithRed:241/255. green:241/255. blue:241/255. alpha:1.];
        
        [self addSubview:line];
        
    }
    
    return self;
    
}

@end
