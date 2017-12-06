//
//  AppDelegate.m
//  BusinessCenter
//
//  Created by 冯海强 on 13-11-18.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//
#import "AppDelegate.h"
#import "MainViewController.h"
#import "LandingViewController.h"
#import "BMKMapManager.h"
#import "Reachability.h"
#import "AppHttpClient.h"
#import "SVProgressHUD.h"
#import "JPUSHService.h"
#import <AudioUnit/AudioUnit.h>
#import <AVFoundation/AVFoundation.h>
#import "RowNumberController.h"
#import "HttpClientRequest.h"


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //推送
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert) categories:nil];
        
    }else {
    
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert) categories:nil];
        
    }
    
    [JPUSHService setBadge:0];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"PushConfig" ofType:@"plist"];
    
    NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    [JPUSHService setupWithOption:launchOptions
                           appKey:[dic objectForKey:@"APP_KEY"]
                          channel:[dic objectForKey:@"CHANNEL"]
                 apsForProduction:[[dic objectForKey:@"APS_FOR_PRODUCTION"] boolValue]
            advertisingIdentifier:nil];
    
    //没有运行的情况下接收消息
    if (launchOptions) {
        
        NSDictionary *remoteNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        
        if (remoteNotification) {
            
//            NSLog(@"不运行情况下推送：%@",remoteNotification);
//            
//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"推送通知"
//                                                           message:@"这是通过推送窗口启动的程序，你可以在这里处理推送内容"
//                                                          delegate:nil
//                                                 cancelButtonTitle:@"知道了"
//                                                 otherButtonTitles:nil, nil];
//            [alert show];
            
            //跳转页面
        }
    }

    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定generalDelegate参数1ZqnR1OTsdLLTr40BMaxqrx0、、TvkidyLqGXYtbdOsAljGcoWD
    BOOL ret = [_mapManager start:@"TvkidyLqGXYtbdOsAljGcoWD" generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    [self setPush];
    
    [WXApi registerApp:@"wxadd50c932b993de9" withDescription:@"demo 2.0"];
    
//    [WXApi registerApp:@"wxadd50c932b993de9"];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    MainViewController*mainVC=[MainViewController shareobject];
    
    self.window.rootViewController=mainVC;
    
    [self.window makeKeyAndVisible];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    
    //先存默认图片
    NSData *imageData_b = [NSKeyedArchiver archivedDataWithRootObject:[CommonUtil scaleImage:[UIImage imageNamed:@"DefaultHead.png"] toSize:CGSizeMake(120,120)]];
    
    [[NSUserDefaults standardUserDefaults] setObject:imageData_b forKey:@"PhotoMidUrl_B"];
    
    NSData *imageData = [NSKeyedArchiver archivedDataWithRootObject:[CommonUtil scaleImage:[UIImage imageNamed:@"invite_reg_no_photo.png"] toSize:CGSizeMake(302,273)]];
    
    // save NSData-object to UserDefaults
    [[NSUserDefaults standardUserDefaults] setObject:imageData forKey:@"Businesser_Logo"];
    
    [[NSUserDefaults standardUserDefaults] setObject:[JPUSHService registrationID] forKey:@"registrationID"];
    
    return YES;
}

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {

//    NSString *tencentScheme = [NSString stringWithFormat:@"wxadd50c932b993de9"];
//    if ([[url scheme] isEqualToString:tencentScheme]) {
        return [WXApi handleOpenURL:url delegate:self];
//    }

}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {

    return [WXApi handleOpenURL:url delegate:self];

}

-(void)onResp:(BaseResp *)resp {
    
    if ([resp isKindOfClass:[PayResp class]]) {
        
        PayResp *response = (PayResp *)resp;
        
        switch (response.errCode) {
            case WXSuccess:
            {
                
                //支付成功
                [[NSNotificationCenter defaultCenter]postNotificationName:@"MenuPaySuccessKey" object:self userInfo:nil];
                
            }
                break;
                
            default:
            {
                
                if (response.errCode == -2) {
                    
                    //取消支付
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"你已取消支付！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    
                    [alert show];
                    
                }else {
                    
                    //支付失败
                    [SVProgressHUD showErrorWithStatus:@"支付失败"];
                    
                }
                
            }
                break;
        }
        
    }
    
}


// 接收通知的方法
- (void)setPush
{
    // 先将数字置0
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeBadge)];
    
}
#pragma mark APNS methods
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)devToken
{
    //接收苹果服务器返回的token并将其发送给极光服务器
    [JPUSHService registerDeviceToken:devToken];
    
    // 删除分隔符和空格
    NSMutableString* mut_str = [[NSMutableString alloc] initWithFormat:@"%@",[devToken description]];
    // 删除开始的“<”
    NSRange range;
    range.location = 0;
    range.length = 1;
    [mut_str deleteCharactersInRange:range];
    // 删除结束的“>”
    range.location = [mut_str length] - 1;
    range.length = 1;
    [mut_str deleteCharactersInRange:range];
    // 删除空格
    range.location = 0;
    range.length = [mut_str length] - 1;
    [mut_str replaceOccurrencesOfString:@" " withString:@"" options:NSCaseInsensitiveSearch range:range];
    
    // 保存deviceToken
    [[NSUserDefaults standardUserDefaults] setObject:mut_str forKey:DEVICETOKEN];

    
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
}

- (NSString *)logDic:(NSDictionary *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
    return str;
}

//前台或者后台接收消息
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    NSDictionary *aps = [userInfo valueForKey:@"aps"];
    NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
    // 取得自定义字段内容，userInfo就是后台返回的JSON数据，是一个字典
    [JPUSHService handleRemoteNotification:userInfo];
    
    if (application.applicationState == UIApplicationStateActive) {
        
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"tishiyin.caf" withExtension:nil];
        
        SystemSoundID soundID = 0;
        
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)(url), &soundID);
        
        AudioServicesPlaySystemSound(soundID);
        
    }

    application.applicationIconBadgeNumber = 0;
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:content delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    alert.tag = 1111;
    
    [alert show];
    
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{
    
    [application registerForRemoteNotifications];
    
}

- (void)goToMssageViewController{
    //将字段存入本地，因为要在你要跳转的页面用它来判断,这里我只介绍跳转一个页面，
    NSUserDefaults *pushJudge = [NSUserDefaults standardUserDefaults];
    [pushJudge setObject:@"push" forKey:@"push"];
    [pushJudge synchronize];

    RowNumberController * VC = [[RowNumberController alloc]init];
    UINavigationController * Nav = [[UINavigationController alloc]initWithRootViewController:VC];//这里加导航栏是因为我跳转的页面带导航栏，如果跳转的页面不带导航，那这句话请省去。
    [self.window.rootViewController presentViewController:Nav animated:YES completion:nil];

}

							
- (void)applicationWillResignActive:(UIApplication *)application
{

}

- (void)applicationDidEnterBackground:(UIApplication *)application
{

}

//清除角标
- (void)applicationWillEnterForeground:(UIApplication *)application
{
//    [application setApplicationIconBadgeNumber:0];
    
//    [application cancelAllLocalNotifications];
    

}

- (void)applicationDidBecomeActive:(UIApplication *)application
{

}

- (void)applicationWillTerminate:(UIApplication *)application
{

}



// 判断网络不好
- (BOOL)isConnectionAvailable{
    
    BOOL  isExistenceNetWork = YES;
    
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    
    switch ( [reach currentReachabilityStatus] ) {
        case NotReachable:
            isExistenceNetWork = NO;
            break;
        case ReachableViaWiFi:
            isExistenceNetWork = YES;
            break;
        case ReachableViaWWAN:
            isExistenceNetWork = YES;
            break;
            
        default:
            break;
    }
    
    if ( !isExistenceNetWork ) {
        
        [SVProgressHUD showErrorWithStatus:@"网络不给力，请稍后再试！"];
        
    }
    
    return isExistenceNetWork;
    
}


#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 1) {
        
        [self goToMssageViewController];
        
    }

}

@end
