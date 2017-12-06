//
//  BusinessdelegatepeopleViewController.h
//  BusinessCenter
//
//  Created by 冯海强 on 13-11-22.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "BaseViewController.h"
@class TableViewWithBlock;


@interface BusinessdelegatepeopleViewController : BaseViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UITextFieldDelegate,UITextFieldDelegate>
{
    
    IBOutlet UIScrollView*Businessdelegatepeople_scrollview;
    
    BOOL SexisOpened;
    
    int delegatetimer;//验证码隔时间
    
}

@property(nonatomic,strong)NSDictionary*delegatepeopleDic;

@property (nonatomic,retain) IBOutlet TableViewWithBlock *SexdownTab;

@property(nonatomic,strong)NSMutableArray*sexarray;


@end
