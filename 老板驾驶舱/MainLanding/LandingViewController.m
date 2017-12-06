//
//  LandingViewController.m
//  BusinessCenter
//
//  Created by 冯海强 on 13-11-18.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import "LandingViewController.h"
#import "MainViewController.h"
#import "SVProgressHUD.h"
#import "HomePageViewController.h"
#import "BusinesserViewController.h"
#import "HttpClientRequest.h"
#import "LandingData.h"
#import "BasicData.h"




@interface LandingViewController ()

@property(nonatomic,weak)IBOutlet UITextField *LandingNametextfield;
@property(nonatomic,weak)IBOutlet UITextField *LandingPasswordtextfield;

@property(nonatomic,weak)IBOutlet UIImageView *imageview;
@property(nonatomic,weak)IBOutlet UIView *loginview;



-(IBAction)enterBtn:(id)sender;

@end

@implementation LandingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    self.LandingNametextfield.placeholder=@"用户名";//初始化赋值
    self.LandingPasswordtextfield.placeholder=@"密码";
    if (iPhone5)
    {
        [self.imageview setFrame:CGRectMake(0, 0, 320, 568)];
        [self.loginview setCenter:CGPointMake(160, 400)];
        
    }else
    {
        [self.imageview setFrame:CGRectMake(0, 0, 320, 480)];
        [self.loginview setCenter:CGPointMake(160, 340)];
    }
    self.imageview.image=[UIImage imageNamed:@"login.png"];
    checkacc.selected=NO;
    checkpwd.selected=NO;
    
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    

    if ([[userDefau objectForKey:@"loginuser.account.l"] isEqualToString:@"1"])
    {
        self.LandingNametextfield.text=[userDefau objectForKey:@"loginuser.account"];
        checkacc.selected=YES;
    }
    if ([[userDefau objectForKey:@"loginuser.pwd.p"] isEqualToString:@"1"])
    {
        self.LandingPasswordtextfield.text=[userDefau objectForKey:@"loginuser.pwd"];
        checkpwd.selected=YES;

    }
    if ([[userDefau objectForKey:@"loginuser.account.l"] isEqualToString:@"0"])
    {
        self.LandingNametextfield.text=nil;
        self.LandingPasswordtextfield.text=nil;
        checkacc.selected=NO;
        checkpwd.selected=NO;
    }

    
    [self.LandingNametextfield setDelegate:self];
    self.LandingNametextfield.tag=101;self.LandingPasswordtextfield.tag=101;
    [self.LandingPasswordtextfield setDelegate:self];
    
    
    [checkacc setImage:[UIImage imageNamed:@"Selected.png"] forState:UIControlStateSelected];
    [checkacc setImage:[UIImage imageNamed:@"Noselected.png"] forState:UIControlStateNormal];
    [checkpwd setImage:[UIImage imageNamed:@"Selected.png"] forState:UIControlStateSelected];
    [checkpwd setImage:[UIImage imageNamed:@"Noselected.png"] forState:UIControlStateNormal];


    self.LandingPasswordtextfield.secureTextEntry=YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



//隐藏键盘的方法
-(void)hidenKeyboard {
    [self.LandingNametextfield resignFirstResponder];
    [self.LandingPasswordtextfield resignFirstResponder];
    [self resumeView];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)sender {
    
    //[theTextField resignFirstResponder];
    if (sender == self.LandingNametextfield) {
        [self.LandingPasswordtextfield becomeFirstResponder];
    }else if (sender == self.LandingPasswordtextfield){
        [self hidenKeyboard];
        // 请求数据
        [self enterBtn:nil];
    }
    return YES;
    
}

//UITextField的协议方法，当开始编辑时监听
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    NSTimeInterval animationDuration=0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    CGRect rect=CGRectMake(0.0f,-85,width,height);
    self.view.frame=rect;
    [UIView commitAnimations];
    return YES;
}

//恢复原始视图位置
-(void)resumeView {
    NSTimeInterval animationDuration=0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    float Y = 0.0f;
    CGRect rect=CGRectMake(0.0f,Y,width,height);
    self.view.frame=rect;
    [UIView commitAnimations];
}



-(IBAction)checkaccount:(id)sender;
{
    if (checkacc.selected)
    {
        checkacc.selected=NO;
    }
    else
        checkacc.selected=YES;
    
}
-(IBAction)checkpassword:(id)sender;
{
    if (checkpwd.selected)
    {
        checkpwd.selected=NO;
    }
    else
        checkpwd.selected=YES;
    
}

-(IBAction)enterBtn:(id)sender
{
    MainViewController*mainVC=[MainViewController shareobject];
    
    NSString *account = self.LandingNametextfield.text;
    if (account.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入帐户"];
        return;
    }
    NSString *pwd = self.LandingPasswordtextfield.text;
    if (pwd.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        return;
    }
    
    // 判断网络是否存在
    if ( ![mainVC isConnectionAvailable] )
    {
        return;
    }

    
    HttpClientRequest *httpClient = [HttpClientRequest sharedInstance];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           account, @"account",
                           pwd,@"password",nil];
    [SVProgressHUD showWithStatus:@"登录中……"];
    
    [httpClient request:@"Login.ashx" parameters:param successed:^(JSONDecoder *jsonDecoder, id responseObject) {
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [jsonDecoder objectWithData:data];

        LandingData*keyData = [[LandingData alloc]initWithJsonObject:handlJson];
        
        BOOL success = [keyData.status boolValue];
        
        if (success)
        {
            [[NSUserDefaults standardUserDefaults] setObject:[handlJson objectForKey:@"merchantid"]  forKey:@"Merchant_ID"];
    
           [[NSUserDefaults standardUserDefaults] setObject:[keyData.member objectForKey:@"memberId"]  forKey:@"memberId"];
            NSString *PhotoBigUrl =[[keyData.member objectForKey:@"PhotoMidUrl"] stringByReplacingOccurrencesOfString:@"Mid" withString:@"Big"];
            [[NSUserDefaults standardUserDefaults] setObject:PhotoBigUrl  forKey:@"PhotoMidUrl"];
            
            [[NSUserDefaults standardUserDefaults] setObject:[keyData.member objectForKey:@"account"]  forKey:@"account"];
            [[NSUserDefaults standardUserDefaults] setObject:[keyData.member objectForKey:@"name"]  forKey:@"name"];
            [[NSUserDefaults standardUserDefaults] setObject:[keyData.member objectForKey:@"nick"]  forKey:@"nick"];
            [[NSUserDefaults standardUserDefaults] setObject:[keyData.member objectForKey:@"sDatetime"]  forKey:@"sDatetime"];
            
            [[NSUserDefaults standardUserDefaults] setObject:keyData.Istype  forKey:@"Istype"];
            
            [[NSUserDefaults standardUserDefaults] setObject:keyData.Anzhuo  forKey:@"Anzhuo"];
            
            [[NSUserDefaults standardUserDefaults] setObject:keyData.Iphone  forKey:@"Iphone"];
            
            [[NSUserDefaults standardUserDefaults] setObject:keyData.Phone  forKey:@"Phone"];
            
            if (checkacc.selected){
                [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"loginuser.account.l"];
            }
            if (!checkacc.selected)
            {
                [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"loginuser.account.l"];
            }
            if (checkpwd.selected){
                [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"loginuser.pwd.p"];
            }
            if (!checkpwd.selected)
            {
                [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"loginuser.pwd.p"];
            }
            
            [[NSUserDefaults standardUserDefaults] setObject:account forKey:@"loginuser.account"];
            [[NSUserDefaults standardUserDefaults] setObject:pwd forKey:@"loginuser.pwd"];
            
            
            [[NSUserDefaults standardUserDefaults] synchronize];//立即读取；
            
            [mainVC loginSucess];
            [SVProgressHUD dismiss];

            [self hidenKeyboard];//关键盘

        }
        else
        {

            [SVProgressHUD showErrorWithStatus:keyData.msg];
   
        }
        
    } failured:^(NSError *error) {
        
        if ([error.description rangeOfString:@"请求超时"].location!=NSNotFound)
        {
            [SVProgressHUD showErrorWithStatus:@"登录超时,请重新登录!"];
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:error.description];

        }

    }];

    
}




@end
