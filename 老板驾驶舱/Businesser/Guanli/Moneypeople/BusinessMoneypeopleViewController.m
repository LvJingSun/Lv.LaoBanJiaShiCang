//
//  BusinessMoneypeopleViewController.m
//  BusinessCenter
//
//  Created by 冯海强 on 13-11-22.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import "BusinessMoneypeopleViewController.h"
#import "BusinessMoneypeopleCell.h"
#import "BusinessMoneypeopledetailsViewController.h"//收银员信息
#import "HttpClientRequest.h"
#import "SVProgressHUD.h"
#import "BasicData.h"
#import "MoneypeopleData.h"


@interface BusinessMoneypeopleViewController ()<UIActionSheetDelegate> {

    NSIndexPath * _indexPath;
    
}

@end

@implementation BusinessMoneypeopleViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"收银员列表";
    self.shopdic=[[NSMutableDictionary alloc]initWithCapacity:0];
    
    M_pagindex=1;
    once=1;//为只运行一次
    
    self.shoparray=[[NSMutableArray alloc]initWithCapacity:0];
    self.moneypeoplearray=[[NSMutableArray alloc]initWithCapacity:0];
    self.tableView.hidden=YES;
    
    UIBarButtonItem *ADD =[[UIBarButtonItem alloc] initWithTitle:@"增加" style:UIBarButtonItemStyleBordered target:self action:@selector(BusinessMoneypeopleAdd)];
    self.navigationItem.rightBarButtonItem =ADD;


    [self getShopFromData];
    
    UILongPressGestureRecognizer * longPressGr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressToDo:)];
    
    longPressGr.minimumPressDuration = 1.0;
    
    [self.tableView addGestureRecognizer:longPressGr];

}

-(void)longPressToDo:(UILongPressGestureRecognizer *)gesture
{
    
    if(gesture.state == UIGestureRecognizerStateBegan)
    {
        CGPoint point = [gesture locationInView:self.tableView];
        
        NSIndexPath * indexPath = [self.tableView indexPathForRowAtPoint:point];
        
        if(indexPath != nil) {
            
            _indexPath = indexPath;

            UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"删除" otherButtonTitles:nil, nil];
            
            [sheet showInView:self.view];
            
        }else {

            return;
            
        }

    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {

    switch (buttonIndex) {
        case 0:
        {
        
            NSString*key=[self.shopdic allKeys][_indexPath.section];
            NSMutableArray*arr=[self.shopdic objectForKey:key];
            
            MoneypeopleDetailData*money=[arr objectAtIndex:_indexPath.row];
            
            [self deleteWithID:money.CashierAccountID];
            
        }
            break;
            
        default:
            break;
    }
    
}

- (void)deleteWithID:(NSString *)cashierID {

    MainViewController*mainVC=[MainViewController shareobject];
    // 判断网络是否存在
    if ( ![mainVC isConnectionAvailable] )
    {
        return;
    }

    HttpClientRequest *httpClient = [HttpClientRequest sharedInstance];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           cashierID,@"cashierAccountID",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中..."];
    [httpClient request:@"CashierDelete.ashx" parameters:param successed:^(JSONDecoder *jsonDecoder, id responseObject) {
        NSData* data = [NSData dataWithData:responseObject];
        NSDictionary* handlJson = [jsonDecoder objectWithData:data];
        
        BasicDetailData*keyData = [[BasicDetailData alloc]initWithJsonObject:handlJson];
        
        BOOL success = [keyData.status boolValue];
        if (success)
        {
            [SVProgressHUD showErrorWithStatus:keyData.msg];
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:keyData.msg];
        }
        
    } failured:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:error.description];
        
    }];
    
}

//增加收银员
-(void)BusinessMoneypeopleAdd
{
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    int a=2;
    [accountDefaults setInteger:a forKey:@"Addmoneypeople"];//增加店铺
    
    BusinessMoneypeopledetailsViewController*BusinessMoneypeopledetailsVC=[[BusinessMoneypeopledetailsViewController alloc]initWithNibName:@"BusinessMoneypeopledetailsViewController" bundle:nil];
    BusinessMoneypeopledetailsVC.moneydetailarray=[[NSMutableArray alloc]initWithCapacity:0];
    [BusinessMoneypeopledetailsVC.moneydetailarray addObjectsFromArray:self.shoparray];
    
    [self .navigationController pushViewController:BusinessMoneypeopledetailsVC animated:YES];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//获取店铺数量对应ID；
-(void)getShopFromData
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
            [self.shoparray addObjectsFromArray:keyData.MctShopList];
            
            
            [SVProgressHUD dismiss];
            self.tableView.hidden=NO;
            [self getMoneypeopleFromServer];
            
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:keyData.msg];
        }
        
    } failured:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:error.description];
        
    }];
    
}

-(void)getMoneypeopleFromServer
{
    
    
    MainViewController*mainVC=[MainViewController shareobject];
    // 判断网络是否存在
    if ( ![mainVC isConnectionAvailable] )
    {
        return;
    }
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    NSString*memberId=[userDefau objectForKey:@"memberId"];
    
    for (int i=0; i<self.shoparray.count; i++)
    {

        ShopDetailData*shop=[self.shoparray objectAtIndex:i];
        
        NSString*pagde=[[NSNumber numberWithInt:M_pagindex] stringValue];
        
        HttpClientRequest *httpClient = [HttpClientRequest sharedInstance];
        NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                               memberId, @"memberId",
                               pagde,@"pageIndex",
                               shop.MerchantShopId,@"merchantShopId",
                               nil];
        [httpClient request:@"MerchantCashierList.ashx" parameters:param successed:^(JSONDecoder *jsonDecoder, id responseObject) {
            NSData* data = [NSData dataWithData:responseObject];
            NSDictionary* handlJson = [jsonDecoder objectWithData:data];
            
            MoneypeopleData*keyData = [[MoneypeopleData alloc]initWithJsonObject:handlJson];
            
            BOOL success = [keyData.status boolValue];
            if (success)
            {
                if (keyData.CashierInfoList.count==0)
                {
                    [SVProgressHUD dismiss];
                    
                    if ([pagde isEqualToString:@"1"]) {
                        return ;
                    }
                    
                    if (once==1)
                    {
                        [self shopnum];//重新分析店铺
                        once++;
                    }

                }
                else
                {
                    [self.moneypeoplearray addObjectsFromArray:keyData.CashierInfoList];
                    
                    M_pagindex++;
                    [self getMoneypeopleFromServer];
                
                    
                }
   
                
            }
            else
            {
                [SVProgressHUD showErrorWithStatus:keyData.msg];
            }
            
        } failured:^(NSError *error) {
            
            [SVProgressHUD showErrorWithStatus:error.description];
            
        }];
        
    }


}


-(void)shopnum
{
    for (int i=0; i<self.shoparray.count; i++)
    {
        ShopDetailData*shop=[self.shoparray objectAtIndex:i];

        for (int j=0; j<self.moneypeoplearray.count; j++)
        {
            MoneypeopleDetailData*money=[self.moneypeoplearray objectAtIndex:j];
            
            if ([money.ShopName isEqualToString:shop.ShopName])
            {
              
                NSArray*keysarray= [self.shopdic allKeys];
   
                if ( [keysarray indexOfObject : shop.ShopName]!=NSNotFound)
                {
                    NSMutableArray*arr=  [self.shopdic objectForKey:shop.ShopName];
                    [arr addObject:money];
                }
                else
                {
                    NSMutableArray*arr=[[NSMutableArray alloc]init];
                    [arr addObject:money];
                    [self.shopdic setObject:arr forKey:shop.ShopName];
                }
                
            }
            
        }
        
    }
    [self.tableView reloadData];
    
}






#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.shopdic allKeys].count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString*key=[self.shopdic allKeys][section];
    NSMutableArray*arr=[self.shopdic objectForKey:key];
    return arr.count;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 58;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{

    NSString*key=[self.shopdic allKeys][section];
    return key;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    BusinessMoneypeopleCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray*cellarray=[[NSBundle mainBundle]
                           loadNibNamed:@"BusinessMoneypeopleCell" owner:self options:nil];
        cell =[cellarray objectAtIndex:0];
    }
    
    NSString*key=[self.shopdic allKeys][indexPath.section];
    NSMutableArray*arr=[self.shopdic objectForKey:key];
    
    MoneypeopleDetailData*money=[arr objectAtIndex:indexPath.row];
        UIImage *reSizeImage = [self.imagechage getImage:money.PhotoHead];
                
                if (reSizeImage != nil)
                {
                    cell.BusinessMoneypeople_Image.image=reSizeImage;
                }
                // 图片加载
                
                [cell.BusinessMoneypeople_Image setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",money.PhotoHead]]] placeholderImage:[UIImage imageNamed:@""] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                    
                cell.BusinessMoneypeople_Image.image=[CommonUtil scaleImage:image toSize:CGSizeMake(74, 51)];
                } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                }];
 
                cell.BusinessMoneypeople_Namelabel.text=money.Name;
                cell.BusinessMoneypeople_Numlabel.text=money.Account;

    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString*key=[self.shopdic allKeys][indexPath.section];
    NSMutableArray*arr=[self.shopdic objectForKey:key];
    
    MoneypeopleDetailData*money=[arr objectAtIndex:indexPath.row];
    
    
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    int a=1;
    [accountDefaults setInteger:a forKey:@"Addmoneypeople"];//查看修改店铺
    
    BusinessMoneypeopledetailsViewController*BusinessMoneypeopledetailsVC=[[BusinessMoneypeopledetailsViewController alloc]initWithNibName:@"BusinessMoneypeopledetailsViewController" bundle:nil];
    
    BusinessMoneypeopledetailsVC.moneydetail=money;
    //店铺数组
    BusinessMoneypeopledetailsVC.moneydetailarray=[[NSMutableArray alloc]initWithCapacity:0];
    [BusinessMoneypeopledetailsVC.moneydetailarray addObjectsFromArray:self.shoparray];
    
    [self .navigationController pushViewController:BusinessMoneypeopledetailsVC animated:YES];
    

    
}


@end
