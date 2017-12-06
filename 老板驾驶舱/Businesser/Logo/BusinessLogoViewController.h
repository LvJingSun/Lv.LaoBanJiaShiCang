//
//  BusinessLogoViewController.h
//  BusinessCenter
//
//  Created by 冯海强 on 13-11-21.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "ImageCache.h"
#import  "UIImageView+AFNetworking.h"


@interface BusinessLogoViewController : UIViewController<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    int pickerorphoto;
}


@property(nonatomic,copy)NSString*LogoURL;
@property(nonatomic,strong)ImageCache *LogoimageCache;

@property(nonatomic,strong)NSMutableDictionary*Logodic;

@end
