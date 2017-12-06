//
//  WIPTableViewController.m
//  BusinessCenter
//
//  Created by 冯海强 on 14-2-10.
//  Copyright (c) 2014年 冯海强. All rights reserved.
//

#import "WIPTableViewController.h"
#import "AdvertisementdetailViewController.h"
#import "InformationdetailViewController.h"
#import "PhotodetailViewController.h"

#import "SVProgressHUD.h"
#import "AppHttpClient.h"

@interface WIPTableViewController ()

@end

@implementation WIPTableViewController

//- (id)initWithStyle:(UITableViewStyle)style
//{
//    self = [super initWithStyle:style];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.W_ListTable setPullDelegate:self];
    self.W_ListTable.pullBackgroundColor = [UIColor whiteColor];
    self.W_ListTable.useRefreshView = YES;
    self.W_ListTable.useLoadingMoreView= YES;
    
  
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    padge=1;
    self.Warray=[[NSMutableArray alloc]initWithCapacity:0];
    
    self.W_ListTable.hidden = YES;
    
    
    if ([self.WIPTabelType isEqualToString:@"10"]){
        self.title=@"待审核广告";
        type=@"1";
        [self getDataFromServerAD];
        
    }else if ([self.WIPTabelType isEqualToString:@"11"]){
        self.title=@"已通过广告";
        type=@"2";
        [self getDataFromServerAD];
        
    }else if ([self.WIPTabelType isEqualToString:@"12"]){
        self.title=@"已退回广告";
        type=@"3";
        [self getDataFromServerAD];
        
    }else if ([self.WIPTabelType isEqualToString:@"13"]){
        self.title=@"已违规广告";
        type=@"4";
        [self getDataFromServerAD];
        
    }else if ([self.WIPTabelType isEqualToString:@"20"]){
        self.title=@"待审核资讯";
        type=@"1";
        [self getDataFromServerIn];
    }else if ([self.WIPTabelType isEqualToString:@"21"]){
        self.title=@"已通过资讯";
        type=@"2";
        [self getDataFromServerIn];
    }else if ([self.WIPTabelType isEqualToString:@"22"]){
        self.title=@"已退回资讯";
        type=@"3";
        [self getDataFromServerIn];
    }else if ([self.WIPTabelType isEqualToString:@"23"]){
        self.title=@"已违规资讯";
        type=@"4";
        [self getDataFromServerIn];
    }else if ([self.WIPTabelType isEqualToString:@"30"]){
        self.title=@"待审核相册";
        type=@"1";
        [self getDataFromServerPH];
    }else if ([self.WIPTabelType isEqualToString:@"31"]){
        self.title=@"已通过相册";
        type=@"2";
        [self getDataFromServerPH];
    }else if ([self.WIPTabelType isEqualToString:@"32"]){
        self.title=@"已退回相册";
        type=@"3";
        [self getDataFromServerPH];
    }else if ([self.WIPTabelType isEqualToString:@"33"]){
        self.title=@"已违规相册";
        type=@"4";
        [self getDataFromServerPH];
    }


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.Warray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    WIPTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray*cellarray=[[NSBundle mainBundle]
                           loadNibNamed:@"WIPTableCell" owner:self options:nil];
        cell =[cellarray objectAtIndex:0];
//        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    
    NSMutableDictionary *dic = [self.Warray objectAtIndex:indexPath.row];

    
    if ([self.WIPTabelType isEqualToString:@"10"]||[self.WIPTabelType isEqualToString:@"11"]||[self.WIPTabelType isEqualToString:@"12"]||[self.WIPTabelType isEqualToString:@"13"]){
        
        cell.photo=[dic objectForKey:@"FrontCover"];
        cell.WIP_NameTitleLable.text=[dic objectForKey:@"ADName"];
        cell.WIP_MemberLable.text=[dic objectForKey:@"AllName"];
        cell.WIP_TimeLable.text=[dic objectForKey:@"ModifyDate"];

    }
    else if ([self.WIPTabelType isEqualToString:@"20"]||[self.WIPTabelType isEqualToString:@"21"]||[self.WIPTabelType isEqualToString:@"22"]||[self.WIPTabelType isEqualToString:@"23"])
    {
        
        cell.photo=[dic objectForKey:@"PhotoUrl"];
        cell.WIP_NameTitleLable.text=[dic objectForKey:@"Title"];
        cell.WIP_MemberLable.text=[dic objectForKey:@"AllName"];
        cell.WIP_TimeLable.text=[dic objectForKey:@"ModifyDate"];
      
    }
    else if ([self.WIPTabelType isEqualToString:@"30"]||[self.WIPTabelType isEqualToString:@"31"]||[self.WIPTabelType isEqualToString:@"32"]||[self.WIPTabelType isEqualToString:@"33"])
    {
        cell.WIP_NameTitleLable.hidden=YES;
        cell.WIP_MemberLablename.frame=CGRectMake(86, 12, 65, 20);
        cell.WIP_TimeLablename.frame=CGRectMake(86, 42, 65, 20);
        cell.WIP_MemberLable.frame=CGRectMake(155, 12, 145, 20);
        cell.WIP_TimeLable.frame=CGRectMake(155, 42, 145, 20);
        
        
        cell.photo=[dic objectForKey:@"PhotoUrl"];
        cell.WIP_MemberLable.text=[dic objectForKey:@"AllName"];
        cell.WIP_TimeLable.text=[dic objectForKey:@"ModifyDate"];
    }

    
    return cell;
    
}


//选中CELL
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.WIPTabelType isEqualToString:@"10"]||[self.WIPTabelType isEqualToString:@"11"]||[self.WIPTabelType isEqualToString:@"12"]||[self.WIPTabelType isEqualToString:@"13"]){
        AdvertisementdetailViewController*AdvertisementVC=[[AdvertisementdetailViewController alloc]initWithNibName:@"AdvertisementdetailViewController" bundle:nil];
        AdvertisementVC.title=@"广告详情";
        if ([self.WIPTabelType isEqualToString:@"10"])
        {
            AdvertisementVC.Ishidden =@"YES";
        }else
            if ([self.WIPTabelType isEqualToString:@"11"])
        {
            AdvertisementVC.Ishidden =@"PASS";
        }
        else
        {
            AdvertisementVC.Ishidden =@"NO";
        }
        AdvertisementVC.ADdic=[self.Warray objectAtIndex:indexPath.row];
        [self .navigationController pushViewController:AdvertisementVC animated:YES];
    }
    else if ([self.WIPTabelType isEqualToString:@"20"]||[self.WIPTabelType isEqualToString:@"21"]||[self.WIPTabelType isEqualToString:@"22"]||[self.WIPTabelType isEqualToString:@"23"])
    {
        InformationdetailViewController*InformationVC=[[InformationdetailViewController alloc]initWithNibName:@"InformationdetailViewController" bundle:nil];
        InformationVC.title=@"资讯详情";
        if ([self.WIPTabelType isEqualToString:@"20"])
        {
            InformationVC.Ishidden =@"YES";
        }else
            if ([self.WIPTabelType isEqualToString:@"21"])
            {
                InformationVC.Ishidden =@"PASS";
            }
        else {
            InformationVC.Ishidden =@"NO";
        }
        InformationVC.Indic = [self.Warray objectAtIndex:indexPath.row];
        [self .navigationController pushViewController:InformationVC animated:YES];
    }
    else if ([self.WIPTabelType isEqualToString:@"30"]||[self.WIPTabelType isEqualToString:@"31"]||[self.WIPTabelType isEqualToString:@"32"]||[self.WIPTabelType isEqualToString:@"33"])
    {
        PhotodetailViewController*PhotoVC=[[PhotodetailViewController alloc]initWithNibName:@"PhotodetailViewController" bundle:nil];
        PhotoVC.title=@"相册详情";
        if ([self.WIPTabelType isEqualToString:@"30"])
        {
            PhotoVC.Ishidden =@"YES";
        }
        else
            if ([self.WIPTabelType isEqualToString:@"31"])
            {
                PhotoVC.Ishidden =@"PASS";
            }
        else
        {
            PhotoVC.Ishidden =@"NO";
        }
        PhotoVC.Phdic = [self.Warray objectAtIndex:indexPath.row];
        [self .navigationController pushViewController:PhotoVC animated:YES];
    }
    
}


//广告
-(void)getDataFromServerAD
{
    MainViewController *MAIN=[MainViewController shareobject];
    // 判断网络是否存在
    if ( ![MAIN isConnectionAvailable] ) {
        return;
    }
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    memberID=[userDefau objectForKey:@"memberId"];
    NSString*pagde=[[NSNumber numberWithInt:padge] stringValue];

    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberID, @"memberId",
                           [NSString stringWithFormat:@"%@",pagde],@"pageIndex",
                           type,@"searchType",
                           nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"WxAdvertiseList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
            NSLog(@"%@",json);
            NSMutableArray *metchantShop = [json valueForKey:@"WxAdvertiseList"];
            
            if (padge == 1) {
                if (metchantShop == nil || metchantShop.count == 0) {
                    
                    [self.Warray removeAllObjects];
                    [SVProgressHUD showErrorWithStatus:@"暂无数据"];
                    self.W_ListTable.hidden = NO;
                    self.W_ListTable.scrollEnabled = NO;
                    [self.W_ListTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
                    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0,320,[ UIScreen mainScreen ].bounds.size.height)];
                    label.backgroundColor=[UIColor whiteColor];
                    label.textAlignment=NSTextAlignmentCenter;
                    label.text=@"暂无数据";
                    label.font = [UIFont boldSystemFontOfSize:20];
                    label.textColor=[UIColor darkGrayColor];
                    [self.tableView addSubview:label];
                    return;
                    
                } else {
                    self.Warray = metchantShop;
                    
                }
            } else {
                if (metchantShop == nil || metchantShop.count == 0) {
                    padge--;
                } else {
                    [self.Warray addObjectsFromArray:metchantShop];
                    
                }
            }
            [self.W_ListTable reloadData];
            self.W_ListTable.hidden = NO;
        } else {
            if (padge > 1) {
                padge--;
            }
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        self.W_ListTable.pullLastRefreshDate = [NSDate date];
        self.W_ListTable.pullTableIsRefreshing = NO;
        self.W_ListTable.pullTableIsLoadingMore = NO;
    } failure:^(NSError *error) {
        if (padge > 1) {
            padge--;
        }
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        //self.tableView.pullLastRefreshDate = [NSDate date];
        self.W_ListTable.pullTableIsRefreshing = NO;
        self.W_ListTable.pullTableIsLoadingMore = NO;
    }];

}


//资讯
-(void)getDataFromServerIn
{
    MainViewController *MAIN=[MainViewController shareobject];
    // 判断网络是否存在
    if ( ![MAIN isConnectionAvailable] ) {
        return;
    }
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    memberID=[userDefau objectForKey:@"memberId"];
    NSString*pagde=[[NSNumber numberWithInt:padge] stringValue];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberID, @"memberId",
                           [NSString stringWithFormat:@"%@",pagde],@"pageIndex",
                           type,@"searchType",
                           nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"WxInfoList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
            NSLog(@"%@",json);
            NSMutableArray *metchantShop = [json valueForKey:@"WxInfoList"];
            
            if (padge == 1) {
                if (metchantShop == nil || metchantShop.count == 0) {
                    
                    [self.Warray removeAllObjects];
                    [SVProgressHUD showErrorWithStatus:@"暂无数据"];
                    
                    self.W_ListTable.hidden = NO;
                    self.W_ListTable.scrollEnabled = NO;
                    [self.W_ListTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
                    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0,320,[ UIScreen mainScreen ].bounds.size.height)];
                    label.backgroundColor=[UIColor whiteColor];
                    label.textAlignment=NSTextAlignmentCenter;
                    label.text=@"暂无数据";
                    label.font = [UIFont boldSystemFontOfSize:20];
                    label.textColor=[UIColor darkGrayColor];
                    [self.tableView addSubview:label];
                    return;
                    
                } else {
                    self.Warray = metchantShop;
                }
            } else {
                if (metchantShop == nil || metchantShop.count == 0) {
                    padge--;
                } else {
                    [self.Warray addObjectsFromArray:metchantShop];
                    
                }
            }
            [self.W_ListTable reloadData];
            self.W_ListTable.hidden = NO;
        } else {
            if (padge > 1) {
                padge--;
            }
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        self.W_ListTable.pullLastRefreshDate = [NSDate date];
        self.W_ListTable.pullTableIsRefreshing = NO;
        self.W_ListTable.pullTableIsLoadingMore = NO;
    } failure:^(NSError *error) {
        if (padge > 1) {
            padge--;
        }
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        //self.tableView.pullLastRefreshDate = [NSDate date];
        self.W_ListTable.pullTableIsRefreshing = NO;
        self.W_ListTable.pullTableIsLoadingMore = NO;
    }];
    
}


//相册
-(void)getDataFromServerPH
{
    MainViewController *MAIN=[MainViewController shareobject];
    // 判断网络是否存在
    if ( ![MAIN isConnectionAvailable] ) {
        return;
    }
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    memberID=[userDefau objectForKey:@"memberId"];
    NSString*pagde=[[NSNumber numberWithInt:padge] stringValue];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberID, @"memberId",
                           [NSString stringWithFormat:@"%@",pagde],@"pageIndex",
                           type,@"searchType",
                           nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"WxPhotoList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
            NSLog(@"%@",json);
            NSMutableArray *metchantShop = [json valueForKey:@"WxPhotoList"];
            
            if (padge == 1) {
                if (metchantShop == nil || metchantShop.count == 0) {
                    
                    [self.Warray removeAllObjects];
                    [SVProgressHUD showErrorWithStatus:@"暂无数据"];
                    self.W_ListTable.hidden = NO;
                    self.W_ListTable.scrollEnabled = NO;
                    [self.W_ListTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
                    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0,320,[ UIScreen mainScreen ].bounds.size.height)];
                    label.backgroundColor=[UIColor whiteColor];
                    label.textAlignment=NSTextAlignmentCenter;
                    label.text=@"暂无数据";
                    label.font = [UIFont boldSystemFontOfSize:20];
                    label.textColor=[UIColor darkGrayColor];
                    [self.tableView addSubview:label];
                    return;
                    
                } else {
                    self.Warray = metchantShop;
                    
                }
            } else {
                if (metchantShop == nil || metchantShop.count == 0) {
                    padge--;
                } else {
                    [self.Warray addObjectsFromArray:metchantShop];
                    
                }
            }
            [self.W_ListTable reloadData];
            self.W_ListTable.hidden = NO;
        } else {
            if (padge > 1) {
                padge--;
            }
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        self.W_ListTable.pullLastRefreshDate = [NSDate date];
        self.W_ListTable.pullTableIsRefreshing = NO;
        self.W_ListTable.pullTableIsLoadingMore = NO;
    } failure:^(NSError *error) {
        if (padge > 1) {
            padge--;
        }
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        //self.tableView.pullLastRefreshDate = [NSDate date];
        self.W_ListTable.pullTableIsRefreshing = NO;
        self.W_ListTable.pullTableIsLoadingMore = NO;
    }];
    
}

- (void)pullTableViewDidTriggerRefresh:(PullTableView*)pullTableView {
    
    padge=1;
    [self.Warray removeAllObjects];
    
    if ([self.WIPTabelType isEqualToString:@"10"]||[self.WIPTabelType isEqualToString:@"11"]||[self.WIPTabelType isEqualToString:@"12"]||[self.WIPTabelType isEqualToString:@"13"]){
        [self performSelector:@selector(getDataFromServerAD) withObject:nil];
    }
    else if ([self.WIPTabelType isEqualToString:@"20"]||[self.WIPTabelType isEqualToString:@"21"]||[self.WIPTabelType isEqualToString:@"22"]||[self.WIPTabelType isEqualToString:@"23"])
    {
        [self performSelector:@selector(getDataFromServerIn) withObject:nil];

    }
    else if ([self.WIPTabelType isEqualToString:@"30"]||[self.WIPTabelType isEqualToString:@"31"]||[self.WIPTabelType isEqualToString:@"32"]||[self.WIPTabelType isEqualToString:@"33"])
    {
        [self performSelector:@selector(getDataFromServerPH) withObject:nil];

    }

    
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView*)pullTableView {
    
    padge++;
    if ([self.WIPTabelType isEqualToString:@"10"]||[self.WIPTabelType isEqualToString:@"11"]||[self.WIPTabelType isEqualToString:@"12"]||[self.WIPTabelType isEqualToString:@"13"]){
        [self performSelector:@selector(getDataFromServerAD) withObject:nil];
    }
    else if ([self.WIPTabelType isEqualToString:@"20"]||[self.WIPTabelType isEqualToString:@"21"]||[self.WIPTabelType isEqualToString:@"22"]||[self.WIPTabelType isEqualToString:@"23"])
    {
        [self performSelector:@selector(getDataFromServerIn) withObject:nil];
        
    }
    else if ([self.WIPTabelType isEqualToString:@"30"]||[self.WIPTabelType isEqualToString:@"31"]||[self.WIPTabelType isEqualToString:@"32"]||[self.WIPTabelType isEqualToString:@"33"])
    {
        [self performSelector:@selector(getDataFromServerPH) withObject:nil];

    }
    
}






@end
