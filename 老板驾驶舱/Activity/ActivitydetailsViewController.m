

//
//  ActivitydetailsViewController.m
//  BusinessCenter
//
//  Created by 冯海强 on 13-11-20.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import "ActivitydetailsViewController.h"
#import "ActivitymemberViewController.h"
#import "ActivityData.h"
#import "SVProgressHUD.h"
#import "HttpClientRequest.h"

@interface ActivitydetailsViewController ()

@property(nonatomic,weak)IBOutlet UITextView*Activitydetails_Nametextview;//名称
@property(nonatomic,weak)IBOutlet UILabel*Activitydetails_Numberlabel;//编号
@property(nonatomic,weak)IBOutlet UILabel*Activitydetails_Classeslabel;//类别
@property(nonatomic,weak)IBOutlet UILabel*Activitydetails_Promulgatorlabel;//分享者
@property(nonatomic,weak)IBOutlet UILabel*Activitydetails_Setuptimelabel;//活动时间
@property(nonatomic,weak)IBOutlet UILabel*Activitydetails_SetupDatelabel;//日期
@property(nonatomic,weak)IBOutlet UILabel*Activitydetails_tags;//标签；
@property(nonatomic,weak)IBOutlet UILabel*Activitydetails_Address;//地址

//报名要求
@property(nonatomic,weak)IBOutlet UILabel*Activitydetails_Sexlabel;//性别
@property(nonatomic,weak)IBOutlet UILabel*Activitydetails_Minagelable;//最小年龄
@property(nonatomic,weak)IBOutlet UILabel*Activitydetails_Maxagelabel;//最大年龄
@property(nonatomic,weak)IBOutlet UILabel*Activitydetails_Minpernumlabel;//最少人数
@property(nonatomic,weak)IBOutlet UILabel*Activitydetails_Maxpernumlabel;//最大人数
@property(nonatomic,weak)IBOutlet UILabel*Activitydetails_Uptotime;//报名截至时间

@property(nonatomic,weak)IBOutlet UIButton*Activitydetails_IsExpiredReturn;//过期
@property(nonatomic,weak)IBOutlet UIButton*Activitydetails_IsAnytimeReturn;//随时
@property(nonatomic,weak)IBOutlet UIButton*Activitydetails_IsReservation;//预约
//价钱及返利
@property(nonatomic,weak)IBOutlet UILabel*Activitydetails_NewMoneylabel;//新价钱
@property(nonatomic,weak)IBOutlet UILabel*Activitydetails_OldMoneylable;//旧价钱
@property(nonatomic,weak)IBOutlet UILabel*Activitydetails_PerMoneylable;//百分比返利
@property(nonatomic,weak)IBOutlet UILabel*Activitydetails_Key;//key值

@property(nonatomic,weak)IBOutlet UITextView*Activitydetails_Explaintextview;//说明
@property(nonatomic,retain)IBOutlet UITextView*Activitydetails_Remindtextview;//特别提醒

@property (weak, nonatomic) IBOutlet UIScrollView *Activitydetails_imageScrollView;//滚动图片scrollview;
@property (weak, nonatomic) IBOutlet UIView *Activitydetails_imageView;//滚动图片view;
@property(nonatomic,strong)   UIPageControl  *pageControlActivity;//下面页数控制器





@end



@implementation ActivitydetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title=@"活动详情";
        
    }
    return self;
}

- (void)viewDidLoad
{
    offsetPageActivity=1;
    
    
    [self.Activitydetails_IsExpiredReturn setImage:[UIImage imageNamed:@"Selected.png"] forState:UIControlStateSelected];
    [self.Activitydetails_IsExpiredReturn setImage:[UIImage imageNamed:@"Noselected.png"] forState:UIControlStateNormal];
    [self.Activitydetails_IsAnytimeReturn setImage:[UIImage imageNamed:@"Selected.png"] forState:UIControlStateSelected];
    [self.Activitydetails_IsAnytimeReturn setImage:[UIImage imageNamed:@"Noselected.png"] forState:UIControlStateNormal];
    [self.Activitydetails_IsReservation setImage:[UIImage imageNamed:@"Selected.png"] forState:UIControlStateSelected];
    [self.Activitydetails_IsReservation setImage:[UIImage imageNamed:@"Noselected.png"] forState:UIControlStateNormal];
    self.Activitydetails_IsExpiredReturn.selected=self.Activitydetails_IsAnytimeReturn.selected=self.Activitydetails_IsReservation.selected=NO;
    
    self.Activitydetails_Nametextview.text=self.activityDetailData.ActivityName;
    self.Activitydetails_Numberlabel.text=self.activityDetailData.ActivityCode;
    self.Activitydetails_Classeslabel.text=self.activityDetailData.ActivityType;
    self.Activitydetails_Promulgatorlabel.text=self.activityDetailData.NickName;
    
    self.Activitydetails_SetupDatelabel.text=[NSString stringWithFormat:@"%@%@%@",self.activityDetailData.ActStartDate,@"-",self.activityDetailData.ActEndDate];
    
    self.Activitydetails_Setuptimelabel.text=[NSString stringWithFormat:@"%@%@%@",self.activityDetailData.ActStartTime,@"-",self.activityDetailData.ActEndtTime];
    
    self.Activitydetails_tags.text=self.activityDetailData.ActivityTags;
    self.Activitydetails_Address.text=self.activityDetailData.Address;
    if ([[NSString stringWithFormat:@"%@",self.activityDetailData.Sex]isEqualToString:@""]||self.activityDetailData.Sex==nil)
    {
     self.Activitydetails_Sexlabel.text=@"性别不限";
    }
    else if([[NSString stringWithFormat:@"%@",self.activityDetailData.Sex]isEqualToString:@"Male"])
    {
        self.Activitydetails_Sexlabel.text=@"男";
    }
    else if ([[NSString stringWithFormat:@"%@",self.activityDetailData.Sex]isEqualToString:@"Female"])
        {
            self.Activitydetails_Sexlabel.text=@"女";

        }
    self.Activitydetails_Minagelable.text=[NSString stringWithFormat:@"%@",self.activityDetailData.AgeMin];
    self.Activitydetails_Maxagelabel.text=[NSString stringWithFormat:@"%@",self.activityDetailData.AgeMax];
    self.Activitydetails_Minpernumlabel.text=[NSString stringWithFormat:@"%@",self.activityDetailData.PeoperNumMin];
    self.Activitydetails_Maxpernumlabel.text=[NSString stringWithFormat:@"%@",self.activityDetailData.PeoperNumMax];
    
    self.Activitydetails_Uptotime.text=[NSString stringWithFormat:@"%@",self.activityDetailData.RegStopTime];
    
    
    if ([[NSString stringWithFormat:@"%@",self.activityDetailData.IsExpiredReturn] isEqualToString:@"Yes"])
    {
        self.Activitydetails_IsExpiredReturn.selected=YES;
    }
    if ([[NSString stringWithFormat:@"%@",self.activityDetailData.IsAnyTimeReturn] isEqualToString:@"Yes"])
    {
        self.Activitydetails_IsAnytimeReturn.selected=YES;
    }
    if ([[NSString stringWithFormat:@"%@",self.activityDetailData.IsReservation] isEqualToString:@"Yes"])
    {
        self.Activitydetails_IsReservation.selected=YES;
    }
    
    self.Activitydetails_NewMoneylabel.text=[NSString stringWithFormat:@"￥%@",self.activityDetailData.Price];
    self.Activitydetails_OldMoneylable.text=[NSString stringWithFormat:@"￥%@",self.activityDetailData.OriginalPrice];
    self.Activitydetails_PerMoneylable.text=[NSString stringWithFormat:@"%@%@%@%@%@",self.activityDetailData.Brokerage,@"%",@"(",self.activityDetailData.BrokerageAmount,@")元"];
    self.Activitydetails_Key.text =[NSString stringWithFormat:@"%@-%@",self.activityDetailData.KeyVaildDateS,self.activityDetailData.KeyVaildDateE];
    
    self.Activitydetails_Explaintextview.text=self.activityDetailData.Content;
    self.Activitydetails_Remindtextview.text=self.activityDetailData.Explain;
    

    self.Activitydetails_Nametextview.editable=NO;
    self.Activitydetails_Explaintextview.editable=NO;
    self.Activitydetails_Remindtextview.editable=NO;
    
    self.Activitydetails_imageScrollView.pagingEnabled = YES;
    self.Activitydetails_imageScrollView.showsHorizontalScrollIndicator = NO;
    if (self.activityphotoarray.count!=0)
    {
        self.Activitydetails_imageScrollView.contentSize = CGSizeMake(self.activityphotoarray.count*160, 180);
    }else
    {
        self.Activitydetails_imageScrollView.contentSize = CGSizeMake(160, 180);
    }
    [self.Activitydetails_imageScrollView addSubview:self.Activitydetails_imageView];
    [self usepageControlActivity];
    //时间3秒一次显示
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(showRecommendImageActivity) userInfo:nil repeats:YES];
    
    

    [Activitydetails_scrollview setFrame:CGRectMake(0,0,320,Activitydetails_scrollview.frame.size.height)];
    
    [Activitydetails_scrollview setContentSize:CGSizeMake(320,Activitydetails_scrollview.frame.size.height+730)];
    
    double version = [[UIDevice currentDevice].systemVersion doubleValue];//判定系统版本。
    
    // 版本判断
    if ( isIOS7 ) {
        if (iPhone5)
        {
            Activitydetails_scrollview.center=CGPointMake(160,Activitydetails_scrollview.frame.size.height/2+60);
            [Activitydetails_scrollview setContentSize:CGSizeMake(320,Activitydetails_scrollview.frame.size.height+730-88)];
        }
        else
        {
            Activitydetails_scrollview.center=CGPointMake(160,Activitydetails_scrollview.frame.size.height/2+148);
        }
    }else{
        if (version<=6.1)
        {
            if (iPhone5)
            {
                Activitydetails_scrollview.center=CGPointMake(160,Activitydetails_scrollview.frame.size.height/2+40);
                
                [Activitydetails_scrollview setContentSize:CGSizeMake(320,Activitydetails_scrollview.frame.size.height+730-88)];
            }
            else
            {
                Activitydetails_scrollview.center=CGPointMake(160,Activitydetails_scrollview.frame.size.height/2+128);
            }
        }
    }

    
    
    
    
    NSUserDefaults*Activity=[NSUserDefaults standardUserDefaults];
    NSString *str = [NSString stringWithFormat:@"%@",[Activity objectForKey:@"activity"]];
    
    if (str.intValue==1)
    {
        
        UIButton *Btn_pass = [UIButton buttonWithType:UIButtonTypeCustom];
        Btn_pass.frame = CGRectMake(30,1095,100, 35);
        [Btn_pass setBackgroundImage:[UIImage imageNamed:@"but-2.png"] forState:UIControlStateNormal];
        Btn_pass.tintColor=[UIColor whiteColor];
        [Btn_pass setTitle:@"通过" forState:UIControlStateNormal];
        [Btn_pass addTarget:self action:@selector(PassactivityIBAction) forControlEvents:UIControlEventTouchUpInside];
        [Activitydetails_scrollview addSubview:Btn_pass];
        
        UIButton *Btn_back = [UIButton buttonWithType:UIButtonTypeCustom];
        Btn_back.frame = CGRectMake(180,1095,100, 35);
        [Btn_back setBackgroundImage:[UIImage imageNamed:@"but-2.png"] forState:UIControlStateNormal];
        Btn_back.tintColor=[UIColor whiteColor];
        [Btn_back setTitle:@"退回" forState:UIControlStateNormal];
        [Btn_back addTarget:self action:@selector(BackactivityIBAction) forControlEvents:UIControlEventTouchUpInside];
        [Activitydetails_scrollview addSubview:Btn_back];
        
        
    }
    else
    {
        UIBarButtonItem *Addshop =[[UIBarButtonItem alloc] initWithTitle:@"成员" style:UIBarButtonItemStyleBordered target:self action:@selector(findmemberpeople)];
        self.navigationItem.rightBarButtonItem =Addshop;[super viewDidLoad];
    }
   
    NSLog(@"%@",self.activityphotoarray);
    
    [self getImage];
    
    // Do any additional setup after loading the view from its nib.
}



-(void)getImage
{
    
    for (int i=0; i<self.activityphotoarray.count; i++)
    {
        ActivityPhontoData*photo=[self.activityphotoarray objectAtIndex:i];
        NSString *path=photo.MidPoster;
        UIImageView*imv=[[UIImageView alloc]init];
        [imv setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",path]]] placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            
            
            UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(i*160, 0, 160, 211)];
            
            imageview.image=[CommonUtil scaleImage:image toSize:CGSizeMake(160, 211)];
            [self.Activitydetails_imageView addSubview:imageview];
            
            
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
            
            [SVProgressHUD showErrorWithStatus:@"海报资源不存在或已丢失!"];
            
        }];
        
        
    }

    
}




-(void)usepageControlActivity
{
    
    self.pageControlActivity = [[UIPageControl alloc] initWithFrame:CGRectMake(11,215,160, 20)];
    self.pageControlActivity.hidesForSinglePage = YES;
    self.pageControlActivity.userInteractionEnabled = NO;
    self.Activitydetails_imageScrollView.delegate=self;
    self.pageControlActivity.backgroundColor=[UIColor grayColor];
    
    //[self.view addSubview:self.pageControl];
    [Activitydetails_scrollview addSubview:self.pageControlActivity];//加上页控制器
    
    self.pageControlActivity.numberOfPages = self.activityphotoarray.count; //总页码
    
    NSLog(@"count = %d",self.activityphotoarray.count);
    
}
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    // 开关的指示当超过50%的前/后页是可见的
    CGFloat pageWidth = self.Activitydetails_imageScrollView.frame.size.width;
    offsetPageActivity = floor((self.Activitydetails_imageScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControlActivity.currentPage = offsetPageActivity;
}


//scrollView 委托方法 当scrollView移动结束的时候调用
#pragma mark -
#pragma mark UIScrollView
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //获取当前页码
    int index = fabs(scrollView.contentOffset.x) / scrollView.frame.size.width;
    
    //设置当前页码
    self.pageControlActivity.currentPage = index;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


//首页推荐滚动方法
-(void)showRecommendImageActivity
{
    if (offsetPageActivity ==self.activityphotoarray.count)
    {
        offsetPageActivity =0;
        [self.Activitydetails_imageScrollView setContentOffset:CGPointMake(160*offsetPageActivity, 0)];
    }
    
    else
    {
        [self.Activitydetails_imageScrollView setContentOffset:CGPointMake(160*offsetPageActivity, 0) animated:YES];
    }
    
    self.pageControlActivity.currentPage=offsetPageActivity;
    offsetPageActivity++;
    
}
//成员
-(void)findmemberpeople
{
    ActivitymemberViewController*BusmemberVC=[[ActivitymemberViewController alloc]initWithNibName:@"ActivitymemberViewController" bundle:nil];
    
    BusmemberVC.activitydata=self.activityDetailData;
    
    [self .navigationController pushViewController:BusmemberVC animated:YES];
    
        
}

-(void)sendDataToServer:(NSString*)descript
{
    
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    NSString*memberId=[userDefau objectForKey:@"memberId"];
    
    MainViewController*mainVC=[MainViewController shareobject];
    // 判断网络是否存在
    if ( ![mainVC isConnectionAvailable] )
    {
        return;
    }
    
    HttpClientRequest *httpClient = [HttpClientRequest sharedInstance];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId, @"memberId",
                           auditType,@"auditType",
                           descript,@"descript",
                           [NSString stringWithFormat:@"%@",self.activityDetailData.ActivityId],@"ActivityId",
                           nil];
    
    [SVProgressHUD showWithStatus:@"正在提交数据..."];
    
    [httpClient request:@"ActivityAudit.ashx" parameters:param successed:^(JSONDecoder *jsonDecoder, id responseObject) {
        
        NSData* data = [NSData dataWithData:responseObject];
        NSDictionary* handlJson = [jsonDecoder objectWithData:data];
        ActivityData *keyData = [[ActivityData alloc]initWithJsonObject:handlJson];
        BOOL success = [keyData.status boolValue];
        if (success)
        {
            [SVProgressHUD dismiss];
            if ([auditType isEqualToString:@"1"])
            {
                [SVProgressHUD showSuccessWithStatus:@"通过成功!"];
            }
            else
            {
                [SVProgressHUD showSuccessWithStatus:@"退回成功!"];
            }
            
                    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",self.activityDetailData.ActivityId]forKey:@"Activity.ID"];
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


//通过
-(void)PassactivityIBAction
{
    auditType=@"1";
    
    UIAlertView *alerv = [[UIAlertView alloc] initWithTitle:@"确认通过此活动?" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    alerv.tag=101;
    [alerv show];
    

    
}
//退回
-(void)BackactivityIBAction
{
    auditType=@"2";

    UIAlertView *alerv = [[UIAlertView alloc] initWithTitle:@"输入退回理由" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    alerv.tag=201;
    alerv.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alerv show];
    
    
}

-(void)alertView : (UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==101)
    {
        if (buttonIndex==0)
        {
            return;
        }
        if (buttonIndex==1)
        {
            [self sendDataToServer:@"通过"];
            return;
        }
        
    }
    else if (alertView.tag==201)
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
            [self sendDataToServer:tf.text];
            return;

        }

    }
        
  }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
