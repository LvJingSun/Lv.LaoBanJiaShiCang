//
//  BusinessPasswordViewController.m
//  BusinessCenter
//
//  Created by 冯海强 on 13-11-22.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import "BusinessPasswordViewController.h"
#import "SaveData.h"
#import "SVProgressHUD.h"
#import "HttpClientRequest.h"



@interface BusinessPasswordViewController ()



@property(nonatomic,weak)IBOutlet UITextField*BusinessPassword_Oldtextfield;//原密码
@property(nonatomic,weak)IBOutlet UITextField*BusinessPassword_Newtextfield;//
@property(nonatomic,weak)IBOutlet UITextField*BusinessPassword_Againtextfield;//



@end

@implementation BusinessPasswordViewController

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
    self.title=@"修改密码";
    
    self.BusinessPassword_Oldtextfield.secureTextEntry=YES;//隐藏
    self.BusinessPassword_Newtextfield.secureTextEntry=YES;
    self.BusinessPassword_Againtextfield.secureTextEntry=YES;
    // Do any additional setup after loading the view from its nib.
    
    UIBarButtonItem *wangcheng =[[UIBarButtonItem alloc] initWithTitle:@"关闭键盘" style:UIBarButtonItemStyleBordered target:self action:@selector(BusinesserPasswordclosekey)];
    self.navigationItem.rightBarButtonItem =wangcheng;
    
    [self.BusinessPassword_Oldtextfield setDelegate:self];
    [self.BusinessPassword_Newtextfield setDelegate:self];
    [self.BusinessPassword_Againtextfield setDelegate:self];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    UIView *view = (UIView *)[touch view];
    if (view == self.view) {
       
        [self BusinesserPasswordclosekey];

    }
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ((textField == self.BusinessPassword_Oldtextfield) || (textField == self.BusinessPassword_Newtextfield)||(textField == self.BusinessPassword_Againtextfield)) {
        [textField resignFirstResponder];
    }
    return YES;
    
}


-(void)BusinesserPasswordclosekey
{
    [self.BusinessPassword_Oldtextfield resignFirstResponder];
    [self.BusinessPassword_Newtextfield resignFirstResponder];
    [self.BusinessPassword_Againtextfield resignFirstResponder];
    
    
}

-(IBAction)BusinessPasswordSaveBtn:(id)sender
{
    [self BusinesserPasswordclosekey];

    if (self.BusinessPassword_Oldtextfield.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入原密码"];
        return;
    }
    NSString *newpaw = self.BusinessPassword_Newtextfield.text;
    if (newpaw.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入新密码"];
        return;
    }
    NSString *agipaw = self.BusinessPassword_Againtextfield.text;
    if (agipaw.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请再次输入密码"];
        return;
    }
    if (![newpaw isEqualToString:agipaw])
    {
        [SVProgressHUD showErrorWithStatus:@"两次密码输入不一样"];
        return;
    }
    
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
                           self.BusinessPassword_Oldtextfield.text,@"oriPwd",
                           self.BusinessPassword_Newtextfield.text,@"newPwd",
                           self.BusinessPassword_Againtextfield.text,@"confirmPwd",
                           nil];
    [SVProgressHUD showWithStatus:@"数据提交中..."];
    
    [httpClient request:@"ChangePasswordSubmit.ashx" parameters:param successed:^(JSONDecoder *jsonDecoder, id responseObject) {
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [jsonDecoder objectWithData:data];
        
        SaveData *keyData = [[SaveData alloc]initWithJsonObject:handlJson];
        
        BOOL success = [keyData.status boolValue];
        
        if (success)
        {
            [SVProgressHUD dismiss];
            [SVProgressHUD showSuccessWithStatus:keyData.msg];
            [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(POPtoView) userInfo:nil repeats:NO];
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


-(void)POPtoView
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
