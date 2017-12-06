//
//  BusinessrunViewController.m
//  BusinessCenter
//
//  Created by 冯海强 on 13-11-21.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import "BusinessrunViewController.h"
#import "SVProgressHUD.h"
#import "HttpClientRequest.h"
#import "BasicData.h"

@interface BusinessrunViewController ()
///
@property(nonatomic,retain)IBOutlet UILabel*Businessrun_YingyeLabel;//营业执照号
@property(nonatomic,retain)IBOutlet UILabel*Businessrun_ShuiwuLabel;//税务号
@property(nonatomic,retain)IBOutlet UILabel*Businessrun_farenLabel;//法人
@property(nonatomic,retain)IBOutlet UILabel*Businessrun_lianxirenLabel;//联系人
@property(nonatomic,retain)IBOutlet UILabel*Businessrun_lianxirenphoneLabel;//联系人电话
////
@property(nonatomic,retain)IBOutlet UITextField*Businessrun_caiwutextfield;//财务
@property(nonatomic,retain)IBOutlet UITextField*Businessrun_caiwuphonetextfield;//财务负责人电话
@property(nonatomic,retain)IBOutlet UITextField*Businessrun_chuangzhentextfield;//传真
@property(nonatomic,retain)IBOutlet UITextField*Businessrun_E_mailphonetextfield;//邮箱
@end

@implementation BusinessrunViewController

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
    
    self.title=@"入驻信息";
    UIBarButtonItem *wangcheng =[[UIBarButtonItem alloc] initWithTitle:@"关闭键盘" style:UIBarButtonItemStyleBordered target:self action:@selector(Businessrunclosekey)];
    self.navigationItem.rightBarButtonItem =wangcheng;
    
    self.Businessrun_caiwutextfield.delegate =self;
    self.Businessrun_caiwuphonetextfield.delegate=self;
    self.Businessrun_chuangzhentextfield.delegate=self;
    self.Businessrun_E_mailphonetextfield.delegate=self;
    
    
//    [self.view addSubview:Businessrun_scrollview];
    CGRect rx = [ UIScreen mainScreen ].bounds;//手机尺寸
    Businessrun_scrollview.frame = CGRectMake(0, 0, 320,rx.size.height);
    
    
    //判别手机以及当前系统的
    double version = [[UIDevice currentDevice].systemVersion doubleValue];//判定系统版本。
    if(rx.size.height == 480.f)
    {
        iphonenum=4;
    }
    else
    {
        iphonenum=5;
    }
    //4前的系统
    if (iphonenum==4&&version<6)
    {
        Businessrun_scrollview.center=CGPointMake(Businessrun_scrollview.center.x,Businessrun_scrollview.center.y+120);
    }
    //4S且6的系统
    if (iphonenum==4&&(version == 6||version==6.1))
    {
        Businessrun_scrollview.center=CGPointMake(Businessrun_scrollview.center.x,Businessrun_scrollview.center.y+130);
    }
    //4S但7的系统
    if (iphonenum==4&&version>=7)
    {
        Businessrun_scrollview.center=CGPointMake(Businessrun_scrollview.center.x,Businessrun_scrollview.center.y+150);
    }
    if (iphonenum==5&&(version == 6||version==6.1))
    {
        Businessrun_scrollview.center=CGPointMake(Businessrun_scrollview.center.x,Businessrun_scrollview.center.y+40);
    }
    if (iphonenum==5&&version >= 7)
    {
        Businessrun_scrollview.center=CGPointMake(Businessrun_scrollview.center.x,Businessrun_scrollview.center.y+60);
    }
    if (iPhone5) {
        [Businessrun_scrollview setContentSize:CGSizeMake(320,Businessrun_scrollview.frame.size.height+165)];
    }else
    {
        [Businessrun_scrollview setContentSize:CGSizeMake(320,Businessrun_scrollview.frame.size.height+175)];
    }
    
    [self getDataFromServer];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ((textField == self.Businessrun_caiwutextfield) || (textField == self.Businessrun_caiwuphonetextfield)||(textField == self.Businessrun_chuangzhentextfield)||(textField ==self.Businessrun_E_mailphonetextfield)) {
        [textField resignFirstResponder];
    }
    return YES;
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField;
{
    if ((textField == self.Businessrun_caiwuphonetextfield)||(textField == self.Businessrun_chuangzhentextfield)) {
        [self showNumPadDone:nil];
    }
    else
    {
        [self hiddenNumPadDone:nil];
    }
    
    
}



-(void)Businessrunclosekey
{
    [self.Businessrun_caiwutextfield resignFirstResponder];
    [self.Businessrun_caiwuphonetextfield resignFirstResponder];
    [self.Businessrun_chuangzhentextfield resignFirstResponder];
    [self.Businessrun_E_mailphonetextfield resignFirstResponder];
}

-(IBAction)BusinessRun_SaveButton:(UIButton*)sender
{
    [self Businessrunclosekey];
    
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
                           self.Businessrun_chuangzhentextfield.text,@"fax",
                           self.Businessrun_E_mailphonetextfield.text,@"officialMail",
                           self.Businessrun_caiwutextfield.text,@"treasurer",
                           self.Businessrun_caiwuphonetextfield.text,@"treasurerPhone",
                           nil];
    [SVProgressHUD showWithStatus:@"数据提交中..."];
    
    [httpClient request:@"MctSettledInfoSubmit.ashx" parameters:param successed:^(JSONDecoder *jsonDecoder, id responseObject) {
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [jsonDecoder objectWithData:data];
        
        BasicData *keyData = [[BasicData alloc]initWithJsonObject:handlJson];
        
        BOOL success = [keyData.status boolValue];
        
        if (success)
        {
            [SVProgressHUD dismiss];
            [SVProgressHUD showSuccessWithStatus:keyData.msg];
            [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(popview) userInfo:nil repeats:NO];
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:keyData.msg];
        }
        
    } failured:^(NSError *error) {
        
        NSLog(@"error:%@",error.description);
        [SVProgressHUD showErrorWithStatus:error.description];
        
    }];

}

-(void)popview
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)getDataFromServer
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
    //    [SVProgressHUD showWithStatus:@"数据加载中..."];
    
    [httpClient request:@"GetMerchantInfos.ashx" parameters:param successed:^(JSONDecoder *jsonDecoder, id responseObject) {
        NSData* data = [NSData dataWithData:responseObject];
        NSDictionary* handlJson = [jsonDecoder objectWithData:data];
        BasicData*keyData = [[BasicData alloc]initWithJsonObject:handlJson];
        
        BOOL success = [keyData.status boolValue];
        
        if (success)
        {
            self.Rundic=keyData.Merchant;
            [self PutDataToTextfield];
            [SVProgressHUD dismiss];
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:keyData.msg];
        }
        
    } failured:^(NSError *error) {
        
        NSLog(@"error:%@",error.description);
        
        [SVProgressHUD showErrorWithStatus:error.description];
        
    }];
  
}


-(void)PutDataToTextfield
{
    self.Businessrun_YingyeLabel.text=[self.Rundic objectForKey:@"Businesslicense"];
    self.Businessrun_ShuiwuLabel.text=[self.Rundic objectForKey:@"Taxcertificate"];
    self.Businessrun_farenLabel.text=[self.Rundic objectForKey:@"Legal"];
    self.Businessrun_lianxirenLabel.text=[self.Rundic objectForKey:@"Officialcontacts"];
    self.Businessrun_lianxirenphoneLabel.text=[self.Rundic objectForKey:@"OfficialcontactsPhone"];
    self.Businessrun_caiwutextfield.text=[self.Rundic objectForKey:@"Treasurer"];
    self.Businessrun_caiwuphonetextfield.text=[self.Rundic objectForKey:@"TreasurerPhone"];
    self.Businessrun_chuangzhentextfield.text=[self.Rundic objectForKey:@"Fax"];
    self.Businessrun_E_mailphonetextfield.text=[self.Rundic objectForKey:@"OfficialMail"];
  
}


@end
