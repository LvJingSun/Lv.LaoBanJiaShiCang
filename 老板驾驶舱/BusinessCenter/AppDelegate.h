//
//  AppDelegate.h
//  BusinessCenter
//
//  Created by 冯海强 on 13-11-18.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
#import "WXApi.h"
#define DEVICETOKEN @"dvicetoken"

@interface AppDelegate : UIResponder <UIApplicationDelegate,UIAlertViewDelegate,WXApiDelegate>
{
    BMKMapManager* _mapManager; //实例化

}


@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navi;


// 版本检测的请求
//- (void)versionRequest;

// 判断网络不好
- (BOOL)isConnectionAvailable;

+ (NSTimer *)shareTimer;

@end
