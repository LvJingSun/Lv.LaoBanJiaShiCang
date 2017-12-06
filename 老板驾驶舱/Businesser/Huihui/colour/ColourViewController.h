//
//  ColourViewController.h
//  BusinessCenter
//
//  Created by 冯海强 on 14-2-13.
//  Copyright (c) 2014年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KZColorPicker.h"
@protocol KZDefaultColorControllerDelegate;


@interface ColourViewController : UIViewController

@property(nonatomic, assign) id<KZDefaultColorControllerDelegate> delegate;
@property(nonatomic, weak) UIColor *selectedColor;
@end

@protocol KZDefaultColorControllerDelegate
- (void) defaultColorController:(ColourViewController *)controller didChangeColor:(UIColor *)color;
@end