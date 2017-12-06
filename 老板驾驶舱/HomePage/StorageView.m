//
//  StorageView.m
//  BusinessCenter
//
//  Created by mac on 16/5/12.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import "StorageView.h"
#define size ([UIScreen mainScreen].bounds.size)

@implementation StorageView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        CGFloat nameLabX = size.width * 0.05;
        
        CGFloat nameLabY = 10;
        
        CGFloat nameLabW = size.width * 0.2;
        
        CGFloat nameLabH = 20;
        
        UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(nameLabX, nameLabY, nameLabW, nameLabH)];
        
        self.nameLab = nameLab;
        
        nameLab.text = @"商品";
        
        [self addSubview:nameLab];
        
        CGFloat nameFieldX = size.width * 0.3;
        
        CGFloat nameFieldY = 5;
        
        CGFloat nameFieldW = size.width * 0.65;
        
        CGFloat nameFieldH = 28;
        
        UITextField *nameField = [[UITextField alloc] initWithFrame:CGRectMake(nameFieldX, nameFieldY, nameFieldW, nameFieldH)];
        
        self.nameField = nameField;
        
        nameField.placeholder = @"请选择商品";
        
        [self addSubview:nameField];
        
        UIButton *goodNameBtn = [[UIButton alloc] initWithFrame:CGRectMake(nameFieldX, nameFieldY, nameFieldW, nameFieldH)];
        
        self.selectGood = goodNameBtn;
        
//        [goodNameBtn addTarget:self action:@selector(goodNameBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:goodNameBtn];
        
        UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(nameFieldX, CGRectGetMaxY(nameField.frame) + 1, nameFieldW, 1)];
        
        line1.backgroundColor = [UIColor colorWithRed:0/255. green:170/255. blue:255/255. alpha:1.];
        
        [self addSubview:line1];
        
        UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(nameLabX, CGRectGetMaxY(nameLab.frame) + 10, size.width * 0.9, 1)];
        
        line2.backgroundColor = [UIColor colorWithRed:230/255. green:230/255. blue:230/255. alpha:1.];
        
        [self addSubview:line2];
        
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(nameLabX, CGRectGetMaxY(line2.frame) + 10, nameLabW, nameLabH)];
        
        self.titleLab = titleLab;
        
        titleLab.text = @"经办人";
        
        [self addSubview:titleLab];
        
        UITextField *titleField = [[UITextField alloc] initWithFrame:CGRectMake(nameFieldX, CGRectGetMaxY(line2.frame) + 5, nameFieldW, nameFieldH)];
        
        titleField.placeholder = @"请选择经办人";
        
        self.titleField = titleField;
        
        [self addSubview:titleField];
        
        UIButton *managerBtn = [[UIButton alloc] initWithFrame:CGRectMake(nameFieldX, CGRectGetMaxY(line2.frame) + 5, nameFieldW, nameFieldH)];
        
//        [managerBtn addTarget:self action:@selector(managerBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        self.selectJBR = managerBtn;
        
        [self addSubview:managerBtn];
        
        UILabel *line3 = [[UILabel alloc] initWithFrame:CGRectMake(nameFieldX, CGRectGetMaxY(titleField.frame) + 1, nameFieldW, 1)];
        
        line3.backgroundColor = [UIColor colorWithRed:0/255. green:170/255. blue:255/255. alpha:1.];
        
        [self addSubview:line3];
        
        UILabel *line4 = [[UILabel alloc] initWithFrame:CGRectMake(nameLabX, CGRectGetMaxY(titleLab.frame) + 10, size.width * 0.9, 1)];
        
        line4.backgroundColor = [UIColor colorWithRed:230/255. green:230/255. blue:230/255. alpha:1.];
        
        [self addSubview:line4];
        
        UILabel *supplierLab = [[UILabel alloc] initWithFrame:CGRectMake(nameLabX, CGRectGetMaxY(line4.frame) + 10, nameLabW, nameLabH)];
        
        self.supplierLab = supplierLab;
        
        supplierLab.text = @"供应商";
        
        [self addSubview:supplierLab];
        
        UITextField *supplierField = [[UITextField alloc] initWithFrame:CGRectMake(nameFieldX, CGRectGetMaxY(line4.frame) + 5, nameFieldW, nameFieldH)];
        
        supplierField.placeholder = @"请选择供应商";
        
        self.supplierField = supplierField;
        
        [self addSubview:supplierField];
        
        UIButton *supplierBtn = [[UIButton alloc] initWithFrame:CGRectMake(nameFieldX, CGRectGetMaxY(line4.frame) + 5, nameFieldW, nameFieldH)];
        
//        [supplierBtn addTarget:self action:@selector(supplierBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        self.selectGYS = supplierBtn;
        
        [self addSubview:supplierBtn];
        
        UILabel *line5 = [[UILabel alloc] initWithFrame:CGRectMake(nameFieldX, CGRectGetMaxY(supplierField.frame) + 1, nameFieldW, 1)];
        
        line5.backgroundColor = [UIColor colorWithRed:0/255. green:170/255. blue:255/255. alpha:1.];
        
        [self addSubview:line5];
        
        UILabel *line6 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(supplierLab.frame) + 10, size.width, 10)];
        
        line6.backgroundColor = [UIColor colorWithRed:230/255. green:230/255. blue:230/255. alpha:1.];
        
        [self addSubview:line6];
        
        
        UILabel *telLab = [[UILabel alloc] initWithFrame:CGRectMake(nameLabX, CGRectGetMaxY(line6.frame) + 10, nameLabW, nameLabH)];
        
        telLab.text = @"进价(¥)";
        
        self.telLab = telLab;
        
        [self addSubview:telLab];
        
        UITextField *telField = [[UITextField alloc] initWithFrame:CGRectMake(nameFieldX, CGRectGetMaxY(line6.frame) + 5, nameFieldW, nameFieldH)];
        
        telField.placeholder = @"请输入价格";
        
        self.telField = telField;
        
        [self addSubview:telField];
        
        UILabel *line7 = [[UILabel alloc] initWithFrame:CGRectMake(nameFieldX, CGRectGetMaxY(telField.frame) + 1, nameFieldW, 1)];
        
        line7.backgroundColor = [UIColor colorWithRed:0/255. green:170/255. blue:255/255. alpha:1.];
        
        [self addSubview:line7];
        
        UILabel *line8 = [[UILabel alloc] initWithFrame:CGRectMake(nameLabX, CGRectGetMaxY(telLab.frame) + 10, size.width * 0.9, 1)];
        
        line8.backgroundColor = [UIColor colorWithRed:230/255. green:230/255. blue:230/255. alpha:1.];
        
        [self addSubview:line8];
        
        UILabel *genderLab = [[UILabel alloc] initWithFrame:CGRectMake(nameLabX, CGRectGetMaxY(line8.frame) + 10, nameLabW, nameLabH)];
        
        genderLab.text = @"售价(¥)";
        
        self.genderLab = genderLab;
        
        [self addSubview:genderLab];
        
        UITextField *genderField = [[UITextField alloc] initWithFrame:CGRectMake(nameFieldX, CGRectGetMaxY(line8.frame) + 5, nameFieldW, nameFieldH)];
        
        self.genderField = genderField;
        
        genderField.placeholder = @"请输入价格";
        
        [self addSubview:genderField];
        
        UILabel *line9 = [[UILabel alloc] initWithFrame:CGRectMake(nameFieldX, CGRectGetMaxY(genderField.frame) + 1, nameFieldW, 1)];
        
        line9.backgroundColor = [UIColor colorWithRed:0/255. green:170/255. blue:255/255. alpha:1.];
        
        [self addSubview:line9];
        
        UILabel *line10 = [[UILabel alloc] initWithFrame:CGRectMake(nameLabX, CGRectGetMaxY(genderLab.frame) + 10, size.width * 0.9, 1)];
        
        line10.backgroundColor = [UIColor colorWithRed:230/255. green:230/255. blue:230/255. alpha:1.];
        
        [self addSubview:line10];
        
        UILabel *countLab = [[UILabel alloc] initWithFrame:CGRectMake(nameLabX, CGRectGetMaxY(line10.frame) + 10, nameLabW, nameLabH)];
        
        countLab.text = @"数量(件)";
        
        self.countLab = countLab;
        
        [self addSubview:countLab];
        
        UITextField *countField = [[UITextField alloc] initWithFrame:CGRectMake(nameFieldX, CGRectGetMaxY(line10.frame) + 5, nameFieldW, nameFieldH)];
        
        self.countField = countField;
        
        countField.placeholder = @"请输入数量";
        
        [self addSubview:countField];
        
        UILabel *line11 = [[UILabel alloc] initWithFrame:CGRectMake(nameFieldX, CGRectGetMaxY(countField.frame) + 1, nameFieldW, 1)];
        
        line11.backgroundColor = [UIColor colorWithRed:0/255. green:170/255. blue:255/255. alpha:1.];
        
        [self addSubview:line11];
        
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
    
    [self.supplierField resignFirstResponder];
    
    [self.countField resignFirstResponder];
    
}

@end
