//
//  BusinessBankViewController.m
//  BusinessCenter
//
//  Created by 冯海强 on 13-11-22.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import "BusinessBankViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "BusinessBankdownCell.h"
#import "BankWebpointCell.h"
#import "UITableView+DataSourceBlocks.h"
#import "TableViewWithBlock.h"
#import "HttpClientRequest.h"
#import "SVProgressHUD.h"
#import "BankData.h"
#import "BankwebData.h"
#import "BankWebpointCell.h"
#import "SaveData.h"

@interface BusinessBankViewController ()


@property(nonatomic,weak)IBOutlet UILabel *BusinessBank_OldNamelabelname;//原名字name
@property(nonatomic,weak)IBOutlet UILabel *BusinessBank_OldNumlabelname;//原卡号name

@property(nonatomic,weak)IBOutlet UILabel *BusinessBank_OldNamelabel;//
@property(nonatomic,weak)IBOutlet UILabel *BusinessBank_OldNumlabel;//
@property(nonatomic,weak)IBOutlet UILabel *BusinessBank_OldBankNamelabel;//
@property(nonatomic,weak)IBOutlet UILabel *BusinessBank_Oldwebbanklabel;//
//
@property(nonatomic,weak)IBOutlet UILabel *BusinessBank_Namelabelname;//名字name
@property(nonatomic,weak)IBOutlet UILabel *BusinessBank_Numlabelname;//卡号name
///
@property(nonatomic,weak)IBOutlet UITextField *BusinessBank_leibietextfield;//类别

@property(nonatomic,weak)IBOutlet UIButton*BusinessBank_leibieBtn;//类别按钮
@property(nonatomic,weak)IBOutlet UIButton*BusinessBank_yinghangBtn;//银行按钮；

@property(nonatomic,weak)IBOutlet UITextField *BusinessBank_Nametextfield;//名字
@property(nonatomic,weak)IBOutlet UITextField *BusinessBank_Numtextfield;//卡号

@property(nonatomic,weak)IBOutlet UITextField *BusinessBank_yinhangtextfield;//银行

@property(nonatomic,weak)IBOutlet UITextField *BusinessBank_diqutextfield;//地区\\网点
@property(nonatomic,weak)IBOutlet UILabel *BusinessBank_stateslabel;//状态

@property(nonatomic,weak)IBOutlet UITextField *BusinessBank_codetextfield;//验证码


@property(nonatomic,strong)NSMutableArray*BusinessBankleibiearray;



@end

@implementation BusinessBankViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.BankDataDic=[[NSMutableDictionary alloc]initWithCapacity:0];
        self.Bankwebarray=[[NSMutableArray alloc]initWithCapacity:0];
        self.Bankcodearray = [[NSArray alloc] initWithObjects:@"0100",@"0102",@"0103",@"0104",@"0105",@"0302",@"0303",@"0305",@"0306",@"0308",@"0309",nil];
    }
    return self;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    //隐藏状态栏
   // [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"银行卡信息";
    
    self.BusinessBank_leibietextfield.enabled=NO;
    self.BusinessBank_yinhangtextfield.enabled=NO;
    
    self.BusinessBank_leibietextfield.placeholder=@"请选择……";
    self.BusinessBank_yinhangtextfield.placeholder=@"请选择……";

    
    self.BusinessBank_diqutextfield.placeholder=@"输入城市或区域查找选择网点";//初始化赋值
    self.BusinessBank_codetextfield.placeholder=@"商户邮箱查收";
    self.BusinessBank_diqutextfield.font=[UIFont boldSystemFontOfSize:13];
    
    UIBarButtonItem *wangcheng =[[UIBarButtonItem alloc] initWithTitle:@"关闭键盘" style:UIBarButtonItemStyleBordered target:self action:@selector(BusinessBankclosekey)];
    self.navigationItem.rightBarButtonItem =wangcheng;
    
    
    self.BusinessBankleibiearray=[[NSMutableArray alloc]init];
    [self.BusinessBankleibiearray addObject:@"个人账户"];
    [self.BusinessBankleibiearray addObject:@"对公账户"];
    
    [self.BusinessBankleibiearray addObject:@"邮储银行"];
    [self.BusinessBankleibiearray addObject:@"中国工商银行"];
    [self.BusinessBankleibiearray addObject:@"中国农业银行"];
    [self.BusinessBankleibiearray addObject:@"中国银行"];
    [self.BusinessBankleibiearray addObject:@"中国建设银行"];
    [self.BusinessBankleibiearray addObject:@"中信银行"];
    [self.BusinessBankleibiearray addObject:@"中国光大银行"];
    [self.BusinessBankleibiearray addObject:@"中国民生银行"];
    [self.BusinessBankleibiearray addObject:@"广东发展银行"];
    [self.BusinessBankleibiearray addObject:@"招商银行"];
    [self.BusinessBankleibiearray addObject:@"兴业银行"];
    
    
    
    [self.view addSubview:BusinessBank_scrollview];
    CGRect rx = [ UIScreen mainScreen ].bounds;//手机尺寸
    BusinessBank_scrollview.frame = CGRectMake(0, 0, 320,rx.size.height);
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
        BusinessBank_scrollview.center=CGPointMake(BusinessBank_scrollview.center.x,BusinessBank_scrollview.center.y+120);
    }
    //4S且6的系统
    else if (iphonenum==4&&(version == 6||version==6.1))
    {
        BusinessBank_scrollview.center=CGPointMake(BusinessBank_scrollview.center.x,BusinessBank_scrollview.center.y+130);
    }
    //4S但7的系统
    else if (iphonenum==4&&version>=7)
    {
        BusinessBank_scrollview.center=CGPointMake(BusinessBank_scrollview.center.x,BusinessBank_scrollview.center.y+145);
    }
   else if (iphonenum==5&&(version == 6||version==6.1))
    {
        BusinessBank_scrollview.center=CGPointMake(BusinessBank_scrollview.center.x,BusinessBank_scrollview.center.y+40);
    }
   else if (iphonenum==5&&version >= 7)
    {
        BusinessBank_scrollview.center=CGPointMake(BusinessBank_scrollview.center.x,BusinessBank_scrollview.center.y+58);
    }
    [BusinessBank_scrollview setContentSize:CGSizeMake(320,BusinessBank_scrollview.frame.size.height+180)];
    
    
    //下拉这块
    BankisOpened1=NO;
    
    [self.BusinessBankdownTab1 initTableViewDataSourceAndDelegate:^(UITableView *tableView,NSInteger section)
     {
         NSInteger i=2;
         return i;
         
     } setCellForIndexPathBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         BusinessBankdownCell *cell=[tableView dequeueReusableCellWithIdentifier:@"BusinessBankdownCell"];
         
         if (!cell)
         {
             cell=[[[NSBundle mainBundle]loadNibNamed:@"BusinessBankdownCell" owner:self options:nil]objectAtIndex:0];
             [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
         }
         cell.BusinessBankdownlab.text=[self.BusinessBankleibiearray objectAtIndex:indexPath.row];

         return cell;
     } setDidSelectRowBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         BusinessBankdownCell *cell=(BusinessBankdownCell*)[tableView cellForRowAtIndexPath:indexPath];
         self.BusinessBank_leibietextfield.text=cell.BusinessBankdownlab.text;
         [self.BusinessBank_leibieBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
         //选择了个人还是对公，前面name改变
//         self.BusinessBank_Namelabelname.text=@"个人姓名";
//         self.BusinessBank_Numlabelname.text=@"个人卡号";
     }];
    
    [self.BusinessBankdownTab1 .layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.BusinessBankdownTab1 .layer setBorderWidth:0];
    

    
    //下拉2
    BankisOpened2=NO;
    
    [self.BusinessBankdownTab2 initTableViewDataSourceAndDelegate:^(UITableView *tableView,NSInteger section)
     {
         NSInteger i=11;
         return i;
         
     } setCellForIndexPathBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         BusinessBankdownCell *cell=[tableView dequeueReusableCellWithIdentifier:@"BusinessBankdownCell"];
         
         if (!cell)
         {
             cell=[[[NSBundle mainBundle]loadNibNamed:@"BusinessBankdownCell" owner:self options:nil]objectAtIndex:0];
             [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
         }
//         [cell.BusinessBankdownlab setText:[NSString stringWithFormat:@"Select %d",indexPath.row]];
         cell.BusinessBankdownlab.text=[self.BusinessBankleibiearray objectAtIndex:indexPath.row+2];
         
         return cell;
     } setDidSelectRowBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         BusinessBankdownCell *cell=(BusinessBankdownCell*)[tableView cellForRowAtIndexPath:indexPath];
         self.BusinessBank_yinhangtextfield.text=cell.BusinessBankdownlab.text;
         [self.BusinessBank_yinghangBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
         
//         self.BusinessBank_Namelabelname.text=@"公司名称";
//         self.BusinessBank_Numlabelname.text=@"公司卡号";
     }];
    
    [self.BusinessBankdownTab2 .layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.BusinessBankdownTab2 .layer setBorderWidth:0];
    
    [self.BusinessBank_Nametextfield setDelegate:self];//名字
    [self.BusinessBank_Numtextfield setDelegate:self];
    [self.BusinessBank_diqutextfield setDelegate:self];
    [self.BusinessBank_codetextfield setDelegate:self];
    
    
    [self getBankDataFromServer];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)BusinessBankclosekey
{
    [self.BusinessBank_Nametextfield resignFirstResponder];//名字
    [self.BusinessBank_Numtextfield resignFirstResponder];
    [self.BusinessBank_diqutextfield resignFirstResponder];
    [self.BusinessBank_stateslabel resignFirstResponder];
    [self.BusinessBank_codetextfield resignFirstResponder];

}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ((textField == self.BusinessBank_Nametextfield) || (textField == self.BusinessBank_Numtextfield)||(textField == self.BusinessBank_diqutextfield)||(textField == self.BusinessBank_codetextfield)) {
        [textField resignFirstResponder];
    }
    return YES;
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField;
{
    if (textField == self.BusinessBank_Numtextfield)
    {
        
        [self showNumPadDone:nil];
        
    }
    else
    {
        [self hiddenNumPadDone:nil];
    }
    
}


//类别选择
-(IBAction)BusinessBankleibieBtn:(id)sender
{
    [self BusinessBankclosekey];

    if (BankisOpened1)
    {
        [UIView animateWithDuration:0.3 animations:^{
            UIImage *closeImage=[UIImage imageNamed:@"Button_down.png"];
            [self.BusinessBank_leibieBtn setImage:closeImage forState:UIControlStateNormal];
            
            CGRect frame=self.BusinessBankdownTab1.frame;
            
            frame.size.height=1;
            [self.BusinessBankdownTab1 setFrame:frame];
            
        } completion:^(BOOL finished){
            
            BankisOpened1=NO;
            
            if ([self.BusinessBank_leibietextfield.text isEqualToString: @"个人账户"])
            {
                self.BusinessBank_Namelabelname.text=@"个人姓名";
                self.BusinessBank_Numlabelname.text=@"个人卡号";
            }
            if ([self.BusinessBank_leibietextfield.text isEqualToString: @"对公账户"])
            {
                self.BusinessBank_Namelabelname.text=@"公司名称";
                self.BusinessBank_Numlabelname.text=@"公司卡号";
            }
        }];
    }
    else
    {
        [UIView animateWithDuration:0.3 animations:^{
            UIImage *openImage=[UIImage imageNamed:@"Button_up.png"];
            [self.BusinessBank_leibieBtn setImage:openImage forState:UIControlStateNormal];
            
            CGRect frame=self.BusinessBankdownTab1.frame;
            
            frame.size.height=80;
            [self.BusinessBankdownTab1 setFrame:frame];
        } completion:^(BOOL finished){
            
            BankisOpened1=YES;
        }];
    }

    

    

}
//银行
-(IBAction)BusinessBankyinhangBtn:(id)sender
{
    [self BusinessBankclosekey];
    
    
    if (BankisOpened2) {
        
        
        [UIView animateWithDuration:0.3 animations:^{
            UIImage *closeImage=[UIImage imageNamed:@"Button_down.png"];
            [self.BusinessBank_yinghangBtn setImage:closeImage forState:UIControlStateNormal];
            
            CGRect frame=self.BusinessBankdownTab2.frame;
            frame.size.height=1;
            [self.BusinessBankdownTab2 setFrame:frame];
            
        } completion:^(BOOL finished){
            
            BankisOpened2=NO;
        }];
    }else{
        
        
        [UIView animateWithDuration:0.3 animations:^{
            UIImage *openImage=[UIImage imageNamed:@"Button_up.png"];
            [self.BusinessBank_yinghangBtn setImage:openImage forState:UIControlStateNormal];
            
            CGRect frame=self.BusinessBankdownTab2.frame;
            
            frame.size.height=110;
            [self.BusinessBankdownTab2 setFrame:frame];
        } completion:^(BOOL finished){
            
            BankisOpened2=YES;
        }];
    }
    
}

//获取银行卡信息（原来的，新的）
-(void)getBankDataFromServer
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
    [httpClient request:@"GetMerchantBankCard.ashx" parameters:param successed:^(JSONDecoder *jsonDecoder, id responseObject) {
        NSData* data = [NSData dataWithData:responseObject];
        NSDictionary* handlJson = [jsonDecoder objectWithData:data];
        
        BankData*keyData = [[BankData alloc]initWithJsonObject:handlJson];
        
        BOOL success = [keyData.status boolValue];
        if (success)
        {
            [SVProgressHUD dismiss];
            
            self.BankDataDic=keyData.MctBankCard;
            
            [self PutDataToTextField];
            
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


//将数据传到界面上
-(void)PutDataToTextField;
{
    
    if ([[self.BankDataDic objectForKey:@"OldAccountCategory"]isEqualToString:@"3"]) {
        self.BusinessBank_OldNamelabelname.text=@"原公司名称:";
        self.BusinessBank_OldNumlabelname.text=@"公司账号:";
    }
    else if ([[self.BankDataDic objectForKey:@"OldAccountCategory"]isEqualToString:@"1"]) {
        self.BusinessBank_OldNamelabelname.text=@"原个人姓名:";
        self.BusinessBank_OldNumlabelname.text=@"个人账号:";
    }
    
    self.BusinessBank_OldNamelabel.text=[self.BankDataDic objectForKey:@"OldCardName"];
    self.BusinessBank_OldNumlabel.text=[self.BankDataDic objectForKey:@"OldCardNumber"];
    self.BusinessBank_OldBankNamelabel.text=[self.BankDataDic objectForKey:@"OldBankName"];
    self.BusinessBank_Oldwebbanklabel.text=[self.BankDataDic objectForKey:@"OldBranchName"];
    if ([[NSString stringWithFormat:@"%@",[self.BankDataDic objectForKey:@"NewAccountCategory"]]isEqualToString:@"<null>"])
    {
        return;
    }
    else
    {
    
    if ([[self.BankDataDic objectForKey:@"NewAccountCategory"]isEqualToString:@"3"]) {
        self.BusinessBank_leibietextfield.text=@"对公账户";
        self.BusinessBank_Namelabelname.text=@"公司名称:";
        self.BusinessBank_Numlabelname.text=@"公司账号:";
    }
    else if ([[self.BankDataDic objectForKey:@"NewAccountCategory"]isEqualToString:@"1"]) {
        self.BusinessBank_leibietextfield.text=@"个人账户";
        self.BusinessBank_Namelabelname.text=@"个人姓名:";
        self.BusinessBank_Numlabelname.text=@"个人账号:";
    }
    //////////////////////////////////////
    self.BusinessBank_Nametextfield.text=[self.BankDataDic objectForKey:@"NewCardName"];
    self.BusinessBank_Numtextfield.text=[self.BankDataDic objectForKey:@"NewCardNumber"];
    if ([[NSString stringWithFormat:@"%@",[self.BankDataDic objectForKey:@"NewBankName"]] isEqualToString:@"<null>"])
    {
         self.BusinessBank_yinhangtextfield.text=@"";
    }
    else
    {
        self.BusinessBank_yinhangtextfield.text=[NSString stringWithFormat:@"%@",[self.BankDataDic objectForKey:@"NewBankName"]];
    }
    self.BusinessBank_stateslabel.text=[self.BankDataDic objectForKey:@"NewFeedBackMsg"];
    }
}





//获取网点
-(void)getBankWebDataFromServer
{
    if (self.BusinessBank_yinhangtextfield.text==nil||[self.BusinessBank_yinhangtextfield.text isEqualToString:@""]) {
    [SVProgressHUD showErrorWithStatus:@"请先选择银行..."];
        return;
    }
    
  //找到银行代码
    for (int ii=0; ii<self.BusinessBankleibiearray.count; ii++)
    {
        if ([self.BusinessBank_yinhangtextfield.text isEqualToString:[self.BusinessBankleibiearray objectAtIndex:ii]])
        {
            orgCode=[self.Bankcodearray objectAtIndex:ii-2];
            break;
        }
    }
    
    if (self.BusinessBank_diqutextfield.text==nil||[self.BusinessBank_diqutextfield.text isEqualToString:@""])
    {
        self.BusinessBank_diqutextfield.text=@"";
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
                           orgCode,@"orgCode",
                           self.BusinessBank_diqutextfield.text,@"orgName",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中..."];
    [httpClient request:@"CNAPSList.ashx" parameters:param successed:^(JSONDecoder *jsonDecoder, id responseObject) {
        NSData* data = [NSData dataWithData:responseObject];
        NSDictionary* handlJson = [jsonDecoder objectWithData:data];
        
        BankwebData*keyData = [[BankwebData alloc]initWithJsonObject:handlJson];
        
        BOOL success = [keyData.status boolValue];
        if (success)
        {
            [SVProgressHUD dismiss];
            [self.Bankwebarray removeAllObjects];
            [self.Bankwebarray addObjectsFromArray:keyData.cNAPSInfo];
            
            [self.BusinessBankweb reloadData];
            [self sendWebDatatoTable];
            
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

//tablew网点信息
-(void)sendWebDatatoTable
{
    CGRect frame=self.BusinessBankweb.frame;
    frame.size.height=150;
    [self.BusinessBankweb setFrame:frame];
    
    [self.BusinessBankweb initTableViewDataSourceAndDelegate:^(UITableView *tableView,NSInteger section)
     {
         NSInteger iii=self.Bankwebarray.count;
         
        return iii;
         
     } setCellForIndexPathBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         BankWebpointCell *cell=[tableView dequeueReusableCellWithIdentifier:@"BankWebpointCell"];
         
         if (!cell)
         {
             cell=[[[NSBundle mainBundle]loadNibNamed:@"BankWebpointCell" owner:self options:nil]objectAtIndex:0];
             [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
         }

         BankwebDetailData*webdata=[self.Bankwebarray objectAtIndex:indexPath.row];
         cell.BusinessBankWebpointlab.text=webdata.OrgName;
         cell.BusinessBankWebpointlab.font=[UIFont boldSystemFontOfSize:12];
         return cell;
     } setDidSelectRowBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         BankWebpointCell *cell=(BankWebpointCell*)[tableView cellForRowAtIndexPath:indexPath];
         self.BusinessBank_diqutextfield.text=cell.BusinessBankWebpointlab.text;
//         [self.BusinessBank_yinghangBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
         CGRect frame=self.BusinessBankweb.frame;
         frame.size.height=0;
         [self.BusinessBankweb setFrame:frame];

     }];
    
    [self.BusinessBankweb .layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.BusinessBankweb .layer setBorderWidth:0];

    
}


//网点
//查询
-(IBAction)BusinessBankchaxunBtn:(id)sender
{
    [self BusinessBankclosekey];

    [self getBankWebDataFromServer];
    
}

//发送验证码
-(void)GetbankcodeFromServerToE_mail
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
                           @"22",@"type",
                           nil];
    [SVProgressHUD showWithStatus:@"正在发送..."];
    [httpClient request:@"SendEmailCode.ashx" parameters:param successed:^(JSONDecoder *jsonDecoder, id responseObject) {
        NSData* data = [NSData dataWithData:responseObject];
        NSDictionary* handlJson = [jsonDecoder objectWithData:data];
        SaveData*keyData = [[SaveData alloc]initWithJsonObject:handlJson];
        
        BOOL success = [keyData.status boolValue];
        
        if (success)
        {
            [SVProgressHUD dismiss];
            
            [NSTimer scheduledTimerWithTimeInterval:120.0 target:self selector:@selector(changetimer) userInfo:nil repeats:NO];
            
            [SVProgressHUD showSuccessWithStatus:keyData.msg];
            
            Banktimer=120;
            
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:keyData.msg];
        }
        
        
    } failured:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:error.description];
    }];

    
}


-(void)changetimer
{
    Banktimer=0;
}
-(IBAction)getBankcodeforme_mail:(id)sender
{


    if (Banktimer==120)
    {
        UIAlertView *alerv = [[UIAlertView alloc] initWithTitle:@"错误" message:@"若未收到邮件请2分钟后再获取" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alerv show];
        return;
    }
    else if(Banktimer==0)
    {

        [self GetbankcodeFromServerToE_mail];
        //请求：：
    }

    
}


//保存
-(IBAction)BusinessBanksaveBtn:(id)sender
{
    [self BusinessBankclosekey];

    UIAlertView *alerv = [[UIAlertView alloc] initWithTitle:@"输入银行卡变更理由!" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
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
            [self SaveBankDataToServer:tf.text];
            return;
            
        }
    }
    
    
}



-(void)SaveBankDataToServer:(NSString*)reasonChange
{
    if (self.BusinessBank_leibietextfield.text==nil||[self.BusinessBank_leibietextfield.text isEqualToString:@""])
    {
        [SVProgressHUD showErrorWithStatus:@"请选择账户类别"];
        return;
    }
    else if (self.BusinessBank_Nametextfield.text==nil||[self.BusinessBank_Nametextfield.text isEqualToString:@""])
    {
        [SVProgressHUD showErrorWithStatus:@"请填写名称"];
        return;
    }
    else if (self.BusinessBank_Numtextfield.text==nil||[self.BusinessBank_Numtextfield.text isEqualToString:@""])
    {
        [SVProgressHUD showErrorWithStatus:@"请填写账号"];
        return;
    }
   else if (self.BusinessBank_yinhangtextfield.text==nil||[self.BusinessBank_yinhangtextfield.text isEqualToString:@""])
    {
        [SVProgressHUD showErrorWithStatus:@"请选择银行"];
        return;
    }
   else if (self.BusinessBank_diqutextfield.text==nil||[self.BusinessBank_diqutextfield.text isEqualToString:@""])
   {
       [SVProgressHUD showErrorWithStatus:@"请填写网点"];
       return;
   }
    
    for (int ii=0; ii<self.BusinessBankleibiearray.count; ii++)
    {
        if ([self.BusinessBank_yinhangtextfield.text isEqualToString:[self.BusinessBankleibiearray objectAtIndex:ii]])
        {
            orgCode=[self.Bankcodearray objectAtIndex:ii-2];
            break;
        }
    }
    
    NSString *branchCode;//网点代码；；
    NSString *accountCategory;//账户类型；
    
    for (int jj=0; jj<self.Bankwebarray.count; jj++) {
        BankwebDetailData*webdata=[self.Bankwebarray objectAtIndex:jj];
        if ([self.BusinessBank_diqutextfield.text isEqualToString:webdata.OrgName])
        {
            branchCode=webdata.OrgValue;
            break;
        }
        
    }
    
    if ([branchCode isEqualToString:@""]||branchCode ==nil)
    {
        [SVProgressHUD showErrorWithStatus:@"请选择正确网点"];
        return;
    }
    
    if ( [self.BusinessBank_leibietextfield.text isEqualToString:@"个人账户"])
    {
        accountCategory=@"1";
    }
    else if([self.BusinessBank_leibietextfield.text isEqualToString:@"对公账户"])
    {
        accountCategory=@"3";
 
    }
    
    NSString * bankCardChangeApplicationID;
    NSString * operation;
    if ([[NSString stringWithFormat:@"%@",[self.BankDataDic objectForKey:@"BankCardChangeApplicationID"]] isEqualToString:@"<null>"])
    {
       bankCardChangeApplicationID=@"0";
        operation=@"1";
    }else
    {
        bankCardChangeApplicationID=[self.BankDataDic objectForKey:@"BankCardChangeApplicationID"];
        operation=@"2";
    }

    
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
                           bankCardChangeApplicationID ,@"bankCardChangeApplicationID",
                           operation,@"operation",
                           self.BusinessBank_Nametextfield.text,@"name",
                           self.BusinessBank_yinhangtextfield.text,@"bankName",
                           orgCode,@"bankCode",
                           branchCode,@"branchCode",
                           self.BusinessBank_diqutextfield.text,@"branchName",
                           self.BusinessBank_Numtextfield.text,@"cardNumber",
                           accountCategory,@"accountCategory",
                           reasonChange,@"reasonChange",
                           self.BusinessBank_codetextfield.text,@"emailCode",
                           nil];
    

    [SVProgressHUD showWithStatus:@"正在提交数据..."];
    
    [httpClient request:@"MerchantBankCardSubmit.ashx" parameters:param successed:^(JSONDecoder *jsonDecoder, id responseObject) {
        
        NSData* data = [NSData dataWithData:responseObject];
        NSDictionary* handlJson = [jsonDecoder objectWithData:data];
        SaveData *keyData = [[SaveData alloc]initWithJsonObject:handlJson];
        BOOL success = [keyData.status boolValue];
        if (success)
        {
            [SVProgressHUD dismiss];
            [SVProgressHUD showSuccessWithStatus:@"银行卡变更信息提交成功!"];
            
            [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(gobackview) userInfo:nil repeats:NO];

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

-(void)gobackview
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}




@end
