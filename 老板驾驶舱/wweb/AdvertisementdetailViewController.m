//
//  AdvertisementdetailViewController.m
//  BusinessCenter
//
//  Created by 冯海强 on 14-2-10.
//  Copyright (c) 2014年 冯海强. All rights reserved.
//

#import "AdvertisementdetailViewController.h"

#import "AppHttpClient.h"
#import "SVProgressHUD.h"

@interface AdvertisementdetailViewController ()

@property (weak, nonatomic)IBOutlet UIScrollView *Advertisementdetails_scrollview;
@property(nonatomic,weak)IBOutlet UIImageView *Advertisement_Photoimage;
@property(nonatomic,weak)IBOutlet UITextView *Advertisement_Nametextview;//名称
@property(nonatomic,weak)IBOutlet UILabel *Advertisement_Memberchantlabel;//所属商户
@property(nonatomic,weak)IBOutlet UILabel *Advertisement_Classeslabel;//类别
@property(nonatomic,weak)IBOutlet UILabel *Advertisement_Orderlabel;//顺序
@property(nonatomic,weak)IBOutlet UILabel *Advertisement_Linklabel;//链接
@property(nonatomic,weak)IBOutlet UILabel *Advertisement_Promulgatorlabel;//发布者
@property(nonatomic,weak)IBOutlet UILabel *Advertisement_Setuptimelabel;//创建时间
@property(nonatomic,weak)IBOutlet UITextView *Advertisement_Descriptiontextview;//描述
@property(nonatomic,weak)IBOutlet UILabel *Advertisement_Explainlabel;//操作说明

@property(nonatomic,weak)IBOutlet UILabel *Advertisement_Explainlabelname;
@property(nonatomic,weak)IBOutlet UIImageView *Advertisement_Explainlabelimage;

@property(nonatomic,weak)IBOutlet UIButton *Advertisement_PassBtn;//通过
@property(nonatomic,weak)IBOutlet UIButton *Advertisement_ReturnBtn;//退回


@end

@implementation AdvertisementdetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.ADdic=[[NSMutableDictionary alloc]initWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    if ([self.Ishidden isEqualToString:@"YES"])
        {
            self.Advertisement_Explainlabel.hidden=self.Advertisement_Explainlabelname.hidden=self.Advertisement_Explainlabelimage.hidden=YES;
            self.Advertisement_PassBtn.frame=CGRectMake(30, 584, 100, 35);
            self.Advertisement_ReturnBtn.frame=CGRectMake(180, 584, 100, 35);
            
        }
        else if ([self.Ishidden isEqualToString:@"PASS"])
        {
            self.Advertisement_Explainlabel.hidden=self.Advertisement_Explainlabelname.hidden=self.Advertisement_Explainlabelimage.hidden=YES;
            self.Advertisement_PassBtn.hidden=YES;
            self.Advertisement_ReturnBtn.hidden=YES;
        }
        else
        {
            self.Advertisement_PassBtn.hidden=YES;
            self.Advertisement_ReturnBtn.hidden=YES;
        }
    
    if (iPhone5)
    {
        if ([self.Ishidden isEqualToString:@"PASS"])
        {
            [self.Advertisementdetails_scrollview setContentSize:CGSizeMake(320,[ UIScreen mainScreen ].bounds.size.height+40)];
        }
        else
        {
        [self.Advertisementdetails_scrollview setContentSize:CGSizeMake(320,[ UIScreen mainScreen ].bounds.size.    height+80)];
        }
    }
    else
    {
        if ([self.Ishidden isEqualToString:@"PASS"])
        {
            [self.Advertisementdetails_scrollview setContentSize:CGSizeMake(320,[ UIScreen mainScreen ].bounds.size.height+130)];
        }else
        {
        [self.Advertisementdetails_scrollview setContentSize:CGSizeMake(320,[ UIScreen mainScreen ].bounds.size.height+170)];
        }
    }

    
    self.Advertisement_Nametextview.editable=NO;
    self.Advertisement_Descriptiontextview.editable=NO;

    [self DatatoText];
    [self InfoImage];

}


-(void)DatatoText
{
    ADID=[self.ADdic objectForKey:@"ADID"];
    self.Advertisement_Nametextview.text=[self.ADdic objectForKey:@"ADName"];
    self.Advertisement_Memberchantlabel.text=[self.ADdic objectForKey:@"AllName"];
    self.Advertisement_Classeslabel.text=[self.ADdic objectForKey:@"MctCatgNames"];
    self.Advertisement_Orderlabel.text=[self.ADdic objectForKey:@"Sort"];
    self.Advertisement_Linklabel.text=[self.ADdic objectForKey:@"LinkUrl"];
    self.Advertisement_Promulgatorlabel.text=[self.ADdic objectForKey:@"CreateBy"];//发布者
    self.Advertisement_Setuptimelabel.text=[self.ADdic objectForKey:@"ModifyDate"];//创建时间
    self.Advertisement_Descriptiontextview.text=[self.ADdic objectForKey:@"Contents"];//描述
    self.Advertisement_Explainlabel.text=[self.ADdic objectForKey:@"OptionDescript"];//操作说明

}


-(void)InfoImage
{
    [self.Advertisement_Photoimage setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[self.ADdic objectForKey:@"FrontCover"]]]] placeholderImage:[UIImage imageNamed:@""] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        
        self.Advertisement_Photoimage.image = [CommonUtil scaleImage:image toSize:CGSizeMake(301, 202)];
        
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
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"确定通过此广告?" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
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
                           ADID,@"aDID",
                           descript,@"descript",
                           auditType,@"auditType",
                           nil];
    
    [SVProgressHUD showWithStatus:@"数据提交中……"];
    [httpClient request:@"WxAdvertiseAudit.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
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
