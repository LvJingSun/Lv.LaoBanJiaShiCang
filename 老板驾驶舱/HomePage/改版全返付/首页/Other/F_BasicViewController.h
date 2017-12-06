//
//  F_BasicViewController.h
//  BusinessCenter
//
//  Created by mac on 2017/3/14.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

@interface F_BasicViewController : UIViewController

- (UIBarButtonItem *)SetNavigationBarImage:(NSString *)aImageName andaction:(SEL)Saction;

- (UIBarButtonItem *)SetNavigationBarRightTitle:(NSString *)title andaction:(SEL)Saction;

@end
