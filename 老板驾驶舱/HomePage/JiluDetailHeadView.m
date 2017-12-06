//
//  JiluDetailHeadView.m
//  BusinessCenter
//
//  Created by mac on 16/5/20.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import "JiluDetailHeadView.h"
#define Size ([UIScreen mainScreen].bounds.size)

@implementation JiluDetailHeadView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        CGFloat imageX = Size.width * 0.05;
        
        CGFloat imageY = 10;
        
        CGFloat imageW = Size.width * 0.2;
        
        CGFloat imageH = 60;
        
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(imageX, imageY, imageW, imageH)];
        
        self.dianzhongImageView = imageview;
        
        [self addSubview:imageview];
        
        CGFloat nameX = Size.width * 0.35;
        
        CGFloat nameY = 10;
        
        CGFloat nameW = Size.width * 0.3;
        
        CGFloat nameH = 25;
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameX, nameY, nameW, nameH)];
        
        self.nameLabel = nameLabel;
        
        nameLabel.font = [UIFont systemFontOfSize:17];
        
        nameLabel.textColor = [UIColor colorWithRed:51/255. green:51/255. blue:51/255. alpha:1.];
        
        [self addSubview:nameLabel];
        
        UILabel *countLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameX, CGRectGetMaxY(nameLabel.frame) + 10, nameW, nameH)];
        
        self.countLabel = countLabel;
        
        countLabel.textColor = [UIColor colorWithRed:125/255. green:125/255. blue:125/255. alpha:1.];
        
        countLabel.font = [UIFont systemFontOfSize:12];
        
        [self addSubview:countLabel];
        
        UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(Size.width * 0.7, 20, Size.width * 0.25, 40)];
        
        self.priceLabel = priceLabel;
        
        priceLabel.font = [UIFont systemFontOfSize:18];
        
        priceLabel.textAlignment = NSTextAlignmentCenter;
        
        priceLabel.textColor = [UIColor colorWithRed:3/255. green:168/255. blue:226/255. alpha:1.];
        
        [self addSubview:priceLabel];
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 79, Size.width, 1)];
        
        line.backgroundColor = [UIColor colorWithRed:241/255. green:241/255. blue:241/255. alpha:1.];
        
        [self addSubview:line];
        
    }
    
    return self;
    
}

@end
