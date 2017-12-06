//
//  AddProductView.h
//  BusinessCenter
//
//  Created by mac on 16/5/11.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface AddProductView : UIView

@property (nonatomic, weak) UITextField *nameField;

@property (nonatomic, weak) UITextField *titleField;

@property (nonatomic, weak) UITextField *typeField;

@property (nonatomic, weak) UIButton *typeBtn;

@property (nonatomic, weak) UITextField *descField;

@property (nonatomic, weak) UIImageView *tuBiaoImageView;

@property (nonatomic, weak) UIButton *imageviewBtn;

- (void)resignFirstResponderKey;

@end
