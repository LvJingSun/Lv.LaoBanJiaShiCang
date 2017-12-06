//
//  AddSupplierView.h
//  BusinessCenter
//
//  Created by mac on 16/5/11.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddSupplierView : UIView

@property (nonatomic, weak) UILabel *nameLab;

@property (nonatomic, weak) UILabel *titleLab;

@property (nonatomic, weak) UILabel *telLab;

@property (nonatomic, weak) UILabel *genderLab;

@property (nonatomic, weak) UITextField *nameField;

@property (nonatomic, weak) UITextField *titleField;

@property (nonatomic, weak) UITextField *telField;

@property (nonatomic, weak) UITextField *genderField;

- (void)resignFirstResponderKey;

@end
