//
//  RevenueTitleView.m
//  BusinessCenter
//
//  Created by mac on 2017/4/12.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import "RevenueTitleView.h"
#define TitleColor [UIColor colorWithRed:33/255.f green:33/255.f blue:33/255.f alpha:1.0]

@interface RevenueTitleView () {

    CGSize size;
    
}

@end

@implementation RevenueTitleView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        size = self.bounds.size;
        
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width * 0.6, size.height)];
        
        titleLab.textAlignment = NSTextAlignmentRight;
        
        titleLab.font = [UIFont systemFontOfSize:17];
        
        titleLab.textColor = TitleColor;
        
        titleLab.text = @"收支记录";
        
        self.titleLab = titleLab;
        
        [self addSubview:titleLab];
        
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(size.width * 0.6 + 5, (size.height - 9) * 0.5, 13, 9)];
        
        self.imageview = image;
        
        image.image = [UIImage imageNamed:@"N_TitleImg_B.png"];
        
        [self addSubview:image];
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.imageview.frame) - 80, 0, 80, size.height)];
        
        self.clickBtn = btn;
        
//        [btn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:btn];
        
    }
    
    return self;
    
}

//-(void)setIsZhanKai:(BOOL)isZhanKai {
//
//    _isZhanKai = isZhanKai;
//    
//    [self setRect];
//    
//    [self setContent];
//    
//}
//
//- (void)setRect {
//
//    self.titleLab.frame = ;
//    
//    self.imageview.frame = ;
//    
//    self.clickBtn.frame = ;
//    
//}
//
//- (void)setContent {
//
//    self.titleLab
//    
//    self.imageview
//    
//    self.clickBtn.tag = 0;
//    
//}
//
//- (void)BtnClick:(UIButton *)sender {
//    
//    if (sender.tag == 1) {
//        
//        sender.tag = 0;
//        
//        self.imageview.image = [UIImage imageNamed:@"N_TitleImg_B.png"];
//        
//    }else {
//        
//        sender.tag = 1;
//    
//        self.imageview.image = [UIImage imageNamed:@"N_TitleImg_T.png"];
//        
//    }
//
//    if ([self.delegate respondsToSelector:@selector(N_TitleCkick:)]) {
//        
//        [self.delegate N_TitleCkick:sender];
//        
//    }
//    
//}

@end
