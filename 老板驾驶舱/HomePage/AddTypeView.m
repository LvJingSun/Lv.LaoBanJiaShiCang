//
//  AddTypeView.m
//  BusinessCenter
//
//  Created by mac on 16/5/16.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import "AddTypeView.h"
#define size ([UIScreen mainScreen].bounds.size)

@implementation AddTypeView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        CGFloat nameLabX = size.width * 0.05;
        
        CGFloat nameLabY = 10;
        
        CGFloat nameLabW = size.width * 0.2;
        
        CGFloat nameLabH = 20;
        
        UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(nameLabX, nameLabY, nameLabW, nameLabH)];
        
        self.nameLab = nameLab;
        
        nameLab.text = @"名称";
        
        [self addSubview:nameLab];
        
        CGFloat nameFieldX = size.width * 0.3;
        
        CGFloat nameFieldY = 5;
        
        CGFloat nameFieldW = size.width * 0.65;
        
        CGFloat nameFieldH = 28;
        
        UITextField *nameField = [[UITextField alloc] initWithFrame:CGRectMake(nameFieldX, nameFieldY, nameFieldW, nameFieldH)];
        
        self.nameField = nameField;
        
        nameField.placeholder = @"请输入分类名称";
        
        [self addSubview:nameField];
        
        UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(nameFieldX, CGRectGetMaxY(nameField.frame) + 1, nameFieldW, 1)];
        
        line1.backgroundColor = [UIColor colorWithRed:0/255. green:170/255. blue:255/255. alpha:1.];
        
        [self addSubview:line1];
        
    }
    
    return self;
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self resignFirstResponderKey];
    
}

- (void)resignFirstResponderKey {

    [self.nameField resignFirstResponder];
    
}

@end
