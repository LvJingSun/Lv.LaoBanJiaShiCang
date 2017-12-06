//
//  AddProductView.m
//  BusinessCenter
//
//  Created by mac on 16/5/11.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import "AddProductView.h"
#define size ([UIScreen mainScreen].bounds.size)

@implementation AddProductView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        CGFloat nameLabX = size.width * 0.05;
        
        CGFloat nameLabY = 10;
        
        CGFloat nameLabW = size.width * 0.2;
        
        CGFloat nameLabH = 20;
        
        UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(nameLabX, nameLabY, nameLabW, nameLabH)];
        
        nameLab.text = @"名称";
        
        [self addSubview:nameLab];
        
        CGFloat nameFieldX = size.width * 0.3;
        
        CGFloat nameFieldY = 5;
        
        CGFloat nameFieldW = size.width * 0.65;
        
        CGFloat nameFieldH = 28;
        
        UITextField *nameField = [[UITextField alloc] initWithFrame:CGRectMake(nameFieldX, nameFieldY, nameFieldW, nameFieldH)];
        
        self.nameField = nameField;
        
        nameField.placeholder = @"商品名称";
        
        [self addSubview:nameField];
        
        UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(nameFieldX, CGRectGetMaxY(nameField.frame) + 1, nameFieldW, 1)];
        
        line1.backgroundColor = [UIColor colorWithRed:0/255. green:170/255. blue:255/255. alpha:1.];
        
        [self addSubview:line1];
        
        UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(nameLabX, CGRectGetMaxY(nameLab.frame) + 10, size.width * 0.9, 1)];
        
        line2.backgroundColor = [UIColor colorWithRed:230/255. green:230/255. blue:230/255. alpha:1.];
        
        [self addSubview:line2];
        
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(nameLabX, CGRectGetMaxY(line2.frame) + 10, nameLabW, nameLabH)];
        
        titleLab.text = @"货号";
        
        [self addSubview:titleLab];
        
        UITextField *titleField = [[UITextField alloc] initWithFrame:CGRectMake(nameFieldX, CGRectGetMaxY(line2.frame) + 5, nameFieldW, nameFieldH)];
        
        titleField.placeholder = @"请准确填写货号";
        
        self.titleField = titleField;
        
        [self addSubview:titleField];
        
        UILabel *line3 = [[UILabel alloc] initWithFrame:CGRectMake(nameFieldX, CGRectGetMaxY(titleField.frame) + 1, nameFieldW, 1)];
        
        line3.backgroundColor = [UIColor colorWithRed:0/255. green:170/255. blue:255/255. alpha:1.];
        
        [self addSubview:line3];
        
        UILabel *line4 = [[UILabel alloc] initWithFrame:CGRectMake(nameLabX, CGRectGetMaxY(titleLab.frame) + 10, size.width * 0.9, 1)];
        
        line4.backgroundColor = [UIColor colorWithRed:230/255. green:230/255. blue:230/255. alpha:1.];
        
        [self addSubview:line4];
        
        UILabel *typeLab = [[UILabel alloc] initWithFrame:CGRectMake(nameLabX, CGRectGetMaxY(line4.frame) + 10, nameLabW, nameLabH)];
        
        typeLab.text = @"分类:";
        
        [self addSubview:typeLab];
        
        UITextField *typeField = [[UITextField alloc] initWithFrame:CGRectMake(nameFieldX, CGRectGetMaxY(line4.frame) + 5, nameFieldW, nameFieldH)];
        
        typeField.placeholder = @"请选择分类";
        
        self.typeField = typeField;
        
        [self addSubview:typeField];
        
        UIButton *typeBtn = [[UIButton alloc] initWithFrame:CGRectMake(nameFieldX, CGRectGetMaxY(line4.frame) + 5, nameFieldW, nameFieldH)];
        
        self.typeBtn = typeBtn;
        
        [typeBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:typeBtn];
        
        UILabel *line5 = [[UILabel alloc] initWithFrame:CGRectMake(nameFieldX, CGRectGetMaxY(typeField.frame) + 1, nameFieldW, 1)];
        
        line5.backgroundColor = [UIColor colorWithRed:0/255. green:170/255. blue:255/255. alpha:1.];
        
        [self addSubview:line5];
        
        UILabel *line6 = [[UILabel alloc] initWithFrame:CGRectMake(nameLabX, CGRectGetMaxY(typeLab.frame) + 10, size.width * 0.9, 1)];
        
        line6.backgroundColor = [UIColor colorWithRed:230/255. green:230/255. blue:230/255. alpha:1.];
        
        [self addSubview:line6];
        
        UILabel *descLab = [[UILabel alloc] initWithFrame:CGRectMake(nameLabX, CGRectGetMaxY(line6.frame) + 10, nameLabW, nameLabH)];
        
        descLab.text = @"备注";
        
        [self addSubview:descLab];
        
        UITextField *descField = [[UITextField alloc] initWithFrame:CGRectMake(nameFieldX, CGRectGetMaxY(line6.frame) + 5, nameFieldW, nameFieldH)];
        
        self.descField = descField;
        
        descField.placeholder = @"请填写备注";
        
        [self addSubview:descField];
        
        UILabel *line7 = [[UILabel alloc] initWithFrame:CGRectMake(nameFieldX, CGRectGetMaxY(descField.frame) + 1, nameFieldW, 1)];
        
        line7.backgroundColor = [UIColor colorWithRed:0/255. green:170/255. blue:255/255. alpha:1.];
        
        [self addSubview:line7];
        
        UILabel *line8 = [[UILabel alloc] initWithFrame:CGRectMake(nameLabX, CGRectGetMaxY(descLab.frame) + 10, size.width * 0.9, 1)];
        
        line8.backgroundColor = [UIColor colorWithRed:230/255. green:230/255. blue:230/255. alpha:1.];
        
        [self addSubview:line8];
        
        UILabel *imageLab = [[UILabel alloc] initWithFrame:CGRectMake(nameLabX, CGRectGetMaxY(line8.frame) + 10, nameLabW, nameLabH)];
        
        imageLab.text = @"图标";
        
        [self addSubview:imageLab];
        
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(nameFieldX, CGRectGetMaxY(line8.frame) + 10, 100, 100)];
        
        self.tuBiaoImageView = imageview;
        
        imageview.backgroundColor = [UIColor lightGrayColor];
        
        [self addSubview:imageview];
        
        UIButton *imageviewBtn = [[UIButton alloc] initWithFrame:CGRectMake(nameFieldX, CGRectGetMaxY(line8.frame) + 10, 100, 100)];
        
        self.imageviewBtn = imageviewBtn;
        
        [self addSubview:imageviewBtn];
        
    }
    
    return self;
    
}

- (void)dismiss {

    [self resignFirstResponderKey];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [self resignFirstResponderKey];
    
}

- (void)resignFirstResponderKey {

    [self.nameField resignFirstResponder];
    
    [self.titleField resignFirstResponder];
    
//    [self.typeField resignFirstResponder];
    
    [self.descField resignFirstResponder];
    
}




@end
