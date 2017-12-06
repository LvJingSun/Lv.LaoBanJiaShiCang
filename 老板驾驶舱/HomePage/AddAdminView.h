//
//  AddAdminView.h
//  BusinessCenter
//
//  Created by mac on 16/5/22.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddAdminView : UIView

@property (nonatomic, copy) NSString *type;

@property (nonatomic, weak) UISegmentedControl *segm;

//商铺
@property (nonatomic, weak) UITextField *shopsField;

@property (nonatomic, weak) UIButton *selectSP;

//角色
@property (nonatomic, weak) UITextField *roleField;

//姓名
@property (nonatomic, weak) UITextField *nameField;

//职位
@property (nonatomic, weak) UITextField *positionField;

@property (nonatomic, weak) UIButton *selectZW;

//等级
@property (nonatomic, weak) UITextField *levelField;

//工资
@property (nonatomic, weak) UITextField *gongziField;

@property (nonatomic, weak) UIButton *selectLevel;

//职称代号（昵称）
@property (nonatomic, weak) UITextField *nickNameField;

//电话
@property (nonatomic, weak) UITextField *phoneField;

//头像
@property (nonatomic, weak) UIImageView *iconImageview;

@property (nonatomic, weak) UIButton *selectIcon;

//账号
@property (nonatomic, weak) UITextField *accountField;

//密码
@property (nonatomic, weak) UITextField *passwordField;

@end
