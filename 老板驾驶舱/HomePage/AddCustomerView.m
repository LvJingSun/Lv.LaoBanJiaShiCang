//
//  AddCustomerView.m
//  BusinessCenter
//
//  Created by mac on 16/5/11.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import "AddCustomerView.h"
#define size ([UIScreen mainScreen].bounds.size)

@implementation AddCustomerView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        CGFloat nameLabX = size.width * 0.05;
        
        CGFloat nameLabY = 10;
        
        CGFloat nameLabW = size.width * 0.2;
        
        CGFloat nameLabH = 20;
        
        UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(nameLabX, nameLabY, nameLabW, nameLabH)];
        
        self.nameLab = nameLab;
        
        nameLab.text = @"姓名";
        
        [self addSubview:nameLab];
        
        CGFloat nameFieldX = size.width * 0.3;
        
        CGFloat nameFieldY = 5;
        
        CGFloat nameFieldW = size.width * 0.65;
        
        CGFloat nameFieldH = 28;
        
        UITextField *nameField = [[UITextField alloc] initWithFrame:CGRectMake(nameFieldX, nameFieldY, nameFieldW, nameFieldH)];
        
        self.nameField = nameField;
        
        nameField.placeholder = @"请输入客户姓名";
        
        [self addSubview:nameField];
        
        UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(nameFieldX, CGRectGetMaxY(nameField.frame) + 1, nameFieldW, 1)];
        
        line1.backgroundColor = [UIColor colorWithRed:0/255. green:170/255. blue:255/255. alpha:1.];
        
        [self addSubview:line1];
        
        UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(nameLabX, CGRectGetMaxY(nameLab.frame) + 10, size.width * 0.9, 1)];
        
        line2.backgroundColor = [UIColor colorWithRed:230/255. green:230/255. blue:230/255. alpha:1.];
        
        [self addSubview:line2];
        
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(nameLabX, CGRectGetMaxY(line2.frame) + 10, nameLabW, nameLabH)];
        
        self.titleLab = titleLab;
        
        titleLab.text = @"地址";
        
        [self addSubview:titleLab];
        
        UITextField *titleField = [[UITextField alloc] initWithFrame:CGRectMake(nameFieldX, CGRectGetMaxY(line2.frame) + 5, nameFieldW, nameFieldH)];
        
        titleField.placeholder = @"请输入客户地址";
        
        self.titleField = titleField;
        
        [self addSubview:titleField];
        
        UILabel *line3 = [[UILabel alloc] initWithFrame:CGRectMake(nameFieldX, CGRectGetMaxY(titleField.frame) + 1, nameFieldW, 1)];
        
        line3.backgroundColor = [UIColor colorWithRed:0/255. green:170/255. blue:255/255. alpha:1.];
        
        [self addSubview:line3];
        
        UILabel *line5 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLab.frame) + 10, size.width, 10)];
        
        line5.backgroundColor = [UIColor colorWithRed:230/255. green:230/255. blue:230/255. alpha:1.];
        
        [self addSubview:line5];
        
        UILabel *telLab = [[UILabel alloc] initWithFrame:CGRectMake(nameLabX, CGRectGetMaxY(line5.frame) + 10, nameLabW, nameLabH)];
        
        telLab.text = @"电话";
        
        self.telLab = telLab;
        
        [self addSubview:telLab];
        
        UITextField *telField = [[UITextField alloc] initWithFrame:CGRectMake(nameFieldX, CGRectGetMaxY(line5.frame) + 5, nameFieldW, nameFieldH)];
        
        telField.placeholder = @"请输入客户联系电话";
        
        self.telField = telField;
        
        [self addSubview:telField];
        
        UILabel *line6 = [[UILabel alloc] initWithFrame:CGRectMake(nameFieldX, CGRectGetMaxY(telField.frame) + 1, nameFieldW, 1)];
        
        line6.backgroundColor = [UIColor colorWithRed:0/255. green:170/255. blue:255/255. alpha:1.];
        
        [self addSubview:line6];
        
        UILabel *line7 = [[UILabel alloc] initWithFrame:CGRectMake(nameLabX, CGRectGetMaxY(telLab.frame) + 10, size.width * 0.9, 1)];
        
        line7.backgroundColor = [UIColor colorWithRed:230/255. green:230/255. blue:230/255. alpha:1.];
        
        [self addSubview:line7];
        
        UILabel *genderLab = [[UILabel alloc] initWithFrame:CGRectMake(nameLabX, CGRectGetMaxY(line7.frame) + 10, nameLabW, nameLabH)];
        
        genderLab.text = @"性别";
        
        self.genderLab = genderLab;
        
        [self addSubview:genderLab];
        
        UITextField *genderField = [[UITextField alloc] initWithFrame:CGRectMake(nameFieldX, CGRectGetMaxY(line7.frame) + 5, nameFieldW, nameFieldH)];
        
        self.genderField = genderField;
        
        genderField.placeholder = @"请选择客户性别";
        
        [self addSubview:genderField];
        
        UILabel *line8 = [[UILabel alloc] initWithFrame:CGRectMake(nameFieldX, CGRectGetMaxY(genderField.frame) + 1, nameFieldW, 1)];
        
        line8.backgroundColor = [UIColor colorWithRed:0/255. green:170/255. blue:255/255. alpha:1.];
        
        [self addSubview:line8];
        
    }
    
    return self;
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self resignFirstResponderKey];
    
}

- (void)resignFirstResponderKey {
    
    [self.nameField resignFirstResponder];
    
    [self.titleField resignFirstResponder];
    
    [self.telField resignFirstResponder];
    
    [self.genderField resignFirstResponder];
    
}


@end
