//
//  StorageView.h
//  BusinessCenter
//
//  Created by mac on 16/5/12.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StorageView : UIView

@property (nonatomic, weak) UILabel *nameLab;

@property (nonatomic, weak) UILabel *titleLab;

@property (nonatomic, weak) UILabel *telLab;

@property (nonatomic, weak) UILabel *genderLab;

@property (nonatomic, weak) UITextField *nameField;

@property (nonatomic, weak) UITextField *titleField;

@property (nonatomic, weak) UITextField *telField;

@property (nonatomic, weak) UITextField *genderField;

@property (nonatomic, weak) UILabel *supplierLab;

@property (nonatomic, weak) UITextField *supplierField;

@property (nonatomic, weak) UILabel *countLab;

@property (nonatomic, weak) UITextField *countField;

@property (nonatomic, weak) UIButton *selectGood;

@property (nonatomic, weak) UIButton *selectJBR;

@property (nonatomic, weak) UIButton *selectGYS;

- (void)resignFirstResponderKey;

@end
