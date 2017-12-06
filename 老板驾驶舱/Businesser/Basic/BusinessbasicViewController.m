//
//  BusinessbasicViewController.m
//  BusinessCenter
//
//  Created by 冯海强 on 13-11-21.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import "BusinessbasicViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "BusinessfenleiCell.h"
#import "UITableView+DataSourceBlocks.h"
#import "TableViewWithBlock.h"

#import "SVProgressHUD.h"
#import "BasicFatherSoonData.h"
#import "HttpClientRequest.h"
#import "BasicData.h"

#import "SaveData.h"


@interface BusinessbasicViewController ()

@property(nonatomic,weak)IBOutlet UIButton*Businessbasic_Headphotoimagebtn;//头像按钮

@property(nonatomic,weak)IBOutlet UITextField*Businessbasic_Typetextfield1;//类别
@property(nonatomic,weak)IBOutlet UITextField*Businessbasic_Typetextfield2;//类别2
@property(nonatomic,weak)IBOutlet UIButton*Businessbasic_TypeButton1;//按钮1
@property(nonatomic,weak)IBOutlet UIButton*Businessbasic_TypeButton2;//按钮2
@property(nonatomic,weak)IBOutlet UITextField*Businessbasic_Nametextfield;//公司名称
@property(nonatomic,weak)IBOutlet UITextField*Businessbasic_Smallnametypetextfield;//简称
@property(nonatomic,weak)IBOutlet UITextField*Businessbasic_Phonetextfield;//电话
@property(nonatomic,weak)IBOutlet UITextField*Businessbasic_Webtextfield;//网站
@property(nonatomic,weak)IBOutlet UITextView * Businessbasic_introducetextfield;//介绍

////

@end



@implementation BusinessbasicViewController

@synthesize m_imagDic;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        fatherindexrow=@"1";
        self.B_Fatherarray=[[NSMutableArray alloc]initWithCapacity:0];
        self.B_Soonarray=[[NSMutableArray alloc]initWithCapacity:0];
        self.BasicDic=[[NSMutableDictionary alloc]initWithCapacity:0];
        [self getDataFromServerFather];
        [self GetallDataFromServer];

        
        // 初始化字典
        m_imagDic = [[NSMutableDictionary alloc]initWithCapacity:0];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //隐藏状态栏
   // [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    NSData *imageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"PhotoMidUrl_B"];
    if(imageData != nil)
    {
        [self.Businessbasic_Headphotoimagebtn setImage: [NSKeyedUnarchiver unarchiveObjectWithData: imageData] forState:UIControlStateNormal];
    }
    
    
    self.title=@"基本信息";
    
    self.Businessbasic_Typetextfield1.enabled=NO;
    self.Businessbasic_Typetextfield2.enabled=NO;//类别
    
    self.Businessbasic_Typetextfield1.placeholder=@"请选择……";
    self.Businessbasic_Typetextfield2.placeholder=@"请选择……";
    
    UIBarButtonItem *wangcheng =[[UIBarButtonItem alloc] initWithTitle:@"关闭键盘" style:UIBarButtonItemStyleBordered target:self action:@selector(Businesserclosekey)];
    self.navigationItem.rightBarButtonItem =wangcheng;
    
    
//    [self.view addSubview:Businessbasic_scrollview];
    CGRect rx = [ UIScreen mainScreen ].bounds;//手机尺寸
    Businessbasic_scrollview.frame = CGRectMake(0, 0, 320,rx.size.height);
    
    //判别手机以及当前系统的
    
    double version = [[UIDevice currentDevice].systemVersion doubleValue];//判定系统版本。
    if(rx.size.height == 480.f)
    {iphonenum=4;
    }
    else
    {iphonenum=5;
    }
    //4前的系统
    if (iphonenum==4&&version<6)
    {Businessbasic_scrollview.center=CGPointMake(Businessbasic_scrollview.center.x,Businessbasic_scrollview.center.y+120);
    }
    
    //4S且6的系统
   else if (iphonenum==4&&(version == 6||version==6.1))
    {
        Businessbasic_scrollview.center=CGPointMake(Businessbasic_scrollview.center.x,Businessbasic_scrollview.center.y+135);
    }
 //////////////////////   //4S但7的系统
   else if (iphonenum==4&&version>=7)
    {
        Businessbasic_scrollview.center=CGPointMake(Businessbasic_scrollview.center.x,Businessbasic_scrollview.center.y+150);
    }
   else if (iphonenum==5&&(version == 6||version==6.1))
    {
        Businessbasic_scrollview.center=CGPointMake(Businessbasic_scrollview.center.x,Businessbasic_scrollview.center.y+45);
    }
   else if (iphonenum==5&&version >= 7)
    {
        Businessbasic_scrollview.center=CGPointMake(Businessbasic_scrollview.center.x,Businessbasic_scrollview.center.y+60);
    }
    
    if (iPhone5)
    {
        [Businessbasic_scrollview setContentSize:CGSizeMake(320,Businessbasic_scrollview.frame.size.height+280)];

    }else
    {
        [Businessbasic_scrollview setContentSize:CGSizeMake(320,Businessbasic_scrollview.frame.size.height+365)];
    }
    
    Businessbasic_scrollview.canCancelContentTouches = YES;

    //下拉这块
    jibenisOpened1=NO;
    jibenisOpened2=NO;

    self.Businessbasic_Nametextfield.delegate=self;
    self.Businessbasic_Smallnametypetextfield.delegate=self;
    self.Businessbasic_Phonetextfield.delegate=self;
    self.Businessbasic_Webtextfield.delegate=self;

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ((textField == self.Businessbasic_Nametextfield) || (textField == self.Businessbasic_Smallnametypetextfield)||(textField == self.Businessbasic_Phonetextfield)||(textField ==self.Businessbasic_Webtextfield)) {
        [textField resignFirstResponder];
    }
    return YES;
    
}


-(void)getDataFromServerFather
{

    
    MainViewController*mainVC=[MainViewController shareobject];
    // 判断网络是否存在
    if ( ![mainVC isConnectionAvailable] )
    {
        return;
    }
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    NSString*memberId=[userDefau objectForKey:@"memberId"];
    NSString*pClassID=@"0";
    
    HttpClientRequest *httpClient = [HttpClientRequest sharedInstance];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId, @"memberId",
                           pClassID,@"pClassID",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中..."];
    [httpClient request:@"MerchantClass.ashx" parameters:param successed:^(JSONDecoder *jsonDecoder, id responseObject) {
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [jsonDecoder objectWithData:data];
        
        NSLog(@"cccccc%@",handlJson);
        
        BasicFatherSoonData *keyData = [[BasicFatherSoonData alloc]initWithJsonObject:handlJson];
        
        BOOL success = [keyData.status boolValue];
        
        if (success)
        {
            [SVProgressHUD dismiss];
            [self.B_Fatherarray addObjectsFromArray:keyData.MerchantClassList];
            
            [self jibendowntab1];
            
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

-(void)jibendowntab1
{
    
    //下拉1
    [self.jibendownTab1 initTableViewDataSourceAndDelegate:^(UITableView *tableView,NSInteger section)
     {
         NSInteger count=self.B_Fatherarray.count;
         return count;
         
     } setCellForIndexPathBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         BusinessfenleiCell *cell=[tableView dequeueReusableCellWithIdentifier:@"BusinessfenleiCell"];
         
         if (!cell)
             
         {
             cell=[[[NSBundle mainBundle]loadNibNamed:@"BusinessfenleiCell" owner:self options:nil]objectAtIndex:0];
             [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
         }
         BasicFatherSoonDetailData *data = [self.B_Fatherarray objectAtIndex:indexPath.row];
         [cell.Downlab setText:[NSString stringWithFormat:@"%@",data.ClassName]];
         return cell;
     } setDidSelectRowBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         BusinessfenleiCell *cell=(BusinessfenleiCell*)[tableView cellForRowAtIndexPath:indexPath];
         
         self.Businessbasic_Typetextfield1.text=cell.Downlab.text;
         [self.Businessbasic_TypeButton1 sendActionsForControlEvents:UIControlEventTouchUpInside];

         for (int i=0 ;i<self.B_Fatherarray.count; i++) {
             BasicFatherSoonDetailData *Name = [self.B_Fatherarray objectAtIndex:i];

             if ([[NSString stringWithFormat:@"%@",self.Businessbasic_Typetextfield1.text] isEqualToString:Name.ClassName])
             {
                 fatherindexrow=Name.ClassID;
                 return ;
             }
             
         }
         
     }];
    
    [self.jibendownTab1 .layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.jibendownTab1 .layer setBorderWidth:0];
    
    
}

-(void)jibendowntab2
{
    
    //下拉2
    [self.jibendownTab2 initTableViewDataSourceAndDelegate:^(UITableView *tableView,NSInteger section)
     {
         NSInteger count=self.B_Soonarray.count;
         return count;
         
     } setCellForIndexPathBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         BusinessfenleiCell *cell=[tableView dequeueReusableCellWithIdentifier:@"BusinessfenleiCell"];
         
         if (!cell)
         {
             cell=[[[NSBundle mainBundle]loadNibNamed:@"BusinessfenleiCell" owner:self options:nil]objectAtIndex:0];
             [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
         }
         
         BasicFatherSoonDetailData *data = [self.B_Soonarray objectAtIndex:indexPath.row];
         [cell.Downlab setText:[NSString stringWithFormat:@"%@",data.ClassName]];
         return cell;
     } setDidSelectRowBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         BusinessfenleiCell *cell=(BusinessfenleiCell*)[tableView cellForRowAtIndexPath:indexPath];
         self.Businessbasic_Typetextfield2.text=cell.Downlab.text;
         
         [self.Businessbasic_TypeButton2 sendActionsForControlEvents:UIControlEventTouchUpInside];
     }];
    
    [self.jibendownTab2 .layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.jibendownTab2 .layer setBorderWidth:0];

    
    
}

-(void)getDataFromServerSoon
{
    
    for (int i=0 ;i<self.B_Fatherarray.count; i++) {
        BasicFatherSoonDetailData *shop = [self.B_Fatherarray objectAtIndex:i];

        
        if ([[NSString stringWithFormat:@"%@",self.Businessbasic_Typetextfield1.text] isEqualToString:shop.ClassName])
        {
            fatherindexrow=shop.ClassID;
            break;
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
                           memberId, @"memberId",
                           fatherindexrow,@"pClassID",
                           nil];
    // [SVProgressHUD showWithStatus:@"数据加载中..."];
    
    [httpClient request:@"MerchantClass.ashx" parameters:param successed:^(JSONDecoder *jsonDecoder, id responseObject) {
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [jsonDecoder objectWithData:data];
        
        BasicFatherSoonData *keyData = [[BasicFatherSoonData alloc]initWithJsonObject:handlJson];
        
        BOOL success = [keyData.status boolValue];
        
        if (success)
        {
            [SVProgressHUD dismiss];
            [self.B_Soonarray removeAllObjects];
            [self.B_Soonarray addObjectsFromArray:keyData.MerchantClassList];
            [self.jibendownTab2 reloadData];
            [self jibendowntab2];
            
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


- (IBAction)jiebenchangeOpenBtn1:(id)sender {
    
    if (jibenisOpened1) {
        
        [UIView animateWithDuration:0.3 animations:^{
            UIImage *closeImage=[UIImage imageNamed:@"Button_down.png"];
            [self.Businessbasic_TypeButton1 setImage:closeImage forState:UIControlStateNormal];
            
            CGRect frame=self.jibendownTab1.frame;
            
            frame.size.height=1;
            [self.jibendownTab1 setFrame:frame];
            
        } completion:^(BOOL finished){
            
            jibenisOpened1=NO;
        }];
    }else{
        
        [UIView animateWithDuration:0.3 animations:^{
            UIImage *openImage=[UIImage imageNamed:@"Button_up.png"];
            [self.Businessbasic_TypeButton1 setImage:openImage forState:UIControlStateNormal];
            
            CGRect frame=self.jibendownTab1.frame;
            
            frame.size.height=150;
            [self.jibendownTab1 setFrame:frame];

            
        } completion:^(BOOL finished){
            
            jibenisOpened1=YES;

            
        }];
        
    }
    


    
}

- (IBAction)jiebenchangeOpenBtn2:(id)sender {
    
    if (self.Businessbasic_Typetextfield1.text.length==0||[self.Businessbasic_Typetextfield1.text isEqualToString:@""])
    {
        [SVProgressHUD showErrorWithStatus:@"请先选择类别一……"];
        return;
    }
    [self getDataFromServerSoon];
    
    
    if (jibenisOpened2) {
        
        
        [UIView animateWithDuration:0.3 animations:^{
            UIImage *closeImage=[UIImage imageNamed:@"Button_down.png"];
            [self.Businessbasic_TypeButton2 setImage:closeImage forState:UIControlStateNormal];
            
            CGRect frame=self.jibendownTab2.frame;
            
            frame.size.height=1;
            [self.jibendownTab2 setFrame:frame];
            
        } completion:^(BOOL finished){
            
            jibenisOpened2=NO;
        }];
    }else{
        
        
        [UIView animateWithDuration:0.3 animations:^{
            UIImage *openImage=[UIImage imageNamed:@"Button_up.png"];
            [self.Businessbasic_TypeButton2 setImage:openImage forState:UIControlStateNormal];
            
            CGRect frame=self.jibendownTab2.frame;
            
            frame.size.height=150;
            [self.jibendownTab2 setFrame:frame];
        } completion:^(BOOL finished){
            
            jibenisOpened2=YES;
        }];
        
        
    }
    
}


-(void)Businesserclosekey
{
   [self.Businessbasic_Nametextfield resignFirstResponder];//公司名称
   [self.Businessbasic_Smallnametypetextfield resignFirstResponder];//简称
   [self.Businessbasic_Phonetextfield resignFirstResponder];//电话
   [self.Businessbasic_Webtextfield resignFirstResponder];//网站
   [self.Businessbasic_introducetextfield resignFirstResponder];//介绍
    
}


//保存
-(void)SaveBasicToServer:(NSString*)classId
{
    
    [self Businesserclosekey];
    
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
                           self.Businessbasic_Nametextfield.text,@"allName",
                           self.Businessbasic_Smallnametypetextfield.text,@"abbreviation",
                           self.Businessbasic_Phonetextfield.text,@"tel",
                           self.Businessbasic_Webtextfield.text,@"webSite",
                           self.Businessbasic_introducetextfield.text,@"briefIntro",
                           classId,@"classId",
                           nil];
    [SVProgressHUD showWithStatus:@"数据提交中..."];
    
    [httpClient multipartFormRequest:@"MctBaseInfoSubmit.ashx" parameter:param file:self.m_imagDic successed:^(JSONDecoder *jsonDecoder, id responseObject) {

        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [jsonDecoder objectWithData:data];
        
        SaveData *keyData = [[SaveData alloc]initWithJsonObject:handlJson];
        
        BOOL success = [keyData.status boolValue];
        
        if (success)
        {
            [SVProgressHUD dismiss];
            [SVProgressHUD showSuccessWithStatus:keyData.msg];

            UIImage *image=[UIImage imageWithData:[self.m_imagDic objectForKey:@"photoBigUrl"]];
            
            NSData *imageData_b = [NSKeyedArchiver archivedDataWithRootObject:[CommonUtil scaleImage:image toSize:CGSizeMake(120,120)]];
            // save NSData-object to UserDefaults

            [[NSUserDefaults standardUserDefaults] setObject:imageData_b forKey:@"PhotoMidUrl_B"];

            
            [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(goLastView) userInfo:nil repeats:NO];

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


- (void)goLastView{
    
     [self.navigationController popViewControllerAnimated:YES];
}



-(IBAction)Businessbasic_TypeSaveButton:(UIButton*)sender
{
    [self Businesserclosekey];
    
    for (int i=0 ;i<self.B_Soonarray.count; i++) {
        BasicFatherSoonDetailData *shop = [self.B_Soonarray objectAtIndex:i];
        if ([[NSString stringWithFormat:@"%@",self.Businessbasic_Typetextfield2.text] isEqualToString:shop.ClassName])
        {
            [self SaveBasicToServer:shop.ClassID];
            break;
        }
        
    }

    
    
}

#pragma mark - 保存图片至沙盒
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 获取沙盒目录
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    // 将图片写入文件
    [imageData writeToFile:fullPath atomically:NO];
}


#pragma mark - image picker delegte

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
    UIImage *scaleImage = [self scaleImage111:savedImage toScale:0.3];
    [self.Businessbasic_Headphotoimagebtn setImage:scaleImage forState:UIControlStateNormal];
    
}





//换头像
-(IBAction)Businesserheadphoto:(id)sender
{
    UIActionSheet *sheet;
    
    sheet  = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
    
    sheet.tag = 1;
    [sheet showInView:self.view];
    
}


- (NSData *)getImageData:(UIImageView *)imageView {
    UIImage *iamge = imageView.image;
    return UIImageJPEGRepresentation(iamge, 1);
}

-(UIImage *)scaleImage111:(UIImage *)image toScale:(float)scaleSize {
    
    
    
    // 将图片存储在字典里
    UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    
    imgV.image = [CommonUtil scaleImage:image toSize:CGSizeMake(30, 30)];
    
    UIImageView *imgV1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
    
    imgV1.image = [CommonUtil scaleImage:image toSize:CGSizeMake(60, 60)];
    
    UIImageView *imgV2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 120, 120)];
    
    imgV2.image = [CommonUtil scaleImage:image toSize:CGSizeMake(120, 120)];
    
    self.m_imagDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                      [self getImageData:imgV],@"photoSmlUrl",
                      [self getImageData:imgV1],@"photoMidUrl",
                      [self getImageData:imgV2],@"photoBigUrl",nil];
    
    
    // 计算图片显示的大小
    float height = image.size.width / 120.0f;
    
    UIGraphicsBeginImageContext(CGSizeMake(120,image.size.height / height));
    [image drawInRect:CGRectMake(0, 0, 120, image.size.height / height)];
    
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    

    return scaledImage;
    
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
        if (buttonIndex == 1) {
            pickerorphoto=0;
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];//打开照片文件
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            [self presentViewController:imagePicker animated:YES completion:^{
            }];
        }
        
    }
}


-(void)GetallDataFromServer
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
 //  [SVProgressHUD showWithStatus:@"数据加载中..."];
    
    [httpClient request:@"GetMerchantInfos.ashx" parameters:param successed:^(JSONDecoder *jsonDecoder, id responseObject) {
        NSData* data = [NSData dataWithData:responseObject];
        NSDictionary* handlJson = [jsonDecoder objectWithData:data];
        BasicData*keyData = [[BasicData alloc]initWithJsonObject:handlJson];
        
        BOOL success = [keyData.status boolValue];
        
        if (success)
        {
            self.BasicDic=keyData.Merchant;
            [self PutDatatoLabel];
            [SVProgressHUD dismiss];
            
          //然后再请求父子类
            
            [self getDataFromServerSoon];

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

-(void)PutDatatoLabel
{
    self.Businessbasic_Typetextfield1.text=[self.BasicDic objectForKey:@"ParentClassName"];
    self.Businessbasic_Typetextfield2.text=[self.BasicDic objectForKey:@"ClassName"];
    self.Businessbasic_Nametextfield.text=[self.BasicDic objectForKey:@"AllName"];
    self.Businessbasic_Smallnametypetextfield.text=[self.BasicDic objectForKey:@"Abbreviation"];
    self.Businessbasic_Phonetextfield.text=[self.BasicDic objectForKey:@"Tel"];
    self.Businessbasic_Webtextfield.text=[self.BasicDic objectForKey:@"WebSite"];
    self.Businessbasic_introducetextfield.text=[self.BasicDic objectForKey:@"Briefintro"];

}






@end
