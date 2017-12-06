//
//  RechargeBasicViewController.m
//  BusinessCenter
//
//  Created by mac on 2017/9/28.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import "RechargeBasicViewController.h"
#import "RechargeHeader.h"

@interface RechargeBasicViewController ()

@end

@implementation RechargeBasicViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.view.backgroundColor = ViewBGColor;
    
//    [self.navigationItem setHidesBackButton:YES];
    
//    self.navigationController.navigationBar.tintColor = ThemeColor;
    
//    [self.navigationController.navigationBar setTranslucent:NO];
    
    //    取消导航栏底部分割线
    //    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //
    //    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
    
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:TitleTextFont,NSForegroundColorAttributeName:ThemeColor}];
    
}

- (UIBarButtonItem *)SetNavigationBarRightTitle:(NSString *)title andaction:(SEL)Saction{
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [addButton setFrame:CGRectMake(0, 0, 60, 40)];
    
    addButton.backgroundColor = [UIColor clearColor];
    
    [addButton setTitle:title forState:UIControlStateNormal];
    
    [addButton setTitleColor:ThemeColor forState:0];
    
    addButton.titleLabel.font = [UIFont systemFontOfSize:16];
    
    [addButton addTarget:self action:Saction forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *_addFriendItem = [[UIBarButtonItem alloc] initWithCustomView:addButton];
    
    return _addFriendItem;
    
}

- (UIBarButtonItem *)SetNavigationBarImage:(NSString *)aImageName andaction:(SEL)Saction{
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setFrame:CGRectMake(0, 0, 32, 32)];
    addButton.backgroundColor = [UIColor clearColor];
    [addButton setImage:[UIImage imageNamed:aImageName] forState:UIControlStateNormal];
    [addButton addTarget:self action:Saction forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *_addFriendItem = [[UIBarButtonItem alloc] initWithCustomView:addButton];
    return _addFriendItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
