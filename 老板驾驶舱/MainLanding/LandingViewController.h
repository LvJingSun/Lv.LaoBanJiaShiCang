//
//  LandingViewController.h
//  BusinessCenter
//
//  Created by 冯海强 on 13-11-18.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "BaseViewController.h"

@interface LandingViewController : BaseViewController<UITextFieldDelegate,UINavigationControllerDelegate>

{
    IBOutlet UIButton*checkacc;
    IBOutlet UIButton*checkpwd;
    
}


@end
