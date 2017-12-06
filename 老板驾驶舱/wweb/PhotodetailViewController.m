//
//  PhotodetailViewController.m
//  BusinessCenter
//
//  Created by 冯海强 on 14-2-10.
//  Copyright (c) 2014年 冯海强. All rights reserved.
//

#import "PhotodetailViewController.h"
#import "AppHttpClient.h"
#import "SVProgressHUD.h"

@interface PhotodetailViewController ()

@property (weak, nonatomic)IBOutlet UIScrollView *Photodetails_scrollview;

@property(nonatomic,weak)IBOutlet UIImageView *Photo_Photoimage;
@property(nonatomic,weak)IBOutlet UILabel *Photo_Memberchantlabel;//所属商户
@property(nonatomic,weak)IBOutlet UILabel *Photo_Classeslabel;//类别
@property(nonatomic,weak)IBOutlet UILabel *Photo_Promulgatorlabel;//发布者
@property(nonatomic,weak)IBOutlet UILabel *Photo_Setuptimelabel;//创建时间
@property(nonatomic,weak)IBOutlet UITextView *Photo_Detailtextview;//内容
@property(nonatomic,weak)IBOutlet UILabel *Photo_Explainlabel;//操作说明

@property(nonatomic,weak)IBOutlet UILabel *Photo_Explainlabelname;
@property(nonatomic,weak)IBOutlet UIImageView *Photo_Explainlabelimage;

@property(nonatomic,weak)IBOutlet UIButton *Photo_PassBtn;//通过
@property(nonatomic,weak)IBOutlet UIButton *Photo_ReturnBtn;//退回

@end

@implementation PhotodetailViewController

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
    // Do any additional setup after loading the view from its nib.
    if ([self.Ishidden isEqualToString:@"YES"])
    {
        self.Photo_Explainlabel.hidden=self.Photo_Explainlabelname.hidden=self.Photo_Explainlabelimage.hidden=YES;
        self.Photo_PassBtn.frame=CGRectMake(30,453, 100, 35);
        self.Photo_ReturnBtn.frame=CGRectMake(180,453, 100, 35);
        
    }
    else if ([self.Ishidden isEqualToString:@"PASS"])
    {
        self.Photo_Explainlabel.hidden=self.Photo_Explainlabelname.hidden=self.Photo_Explainlabelimage.hidden=YES;
        self.Photo_PassBtn.hidden=self.Photo_ReturnBtn.hidden=YES;
        
    }
    else
    {
        self.Photo_PassBtn.hidden=self.Photo_ReturnBtn.hidden=YES;
    }
    if (iPhone5)
    {
        if ([self.Ishidden isEqualToString:@"PASS"])
        {
            [self.Photodetails_scrollview setContentSize:CGSizeMake(320,[ UIScreen mainScreen ].bounds.size.height-40)];
        }
        else
        {
        [self.Photodetails_scrollview setContentSize:CGSizeMake(320,[ UIScreen mainScreen ].bounds.size.height)];
        }
    }
    else
    {
        if ([self.Ishidden isEqualToString:@"PASS"])
        {
            [self.Photodetails_scrollview setContentSize:CGSizeMake(320,[ UIScreen mainScreen ].bounds.size.height-10)];
        }else
        {
        [self.Photodetails_scrollview setContentSize:CGSizeMake(320,[ UIScreen mainScreen ].bounds.size.height+30)];
        }
    }

    self.Photo_Detailtextview.editable=NO;
    
    [self DataToText];
    [self InfoImage];

    
}


-(void)DataToText
{
    MerchantPhotoID=[self.Phdic objectForKey:@"MerchantPhotoID"];
    self.Photo_Memberchantlabel.text=[self.Phdic objectForKey:@"AllName"];
    self.Photo_Classeslabel.text=[self.Phdic objectForKey:@"MctCatgNames"];
    self.Photo_Promulgatorlabel.text=[self.Phdic objectForKey:@"CreateBy"];
    
    self.Photo_Setuptimelabel.text=[self.Phdic objectForKey:@"ModifyDate"];
    self.Photo_Detailtextview.text=[self.Phdic objectForKey:@"BriefIntro"];
    self.Photo_Explainlabel.text=[self.Phdic objectForKey:@"Description"];
    
    
}


-(void)InfoImage
{
    [self.Photo_Photoimage setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[self.Phdic objectForKey:@"PhotoUrl"]]]] placeholderImage:[UIImage imageNamed:@""] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        
        self.Photo_Photoimage.image = [CommonUtil scaleImage:image toSize:CGSizeMake(301, 202)];
        
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
                           MerchantPhotoID,@"photoID",
                           descript,@"descript",
                           auditType,@"auditType",
                           nil];
    
    [SVProgressHUD showWithStatus:@"数据提交中……"];
    [httpClient request:@"WxPhotoAudit.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
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
