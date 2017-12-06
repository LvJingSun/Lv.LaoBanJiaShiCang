//
//  AddAdminView.m
//  BusinessCenter
//
//  Created by mac on 16/5/22.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import "AddAdminView.h"
#define size ([UIScreen mainScreen].bounds.size)
#define BJ_COLOR [UIColor colorWithRed:245/255. green:245/255. blue:249/255. alpha:1.]
#define LINE_COLOR [UIColor colorWithRed:230/255. green:230/255. blue:230/255. alpha:1.]

@interface AddAdminView ()

@end

@implementation AddAdminView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(size.width * 0.05, 10, size.width * 0.15, 30)];
        
        lab.text = @"角色";
        
        [self addSubview:lab];
        
        UISegmentedControl *segm = [[UISegmentedControl alloc] initWithItems:@[@"收银员",@"普通员工"]];
        
        segm.frame = CGRectMake(size.width * 0.25, 10, size.width * 0.6, 30);
        
        segm.selectedSegmentIndex = 0;
        
        segm.tintColor = [UIColor colorWithRed:19/255. green:151/255. blue:36/255. alpha:1.];
        
        self.segm = segm;
        
        [self addSubview:segm];
        
        UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, size.width, 1)];
        
        line1.backgroundColor = LINE_COLOR;
        
        [self addSubview:line1];
        
        UILabel *biaoti1 = [[UILabel alloc] initWithFrame:CGRectMake(size.width * 0.05, CGRectGetMaxY(line1.frame), size.width * 0.15, 40)];
        
        biaoti1.textColor = [UIColor blackColor];
        
        biaoti1.text = @"店铺";
        
        [self addSubview:biaoti1];
        
        UITextField *shopsField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(biaoti1.frame), CGRectGetMaxY(line1.frame), size.width * 0.8, 40)];
        
        shopsField.placeholder = @"选择商铺";
        
        self.shopsField = shopsField;
        
        [self addSubview:shopsField];
        
        UIButton *selectSP = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(biaoti1.frame), CGRectGetMaxY(line1.frame), size.width * 0.8, 40)];
        
        self.selectSP = selectSP;
        
        [selectSP addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:selectSP];
        
        UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(size.width * 0.05, CGRectGetMaxY(biaoti1.frame), size.width * 0.95, 1)];
        
        line2.backgroundColor = LINE_COLOR;
        
        [self addSubview:line2];

        UILabel *biaoti2 = [[UILabel alloc] initWithFrame:CGRectMake(size.width * 0.05, CGRectGetMaxY(line2.frame), size.width * 0.15, 40)];
        
        biaoti2.text = @"姓名";
        
        [self addSubview:biaoti2];
        
        UITextField *nameField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(biaoti2.frame), CGRectGetMaxY(line2.frame), size.width * 0.8, 40)];
        
        nameField.placeholder = @"员工姓名";
        
        self.nameField = nameField;
        
        [self addSubview:nameField];
        
        UILabel *line3 = [[UILabel alloc] initWithFrame:CGRectMake(size.width * 0.05, CGRectGetMaxY(biaoti2.frame), size.width * 0.95, 1)];
        
        line3.backgroundColor = LINE_COLOR;
        
        [self addSubview:line3];
        
        UILabel *biaoti3 = [[UILabel alloc] initWithFrame:CGRectMake(size.width * 0.05, CGRectGetMaxY(line3.frame), size.width * 0.15, 40)];
        
        biaoti3.text = @"职位";
        
        [self addSubview:biaoti3];
        
        UITextField *positionField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(biaoti3.frame), CGRectGetMaxY(line3.frame), size.width * 0.8, 40)];
        
        positionField.placeholder = @"选择职位";
        
        self.positionField = positionField;
        
        [self addSubview:positionField];
        
        UIButton *selectZW = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(biaoti3.frame), CGRectGetMaxY(line3.frame), size.width * 0.8, 40)];
        
        self.selectZW = selectZW;
        
        [selectZW addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:selectZW];
        
        UILabel *line4 = [[UILabel alloc] initWithFrame:CGRectMake(size.width * 0.05, CGRectGetMaxY(biaoti3.frame), size.width * 0.95, 1)];
        
        line4.backgroundColor = LINE_COLOR;
        
        [self addSubview:line4];
        
        UILabel *biaotiL = [[UILabel alloc] initWithFrame:CGRectMake(size.width * 0.05, CGRectGetMaxY(line4.frame), size.width * 0.15, 40)];
        
        biaotiL.text = @"等级";
        
        [self addSubview:biaotiL];
        
        UITextField *levelField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(biaotiL.frame), CGRectGetMaxY(line4.frame), size.width * 0.8, 40)];
        
        levelField.placeholder = @"选择等级";
        
        self.levelField = levelField;
        
        [self addSubview:levelField];
        
        UIButton *selectlevel = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(biaotiL.frame), CGRectGetMaxY(line4.frame), size.width * 0.8, 40)];
        
        self.selectLevel = selectlevel;
        
        [selectlevel addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:selectlevel];
        
        UILabel *lineL = [[UILabel alloc] initWithFrame:CGRectMake(size.width * 0.05, CGRectGetMaxY(biaotiL.frame), size.width * 0.95, 1)];
        
        lineL.backgroundColor = LINE_COLOR;
        
        [self addSubview:lineL];
        
        
        
        UILabel *biaotiG = [[UILabel alloc] initWithFrame:CGRectMake(size.width * 0.05, CGRectGetMaxY(lineL.frame), size.width * 0.15, 40)];
        
        biaotiG.text = @"工资";
        
        [self addSubview:biaotiG];
        
        UITextField *gongziField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(biaotiG.frame), CGRectGetMaxY(lineL.frame), size.width * 0.8, 40)];
        
        gongziField.placeholder = @"基本工资";
        
        self.gongziField = gongziField;
        
        [self addSubview:gongziField];
        
        UILabel *lineG = [[UILabel alloc] initWithFrame:CGRectMake(size.width * 0.05, CGRectGetMaxY(biaotiG.frame), size.width * 0.95, 1)];
        
        lineG.backgroundColor = LINE_COLOR;
        
        [self addSubview:lineG];
        
        
        UILabel *biaoti4 = [[UILabel alloc] initWithFrame:CGRectMake(size.width * 0.05, CGRectGetMaxY(lineG.frame), size.width * 0.15, 40)];
        
        biaoti4.text = @"昵称";
        
        [self addSubview:biaoti4];
        
        UITextField *nickNameField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(biaoti4.frame), CGRectGetMaxY(lineG.frame), size.width * 0.8, 40)];
        
        nickNameField.placeholder = @"员工昵称";
        
        self.nickNameField = nickNameField;
        
        [self addSubview:nickNameField];
        
        UILabel *line5 = [[UILabel alloc] initWithFrame:CGRectMake(size.width * 0.05, CGRectGetMaxY(biaoti4.frame), size.width * 0.95, 1)];
        
        line5.backgroundColor = LINE_COLOR;
        
        [self addSubview:line5];
        
        UILabel *biaoti5 = [[UILabel alloc] initWithFrame:CGRectMake(size.width * 0.05, CGRectGetMaxY(line5.frame), size.width * 0.15, 40)];
        
        biaoti5.text = @"电话";
        
        [self addSubview:biaoti5];
        
        UITextField *phoneField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(biaoti5.frame), CGRectGetMaxY(line5.frame), size.width * 0.8, 40)];
        
        phoneField.placeholder = @"员工电话";
        
        self.phoneField = phoneField;
        
        [self addSubview:phoneField];
        
        UILabel *line6 = [[UILabel alloc] initWithFrame:CGRectMake(size.width * 0.05, CGRectGetMaxY(biaoti5.frame), size.width * 0.95, 1)];
        
        line6.backgroundColor = LINE_COLOR;
        
        [self addSubview:line6];
        
        UILabel *biaoti6 = [[UILabel alloc] initWithFrame:CGRectMake(size.width * 0.05, CGRectGetMaxY(line6.frame), size.width * 0.15, 40)];
        
        biaoti6.text = @"头像";
        
        [self addSubview:biaoti6];
        
        UIImageView *iconImageview = [[UIImageView alloc] initWithFrame:CGRectMake(size.width * 0.25, CGRectGetMaxY(line6.frame) + 10, size.width * 0.4, size.width * 0.4)];
        
        self.iconImageview = iconImageview;
        
        iconImageview.backgroundColor = [UIColor lightGrayColor];
        
        [self addSubview:iconImageview];
        
        UIButton *selectIcon = [[UIButton alloc] initWithFrame:CGRectMake(size.width * 0.25, CGRectGetMaxY(line6.frame) + 10, size.width * 0.4, size.width * 0.4)];
        
        self.selectIcon = selectIcon;
        
        [self addSubview:selectIcon];
        
    }
    
    return self;
    
}

- (void)dismiss {

    if (![self.shopsField isExclusiveTouch]) {
        
        [self.shopsField resignFirstResponder];
        
    }
    
    if (![self.nameField isExclusiveTouch]) {
        
        [self.nameField resignFirstResponder];
        
    }
    
    if (![self.positionField isExclusiveTouch]) {
        
        [self.positionField resignFirstResponder];
        
    }
    
    if (![self.nickNameField isExclusiveTouch]) {
        
        [self.nickNameField resignFirstResponder];
        
    }
    
    if (![self.phoneField isExclusiveTouch]) {
        
        [self.phoneField resignFirstResponder];
        
    }
    
    if (![self.levelField isExclusiveTouch]) {
        
        [self.levelField resignFirstResponder];
        
    }
    
    if (![self.gongziField isExclusiveTouch]) {
        
        [self.gongziField resignFirstResponder];
        
    }
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    if (![self.shopsField isExclusiveTouch]) {
        
        [self.shopsField resignFirstResponder];
        
    }
    
    if (![self.nameField isExclusiveTouch]) {
        
        [self.nameField resignFirstResponder];
        
    }
    
    if (![self.positionField isExclusiveTouch]) {
        
        [self.positionField resignFirstResponder];
        
    }
    
    if (![self.nickNameField isExclusiveTouch]) {
        
        [self.nickNameField resignFirstResponder];
        
    }
    
    if (![self.phoneField isExclusiveTouch]) {
        
        [self.phoneField resignFirstResponder];
        
    }
    
    if (![self.levelField isExclusiveTouch]) {
        
        [self.levelField resignFirstResponder];
        
    }
    
    if (![self.gongziField isExclusiveTouch]) {
        
        [self.gongziField resignFirstResponder];
        
    }
    
}

@end
