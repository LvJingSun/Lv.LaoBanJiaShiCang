//
//  InformationdetailViewController.m
//  BusinessCenter
//
//  Created by 冯海强 on 14-2-10.
//  Copyright (c) 2014年 冯海强. All rights reserved.


#import "InformationdetailViewController.h"
#import "AppHttpClient.h"
#import "SVProgressHUD.h"

@interface InformationdetailViewController ()
@property (weak, nonatomic)IBOutlet UIScrollView *Informationdetails_scrollview;
@property(nonatomic,weak)IBOutlet UIImageView *Information_Photoimage;
@property(nonatomic,weak)IBOutlet UITextView *Information_Nametextview;//名称
@property(nonatomic,weak)IBOutlet UILabel *Information_Smallnamelabel;//副标
@property(nonatomic,weak)IBOutlet UILabel *Information_Memberchantlabel;//所属商户
@property(nonatomic,weak)IBOutlet UILabel *Information_Classeslabel;//类别
@property(nonatomic,weak)IBOutlet UILabel *Information_Orderlabel;//顺序
@property(nonatomic,weak)IBOutlet UILabel *Information_Promulgatorlabel;//发布者
@property(nonatomic,weak)IBOutlet UILabel *Information_Setuptimelabel;//创建时间
@property(nonatomic,weak)IBOutlet UITextView *Information_Descriptiontextview;//介绍
@property(nonatomic,weak)IBOutlet UIWebView *Information_Detailtextview;//内容

@property(nonatomic,weak)IBOutlet UILabel *Information_Explainlabel;//操作说明
@property(nonatomic,weak)IBOutlet UILabel *Information_Explainlabelname;
@property(nonatomic,weak)IBOutlet UIImageView *Information_Explainlabelimage;

@property(nonatomic,weak)IBOutlet UIButton *Information_PassBtn;//通过
@property(nonatomic,weak)IBOutlet UIButton *Information_ReturnBtn;//退回
@end

@implementation InformationdetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.Indic=[[NSMutableDictionary alloc]initWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if ([self.Ishidden isEqualToString:@"YES"])
    {
        self.Information_Explainlabel.hidden=self.Information_Explainlabelname.hidden=self.Information_Explainlabelimage.hidden=YES;
        self.Information_PassBtn.frame=CGRectMake(30, 671, 100, 35);
        self.Information_ReturnBtn.frame=CGRectMake(180, 671, 100, 35);
        
    }
    else if ([self.Ishidden isEqualToString:@"PASS"])
    {
        self.Information_Explainlabel.hidden=self.Information_Explainlabelname.hidden=self.Information_Explainlabelimage.hidden=YES;
        self.Information_PassBtn.hidden=self.Information_ReturnBtn.hidden=YES;

    }
    else
    {
        self.Information_PassBtn.hidden=self.Information_ReturnBtn.hidden=YES;
    }
    
    if (iPhone5)
    {
        if ([self.Ishidden isEqualToString:@"PASS"])
        {
            [self.Informationdetails_scrollview setContentSize:CGSizeMake(320,[ UIScreen mainScreen ].bounds.size.height+120)];
        }
        else
        {
        [self.Informationdetails_scrollview setContentSize:CGSizeMake(320,[ UIScreen mainScreen ].bounds.size.height+160)];
        }
    }
    else
    {
        if ([self.Ishidden isEqualToString:@"PASS"])
        {
            [self.Informationdetails_scrollview setContentSize:CGSizeMake(320,[ UIScreen mainScreen ].bounds.size.height+220)];
        }else
        {
        [self.Informationdetails_scrollview setContentSize:CGSizeMake(320,[ UIScreen mainScreen ].bounds.size.height+260)];
        }
    }

    self.Information_Nametextview.editable=NO;
    self.Information_Descriptiontextview.editable=NO;
//    self.Information_Detailtextview.editable=NO;
    
    [self DataToText];
    [self InfoImage];

}


-(void)DataToText
{
    InfoID=[self.Indic objectForKey:@"InfoID"];
    self.Information_Nametextview.text=[self.Indic objectForKey:@"Title"];
    self.Information_Smallnamelabel.text=[self.Indic objectForKey:@"SubTitle"];
    self.Information_Memberchantlabel.text=[self.Indic objectForKey:@"AllName"];
    self.Information_Classeslabel.text=[self.Indic objectForKey:@"MctCatgNames"];
    self.Information_Orderlabel.text=[self.Indic objectForKey:@"Sort"];
    self.Information_Promulgatorlabel.text=[self.Indic objectForKey:@"CreateBy"];//发布者
    self.Information_Setuptimelabel.text=[self.Indic objectForKey:@"ModifyDate"];//创建时间
    self.Information_Descriptiontextview.text=[self.Indic objectForKey:@"CoreIntro"];//描述
    
    NSString*str=[self.Indic objectForKey:@"Contents"];
    
    [self.Information_Detailtextview loadHTMLString:str baseURL:nil];
//    self.Information_Detailtextview.userInteractionEnabled = NO;
    self.Information_Detailtextview.backgroundColor=[UIColor clearColor];
    self.Information_Detailtextview.opaque = NO;
    
    self.Information_Explainlabel.text=[self.Indic objectForKey:@"OptionDescript"];
    

    
}


-(void)InfoImage
{
    [self.Information_Photoimage setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[self.Indic objectForKey:@"PhotoUrl"]]]] placeholderImage:[UIImage imageNamed:@""] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        
        self.Information_Photoimage.image = [CommonUtil scaleImage:image toSize:CGSizeMake(301, 202)];
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)PassBtn:(UIButton*)sender
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"确定通过此资讯?" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag=101;
    [alert show];
    
}

-(IBAction)ReturnBtn:(UIButton*)sender
{
    UIAlertView *alerv = [[UIAlertView alloc] initWithTitle:@"输入退回理由" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    alerv.tag=102;
    alerv.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alerv show];
}


-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //得到输入框
    
    if (alertView.tag==101)
    {
        if (buttonIndex==0)
        {
            return;
        }
        
        if (buttonIndex==1)
        {
            [self SendDataToServer:@"审核通过" auditType:@"1"];
            return;
        }
        
    }
    
    if (alertView.tag==102)
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
                [SVProgressHUD showErrorWithStatus:@"退回失败,理由不能为空!"];
                return;
            }
            else
            {
                [self SendDataToServer:tf.text auditType:@"2"];
                
                return;
            }
            
        }
        
    }
    
}



-(void)SendDataToServer:(NSString*)descript auditType:(NSString*)auditType;
{
    
    MainViewController *MAIN=[MainViewController shareobject];
    // 判断网络是否存在
    if ( ![MAIN isConnectionAvailable] ) {
        return;
    }
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    NSString * memberID=[userDefau objectForKey:@"memberId"];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberID, @"memberId",
                           InfoID,@"infoID",
                           descript,@"descript",
                           auditType,@"auditType",
                           nil];
    
    [SVProgressHUD showWithStatus:@"数据提交中……"];
    [httpClient request:@"WxInfoAudit.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            [SVProgressHUD dismiss];
            
            if ([auditType isEqualToString:@"1"])
            {
                [SVProgressHUD showSuccessWithStatus:@"通过成功!"];
            }
            else
            {
                [SVProgressHUD showSuccessWithStatus:@"退回成功!"];
                
            }
            
            [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(pop) userInfo:nil repeats:NO];
            
        }
        else
        {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
    } failure:^(NSError *error) {
        
        NSLog(@"error:%@",error.description);
        
        [SVProgressHUD showErrorWithStatus:error.description];
    }];
    
}


-(void)pop
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
