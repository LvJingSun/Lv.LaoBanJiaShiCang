//
//  MainViewController.m
//  BusinessCenter
//
//  Created by 冯海强 on 13-11-18.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import "MainViewController.h"
#import "HomePageViewController.h"
#import "WresourceViewController.h"
#import "ProductViewController.h"
#import "PIPViewController.h"
#import "ActivityViewController.h"
#import "BusinesserViewController.h"
#import "LandingViewController.h"
#import "AppHttpClient.h"
#import "SVProgressHUD.h"
#import "Reachability.h"
#import "HttpClientRequest.h"
#import "BasicData.h"
#import "JPUSHService.h"


@interface MainViewController ()



@end

//#define iphone [ UIScreen mainScreen ].bounds;//手机尺寸


@implementation MainViewController




+(MainViewController*)shareobject;//保证主视图只有一个；
{
    static MainViewController*sssmainviewcontroller=nil;
    if (sssmainviewcontroller==nil)
    {
        sssmainviewcontroller=[[MainViewController alloc]init];
    }
    return sssmainviewcontroller;
}


//调用正在上传alert
+(void) showHintAlertView:(BOOL) show withMsg:(NSString*)msg;
{
    static UIAlertView *alert=nil;
    if (show)
    {
        if (!alert)
        {
            alert=[[UIAlertView alloc]initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
            
            UIActivityIndicatorView*activiInView=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            activiInView.tag=0;
            [alert addSubview:activiInView];
            activiInView.center=CGPointMake(alert.frame.size.width/2+140, alert.frame.size.height/2+100);
            [activiInView startAnimating];
        }
        alert.message=msg;
        [alert show];
        
    }
    else
    {
        
        if (alert)
        {
            [alert dismissWithClickedButtonIndex:0 animated:YES];
            alert =nil;
        }
        
    }
    
}




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.mainNavigationController=[[UINavigationController alloc]init];
    self.mainNavigationController.navigationBarHidden=YES;

    self.mainNavigationController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.mainNavigationController.view.center=CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    [self.view addSubview:self.mainNavigationController.view];//在视图里嵌入一个导航控制器，导航控制器作为子视图；（以前是导航控制器是主视图，将视图压入导航；）

    [self.mainNavigationController.navigationBar setBackgroundColor:[UIColor redColor]];
  
    LandingViewController*loginVC=[[LandingViewController alloc]init];
    self.navi=[[UINavigationController alloc]initWithRootViewController:loginVC];
    
    self.navi.view.center=CGPointMake(self.navi.view.center.x,self.navi.view.center.y);
    self.navi.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    //重新alloc一个导航，log视图圧入新导航
    self.navi.navigationBarHidden=YES;
    [self.view addSubview:self.navi.view];//根视图上压一个有导航的登录视图（如果用户为空）
    self.navi.view.alpha=0.8;

}


// 判断网络不好
- (BOOL)isConnectionAvailable
{
    
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


-(void) loginSucess
{
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.navi.view.center = CGPointMake(self.navi.view.center.x,60);
        //什么时候消失
        self.navi.view.alpha = 0;
    } completion:^(BOOL finished)
    {
        [self getDataFromServer];
        
        [self pushRegisID];

    }];
}

//未读消息数
-(void)getDataFromServer
{
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           [userDefau objectForKey:@"memberId"], @"memberId",nil];
    
    [httpClient request:@"Default_Red.ashx" parameters:param success:^(NSJSONSerialization* json)
     {
        Homepagevalue = [json valueForKey:@"TotalNoReadMsg"];
             
        [self showtabbar];
     }
    failure:^(NSError *error)
     {
         [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
     }];

    
    [self getlogoFromServer];
    
    [self getphotoimage];
    
    [self saveToken];
    

}

- (void)pushRegisID {
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];
    
    NSString *registrationID = [userDefau objectForKey:@"registrationID"];
    
    HttpClientRequest *httpClient1 = [HttpClientRequest sharedInstance];
    
    NSDictionary *param1 = [NSDictionary dictionaryWithObjectsAndKeys:
                            memberId, @"memberID",
                            @"PhoneType_1",@"phoneType",
                            registrationID,@"registrationID",
                            nil];

    [httpClient1 request:@"ErpMerchantCenterAdd.ashx" parameters:param1 successed:^(JSONDecoder *jsonDecoder, id responseObject) {
        
    } failured:^(NSError *error) {

    }];

}


-(void)showtabbar;{
    
    HomePageViewController*HomePageVC=[[HomePageViewController alloc]initWithNibName:@"HomePageViewController" bundle:nil];
    
    WresourceViewController*WresourceVC=[[WresourceViewController alloc]initWithNibName:@"WresourceViewController" bundle:nil];
    
    PIPViewController*PIPVC=[[PIPViewController alloc]initWithNibName:@"PIPViewController" bundle:nil];
    
//    New_ShouYinTaiViewController *PIPVC = [[New_ShouYinTaiViewController alloc] init];
    
    BusinesserViewController*BusinesserVC=[[BusinesserViewController alloc]initWithNibName:@"BusinesserViewController" bundle:nil];
    
    self.tabbar=[[UITabBarController alloc]init];
    
    [self.view addSubview: self.tabbar.view];
    
    self.tabbar.viewControllers=@[HomePageVC,WresourceVC,PIPVC,BusinesserVC];

    [self.mainNavigationController pushViewController:self.tabbar animated:YES];
        
    if ([NSString stringWithFormat:@"%@",Homepagevalue].intValue>0)
    {
        HomePageVC.tabBarItem.badgeValue = [NSString stringWithFormat:@"%@",Homepagevalue];
    }

}

-(void)saveToken
{
    if ([[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:DEVICETOKEN]] isEqualToString:@"(null)"]) {
        
        
    }else
    {
        NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
        NSString *userId = @"0";
        NSString *roleCode = @"Merchant";
        NSString *tokenValue =[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:DEVICETOKEN]];
        NSString *model = @"Apple";
        NSString *type = @"BossTool";
        NSString *key = @"";
        
        AppHttpClient* httpClient = [AppHttpClient sharedClient];
        NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                               [userDefau objectForKey:@"memberId"], @"memberId",
                               userId,@"userId",
                               roleCode,@"roleCode",
                               tokenValue,@"tokenValue",
                               model,@"model",
                               type,@"type",
                               key,@"key",
                               nil];
        
        [httpClient request:@"AppTokenUpdate.ashx" parameters:param success:^(NSJSONSerialization* json)
         {
             BOOL success = [[json valueForKey:@"status"] boolValue];
             if (success) {
                 
//                                  NSString *msg = [json valueForKey:@"msg"];
//                                  [SVProgressHUD showSuccessWithStatus:msg];
                 
             } else {
//                                  NSString *msg = [json valueForKey:@"msg"];
//                                  [SVProgressHUD showErrorWithStatus:msg];
             }
             
         }
            failure:^(NSError *error)
         {
//             [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
         }];
        
        
    }
    
}

//刷新。。。示读消息数
-(void)getDatarefresh
{
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           [userDefau objectForKey:@"memberId"], @"memberId",nil];
    
    [httpClient request:@"Default_Red.ashx" parameters:param success:^(NSJSONSerialization* json)
     {
        Homepagevalue = [json valueForKey:@"TotalNoReadMsg"];//tabbar上数为系统消息数了
        HomePageViewController*HomePageVC=self.tabbar.viewControllers[0];
         if (Homepagevalue.intValue>0)
         {
             HomePageVC.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",Homepagevalue.intValue];
         }
         
     }
                failure:^(NSError *error)
     {
         [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
     }];

}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)getlogoFromServer
{
    MainViewController*mainVC=[MainViewController shareobject];
    // 判断网络是否存在
    if ( ![mainVC isConnectionAvailable] )
    {
        return;
    }
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    NSString*memberId=[userDefau objectForKey:@"memberId"];
    
    HttpClientRequest *httpClient = [HttpClientRequest sharedInstance];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId, @"memberId",
                           nil];
    //  [SVProgressHUD showWithStatus:@"数据加载中..."];
    
    [httpClient request:@"GetMerchantInfos.ashx" parameters:param successed:^(JSONDecoder *jsonDecoder, id responseObject) {
        NSData* data = [NSData dataWithData:responseObject];
        NSDictionary* handlJson = [jsonDecoder objectWithData:data];
        BasicData*keyData = [[BasicData alloc]initWithJsonObject:handlJson];
        
        BOOL success = [keyData.status boolValue];
        
        if (success)
        {
            NSString *path =[keyData.Merchant objectForKey:@"Logo"];
            
            UIImage *reSizeImage = [self.imageCache getImage:path];
            UIImageView*imv=[[UIImageView alloc]init];
            if (reSizeImage != nil)
            {
                imv.image = reSizeImage;
            }
            [imv setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",path]]] placeholderImage:[UIImage imageNamed:@""] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                ///////////////////////Logo
                
                // create NSData-object from image
                NSData *imageData = [NSKeyedArchiver archivedDataWithRootObject:[CommonUtil scaleImage:image toSize:CGSizeMake(302,273)]];
                // save NSData-object to UserDefaults
                [[NSUserDefaults standardUserDefaults] setObject:imageData forKey:@"Businesser_Logo"];
                
            } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                
            }];
            
        }
        else
        {
            
            [SVProgressHUD showErrorWithStatus:keyData.msg];
        }
        
        
    } failured:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:error.description];
        
    }];
    
}


-(void)getphotoimage
{
    NSString *path =[[NSUserDefaults standardUserDefaults] objectForKey:@"PhotoMidUrl"];
    
    UIImage *reSizeImage = [self.imageCache getImage:path];
    UIImageView*imv=[[UIImageView alloc]init];
    if (reSizeImage != nil)
    {
        imv.image = reSizeImage;
    }
    [imv setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",path]]] placeholderImage:[UIImage imageNamed:@""] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {

        NSData *imageData_b = [NSKeyedArchiver archivedDataWithRootObject:[CommonUtil scaleImage:image toSize:CGSizeMake(120,120)]];

        [[NSUserDefaults standardUserDefaults] setObject:imageData_b forKey:@"PhotoMidUrl_B"];
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        
    }];

}

@end
