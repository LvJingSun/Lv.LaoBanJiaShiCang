//
//  MainViewController.h
//  BusinessCenter
//
//  Created by 冯海强 on 13-11-18.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageCache.h"
#import "CommonUtil.h"
#import "UIImageView+AFNetworking.h"
#import "AppDelegate.h"



#define HTTP_SERVER @"http://222.191.251.180:8010/MemberCenterApple.html"

@interface MainViewController : UIViewController<UITabBarControllerDelegate>
{
    NSString*Homepagevalue;
//    NSString*Productvalue;
//    NSString*Activityvalue;
    
    
}
-(void)getDatarefresh;

+(MainViewController*)shareobject;
+(void) showHintAlertView:(BOOL) show withMsg:(NSString*)msg;

-(void) loginSucess;

- (BOOL)isConnectionAvailable;

@property (strong, nonatomic) UITabBarController *tabbar;
@property(strong,nonatomic)UINavigationController*navi;
@property (strong,nonatomic)UINavigationController*mainNavigationController;

@property(nonatomic,strong)ImageCache*imageCache;


@end


#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define isIOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? YES : NO)
