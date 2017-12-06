//
//  ProductdetailsViewController.m
//  BusinessCenter
//
//  Created by 冯海强 on 13-11-19.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import "ProductdetailsViewController.h"
#import "ProductdingdanViewController.h"
#import "ProductData.h"
#import "SVProgressHUD.h"
#import "HttpClientRequest.h"

@interface ProductdetailsViewController ()
//产品详情
@property (weak, nonatomic)IBOutlet UIScrollView*Productdetails_scrollview;

@property(nonatomic,weak)IBOutlet UITextView*Productdetails_Nametextview;//名称
@property(nonatomic,weak)IBOutlet UILabel*Productdetails_Smallnamelabel;//简称
@property(nonatomic,weak)IBOutlet UILabel*Productdetails_Numberlabel;//编号
@property(nonatomic,weak)IBOutlet UILabel*Productdetails_tags;//标签；
@property(nonatomic,weak)IBOutlet UILabel*Productdetails_Numlable;//数量
@property(nonatomic,weak)IBOutlet UILabel*Productdetails_Classeslabel;//类别
@property(nonatomic,weak)IBOutlet UILabel*Productdetails_Promulgatorlabel;//发布者
@property(nonatomic,weak)IBOutlet UILabel*Porductdetails_Setuptimelabel;//创建时间
@property(nonatomic,weak)IBOutlet UILabel*Porductdetails_Soldouttimelabel;//下架时间
//价钱及返利
@property(nonatomic,weak)IBOutlet UILabel*Porductdetails_NewMoneylabel;//新价钱
@property(nonatomic,weak)IBOutlet UILabel*Porductdetails_OldMoneylable;//旧价钱
@property(nonatomic,weak)IBOutlet UILabel*Porductdetails_PerMoneylable;//百分比返利
@property(nonatomic,weak)IBOutlet UILabel*Porductdetails_Keydate;//key

@property(nonatomic,weak)IBOutlet UIButton*Porductdetails_IsExpiredReturn;//过期
@property(nonatomic,weak)IBOutlet UIButton*Porductdetails_IsAnytimeReturn;//随时
@property(nonatomic,weak)IBOutlet UIButton*Porductdetails_IsReservation;//预约


@property(nonatomic,weak)IBOutlet UITextView*Porductdetails_Explaintextview;//说明
@property(nonatomic,weak)IBOutlet UITextView*Porductdetails_Remindtextview;//特别提醒

@property (weak, nonatomic) IBOutlet UIScrollView *Productdetails_imageScrollView;//滚动图片scrollview;
@property (weak, nonatomic) IBOutlet UIView *Productdetails_imageView;//滚动图片view;
@property(nonatomic,strong)   UIPageControl  *pageControl;//下面页数



@end



@implementation ProductdetailsViewController



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title=@"产品详情";

    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    //是否需要前面刷新
    
    
    offsetPage=1;
    // Do any additional setup after loading the view from its nib.
    [self.Porductdetails_IsExpiredReturn setImage:[UIImage imageNamed:@"Selected.png"] forState:UIControlStateSelected];
    [self.Porductdetails_IsExpiredReturn setImage:[UIImage imageNamed:@"Noselected.png"] forState:UIControlStateNormal];
    [self.Porductdetails_IsAnytimeReturn setImage:[UIImage imageNamed:@"Selected.png"] forState:UIControlStateSelected];
    [self.Porductdetails_IsAnytimeReturn setImage:[UIImage imageNamed:@"Noselected.png"] forState:UIControlStateNormal];
    [self.Porductdetails_IsReservation setImage:[UIImage imageNamed:@"Selected.png"] forState:UIControlStateSelected];
    [self.Porductdetails_IsReservation setImage:[UIImage imageNamed:@"Noselected.png"] forState:UIControlStateNormal];
    self.Porductdetails_IsExpiredReturn.selected=self.Porductdetails_IsAnytimeReturn.selected=self.Porductdetails_IsReservation.selected=NO;
    
    self.Productdetails_Nametextview.text=self.productdetail.SvcName;
    self.Productdetails_Smallnamelabel.text=self.productdetail.SvcSimpleName;
    self.Productdetails_Numberlabel.text=self.productdetail.ServiceCode;
    self.Productdetails_Numlable.text=[NSString stringWithFormat:@"%@",self.productdetail.Quantity];
    self.Productdetails_Classeslabel.text=self.productdetail.ClassValue;
    
    
    self.Productdetails_Promulgatorlabel.text=self.productdetail.CreateBy;
    self.Porductdetails_Setuptimelabel.text=self.productdetail.CreateDate;
    self.Porductdetails_Soldouttimelabel.text=self.productdetail.ShelfTime;
    self.Porductdetails_NewMoneylabel.text=[NSString stringWithFormat:@"￥%@",self.productdetail.Price];
    self.Porductdetails_OldMoneylable.text=[NSString stringWithFormat:@"￥%@",self.productdetail.OriginalPrice];
    float pri=self.productdetail.Price.floatValue*self.productdetail.Commissionrate.floatValue/100;
    self.Porductdetails_PerMoneylable.text=[NSString stringWithFormat:@"%@%@%@%0.2f%@",self.productdetail.Commissionrate,@"%",@"(",pri,@"元)"];
    self.Porductdetails_Keydate.text=[NSString stringWithFormat:@"%@一%@",self.productdetail.KeyvaildDateS,self.productdetail.KeyvaildDateE];
    if ([[NSString stringWithFormat:@"%@",self.productdetail.IsExpiredReturn] isEqualToString:@"Yes"])
    {
        self.Porductdetails_IsExpiredReturn.selected=YES;
    }
    if ([[NSString stringWithFormat:@"%@",self.productdetail.IsAnytimeReturn] isEqualToString:@"Yes"])
    {
        self.Porductdetails_IsAnytimeReturn.selected=YES;
    }
    if ([[NSString stringWithFormat:@"%@",self.productdetail.IsReservation] isEqualToString:@"Yes"])
    {
        self.Porductdetails_IsReservation.selected=YES;
    }
    self.Porductdetails_Explaintextview.text=self.productdetail.Introduction;
    self.Porductdetails_Remindtextview.text=self.productdetail.Explain;
    self.Productdetails_tags.text=self.productdetail.Tags;
 


    ////////
   self.Productdetails_Nametextview.editable=NO;
    self.Porductdetails_Explaintextview.editable=NO;
    self.Porductdetails_Remindtextview.editable=NO;
    
    self.Productdetails_imageScrollView.pagingEnabled = YES;
    self.Productdetails_imageScrollView.showsHorizontalScrollIndicator = NO;
    if (self.produtctphotoarray.count!=0)
    {
    self.Productdetails_imageScrollView.contentSize = CGSizeMake(self.produtctphotoarray.count*307, 180);
    }else
    {
    self.Productdetails_imageScrollView.contentSize = CGSizeMake(307, 180);
    }

    
    [self usepageControlProduct];
    //时间3秒一次显示
    [NSTimer scheduledTimerWithTimeInterval:2.5 target:self selector:@selector(showRecommendImageProduct) userInfo:nil repeats:YES];
    
    
    [self.Productdetails_scrollview setFrame:CGRectMake(0,0,320,self.Productdetails_scrollview.frame.size.height)];
    
    [self.Productdetails_scrollview setContentSize:CGSizeMake(320,self.Productdetails_scrollview.frame.size.height+700)];
 
    double version = [[UIDevice currentDevice].systemVersion doubleValue];//判定系统版本。

    // 版本判断
    if ( isIOS7 ) {
        if (iPhone5)
        {
        self.Productdetails_scrollview.center=CGPointMake(160,self.Productdetails_scrollview.frame.size.height/2+60);
        [self.Productdetails_scrollview setContentSize:CGSizeMake(320,self.Productdetails_scrollview.frame.size.height+700-88)];
        }
        else
        {
          self.Productdetails_scrollview.center=CGPointMake(160,self.Productdetails_scrollview.frame.size.height/2+148);
        }
    }else{
        if (version<=6.1)
        {
            if (iPhone5)
            {
                self.Productdetails_scrollview.center=CGPointMake(160,self.Productdetails_scrollview.frame.size.height/2+40);
                
                [self.Productdetails_scrollview setContentSize:CGSizeMake(320,self.Productdetails_scrollview.frame.size.height+700-88)];
            }
            else
            {
        self.Productdetails_scrollview.center=CGPointMake(160,self.Productdetails_scrollview.frame.size.height/2+128);
            }
        }
    }


    NSUserDefaults*product=[NSUserDefaults standardUserDefaults];
    NSString *str = [NSString stringWithFormat:@"%@",[product objectForKey:@"product"]];
    if (str.intValue==1)
    {
        
        UIButton *Btn_pass = [UIButton buttonWithType:UIButtonTypeCustom];
        Btn_pass.frame = CGRectMake(30,1070,100, 35);
        [Btn_pass setBackgroundImage:[UIImage imageNamed:@"but-2.png"] forState:UIControlStateNormal];
        Btn_pass.tintColor=[UIColor whiteColor];
        [Btn_pass setTitle:@"通过" forState:UIControlStateNormal];
        [Btn_pass addTarget:self action:@selector(PassproductIBAction) forControlEvents:UIControlEventTouchUpInside];
        [self.Productdetails_scrollview addSubview:Btn_pass];
        
        UIButton *Btn_back = [UIButton buttonWithType:UIButtonTypeCustom];
        Btn_back.frame = CGRectMake(180,1070,100, 35);
        [Btn_back setBackgroundImage:[UIImage imageNamed:@"but-2.png"] forState:UIControlStateNormal];
        Btn_back.tintColor=[UIColor whiteColor];
        [Btn_back setTitle:@"退回" forState:UIControlStateNormal];
        [Btn_back addTarget:self action:@selector(BackproductIBAction) forControlEvents:UIControlEventTouchUpInside];
        [self.Productdetails_scrollview addSubview:Btn_back];
        
    }
    if (str.intValue==2)
    {
       
        UIButton *Btn_out = [UIButton buttonWithType:UIButtonTypeCustom];
        Btn_out.frame = CGRectMake(20,1070,280,35);
        [Btn_out setBackgroundImage:[UIImage imageNamed:@"but-2.png"] forState:UIControlStateNormal];
        Btn_out.tintColor=[UIColor whiteColor];
        [Btn_out setTitle:@"下架" forState:UIControlStateNormal];
        [Btn_out addTarget:self action:@selector(OutproductIBAction) forControlEvents:UIControlEventTouchUpInside];
        [self.Productdetails_scrollview addSubview:Btn_out];
        
    }
    
    if (str.intValue!=1)
    {
        UIBarButtonItem *Addshop =[[UIBarButtonItem alloc] initWithTitle:@"订单" style:UIBarButtonItemStyleBordered target:self action:@selector(Productdingdan)];
        self.navigationItem.rightBarButtonItem =Addshop;[super viewDidLoad];
    }
    

    
    [self getimage];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//选获取图片
-(void)getimage
{
    for (int i=0; i<self.produtctphotoarray.count; i++)
    {
        ProductPhontoData*photo=[self.produtctphotoarray objectAtIndex:i];
        NSString *path=photo.BigPoster;
        NSLog(@"%@",path);
        UIImageView*imv=[[UIImageView alloc]init];
        [imv setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",path]]] placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            
            
            UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(i*307, 0, 307, 211)];

            imageview.image=[CommonUtil scaleImage:image toSize:CGSizeMake(307, 211)];
            
            [self.Productdetails_imageView addSubview:imageview];
            
 
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
            
            [SVProgressHUD showErrorWithStatus:@"海报资源不存在或已丢失!"];
            
        }];

   
    }

}



-(void)Productdingdan
{
    ProductdingdanViewController*BusdingdanVC=[[ProductdingdanViewController alloc]initWithNibName:@"ProductdingdanViewController" bundle:nil];
    BusdingdanVC.DingdanData=self.productdetail;
    [self .navigationController pushViewController:BusdingdanVC animated:YES];
    
}


-(void)usepageControlProduct
{
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(7,215,307, 20)];
    self.pageControl.hidesForSinglePage = YES;
    self.pageControl.userInteractionEnabled = NO;
    self.Productdetails_imageScrollView.delegate=self;
    self.pageControl.backgroundColor=[UIColor grayColor];
    
    //[self.view addSubview:self.pageControl];
    [self.Productdetails_scrollview addSubview:self.pageControl];//加上页控制器
    
    self.pageControl.numberOfPages = self.produtctphotoarray.count; //总页码
    
}

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    // 开关的指示当超过50%的前/后页是可见的
    CGFloat pageWidth = self.Productdetails_imageScrollView.frame.size.width;
    offsetPage = floor((self.Productdetails_imageScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = offsetPage;
}


//scrollView 委托方法 当scrollView移动结束的时候调用
#pragma mark -
#pragma mark UIScrollView
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //获取当前页码
    int index = fabs(scrollView.contentOffset.x) / scrollView.frame.size.width;
    
    //设置当前页码
    self.pageControl.currentPage = index;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


//图片滚动方法
-(void)showRecommendImageProduct
{
    if (offsetPage ==self.produtctphotoarray.count)
    {
        offsetPage =0;
        [self.Productdetails_imageScrollView setContentOffset:CGPointMake(307*offsetPage, 0)];
    }
    
    else
    {
        [self.Productdetails_imageScrollView setContentOffset:CGPointMake(307*offsetPage, 0) animated:YES];
    }
    
    self.pageControl.currentPage=offsetPage;
    offsetPage++;
    
}

-(void)SendDataToServer:(NSString*)descript;
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
                           [NSString stringWithFormat:@"%@",self.productdetail.ServiceId],@"serviceId",
                           nil];
    
    [SVProgressHUD showWithStatus:@"正在提交数据..."];
    
    [httpClient request:@"ProductAudit.ashx" parameters:param successed:^(JSONDecoder *jsonDecoder, id responseObject) {
        
        NSData* data = [NSData dataWithData:responseObject];
        NSDictionary* handlJson = [jsonDecoder objectWithData:data];
        ProductData *keyData = [[ProductData alloc]initWithJsonObject:handlJson];
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
            
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",self.productdetail.ServiceId]forKey:@"Product.ID"];
            
        [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(poptolastview) userInfo:nil repeats:NO];
            
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



-(void)PassproductIBAction//通过
{
    
    auditType=@"1";
    UIAlertView *alerv = [[UIAlertView alloc] initWithTitle:@"确认通过此产品?" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    alerv.tag=101;
    [alerv show];
    
    
}


-(void)BackproductIBAction// 退回
{
    auditType=@"2";
    
    UIAlertView *alerv = [[UIAlertView alloc] initWithTitle:@"输入退回理由" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    alerv.tag=201;
    alerv.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alerv show];

    
}

-(void)alertView : (UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
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
            [self SendDataToServer:@"通过"];
            return;
        }
        
    }
    
    if (alertView.tag==201)
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
            [self SendDataToServer:tf.text];
            return;
        }
        
    }

    }
    
    if (alertView.tag==301)
    {
        if (buttonIndex==0)
        {
            return;
        }
        
        if (buttonIndex==1)
        {
            [self SendDataOutproductIBAction];
            return;
        }
        
        
    }
    
    
    
    
}

-(void)OutproductIBAction
{
    
    UIAlertView *alerv = [[UIAlertView alloc] initWithTitle:@"确认下架此产品?" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    alerv.tag=301;
    [alerv show];
    
    
}



-(void)SendDataOutproductIBAction//下架
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
                            [NSString stringWithFormat:@"%@",self.productdetail.ServiceId],@"serviceId",
                           nil];
    
    [SVProgressHUD showWithStatus:@"正在提交数据..."];
    
    [httpClient request:@"ProductUnder.ashx" parameters:param successed:^(JSONDecoder *jsonDecoder, id responseObject) {
        
        NSData* data = [NSData dataWithData:responseObject];
        NSDictionary* handlJson = [jsonDecoder objectWithData:data];
        ProductData *keyData = [[ProductData alloc]initWithJsonObject:handlJson];
        BOOL success = [keyData.status boolValue];
        if (success)
        {
            [SVProgressHUD dismiss];

            [SVProgressHUD showSuccessWithStatus:@"下架成功!"];
  
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",self.productdetail.ServiceId]forKey:@"Product.ID"];
            
          [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(poptolastview) userInfo:nil repeats:NO];
            
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



-(void)poptolastview
{
    [self.navigationController popViewControllerAnimated:YES];
}



@end
