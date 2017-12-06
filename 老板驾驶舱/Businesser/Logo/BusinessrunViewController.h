//
//  BusinessrunViewController.h
//  BusinessCenter
//
//  Created by 冯海强 on 13-11-21.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "BaseViewController.h"


@interface BusinessrunViewController : BaseViewController<UITextFieldDelegate>
{
    IBOutlet UIScrollView*Businessrun_scrollview;//入驻信息scroview
    int iphonenum;
}

@property(nonatomic,strong)NSDictionary*Rundic;

@end
