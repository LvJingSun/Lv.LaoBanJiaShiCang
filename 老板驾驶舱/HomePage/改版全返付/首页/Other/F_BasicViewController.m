//
//  F_BasicViewController.m
//  BusinessCenter
//
//  Created by mac on 2017/3/14.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import "F_BasicViewController.h"

@interface F_BasicViewController ()

@end

@implementation F_BasicViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];
    
    self.navigationItem.backBarButtonItem = backItem;
    
    self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
    
}

- (UIBarButtonItem *)SetNavigationBarImage:(NSString *)aImageName andaction:(SEL)Saction{
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [addButton setFrame:CGRectMake(0, 0, 50, 50)];
    
    addButton.backgroundColor = [UIColor clearColor];
    
    [addButton setImage:[UIImage imageNamed:aImageName] forState:UIControlStateNormal];
    
    [addButton addTarget:self action:Saction forControlEvents:UIControlEventTouchUpInside];
    
//    addButton.layer.masksToBounds = YES;
//    
//    addButton.layer.cornerRadius = addButton.frame.size.width * 0.5;
    
    UIBarButtonItem *_addFriendItem = [[UIBarButtonItem alloc] initWithCustomView:addButton];
    
    return _addFriendItem;
    
}

- (UIBarButtonItem *)SetNavigationBarRightTitle:(NSString *)title andaction:(SEL)Saction{
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [addButton setFrame:CGRectMake(0, 0, 40, 40)];
    
    addButton.backgroundColor = [UIColor clearColor];
    
    [addButton setTitle:title forState:UIControlStateNormal];
    
    addButton.titleLabel.font = [UIFont systemFontOfSize:15];
    
    [addButton setTitleColor:[UIColor darkGrayColor] forState:0];
    
    [addButton addTarget:self action:Saction forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *_addFriendItem = [[UIBarButtonItem alloc] initWithCustomView:addButton];
    
    return _addFriendItem;
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

}

@end
