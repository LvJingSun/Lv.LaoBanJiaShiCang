//
//  BusshopAddorChangeViewController.m
//  BusinessCenter
//
//  Created by 冯海强 on 13-11-21.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import "BusshopAddorChangeViewController.h"
#import "BusinessfenleiCell.h"//同用基本信息里分类Cell下拉
#import <QuartzCore/QuartzCore.h>
#import "UITableView+DataSourceBlocks.h"
#import "TableViewWithBlock.h"
#import "BusinessshopMapViewController.h"
#import "BMapViewController.h"
#import "SaveData.h"
#import "SVProgressHUD.h"
#import "shopFatherSoonData.h"
#import "HttpClientRequest.h"

@interface BusshopAddorChangeViewController ()

@property(nonatomic,weak)IBOutlet UITextField*BusinessSoopAddorChange_Nametextfield;//店铺
@property(nonatomic,weak)IBOutlet UITextField*BusinessSoopAddorChange_quyutextfield1;//区域1
@property(nonatomic,weak)IBOutlet UITextField*BusinessSoopAddorChange_quyutextfield2;//区域2
@property(nonatomic,weak)IBOutlet UIButton*Businessbasic_quyuButton1;//按钮1
@property(nonatomic,weak)IBOutlet UIButton*Businessbasic_quyuButton2;//按钮2
@property(nonatomic,weak)IBOutlet UITextField*BusinessSoopAddorChange_dizhitextfield;//地址
@property(nonatomic,weak)IBOutlet UITextField*BusinessSoopAddorChange_Timetextfield;//营业时间
@property(nonatomic,weak)IBOutlet UITextField*BusinessSoopAddorChange_Bustextfield;//公交
@property(nonatomic,weak)IBOutlet UITextField*BusinessSoopAddorChange_Phonetextfield;//电话


@end

@implementation BusshopAddorChangeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        fatherindexrow=@"1";
        self.S_fatherarray=[[NSMutableArray alloc]initWithCapacity:0];
        self.S_soonarray=[[NSMutableArray alloc]initWithCapacity:0];
        [self getDataFromServerFather_S];
        [self getDataFromServerSoon_S];
    }
    return self;
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
}



- (void)viewDidLoad
{
    [super viewDidLoad];

    
    self.BusinessSoopAddorChange_quyutextfield1.enabled=NO;//区域1
    self.BusinessSoopAddorChange_quyutextfield2.enabled=NO;//区域2
    
    self.BusinessSoopAddorChange_quyutextfield1.placeholder=@"请选择……";
    self.BusinessSoopAddorChange_quyutextfield2.placeholder=@"请选择……";
    
    
    NSUserDefaults*product=[NSUserDefaults standardUserDefaults];
    NSString *str = [NSString stringWithFormat:@"%@",[product objectForKey:@"Addshop"]];
    if (str.intValue==1)
    {
        self.title=@"店铺信息";
        
        self.BusinessSoopAddorChange_Nametextfield.text=self.shopDetailData.ShopName;
        self.BusinessSoopAddorChange_quyutextfield1.text=self.shopDetailData.CityName;
        self.BusinessSoopAddorChange_quyutextfield2.text=self.shopDetailData.Areaname;
        self.BusinessSoopAddorChange_dizhitextfield.text=self.shopDetailData.Address;
        self.BusinessSoopAddorChange_Timetextfield.text=self.shopDetailData.OpeningHours;
        self.BusinessSoopAddorChange_Bustextfield.text=self.shopDetailData.Businfo;
        self.BusinessSoopAddorChange_Phonetextfield.text=self.shopDetailData.Phone;
        [[NSUserDefaults standardUserDefaults] setObject:self.shopDetailData.MapX forKey:@"Map.x"];
        [[NSUserDefaults standardUserDefaults] setObject:self.shopDetailData.MapY forKey:@"Map.y"];
        [[NSUserDefaults standardUserDefaults] setObject:self.shopDetailData.Hc forKey:@"level"];

        
    }
    if (str.intValue==2)
    {
        self.title=@"增加店铺";
    }

    
    UIBarButtonItem *wangcheng =[[UIBarButtonItem alloc] initWithTitle:@"关闭键盘" style:UIBarButtonItemStyleBordered target:self action:@selector(BusinessAddorChangeclosekey)];
    self.navigationItem.rightBarButtonItem =wangcheng;
    
    
//    [self.view addSubview:BusinessAddorChange_scrollview];
    CGRect rx = [ UIScreen mainScreen ].bounds;//手机尺寸
    BusinessAddorChange_scrollview.frame = CGRectMake(0, 0, 320,rx.size.height);
    
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
        BusinessAddorChange_scrollview.center=CGPointMake(BusinessAddorChange_scrollview.center.x,BusinessAddorChange_scrollview.center.y+120);
        
    }
    
    //4S且6的系统
    if (iphonenum==4&&(version == 6||version==6.1))
    {
        BusinessAddorChange_scrollview.center=CGPointMake(BusinessAddorChange_scrollview.center.x,BusinessAddorChange_scrollview.center.y+130);
        
    }
    //4S但7的系统
    if (iphonenum==4&&version>=7)
    {
        BusinessAddorChange_scrollview.center=CGPointMake(BusinessAddorChange_scrollview.center.x,BusinessAddorChange_scrollview.center.y+150);
        
    }
    if (iphonenum==5&&(version == 6||version==6.1))
    {
        BusinessAddorChange_scrollview.center=CGPointMake(BusinessAddorChange_scrollview.center.x,BusinessAddorChange_scrollview.center.y+40);
    }
    
    if (iphonenum==5&&version >= 7)
    {
        BusinessAddorChange_scrollview.center=CGPointMake(BusinessAddorChange_scrollview.center.x,BusinessAddorChange_scrollview.center.y+60);
    }
    
    
    [BusinessAddorChange_scrollview setContentSize:CGSizeMake(320,618)];
    
    
    
    
    //下拉这块
    shopisOpened1=NO;
    shopisOpened2=NO;

    
    [self.BusinessSoopAddorChange_Nametextfield setDelegate:self];//店铺
    [self.BusinessSoopAddorChange_dizhitextfield setDelegate:self];//地址
    [self.BusinessSoopAddorChange_Timetextfield setDelegate:self];//营业时间
    [self.BusinessSoopAddorChange_Bustextfield setDelegate:self];//公交
    [self.BusinessSoopAddorChange_Phonetextfield setDelegate:self];//电话
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    if ((textField == self.BusinessSoopAddorChange_Nametextfield) || (textField == self.BusinessSoopAddorChange_dizhitextfield)||(textField == self.BusinessSoopAddorChange_Timetextfield)||(textField ==self.BusinessSoopAddorChange_Bustextfield)||(textField ==self.BusinessSoopAddorChange_Phonetextfield)) {
        [textField resignFirstResponder];
    }
    return YES;
    
}




-(void)BusinessAddorChangeclosekey
{
    
    [self.BusinessSoopAddorChange_Nametextfield resignFirstResponder];//店铺
    [self.BusinessSoopAddorChange_dizhitextfield resignFirstResponder];//地址
    [self.BusinessSoopAddorChange_Timetextfield resignFirstResponder];//营业时间
    [self.BusinessSoopAddorChange_Bustextfield resignFirstResponder];//公交
    [self.BusinessSoopAddorChange_Phonetextfield resignFirstResponder];//电话
    
    
}


-(void)getDataFromServerFather_S
{
    MainViewController*mainVC=[MainViewController shareobject];
    // 判断网络是否存在
    if ( ![mainVC isConnectionAvailable] )
    {
        return;
    }
    
    NSString*parentId=@"0";
    
    HttpClientRequest *httpClient = [HttpClientRequest sharedInstance];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           parentId,@"parentId",
                           nil];
    // [SVProgressHUD showWithStatus:@"数据加载中..."];
    
    [httpClient request:@"CityList.ashx" parameters:param successed:^(JSONDecoder *jsonDecoder, id responseObject) {
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [jsonDecoder objectWithData:data];
        
        shopFatherSoonData *keyData = [[shopFatherSoonData alloc]initWithJsonObject:handlJson];
        
        BOOL success = [keyData.status boolValue];
        
        if (success)
        {
            [SVProgressHUD dismiss];
            [self.S_fatherarray addObjectsFromArray:keyData.CityList];
            
            [self getDataFromServerSoon_S];
            [self shopDownTab1];
            
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

-(void)shopDownTab1
{
    //下拉1
    [self.shopdownTab1 initTableViewDataSourceAndDelegate:^(UITableView *tableView,NSInteger section)
     {
         NSInteger count=self.S_fatherarray.count;
         return count;
         
     } setCellForIndexPathBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         BusinessfenleiCell *cell=[tableView dequeueReusableCellWithIdentifier:@"BusinessfenleiCell"];
         
         if (!cell)
         {
             cell=[[[NSBundle mainBundle]loadNibNamed:@"BusinessfenleiCell" owner:self options:nil]objectAtIndex:0];
             [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
         }
         shopFatherSoonDetailData *data = [self.S_fatherarray objectAtIndex:indexPath.row];
         [cell.Downlab setText:[NSString stringWithFormat:@"%@",data.CityName]];
         return cell;
     } setDidSelectRowBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         BusinessfenleiCell *cell=(BusinessfenleiCell*)[tableView cellForRowAtIndexPath:indexPath];
         self.BusinessSoopAddorChange_quyutextfield1.text=cell.Downlab.text;
         [self.Businessbasic_quyuButton1 sendActionsForControlEvents:UIControlEventTouchUpInside];
         
         for (int i=0 ;i<self.S_fatherarray.count; i++) {
             shopFatherSoonDetailData *Name = [self.S_fatherarray objectAtIndex:i];
             
             if ([[NSString stringWithFormat:@"%@",self.BusinessSoopAddorChange_quyutextfield1.text] isEqualToString:Name.CityName])
             {
                 fatherindexrow=Name.CityId;
                 return ;
             }
             
         }

         
     }];
    
    [self.shopdownTab1 .layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.shopdownTab1 .layer setBorderWidth:0];
    
    
    
}

-(void)shopDownTab2
{
    
    //下拉2
    [self.shopdownTab2 initTableViewDataSourceAndDelegate:^(UITableView *tableView,NSInteger section)
     {
         NSInteger count=self.S_soonarray.count;
         return count;
         
     } setCellForIndexPathBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         BusinessfenleiCell *cell=[tableView dequeueReusableCellWithIdentifier:@"BusinessfenleiCell"];
         
         if (!cell)
         {
             cell=[[[NSBundle mainBundle]loadNibNamed:@"BusinessfenleiCell" owner:self options:nil]objectAtIndex:0];
             [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
         }
         shopFatherSoonDetailData *data = [self.S_soonarray objectAtIndex:indexPath.row];
         [cell.Downlab setText:[NSString stringWithFormat:@"%@",data.CityName]];         return cell;
     } setDidSelectRowBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         BusinessfenleiCell *cell=(BusinessfenleiCell*)[tableView cellForRowAtIndexPath:indexPath];
         self.BusinessSoopAddorChange_quyutextfield2.text=cell.Downlab.text;
         [self.Businessbasic_quyuButton2 sendActionsForControlEvents:UIControlEventTouchUpInside];
   
         
         for (int i=0 ;i<self.S_soonarray.count; i++) {
             shopFatherSoonDetailData *shop = [self.S_soonarray objectAtIndex:i];
             
             if ([[NSString stringWithFormat:@"%@",self.BusinessSoopAddorChange_quyutextfield2.text] isEqualToString:shop.CityName])
             {
                 soonindexrow=shop.CityId;
                 return ;
             }
             
         }
         
     }];
    
    [self.shopdownTab2 .layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.shopdownTab2 .layer setBorderWidth:0];
    
    
}

-(void)getDataFromServerSoon_S
{
    for (int i=0 ;i<self.S_fatherarray.count; i++) {
        shopFatherSoonDetailData *Name = [self.S_fatherarray objectAtIndex:i];
        
        if ([[NSString stringWithFormat:@"%@",self.BusinessSoopAddorChange_quyutextfield1.text] isEqualToString:Name.CityName])
        {
            fatherindexrow=Name.CityId;
        }
        
    }
    
    MainViewController*mainVC=[MainViewController shareobject];
    // 判断网络是否存在
    if ( ![mainVC isConnectionAvailable] )
    {
        return;
    }
    HttpClientRequest *httpClient = [HttpClientRequest sharedInstance];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           fatherindexrow,@"parentId",
                           nil];
    // [SVProgressHUD showWithStatus:@"数据加载中..."];
    [httpClient request:@"CityList.ashx" parameters:param successed:^(JSONDecoder *jsonDecoder, id responseObject) {
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [jsonDecoder objectWithData:data];
        
        shopFatherSoonData *keyData = [[shopFatherSoonData alloc]initWithJsonObject:handlJson];
        
        BOOL success = [keyData.status boolValue];
        
        if (success)
        {
            [SVProgressHUD dismiss];
            [self.S_soonarray removeAllObjects];
            [self.S_soonarray addObjectsFromArray:keyData.CityList];
            [self.shopdownTab2 reloadData];
            [self shopDownTab2];
            
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




//区域1
-(IBAction)BusinessShopAddorChange_quyuButton1:(UIButton*)sender
{
    if (shopisOpened1) {
        
        [UIView animateWithDuration:0.3 animations:^{
            UIImage *closeImage=[UIImage imageNamed:@"Button_down.png"];
            [self.Businessbasic_quyuButton1 setImage:closeImage forState:UIControlStateNormal];
            
            CGRect frame=self.shopdownTab1.frame;
            
            frame.size.height=1;
            [self.shopdownTab1 setFrame:frame];
            
        } completion:^(BOOL finished){
            
            shopisOpened1=NO;
        }];
    }else{
        
        
        [UIView animateWithDuration:0.3 animations:^{
            UIImage *openImage=[UIImage imageNamed:@"Button_up.png"];
            [self.Businessbasic_quyuButton1 setImage:openImage forState:UIControlStateNormal];
            
            CGRect frame=self.shopdownTab1.frame;
            
            frame.size.height=55;
            [self.shopdownTab1 setFrame:frame];
        } completion:^(BOOL finished){
            
            shopisOpened1=YES;
        }];
        
        
    }

    
}
//区域2
-(IBAction)BusinessShopAddorChange_quyuButton2:(UIButton*)sender
{
    
    if (self.BusinessSoopAddorChange_quyutextfield1.text.length==0||[self.BusinessSoopAddorChange_quyutextfield1.text isEqualToString:@""])
    {
        [SVProgressHUD showErrorWithStatus:@"请先选择类别一……"];
        return;
    }
    [self getDataFromServerSoon_S];
    
    if (shopisOpened2) {
        
        
        [UIView animateWithDuration:0.3 animations:^{
            UIImage *closeImage=[UIImage imageNamed:@"Button_down.png"];
            [self.Businessbasic_quyuButton2 setImage:closeImage forState:UIControlStateNormal];
            
            CGRect frame=self.shopdownTab2.frame;
            
            frame.size.height=1;
            [self.shopdownTab2 setFrame:frame];
            
        } completion:^(BOOL finished){
            
            shopisOpened2=NO;
        }];
    }else{
        
        
        [UIView animateWithDuration:0.3 animations:^{
            UIImage *openImage=[UIImage imageNamed:@"Button_up.png"];
            [self.Businessbasic_quyuButton2 setImage:openImage forState:UIControlStateNormal];
            
            CGRect frame=self.shopdownTab2.frame;
            
            frame.size.height=145;
            [self.shopdownTab2 setFrame:frame];
        } completion:^(BOOL finished){
            
            shopisOpened2=YES;
        }];
        
        
    }


}

//修改地图
-(IBAction)BusinessShopAddorChange_MapButton:(UIButton*)sender
{

    BMapViewController*BusinessMapVC=[[BMapViewController alloc]initWithNibName:@"BMapViewController" bundle:nil];
    
    BusinessMapVC.MAPshopdetail=self.shopDetailData;

    [self.navigationController pushViewController:BusinessMapVC animated:YES];
    

}

-(IBAction)BusinessShopAddorChange_SaveButton:(UIButton*)sender
{
    [self BusinessAddorChangeclosekey];
    NSString*districtID;
    NSString*merchantShopId;//商圈ID;
    
    if ([self.title isEqualToString:@"店铺信息"])
    {
      option=@"2";
        
        districtID=self.shopDetailData.Districtid;
        merchantShopId=self.shopDetailData.MerchantShopId;
    }
    if ([self.title isEqualToString:@"增加店铺"])
    {
        option=@"1";
        districtID=@"0";
        merchantShopId=@"1";

    }

    if (self.BusinessSoopAddorChange_Nametextfield.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入店铺名称"];
        return;
    }
    if (self.BusinessSoopAddorChange_quyutextfield1.text.length == 0||self.BusinessSoopAddorChange_quyutextfield2.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择区域"];
        return;
    }
    if (self.BusinessSoopAddorChange_dizhitextfield.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入地址"];
        return;
    }
    if (self.BusinessSoopAddorChange_Timetextfield.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入营业时间"];
        return;
    }
    if (self.BusinessSoopAddorChange_Bustextfield.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入公交信息"];
        return;
    }
    if (self.BusinessSoopAddorChange_Phonetextfield.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入咨询电话"];
        return;
    }

    
    for (int i=0 ;i<self.S_fatherarray.count; i++) {
        shopFatherSoonDetailData *Name = [self.S_fatherarray objectAtIndex:i];
        
        if ([[NSString stringWithFormat:@"%@",self.BusinessSoopAddorChange_quyutextfield1.text] isEqualToString:Name.CityName])
        {
            fatherindexrow=Name.CityId;
        }
        
    }
    
    for (int i=0 ;i<self.S_soonarray.count; i++) {
        shopFatherSoonDetailData *shop = [self.S_soonarray objectAtIndex:i];
        
        if ([[NSString stringWithFormat:@"%@",self.BusinessSoopAddorChange_quyutextfield2.text] isEqualToString:shop.CityName])
        {
            soonindexrow=shop.CityId;
        }
    }
    

    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"level"]==nil)
    {
        if ([self.shopDetailData.Hc isEqualToString:@"<null>"])
        {
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@""] forKey:@"level"];
        }
        else
        {
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",self.shopDetailData.Hc] forKey:@"level"];
        }
    }
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"Map.x"]==nil)
    {
        if ([self.shopDetailData.MapX isEqualToString:@"<null>"])
        {
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@""] forKey:@"Map.x"];
        }
        else
        {
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",self.shopDetailData.MapX] forKey:@"Map.x"];
        }
    }
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"Map.y"]==nil)
    {
        if ([self.shopDetailData.MapY isEqualToString:@"<null>"])
        {
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@""] forKey:@"Map.y"];
        }
        else
        {
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",self.shopDetailData.MapY] forKey:@"Map.y"];
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
                           option,@"option",
                           self.BusinessSoopAddorChange_dizhitextfield.text,@"address",
                           soonindexrow,@"areaID",
                           self.BusinessSoopAddorChange_Bustextfield.text,@"busInfo",
                           fatherindexrow,@"cityID",
                           districtID,@"districtID",
                           [userDefau objectForKey:@"level"],@"hc",
                           [userDefau objectForKey:@"Map.x"],@"mapX",
                           [userDefau objectForKey:@"Map.y"],@"mapY",
                           merchantShopId,@"merchantShopId",
                           self.BusinessSoopAddorChange_Timetextfield.text,@"openingHours",
                           self.BusinessSoopAddorChange_Nametextfield.text,@"shopName",
                           self.BusinessSoopAddorChange_Phonetextfield.text,@"tel",
                           nil];
    [SVProgressHUD showWithStatus:@"数据提交中..."];
    NSLog(@"测试测试测试%@",param);
    
    [httpClient request:@"MerchantShopSubmit.ashx" parameters:param successed:^(JSONDecoder *jsonDecoder, id responseObject) {
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [jsonDecoder objectWithData:data];
        
        SaveData *keyData = [[SaveData alloc]initWithJsonObject:handlJson];
        
        BOOL success = [keyData.status boolValue];
        
        if (success)
        {
            [SVProgressHUD dismiss];
            [SVProgressHUD showSuccessWithStatus:keyData.msg];
            
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


-(void)goLastView
{
    
    [self.navigationController popViewControllerAnimated:YES];
}



@end
