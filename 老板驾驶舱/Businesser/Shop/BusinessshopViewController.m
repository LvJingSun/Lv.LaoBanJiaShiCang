//
//  BusinessshopViewController.m
//  BusinessCenter
//
//  Created by 冯海强 on 13-11-21.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import "BusinessshopViewController.h"
#import "BusinessshopCell.h"
#import "BusshopAddorChangeViewController.h"

#import "SVProgressHUD.h"
#import "HttpClientRequest.h"
#import "BasicData.h"

@interface BusinessshopViewController ()

@end

@implementation BusinessshopViewController


-(void)viewWillAppear:(BOOL)animated
{
    
    self.Shoparray=[[NSMutableArray alloc]initWithCapacity:0];
    self.B_ListTable.hidden=YES;
    self.addview.hidden=YES;

    [self getShopDataFromServer];

}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"店铺列表";
    
    
    UIBarButtonItem *Addshop =[[UIBarButtonItem alloc] initWithTitle:@"增加" style:UIBarButtonItemStyleBordered target:self action:@selector(Addshopbutton)];
    self.navigationItem.rightBarButtonItem =Addshop;
    
    [self.addviewBtn addTarget:self action:@selector(Addshopbutton) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getShopDataFromServer
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
    [httpClient request:@"GetMerchantInfos.ashx" parameters:param successed:^(JSONDecoder *jsonDecoder, id responseObject) {
        NSData* data = [NSData dataWithData:responseObject];
        NSDictionary* handlJson = [jsonDecoder objectWithData:data];
        
        BasicDetailData*keyData = [[BasicDetailData alloc]initWithJsonObject:handlJson];

        BOOL success = [keyData.status boolValue];
        if (success)
        {
            [SVProgressHUD dismiss];
 
            if (keyData.MctShopList.count == 0) {
                
                self.addview.hidden = NO;
                self.B_ListTable.hidden=YES;
                return ;
            }
            
            [self.Shoparray addObjectsFromArray:keyData.MctShopList];
            
            self.B_ListTable.hidden=NO;
            [self.B_ListTable reloadData];
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



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.Shoparray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 125;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    BusinessshopCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray*cellarray=[[NSBundle mainBundle]
                           loadNibNamed:@"BusinessshopCell" owner:self options:nil];
        cell =[cellarray objectAtIndex:0];
    }
    
    
    if (self.Shoparray.count!=0)
    {
        ShopDetailData*shop=[self.Shoparray objectAtIndex:indexPath.row];
        cell.Businessshop_ShopnameLabel.text=shop.ShopName;
        cell.Businessshop_ShopadressLabel.text=shop.Address;
        cell.Businessshop_ShoptimeLabel.text=shop.OpeningHours;
        cell.Businessshop_ShopphoneLabel.text=shop.Phone;
        cell.Businessshop_ShopbusLabel.text=shop.Businfo;
        
        
    }
    
    return cell;
}

//查看修改店铺
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    int a=1;
    [accountDefaults setInteger:a forKey:@"Addshop"];//查看修改店铺
    
    BusshopAddorChangeViewController*BusAddorchangeVC=[[BusshopAddorChangeViewController alloc]initWithNibName:@"BusshopAddorChangeViewController" bundle:nil];
    ShopDetailData*shopdata=[self.Shoparray objectAtIndex:indexPath.row];
    BusAddorchangeVC.shopDetailData=shopdata;
    
    [self .navigationController pushViewController:BusAddorchangeVC animated:YES];
    
    
}

//增加新店铺；
-(void)Addshopbutton
{
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    int a=2;
    [accountDefaults setInteger:a forKey:@"Addshop"];//增加店铺
    
    BusshopAddorChangeViewController*BusAddorchangeVC=[[BusshopAddorChangeViewController alloc]initWithNibName:@"BusshopAddorChangeViewController" bundle:nil];
    [self .navigationController pushViewController:BusAddorchangeVC animated:YES];
    
    
}

@end
