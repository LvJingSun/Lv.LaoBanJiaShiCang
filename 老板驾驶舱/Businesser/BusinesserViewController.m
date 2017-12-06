//
//  BusinesserViewController.m
//  BusinessCenter
//
//  Created by 冯海强 on 13-11-18.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import "BusinesserViewController.h"
#import "BusinessbasicViewController.h"//基本
#import "BusinessrunViewController.h"
#import "BusinessshopViewController.h"//入驻
#import "BusinessLogoViewController.h"
#import "BusinessPasswordViewController.h"
#import "BusinessMoneypeopleViewController.h"//收银
#import "BusinessdelegatepeopleViewController.h"//代理人
#import "BusinessBankViewController.h"
#import "HuiViewController.h"

@interface BusinesserViewController (){

    NSString *downLoad;
    
}

@end

@implementation BusinesserViewController

- (id)initWithStyle:(UITableViewStyle)style
{
   // self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
    }
    return self;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = @"商户";
        self.tabBarItem.image = [UIImage imageNamed:@"Merchant"];
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated;
{
    //    self.tabBarController.navigationItem.rightBarButtonItem=nil;
    self.tabBarController.title=self.title;
    
}
-(void)viewWillAppear:(BOOL)animated
{

    self.navigationController.navigationBarHidden = NO;
    
    [B_tableview reloadData];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    


    Bus_shopcArray=[[NSMutableArray alloc]init];
    Bus_otherArray=[[NSMutableArray alloc]init];
    [Bus_shopcArray addObject:@"入驻运营信息"];
    [Bus_shopcArray addObject:@"商户店铺"];
    [Bus_shopcArray addObject:@"商户Logo"];
    [Bus_otherArray addObject:@"密码设置"];
    [Bus_otherArray addObject:@"收银员管理"];
    [Bus_otherArray addObject:@"代理人管理"];
    [Bus_otherArray addObject:@"收款银行卡号管理"];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    if ([[UIDevice currentDevice].systemVersion doubleValue]>=7)
    {
        tableView.center=CGPointMake(self.view.center.x, self.view.center.y-34);
        
    }
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    if (section==0)
    {
        return 1;
    }
    else if (section==1)
    {
        return 3;
    }
    else if (section==2)
    {
        return 4;
    }
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        return 65;
    }
    if (indexPath.section == 3 && indexPath.row == 0) {
        return 41;
    }
    return 40;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];//解决Cell上重用机制问题。
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];//有点浪费空间
      NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%d%d", [indexPath section], [indexPath row]];//以indexPath来唯一确定cell
      UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier]; //出列可重用的cell

    if (cell == nil) {
        if ((indexPath.section == 3 && indexPath.row == 0)||indexPath.section==0) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        } else {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        }
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;

    }
    
    // Configure the cell...
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];

    if (indexPath.section==0)
    {
        cell.textLabel.text= [userDefau objectForKey:@"nick"];
        cell.textLabel.textColor=[UIColor grayColor];
        
       cell.detailTextLabel.text=[userDefau objectForKey:@"account"];
        
        cell.detailTextLabel.textColor=[UIColor redColor];
        cell.detailTextLabel.font=[UIFont systemFontOfSize:15];
        //cell.imageView.image = [UIImage imageNamed:@"chenchen.png"];
        NSData *imageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"PhotoMidUrl_B"];
        if(imageData != nil)
        {
            cell.imageView.image=[CommonUtil scaleImage:[NSKeyedUnarchiver unarchiveObjectWithData:imageData] toSize:CGSizeMake(65,60)];
        }
        
    }
   else if (indexPath.section==1)
    {
        cell.textLabel.text=[Bus_shopcArray objectAtIndex:indexPath.row];
        
    }
    
   else if (indexPath.section==2)
    {
        cell.textLabel.text=[Bus_otherArray objectAtIndex:indexPath.row];
    }
   else if (indexPath.section==3)
   {
//       if (indexPath.row==0)
//       {
//           cell.textLabel.text = @"我的APP设置";
//
//       }
//       else
           if (indexPath.row==0)
               
       {
           // 将本身的版本与服务器端请求的数据进行比较，若相同则不升级；反之升级
           NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
           cell.textLabel.text = [NSString stringWithFormat:@"当前版本：%@",version];
           cell.accessoryType = UITableViewCellAccessoryNone;
           [cell setSelectionStyle:UITableViewCellSelectionStyleNone];//cell 不被选择

       }
       else if (indexPath.row==1)
       {
           UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0,0,185,40)];
           label.text=@"退出登录";
           label.font=[UIFont systemFontOfSize:19];
           label.textColor = [UIColor redColor];
           cell.accessoryView = label;
       }
   }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    
    if (indexPath.section==0)
    {
        BusinessbasicViewController*BusbasVC=[[BusinessbasicViewController alloc]initWithNibName:@"BusinessbasicViewController" bundle:nil];
        
        [self .navigationController pushViewController:BusbasVC animated:YES];
        
    }
   else if (indexPath.section==1)
    {
        if (indexPath.row==0)
        {
            BusinessrunViewController*BusRunVC=[[BusinessrunViewController alloc]initWithNibName:@"BusinessrunViewController" bundle:nil];
            
            [self .navigationController pushViewController:BusRunVC animated:YES];
        }
        else if (indexPath.row==1)
        {
            BusinessshopViewController*BusshopVC=[[BusinessshopViewController alloc]initWithNibName:@"BusinessshopViewController" bundle:nil];
            
            [self .navigationController pushViewController:BusshopVC animated:YES];
            
        }
        else if (indexPath.row==2)
        {
            BusinessLogoViewController*BussLogoVC=[[BusinessLogoViewController alloc]initWithNibName:@"BusinessLogoViewController" bundle:nil];
            
            [self .navigationController pushViewController:BussLogoVC animated:YES];
            
        }
        
    }
    
   else if (indexPath.section==2)
    {
        if (indexPath.row==0)
        {
            BusinessPasswordViewController*BussPasswordVC=[[BusinessPasswordViewController alloc]initWithNibName:@"BusinessPasswordViewController" bundle:nil];
            
            [self .navigationController pushViewController:BussPasswordVC animated:YES];
        }

      else if (indexPath.row==1)
        {
            BusinessMoneypeopleViewController*BussMoneypeopleVC=[[BusinessMoneypeopleViewController alloc]initWithNibName:@"BusinessMoneypeopleViewController" bundle:nil];
            
            [self .navigationController pushViewController:BussMoneypeopleVC animated:YES];
        }
       else if (indexPath.row==2)
        {
            BusinessdelegatepeopleViewController*BusinessdelegateVC=[[BusinessdelegatepeopleViewController alloc]initWithNibName:@"BusinessdelegatepeopleViewController" bundle:nil];
            
            [self .navigationController pushViewController:BusinessdelegateVC animated:YES];
        }
       else if (indexPath.row==3)
        {
            BusinessBankViewController*BusinessBankVC=[[BusinessBankViewController alloc]initWithNibName:@"BusinessBankViewController" bundle:nil];
            
            [self .navigationController pushViewController:BusinessBankVC animated:YES];
        }

        
    }
   else if (indexPath.section==3)
   {
       
//       if (indexPath.row==0)
//       {
//           HuiViewController *HuiVC=[[HuiViewController alloc]initWithNibName:@"HuiViewController" bundle:nil];
//           [self.navigationController pushViewController:HuiVC animated:YES];
//
//       }
//       
//       else if (indexPath.row==1)
//       {
//           
//       }
//       else
           if (indexPath.row==1)
       {
           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"退出系统？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
           [alertView show];
  
       }

       
   }

    
}


// 版本更新
- (void)upDateVersion{
    
    // 点击进入版本升级的url-appStore下载的地址
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:downLoad]];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        
        MainViewController* mainVC = [MainViewController shareobject];
        [mainVC.mainNavigationController.view removeFromSuperview];//删除主导航上的视图
        [mainVC.navi.view removeFromSuperview];
        [mainVC viewDidLoad];
    }
}


@end
