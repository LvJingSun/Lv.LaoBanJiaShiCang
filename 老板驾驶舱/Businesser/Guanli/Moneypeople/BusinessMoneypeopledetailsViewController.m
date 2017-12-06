//
//  BusinessMoneypeopledetailsViewController.m
//  BusinessCenter
//
//  Created by 冯海强 on 13-11-22.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import "BusinessMoneypeopledetailsViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "BusinessmoneypeopledownCell.h"
#import "UITableView+DataSourceBlocks.h"
#import "TableViewWithBlock.h"
#import "SaveData.h"
#import "HttpClientRequest.h"
#import "SVProgressHUD.h"

@interface BusinessMoneypeopledetailsViewController ()

@property(nonatomic,weak)IBOutlet UIButton*BusinessMoneypeopledetails_Headphotobtn;//头像

@property(nonatomic,weak)IBOutlet UITextField *BusinessMoneypeopledetails_Shopnamefield;//所属店名
@property(nonatomic,weak)IBOutlet UIButton *BusinessMoneypeopledetails_ShopnameBtn;//所属店名按钮

@property(nonatomic,weak)IBOutlet UITextField *BusinessMoneypeopledetails_Namefield;//姓名
@property(nonatomic,weak)IBOutlet UITextField *BusinessMoneypeopledetails_Numfield;//帐号
@property(nonatomic,weak)IBOutlet UITextField *BusinessMoneypeopledetails_zhuangtaifield;//状态
@property(nonatomic,weak)IBOutlet UIButton *BusinessMoneypeopledetails_zhuangtaiBtn;//状态按钮

@property(nonatomic,weak)IBOutlet UITextField *BusinessMoneypeopledetails_Passwordfield;//密码
@property(nonatomic,weak)IBOutlet UITextField *BusinessMoneypeopledetails_Againwordfield;//确认密码
@property(nonatomic,weak)IBOutlet UILabel *BusinessMoneypeopledetails_IPlabel;//IP地址
@property(nonatomic,weak)IBOutlet UILabel *BusinessMoneypeopledetails_Firsttimelabel;//创建时间
@property(nonatomic,weak)IBOutlet UILabel *BusinessMoneypeopledetails_Lasttimelabel;//最后登陆

@property(nonatomic,strong)NSMutableArray*Business_moneypeoplzhuangtaiearray;//状态数组

@property(nonatomic,strong)NSMutableArray*Business_moneypeopleshopnamearray;//店铺名数组

@end

@implementation BusinessMoneypeopledetailsViewController

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
    //隐藏状态栏
  //  [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSUserDefaults*product=[NSUserDefaults standardUserDefaults];
    NSString *str = [NSString stringWithFormat:@"%@",[product objectForKey:@"Addmoneypeople"]];
    if (str.intValue==2){
        self.title=@"增加收银员";
    }
    if (str.intValue==1){
        self.title=@"收银员信息";
    }
    
    self.BusinessMoneypeopledetails_Shopnamefield.text=self.moneydetail.ShopName;
    self.BusinessMoneypeopledetails_Namefield.text=self.moneydetail.Name;
    self.BusinessMoneypeopledetails_Numfield.text=self.moneydetail.Account;
    if ([self.moneydetail.Status isEqualToString:@"Normal"])
    {
        self.BusinessMoneypeopledetails_zhuangtaifield.text=@"正常";
    }
    else if ([self.moneydetail.Status isEqualToString:@"Locking"])
    {
        self.BusinessMoneypeopledetails_zhuangtaifield.text=@"锁定";
    }
    else if ([self.moneydetail.Status isEqualToString:@"AppLocked"])
    {
        self.BusinessMoneypeopledetails_zhuangtaifield.text=@"APP锁定";
    }
    
        
    //////////密码
    self.BusinessMoneypeopledetails_IPlabel.text=self.moneydetail.LoginIp;
    self.BusinessMoneypeopledetails_Firsttimelabel.text=self.moneydetail.CreateTime;
    self.BusinessMoneypeopledetails_Lasttimelabel.text=self.moneydetail.LoginTime;
    
    
    
    self.BusinessMoneypeopledetails_zhuangtaifield.enabled=NO;
    self.BusinessMoneypeopledetails_Shopnamefield.enabled=NO;
    
    self.BusinessMoneypeopledetails_Passwordfield.secureTextEntry=YES ;//密码
    self.BusinessMoneypeopledetails_Againwordfield.secureTextEntry=YES ;//确认密码
    
    self.BusinessMoneypeopledetails_Shopnamefield.placeholder=@"请选择……";

    self.BusinessMoneypeopledetails_zhuangtaifield.placeholder=@"请选择……";
    
    UIBarButtonItem *wangcheng =[[UIBarButtonItem alloc] initWithTitle:@"关闭键盘" style:UIBarButtonItemStyleBordered target:self action:@selector(BusinessMoneydetailseclosekey)];
    self.navigationItem.rightBarButtonItem =wangcheng;
    
    self.Business_moneypeoplzhuangtaiearray=[[NSMutableArray alloc]init];
    [self.Business_moneypeoplzhuangtaiearray addObject:@"正常"];
    [self.Business_moneypeoplzhuangtaiearray addObject:@"锁定"];
    [self.Business_moneypeoplzhuangtaiearray addObject:@"APP锁定"];
    
    [self.view addSubview:BusinessMoneypeopledetails_scrollview];
    CGRect rx = [ UIScreen mainScreen ].bounds;//手机尺寸
    BusinessMoneypeopledetails_scrollview.frame = CGRectMake(0, 0, 320,rx.size.height);
    
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
        BusinessMoneypeopledetails_scrollview.center=CGPointMake(BusinessMoneypeopledetails_scrollview.center.x,BusinessMoneypeopledetails_scrollview.center.y+120);
    }
    
    //4S且6的系统
    if (iphonenum==4&&(version == 6||version==6.1))
    {
        BusinessMoneypeopledetails_scrollview.center=CGPointMake(BusinessMoneypeopledetails_scrollview.center.x,BusinessMoneypeopledetails_scrollview.center.y+130);
        
    }
    //4S但7的系统
    if (iphonenum==4&&version>=7)
    {
        BusinessMoneypeopledetails_scrollview.center=CGPointMake(BusinessMoneypeopledetails_scrollview.center.x,BusinessMoneypeopledetails_scrollview.center.y+150);
    }
    if (iphonenum==5&&(version == 6||version==6.1))
    {
        BusinessMoneypeopledetails_scrollview.center=CGPointMake(BusinessMoneypeopledetails_scrollview.center.x,BusinessMoneypeopledetails_scrollview.center.y+40);
    }
    if (iphonenum==5&&version >= 7)
    {
        BusinessMoneypeopledetails_scrollview.center=CGPointMake(BusinessMoneypeopledetails_scrollview.center.x,BusinessMoneypeopledetails_scrollview.center.y+60);
    }
    [BusinessMoneypeopledetails_scrollview setContentSize:CGSizeMake(320,BusinessMoneypeopledetails_scrollview.frame.size.height+210)];
    
    
    //状态
    //下拉这块
    moneypeoisOpened=NO;
    
    [self.moneypeodownTab initTableViewDataSourceAndDelegate:^(UITableView *tableView,NSInteger section)
     {
         NSInteger i=self.Business_moneypeoplzhuangtaiearray.count;
         return i;
         
     } setCellForIndexPathBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         BusinessmoneypeopledownCell *cell=[tableView dequeueReusableCellWithIdentifier:@"BusinessmoneypeopledownCell"];
         
         if (!cell)
         {
             cell=[[[NSBundle mainBundle]loadNibNamed:@"BusinessmoneypeopledownCell" owner:self options:nil]objectAtIndex:0];
             [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
         }
//         [cell.moneypeodownlab setText:[NSString stringWithFormat:@"Select %d",indexPath.row]];
         cell.moneypeodownlab.text=[self.Business_moneypeoplzhuangtaiearray objectAtIndex:indexPath.row];
         
         return cell;
     } setDidSelectRowBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         BusinessmoneypeopledownCell *cell=(BusinessmoneypeopledownCell*)[tableView cellForRowAtIndexPath:indexPath];
         self.BusinessMoneypeopledetails_zhuangtaifield.text=cell.moneypeodownlab.text;
         [self.BusinessMoneypeopledetails_zhuangtaiBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
     }];
    
    [self.moneypeodownTab .layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.moneypeodownTab .layer setBorderWidth:0];

    
   //shop
    //下拉这块
    moneypeoisOpened2=NO;
    
    [self.moneypeodownTab2 initTableViewDataSourceAndDelegate:^(UITableView *tableView,NSInteger section)
     {
         NSInteger count=self.moneydetailarray.count;
         return count;
         
     } setCellForIndexPathBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         BusinessmoneypeopledownCell *cell=[tableView dequeueReusableCellWithIdentifier:@"BusinessmoneypeopledownCell"];
         
         if (!cell)
         {
             cell=[[[NSBundle mainBundle]loadNibNamed:@"BusinessmoneypeopledownCell" owner:self options:nil]objectAtIndex:0];
             [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
         }
         
         
         ShopDetailData *data = [self.moneydetailarray objectAtIndex:indexPath.row];
      [cell.moneypeodownlab setText:[NSString stringWithFormat:@"%@",data.ShopName]];
         
         return cell;
     } setDidSelectRowBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         BusinessmoneypeopledownCell *cell=(BusinessmoneypeopledownCell*)[tableView cellForRowAtIndexPath:indexPath];
         self.BusinessMoneypeopledetails_Shopnamefield.text=cell.moneypeodownlab.text;
         [self.BusinessMoneypeopledetails_ShopnameBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
     }];
    
    [self.moneypeodownTab2 .layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.moneypeodownTab2 .layer setBorderWidth:0];
    

    self.BusinessMoneypeopledetails_Passwordfield.placeholder=@"收银密码不想修改,保存为空。";
    [self.BusinessMoneypeopledetails_Namefield setDelegate:self];//姓名
    [self.BusinessMoneypeopledetails_Numfield setDelegate:self];//帐号
    [self.BusinessMoneypeopledetails_Passwordfield setDelegate:self];//密码
    [self.BusinessMoneypeopledetails_Againwordfield setDelegate:self];//确认密码


    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ((textField == self.BusinessMoneypeopledetails_Namefield) || (textField == self.BusinessMoneypeopledetails_Numfield)||(textField == self.BusinessMoneypeopledetails_Passwordfield)||(textField == self.BusinessMoneypeopledetails_Againwordfield)) {
        [textField resignFirstResponder];
    }
    return YES;
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    UIView *view = (UIView *)[touch view];
    if (view == self.view) {

        [self BusinessMoneydetailseclosekey];
    }
}


-(void)BusinessMoneydetailseclosekey
{
    
    [self.BusinessMoneypeopledetails_Namefield resignFirstResponder];//姓名
    [self.BusinessMoneypeopledetails_Numfield resignFirstResponder];//帐号
    [self.BusinessMoneypeopledetails_Passwordfield resignFirstResponder];//密码
    [self.BusinessMoneypeopledetails_Againwordfield resignFirstResponder];//确认密码

}


-(IBAction)Moneypeopleheadphoto:(id)sender
{
    UIActionSheet *sheet;
    
    sheet  = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
    
    sheet.tag = 1;
    [sheet showInView:self.view];

    
}


- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 获取沙盒目录
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    // 将图片写入文件
    [imageData writeToFile:fullPath atomically:NO];
}



//替换图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *image=[[UIImage alloc]init];
    if (pickerorphoto==0)
    {
        image = [info objectForKey:UIImagePickerControllerEditedImage];
    }else if (pickerorphoto==1)
    {
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    [self saveImage:image withName:@"currentImage.png"];
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    [self.BusinessMoneypeopledetails_Headphotobtn setImage:savedImage forState:UIControlStateNormal];


    //从相册拿照片；
}



-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 1)
    {
        //打开照相
        if (buttonIndex==0)
        {
            pickerorphoto=1;
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
                UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                imagePicker.delegate = self;
                //imagePicker.allowsImageEditing = YES;
                imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                [self presentViewController:imagePicker animated:YES completion:^{}];
            }
            else{
                //如果没有提示用户
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"错误" message:@"手机没有摄像头" delegate:nil cancelButtonTitle:@"确定!" otherButtonTitles:nil];
                [alert show];
            }
        }
        
        //打开相册
        if (buttonIndex ==1) {
            pickerorphoto=0;
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];//打开照片文件
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            [self presentViewController:imagePicker animated:YES completion:^{
            }];
        }
        
    }
}




-(IBAction)BusinessMoneypeopledetails_shop:(UIButton*)sender
{
    [self BusinessMoneydetailseclosekey];

    
    if (moneypeoisOpened2) {
        
        
        [UIView animateWithDuration:0.3 animations:^{
            UIImage *closeImage=[UIImage imageNamed:@"Button_down.png"];
            [self.BusinessMoneypeopledetails_ShopnameBtn setImage:closeImage forState:UIControlStateNormal];
            
            CGRect frame=self.moneypeodownTab2.frame;
            
            frame.size.height=1;
            [self.moneypeodownTab2 setFrame:frame];
            
        } completion:^(BOOL finished){
            
            moneypeoisOpened2=NO;
        }];
    }else{
        
        
        [UIView animateWithDuration:0.3 animations:^{
            UIImage *openImage=[UIImage imageNamed:@"Button_up.png"];
            [self.BusinessMoneypeopledetails_ShopnameBtn setImage:openImage forState:UIControlStateNormal];
            
            CGRect frame=self.moneypeodownTab2.frame;
            
            frame.size.height=90;
            [self.moneypeodownTab2 setFrame:frame];
        } completion:^(BOOL finished){
            
            moneypeoisOpened2=YES;
        }];
        
    }

    
    
    
    
}




-(IBAction)BusinessMoneypeopledetails_zhuangtai:(UIButton*)sender
{
    [self BusinessMoneydetailseclosekey];

    
    if (moneypeoisOpened) {
        
        
        [UIView animateWithDuration:0.3 animations:^{
            UIImage *closeImage=[UIImage imageNamed:@"Button_down.png"];
            [self.BusinessMoneypeopledetails_zhuangtaiBtn setImage:closeImage forState:UIControlStateNormal];
            
            CGRect frame=self.moneypeodownTab.frame;
            
            frame.size.height=1;
            [self.moneypeodownTab setFrame:frame];
            
        } completion:^(BOOL finished){
            
            moneypeoisOpened=NO;
        }];
    }else{
        
        
        [UIView animateWithDuration:0.3 animations:^{
            UIImage *openImage=[UIImage imageNamed:@"Button_up.png"];
            [self.BusinessMoneypeopledetails_zhuangtaiBtn setImage:openImage forState:UIControlStateNormal];
            
            CGRect frame=self.moneypeodownTab.frame;
            
            frame.size.height=100;
            [self.moneypeodownTab setFrame:frame];
        } completion:^(BOOL finished){
            
            moneypeoisOpened=YES;
        }];
        
        
    }
    
}

-(IBAction)BusinessMoneypeopledetails_SaveBtn:(UIButton*)sender
{
    [self BusinessMoneydetailseclosekey];
    [self CashierSendToServer];
}

-(void)POPlastview
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

//保存收银员信息
-(void)CashierSendToServer
{
    NSString *option;
    NSString *cashierAccountID;//账户ID
    NSString *merchantShopID;
    NSString *status;//状态
    NSString *password;
    NSString *aginpassword;

    if (self.BusinessMoneypeopledetails_Passwordfield.text==nil||self.BusinessMoneypeopledetails_Againwordfield.text==nil)
    {
        password=@"";aginpassword=@"";
    }
    else
    {
        password=self.BusinessMoneypeopledetails_Passwordfield.text;
        aginpassword=self.BusinessMoneypeopledetails_Againwordfield.text;
    }
    
    if ([self.title isEqualToString:@"增加收银员"])
    {
        option=@"1";
        cashierAccountID=@"0";
    }
    else if ([self.title isEqualToString:@"收银员信息"])
    {
        option=@"2";
        cashierAccountID=self.moneydetail.CashierAccountID;
        
    }
    
    for (int i=0 ;i<self.moneydetailarray.count; i++) {
        ShopDetailData *shop = [self.moneydetailarray objectAtIndex:i];
        if ([[NSString stringWithFormat:@"%@",self.BusinessMoneypeopledetails_Shopnamefield.text] isEqualToString:shop.ShopName])
        {
            merchantShopID=shop.MerchantShopId;
            break;
        }
    }

    
    if ([self.BusinessMoneypeopledetails_zhuangtaifield.text isEqualToString:@"正常"])
    {
        status=@"Normal";
    }
    else if ([self.BusinessMoneypeopledetails_zhuangtaifield.text isEqualToString:@"锁定"])
    {
        status=@"Locking";
    }
    else if ([self.BusinessMoneypeopledetails_zhuangtaifield.text isEqualToString:@"APP锁定"])
    {
        status=@"AppLocked";
    }

    if ([self.BusinessMoneypeopledetails_Shopnamefield.text isEqualToString:@""]||self.BusinessMoneypeopledetails_Shopnamefield.text==nil)
    {
        [SVProgressHUD showErrorWithStatus:@"请选择店铺"];
        return;
    }
    else  if ([self.BusinessMoneypeopledetails_Namefield.text isEqualToString:@""]||self.BusinessMoneypeopledetails_Namefield.text==nil)
    {
        [SVProgressHUD showErrorWithStatus:@"请输入姓名"];
        return;
    }
    else  if ([self.BusinessMoneypeopledetails_Numfield.text isEqualToString:@""]||self.BusinessMoneypeopledetails_Numfield.text==nil)
    {
        [SVProgressHUD showErrorWithStatus:@"请输入帐号"];
        return;
    }
    else  if ([self.BusinessMoneypeopledetails_zhuangtaifield.text isEqualToString:@""]||self.BusinessMoneypeopledetails_zhuangtaifield.text==nil)
    {
        [SVProgressHUD showErrorWithStatus:@"请选择状态"];
        return;
    }
    else if([option isEqualToString:@"1"])
    {
        if ([self.BusinessMoneypeopledetails_Passwordfield.text isEqualToString:@""]||self.BusinessMoneypeopledetails_Passwordfield.text==nil)
    {
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        return;
    }
    else  if ([self.BusinessMoneypeopledetails_Againwordfield.text isEqualToString:@""]||self.BusinessMoneypeopledetails_Againwordfield.text==nil)
    {
        [SVProgressHUD showErrorWithStatus:@"请输入确认密码"];
        return;
    }
    else  if (![self.BusinessMoneypeopledetails_Passwordfield.text isEqualToString:self.BusinessMoneypeopledetails_Againwordfield.text])
    {
        [SVProgressHUD showErrorWithStatus:@"两次密码输入不一样"];
        return;
    }
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
                           self.BusinessMoneypeopledetails_Numfield.text,@"account",
                           cashierAccountID,@"cashierAccountID",
                           memberId, @"memberId",
                           merchantShopID,@"merchantShopID",
                           option,@"option",
                           self.BusinessMoneypeopledetails_Namefield.text,@"realName",
                           status,@"status",
                           password,@"password",
                           aginpassword,@"confrimPassword",
                           nil];
    [SVProgressHUD showWithStatus:@"数据提交中..."];
    
    [httpClient request:@"CashierSubmit.ashx" parameters:param successed:^(JSONDecoder *jsonDecoder, id responseObject) {
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [jsonDecoder objectWithData:data];
        
        SaveData *keyData = [[SaveData alloc]initWithJsonObject:handlJson];
        
        BOOL success = [keyData.status boolValue];
        
        if (success)
        {
            [SVProgressHUD dismiss];
            [SVProgressHUD showSuccessWithStatus:keyData.msg];
            [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(POPlastview) userInfo:nil repeats:NO];
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







@end
