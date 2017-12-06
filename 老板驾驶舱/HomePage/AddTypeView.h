//
//  AddTypeView.h
//  BusinessCenter
//
//  Created by mac on 16/5/16.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddTypeView : UIView

@property (nonatomic, weak) UILabel *nameLab;

@property (nonatomic, weak) UITextField *nameField;

- (void)resignFirstResponderKey;

@end
