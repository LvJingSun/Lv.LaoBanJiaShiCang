//
//  BusinessdelegatepeopleViewController.m
//  BusinessCenter
//
//  Created by 冯海强 on 13-11-22.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import "BusinessdelegatepeopleViewController.h"
#import "BusinessdelegatehelpViewController.h"
#import "SVProgressHUD.h"
#import "HttpClientRequest.h"
#import "DelegatepeopleData.h"

#import "SexdownCell.h"
#import <QuartzCore/QuartzCore.h>
#import "UITableView+DataSourceBlocks.h"
#import "TableViewWithBlock.h"
#import "SaveData.h"

@interface BusinessdelegatepeopleViewController ()

@property(nonatomic,weak) IBOutlet UILabel *Businessdelegate_Nametextfield;
@property(nonatomic,weak) IBOutlet UILabel *Businessdelegate_phonetextfield;
@property(nonatomic,weak) IBOutlet UILabel *Businessdelegate_E_mailtextfield;
@property(nonatomic,weak) IBOutlet UILabel *Businessdelegate_Nicktextfield;


@property(nonatomic,weak) IBOutlet UITextField *Businessdelegate_NewNametextfield;
@property(nonatomic,weak) IBOutlet UITextField *Businessdelegate_NewSextfield;
@property(nonatomic,weak) IBOutlet UITextField *Businessdelegate_Newphonetextfield;
@property(nonatomic,weak) IBOutlet UITextField *Businessdelegate_NewE_mailtextfield;
@property(nonatomic,weak) IBOutlet UILabel *
    Businessdelegate_Goontextfield;
@property(nonatomic,weak) IBOutlet UITextField * Businessdelegate_codetextfield;//验证码
@property(nonatomic,weak) IBOutlet UIButton *Businessdelegate_Sexdownbtn;

@property(nonatomic,weak) IBOutlet UIButton *BusinessdelegateSaveBtn;//保存




@end

@implementation BusinessdelegatepeopleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.delegatepeopleDic=[[NSMutableDictionary alloc]initWithCapacity:0];
        self.sexarray=[[NSMutableArray alloc]init];
        [self.sexarray addObject:@"男"];
        [self.sexarray addObject:@"女"];
        
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    //隐藏状态栏
  //  [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    //self.Businessdelegate_imageBtn.enabled=NO;
    
    
    //Businessdelegatepeople_scrollview.scrollsToTop=YES;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"代理人信息";
 
    self.Businessdelegate_NewNametextfield.delegate=self;
    self.Businessdelegate_Newphonetextfield.delegate=self;
    self.Businessdelegate_NewE_mailtextfield.delegate=self;
    self.Businessdelegate_codetextfield.delegate=self;
    UIBarButtonItem *wangcheng =[[UIBarButtonItem alloc] initWithTitle:@"帮助" style:UIBarButtonItemStyleBordered target:self action:@selector(preparehelepage)];
    self.navigationItem.rightBarButtonItem =wangcheng;
    
    
    self.Businessdelegate_NewSextfield.enabled=NO;
    self.Businessdelegate_codetextfield.placeholder=@"商户邮箱查收";
//    UIButton *Btn_out = [UIButton buttonWithType:UIButtonTypeRoundedRect];

    

    int iphonenum;
    CGRect rx = [ UIScreen mainScreen ].bounds;//手机尺寸
    if(rx.size.height == 480.f)
    {
        iphonenum=4;
    }
    else
    {
        iphonenum=5;
    }
    double version = [[UIDevice currentDevice].systemVersion doubleValue];//判定系统版本。
    [self.view addSubview:Businessdelegatepeople_scrollview];
    Businessdelegatepeople_scrollview.frame = CGRectMake(0, 0, 320,rx.size.height);
    //4前的系统
    if (iphonenum==4&&version<6)
    {
        Businessdelegatepeople_scrollview.center=CGPointMake(Businessdelegatepeople_scrollview.center.x,Businessdelegatepeople_scrollview.center.y+120);
    }
    
    //4S且6的系统
    if (iphonenum==4&&(version == 6||version==6.1))
    {
        Businessdelegatepeople_scrollview.center=CGPointMake(Businessdelegatepeople_scrollview.center.x,Businessdelegatepeople_scrollview.center.y+130);
        
    }
    //4S但7的系统
    if (iphonenum==4&&version>=7)
    {
        Businessdelegatepeople_scrollview.center=CGPointMake(Businessdelegatepeople_scrollview.center.x,Businessdelegatepeople_scrollview.center.y+150);
    }
    if (iphonenum==5&&(version == 6||version==6.1))
    {
        Businessdelegatepeople_scrollview.center=CGPointMake(Businessdelegatepeople_scrollview.center.x,Businessdelegatepeople_scrollview.center.y+40);
    }
    if (iphonenum==5&&version >= 7)
    {
        Businessdelegatepeople_scrollview.center=CGPointMake(Businessdelegatepeople_scrollview.center.x,Businessdelegatepeople_scrollview.center.y+60);
    }
    [Businessdelegatepeople_scrollview setContentSize:CGSizeMake(320,Businessdelegatepeople_scrollview.frame.size.height+170)];
    
    [self  getDataFromServer_Del];

  
    

    SexisOpened=NO;
    
    [self.SexdownTab initTableViewDataSourceAndDelegate:^(UITableView *tableView,NSInteger section)
     {
         NSInteger i=self.sexarray.count;
         return i;
         
     } setCellForIndexPathBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         SexdownCell *cell=[tableView dequeueReusableCellWithIdentifier:@"SexdownCell"];
         
         if (!cell)
         {
             cell=[[[NSBundle mainBundle]loadNibNamed:@"SexdownCell" owner:self options:nil]objectAtIndex:0];
             [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
         }
         //         [cell.moneypeodownlab setText:[NSString stringWithFormat:@"Select %d",indexPath.row]];
         cell.SexDownlab.text=[self.sexarray objectAtIndex:indexPath.row];
         
         return cell;
     } setDidSelectRowBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         SexdownCell *cell=(SexdownCell*)[tableView cellForRowAtIndexPath:indexPath];
         self.Businessdelegate_NewSextfield.text=cell.SexDownlab.text;
         [self.Businessdelegate_Sexdownbtn sendActionsForControlEvents:UIControlEventTouchUpInside];

     }];
    
    [self.SexdownTab .layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.SexdownTab .layer setBorderWidth:0];
    
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ((textField == self.Businessdelegate_Newphonetextfield) || (textField == self.Businessdelegate_NewE_mailtextfield)||(textField == self.Businessdelegate_codetextfield)) {
        [textField resignFirstResponder];
    }
    return YES;
    
}


-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == self.Businessdelegate_Newphonetextfield) {
        [self showNumPadDone:nil];
    }
    else
    {
        [self hiddenNumPadDone:nil];
    }
    
    
    return YES;
}



-(IBAction)ButtonSexdowncell:(id)sender
{

    
    if (SexisOpened) {
        [UIView animateWithDuration:0.3 animations:^{
            UIImage *closeImage=[UIImage imageNamed:@"Button_down.png"];
            [self.Businessdelegate_Sexdownbtn setImage:closeImage forState:UIControlStateNormal];
            
            CGRect frame=self.SexdownTab.frame;
            
            frame.size.height=1;
            [self.SexdownTab setFrame:frame];
            
        } completion:^(BOOL finished){
            
            SexisOpened=NO;
        }];
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            UIImage *openImage=[UIImage imageNamed:@"Button_up.png"];
            [self.Businessdelegate_Sexdownbtn setImage:openImage forState:UIControlStateNormal];
            
            CGRect frame=self.SexdownTab.frame;
            
            frame.size.height=60;
            [self.SexdownTab setFrame:frame];
        } completion:^(BOOL finished){

            SexisOpened=YES;
        }];
    }
    
}





-(void)Businessdelegateclosekey:(UISwipeGestureRecognizer*)recognizer
{
    [self.Businessdelegate_Nametextfield resignFirstResponder];
    [self.Businessdelegate_phonetextfield resignFirstResponder];
    [self.Businessdelegate_E_mailtextfield resignFirstResponder];
    [self.Businessdelegate_NewNametextfield resignFirstResponder];
    [self.Businessdelegate_Newphonetextfield resignFirstResponder];
    [self.Businessdelegate_NewE_mailtextfield resignFirstResponder];
    [self.Businessdelegate_codetextfield resignFirstResponder];

    [self.view removeGestureRecognizer:recognizer];

}


-(void)closekey
{
    [self.Businessdelegate_Nametextfield resignFirstResponder];
    [self.Businessdelegate_phonetextfield resignFirstResponder];
    [self.Businessdelegate_E_mailtextfield resignFirstResponder];
    [self.Businessdelegate_NewNametextfield resignFirstResponder];
    [self.Businessdelegate_Newphonetextfield resignFirstResponder];
    [self.Businessdelegate_NewE_mailtextfield resignFirstResponder];
    [self.Businessdelegate_codetextfield resignFirstResponder];

}


-(void)getDataFromServer_Del
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
     [SVProgressHUD showWithStatus:@"数据加载中..."];
    [httpClient request:@"GetMerchantResMember.ashx" parameters:param successed:^(JSONDecoder *jsonDecoder, id responseObject) {
        NSData* data = [NSData dataWithData:responseObject];
        NSDictionary* handlJson = [jsonDecoder objectWithData:data];
        DelegatepeopleData*keyData = [[DelegatepeopleData alloc]initWithJsonObject:handlJson];
        
        BOOL success = [keyData.status boolValue];
        
        if (success)
        {
            self.delegatepeopleDic=keyData.ResMember;
            [self putDataToText];
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


-(void)putDataToText
{
    self.Businessdelegate_Nicktextfield.text=[self.delegatepeopleDic objectForKey:@"OldNickName"];
    self.Businessdelegate_phonetextfield.text=[self.delegatepeopleDic objectForKey:@"OldPhone"];
    self.Businessdelegate_E_mailtextfield.text=[self.delegatepeopleDic objectForKey:@"OldEmail"];
    self.Businessdelegate_Nametextfield.text=[self.delegatepeopleDic objectForKey:@"OldRealName"];
    
  if ([[NSString stringWithFormat:@"%@",[self.delegatepeopleDic objectForKey:@"NewRealName"]]isEqualToString:@"<null>"])
  {
      return;
  }
    else
    {
        if ([[self.delegatepeopleDic objectForKey:@"NewSex"]isEqualToString:@"Male"]) {
            self.Businessdelegate_NewSextfield.text=@"男";
        }
        if ([[self.delegatepeopleDic objectForKey:@"NewSex"]isEqualToString:@"Female"]) {
            self.Businessdelegate_NewSextfield.text=@"女";
        }
        
        self.Businessdelegate_NewNametextfield.text=[self.delegatepeopleDic objectForKey:@"NewRealName"];
        self.Businessdelegate_Newphonetextfield.text=[self.delegatepeopleDic objectForKey:@"NewPhone"];
        self.Businessdelegate_NewE_mailtextfield.text=[self.delegatepeopleDic objectForKey:@"NewEmail"];
        self.Businessdelegate_Goontextfield.text=[NSString stringWithFormat:@"%@\n如有疑问,请点击右上角帮助！",[self.delegatepeopleDic objectForKey:@"NewFeedBackMsg"]];
        
    }
    
    
}



-(IBAction)checkphonenum:(id)sender
{

    [self closekey];
    
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
                           self.Businessdelegate_Newphonetextfield.text,@"phoneNumber",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中..."];
    [httpClient request:@"MerchantResMemberCheck.ashx" parameters:param successed:^(JSONDecoder *jsonDecoder, id responseObject) {
        NSData* data = [NSData dataWithData:responseObject];
        NSDictionary* handlJson = [jsonDecoder objectWithData:data];
        SaveData*keyData = [[SaveData alloc]initWithJsonObject:handlJson];
        
        BOOL success = [keyData.status boolValue];
        
        if (success)
        {
            [SVProgressHUD dismiss];
            
            if (([keyData.msg rangeOfString:@"|"].location!=NSNotFound&&[keyData.msg rangeOfString:@"男"].location!=NSNotFound)||([keyData.msg rangeOfString:@"|"].location!=NSNotFound&&[keyData.msg rangeOfString:@"女"].location!=NSNotFound))
            {
                 self.Businessdelegate_NewNametextfield.text = [keyData.msg substringToIndex:[keyData.msg rangeOfString:@"|"].location];
                self.Businessdelegate_NewSextfield.text=[keyData.msg substringWithRange:NSMakeRange([keyData.msg rangeOfString:@"|"].location+1,1)];
                
                self.Businessdelegate_NewNametextfield.enabled=NO;
                self.Businessdelegate_NewSextfield.enabled=NO;
                self.Businessdelegate_Sexdownbtn.enabled=NO;
 
            }

        }
        else
        {
            [SVProgressHUD dismiss];
 
            if (([keyData.msg rangeOfString:@"|"].location!=NSNotFound&&[keyData.msg rangeOfString:@"男"].location!=NSNotFound)||([keyData.msg rangeOfString:@"|"].location!=NSNotFound&&[keyData.msg rangeOfString:@"女"].location!=NSNotFound))
            {
                self.Businessdelegate_NewNametextfield.text = [keyData.msg substringToIndex:[keyData.msg rangeOfString:@"|"].location];
                self.Businessdelegate_NewSextfield.text=[keyData.msg substringWithRange:NSMakeRange([keyData.msg rangeOfString:@"|"].location+1,1)];
                self.Businessdelegate_NewNametextfield.enabled=NO;
                self.Businessdelegate_NewSextfield.enabled=NO;
                self.Businessdelegate_Sexdownbtn.enabled=NO;
            }
            else
            {
                [SVProgressHUD showErrorWithStatus:keyData.msg];
                self.Businessdelegate_NewNametextfield.enabled=YES;
                self.Businessdelegate_NewSextfield.enabled=YES;
                self.Businessdelegate_Sexdownbtn.enabled=YES;
            }
        }
        
    } failured:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:error.description];
    }];
 
}
//获取验证码
-(void)getDelegateCodeFromServerToE_mail
{
    
    [self closekey];
    
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
                           @"21",@"type",
                           
                           nil];
    
    NSLog(@"=====%@",param);
    
    [SVProgressHUD showWithStatus:@"正在发送..."];
    [httpClient request:@"SendEmailCode.ashx" parameters:param successed:^(JSONDecoder *jsonDecoder, id responseObject) {
        NSData* data = [NSData dataWithData:responseObject];
        NSDictionary* handlJson = [jsonDecoder objectWithData:data];
        SaveData*keyData = [[SaveData alloc]initWithJsonObject:handlJson];
        
        BOOL success = [keyData.status boolValue];
        
        if (success)
        {
            [SVProgressHUD dismiss];
            
            [SVProgressHUD showSuccessWithStatus:keyData.msg];
            
            [NSTimer scheduledTimerWithTimeInterval:120.0 target:self selector:@selector(changetimer1) userInfo:nil repeats:NO];
            
            delegatetimer=120;
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:keyData.msg];
        }
        
        
    } failured:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:error.description];
    }];

    
    
    
}





-(void)changetimer1
{
    delegatetimer=0;
}


//获取验证码
-(IBAction)getDelegateCode:(id)sender
{

    
    if (delegatetimer==120)
    {
        UIAlertView *alerv = [[UIAlertView alloc] initWithTitle:@"错误" message:@"若未收到邮件请2分钟后获取" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alerv show];
        return;
    }
    else if(delegatetimer==0)
    {
        [self getDelegateCodeFromServerToE_mail];

       //请求：：
    }

}




//跳出帮助页
-(void)preparehelepage
{
        BusinessdelegatehelpViewController*BusinessdelegatehelpVC=[[BusinessdelegatehelpViewController alloc]initWithNibName:@"BusinessdelegatehelpViewController" bundle:nil];
    [self presentViewController:BusinessdelegatehelpVC animated:YES completion:^{
        
    }];
    

}

-(IBAction)Businessdelegate_Save:(id)sender
{
    UIAlertView *alerv = [[UIAlertView alloc] initWithTitle:@"输入代理人变更理由!" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    alerv.tag=1001;
    alerv.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alerv show];

}

-(void)alertView : (UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UITextField *tf=[alertView textFieldAtIndex:0];
    if (buttonIndex==0)
    {
        return;
    }
    if (buttonIndex==1)
    {
        
        if (tf.text.length==0||[tf.text isEqualToString:@""])
        {
            [SVProgressHUD showErrorWithStatus:@"失败,理由不能为空!"];
            return;
        }
        else
        {
            [self sendDataToServer:tf.text];
            return;
            
        }
    }

    
}


-(void)sendDataToServer:(NSString*)reasonChange
{
    
    NSString * agentChangeApplicationID;//ID
    NSString * operation;
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    NSString*memberId=[userDefau objectForKey:@"memberId"];
    
    MainViewController*mainVC=[MainViewController shareobject];
    // 判断网络是否存在
    if ( ![mainVC isConnectionAvailable] )
    {
        return;
    }
    
    NSString *email = self.Businessdelegate_E_mailtextfield.text;
    
    if ([email isEqualToString:@""]) {
        
        [SVProgressHUD showErrorWithStatus:@"请填写邮箱"];
        
        return;
        
    }
    
    NSString*Sexstr;
    
    if ([self.Businessdelegate_NewSextfield.text isEqualToString:@"男"])
    {
        Sexstr=@"Male";
    }
    else if ([self.Businessdelegate_NewSextfield.text isEqualToString:@"女"])
    {
        Sexstr=@"Female";
    }
    
    NSString *newid = self.delegatepeopleDic[@"NewAgentChangeApplicationID"];
    
    if ([self isBlankString:newid]) {
        
        agentChangeApplicationID = @"0";
        
    }else {
    
        agentChangeApplicationID = newid;
        
    }
    
    NSString *newphone = self.delegatepeopleDic[@"NewPhone"];
    
    if ([self isBlankString:newphone]) {
        
        operation=@"1";
        
    }else {
    
        operation=@"2";
        
    }
    
    HttpClientRequest *httpClient = [HttpClientRequest sharedInstance];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId, @"memberId",
                           agentChangeApplicationID,@"agentChangeApplicationID",
                           operation,@"operation",
                           self.Businessdelegate_Newphonetextfield.text,@"mobilePhone",
                           Sexstr,@"sex",
                           reasonChange,@"reasonChange",
                           self.Businessdelegate_codetextfield.text,@"emailCode",
                           email,@"email",
                           nil];
    
    [SVProgressHUD showWithStatus:@"正在提交数据..."];

    [httpClient request:@"MerchantResMemberSubmit.ashx" parameters:param successed:^(JSONDecoder *jsonDecoder, id responseObject) {
        
        NSData* data = [NSData dataWithData:responseObject];
        NSDictionary* handlJson = [jsonDecoder objectWithData:data];
        SaveData *keyData = [[SaveData alloc]initWithJsonObject:handlJson];
        BOOL success = [keyData.status boolValue];
        if (success)
        {
            [SVProgressHUD dismiss];
            [SVProgressHUD showSuccessWithStatus:@"代理人变更信息提交成功!"];
            [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(poptoview) userInfo:nil repeats:NO];

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

- (BOOL)isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

-(void)poptoview
{
    [self.navigationController popViewControllerAnimated:YES];
}



@end
