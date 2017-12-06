//
//  BtnView.m
//  BusinessCenter
//
//  Created by mac on 16/4/22.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import "BtnView.h"
#import "BtnModel.h"

@interface BtnView ()

@property (nonatomic, weak) UIImageView *imageview;

@property (nonatomic, weak) UILabel *titleLab;



@property (nonatomic, weak) UIButton *btn;

@end

@implementation BtnView





- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self == [super initWithFrame:frame]) {
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        
        btn.backgroundColor = [UIColor whiteColor];
        
        [btn addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
        
        self.btn = btn;
        
        [self addSubview:btn];
        
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width * 0.3, frame.size.height)];
        
        self.imageview = image;
        
        [btn addSubview:image];
        
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width * 0.35, 0, frame.size.width * 0.65, frame.size.height * 0.5)];
        
        self.titleLab = titleLab;
        
        [btn addSubview:titleLab];
        
        UILabel *countLab = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width * 0.35, frame.size.height * 0.5, frame.size.width * 0.65, frame.size.height * 0.5)];
        
        self.countLab = countLab;
        
        [btn addSubview:countLab];
        
    }
    
    return self;
    
}

- (void)btnclick:(UIButton *)btn {

    if ([self.delegate respondsToSelector:@selector(BtnClickSelected:)]) {
        
        [self.delegate BtnClickSelected:self.model];
        
    }
    
}

-(void)setModel:(BtnModel *)model {

    _model = model;
    
    self.imageview.image = [UIImage imageNamed:model.imageName];
    
    self.titleLab.text = model.title;
    
//    self.countLab.text = model.count;
    
}

- (void)layoutSubviews {
    
}

@end
