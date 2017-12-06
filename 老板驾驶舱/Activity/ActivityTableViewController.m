//
//  ActivityTableViewController.m
//  BusinessCenter
//
//  Created by 冯海强 on 13-11-20.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import "ActivityTableViewController.h"
#import "ActivityTableCell.h"
#import "ActivitydetailsViewController.h"
#import "SVProgressHUD.h"
#import "ActivityData.h"
#import "HttpClientRequest.h"
@interface ActivityTableViewController ()

@property (weak, nonatomic) IBOutlet UIButton *btnjiaqian;
@property (weak, nonatomic) IBOutlet UIButton *btnfanli;

@property (weak, nonatomic) IBOutlet UIView *btnview;

@end


@implementation ActivityTableViewController

//- (id)initWithStyle:(UITableViewStyle)style
//{
//    self = [super initWithStyle:style];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.Activityarray=[[NSMutableArray alloc]initWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.B_ListTable setPullDelegate:self];
    self.B_ListTable.pullBackgroundColor = [UIColor whiteColor];
    self.B_ListTable.useRefreshView = YES;
    self.B_ListTable.useLoadingMoreView= YES;
    
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"Activity.ID"];

    A_pageIndex=1;
    self.B_ListTable.hidden=YES;
    
    
    self.itemType = @"Price";//销售数量
    self.btnjiaqian.userInteractionEnabled = NO;
    self.btnfanli.userInteractionEnabled = YES;
    [self.btnjiaqian setBackgroundImage:[UIImage imageNamed:@"comm_tabar_selected.png"] forState:UIControlStateNormal];

    NSUserDefaults*activity=[NSUserDefaults standardUserDefaults];
    NSString *str = [NSString stringWithFormat:@"%@",[activity objectForKey:@"activity"]];
    if (str.intValue==1)
    {
        self.title=@"待审核活动";
        A_searchType=1;
        
        if (iPhone5) {
            
            self.B_ListTable.frame = CGRectMake(0, 0, viewsize.size.width, viewsize.size.height - 68);
            
        }else
        {
            
            self.B_ListTable.frame = CGRectMake(0, 0, viewsize.size.width, viewsize.size.height + 20);
        }
        
        [self getDataFromServer_A];

    }
    if (str.intValue==2)
    {
        self.title=@"进行中活动";
        A_searchType=2;
        
        [self getDataFromServer_A:self.itemType second:@"1"];

    }
    if (str.intValue==3)
    {
        self.title=@"已结束活动";
        A_searchType=3;

        [self getDataFromServer_A:self.itemType second:@"1"];

    }
    
  

}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"Activity.ID"]!=nil)
    {
        A_pageIndex=1;
        self.Activityarray=[[NSMutableArray alloc]initWithCapacity:0];
        
        if ([self.title isEqualToString:@"待审核活动"]) {
            [self getDataFromServer_A];
            
        }else
        {
            [self getDataFromServer_A:self.itemType second:@"1"];

        }
        
    }
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"Activity.ID"];

    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)changeType:(UIButton*)sender {
    
    A_pageIndex=1;
    [self.Activityarray removeAllObjects];
    
    [self.btnjiaqian setBackgroundImage:[UIImage imageNamed:@"comm_tabar_def.png"] forState:UIControlStateNormal];
    [self.btnjiaqian setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btnfanli setBackgroundImage:[UIImage imageNamed:@"comm_tabar_def.png"] forState:UIControlStateNormal];
    [self.btnfanli setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    if (sender == self.btnjiaqian) {
        
        self.B_ListTable.hidden = YES;
        self.btnjiaqian.userInteractionEnabled = NO;
        self.btnfanli.userInteractionEnabled = YES;
        
        [self.btnjiaqian setBackgroundImage:[UIImage imageNamed:@"comm_tabar_selected.png"] forState:UIControlStateNormal];
        self.itemType = @"Price";
        [self getDataFromServer_A:self.itemType second:@"1"];
        
    }
    if (sender == self.btnfanli) {
        
        self.B_ListTable.hidden = YES;
        
        self.btnjiaqian.userInteractionEnabled = YES;
        self.btnfanli.userInteractionEnabled = NO;

        
        [self.btnfanli setBackgroundImage:[UIImage imageNamed:@"comm_tabar_selected.png"] forState:UIControlStateNormal];
        self.itemType = @"Brokerage";
        [self getDataFromServer_A:self.itemType second:@"1"];
    }
      
}



-(void)getDataFromServer_A
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
    
    NSString*pagde=[[NSNumber numberWithInt:A_pageIndex] stringValue];
    NSString*search=[[NSNumber numberWithInt:A_searchType] stringValue];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId, @"memberId",
                           pagde,@"pageIndex",
                           search,@"searchType",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中..."];
    
    [httpClient request:@"ActivityList.ashx" parameters:param successed:^(JSONDecoder *jsonDecoder, id responseObject) {
        
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [jsonDecoder objectWithData:data];
        
        ActivityData*keyData = [[ActivityData alloc]initWithJsonObject:handlJson];
        
        BOOL success = [keyData.status boolValue];

    if (success)
    {
        [SVProgressHUD dismiss];
        
        if (A_pageIndex == 1)
        {
            if (keyData.ActivityList== nil ||keyData.ActivityList.count==0)
            {
                [self.Activityarray removeAllObjects];
                [SVProgressHUD showErrorWithStatus:@"暂无数据"];
                
                self.B_ListTable.hidden = NO;
                self.B_ListTable.scrollEnabled = NO;
                [self.B_ListTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
                UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0,320,[ UIScreen mainScreen ].bounds.size.height)];
                label.backgroundColor=[UIColor whiteColor];
                label.textAlignment=NSTextAlignmentCenter;
                label.text=@"暂无数据";
                label.font = [UIFont boldSystemFontOfSize:20];
                label.textColor=[UIColor darkGrayColor];
                [self.B_ListTable addSubview:label];
                return;
            }
            else
            {
                [self.Activityarray addObjectsFromArray:keyData.ActivityList];
            }
        }
        else
        {
            if (keyData.ActivityList == nil ||keyData.ActivityList.count== 0)
            {
                A_pageIndex--;
            }
            else
            {
                [self.Activityarray addObjectsFromArray:keyData.ActivityList];
            }
        }
        self.B_ListTable.hidden = NO;

        [self.B_ListTable reloadData];
    }
    else
    {
        if (A_pageIndex > 1)
        {
            A_pageIndex--;
        }
        NSString *msg = keyData.msg;
        [SVProgressHUD showErrorWithStatus:msg];
    }
    self.B_ListTable.pullLastRefreshDate = [NSDate date];
    self.B_ListTable.pullTableIsRefreshing = NO;
    self.B_ListTable.pullTableIsLoadingMore = NO;
    
    
} failured:^(NSError *error) {
    
    NSLog(@"error:%@",error.description);
    
    [SVProgressHUD showErrorWithStatus:error.description];
    
    if (A_pageIndex > 1)
    {
        A_pageIndex--;
    }
    //NSLog(@"failed:%@", error);
    [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    //self.tableView.pullLastRefreshDate = [NSDate date];
    self.B_ListTable.pullTableIsRefreshing = NO;
    self.B_ListTable.pullTableIsLoadingMore = NO;
    
}];


    
}


-(void)getDataFromServer_A:(NSString* )sortFiled second:(NSString *)sort
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
    
    NSString*pagde=[[NSNumber numberWithInt:A_pageIndex] stringValue];
    NSString*search=[[NSNumber numberWithInt:A_searchType] stringValue];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId, @"memberId",
                           pagde,@"pageIndex",
                           search,@"searchType",
                           sortFiled,@"sortFiled",
                           sort,@"sort",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中..."];
    NSLog(@"%@",param);
    
    [httpClient request:@"ActivityList_1_0.ashx" parameters:param successed:^(JSONDecoder *jsonDecoder, id responseObject) {
        
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [jsonDecoder objectWithData:data];
        
        ActivityData*keyData = [[ActivityData alloc]initWithJsonObject:handlJson];
        
        BOOL success = [keyData.status boolValue];
        
        if (success)
        {
            [SVProgressHUD dismiss];
            
            if (A_pageIndex == 1)
            {
                if (keyData.ActivityList== nil ||keyData.ActivityList.count==0)
                {
                    [self.Activityarray removeAllObjects];
                    [SVProgressHUD showErrorWithStatus:@"暂无数据"];
                    
                    self.B_ListTable.hidden = NO;
                    self.B_ListTable.scrollEnabled = NO;
                    [self.B_ListTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
                    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0,320,[ UIScreen mainScreen ].bounds.size.height)];
                    label.backgroundColor=[UIColor whiteColor];
                    label.textAlignment=NSTextAlignmentCenter;
                    label.text=@"暂无数据";
                    label.font = [UIFont boldSystemFontOfSize:20];
                    label.textColor=[UIColor darkGrayColor];
                    [self.B_ListTable addSubview:label];
                    return;
                }
                else
                {
                    [self.Activityarray addObjectsFromArray:keyData.ActivityList];
                }
            }
            else
            {
                if (keyData.ActivityList == nil ||keyData.ActivityList.count== 0)
                {
                    A_pageIndex--;
                }
                else
                {
                    [self.Activityarray addObjectsFromArray:keyData.ActivityList];
                }
            }
            self.B_ListTable.hidden = NO;
            
            [self.B_ListTable reloadData];
        }
        else
        {
            if (A_pageIndex > 1)
            {
                A_pageIndex--;
            }
            NSString *msg = keyData.msg;
            [SVProgressHUD showErrorWithStatus:msg];
        }
        self.B_ListTable.pullLastRefreshDate = [NSDate date];
        self.B_ListTable.pullTableIsRefreshing = NO;
        self.B_ListTable.pullTableIsLoadingMore = NO;
        
        
    } failured:^(NSError *error) {
        
        NSLog(@"error:%@",error.description);
        
        [SVProgressHUD showErrorWithStatus:error.description];
        
        if (A_pageIndex > 1)
        {
            A_pageIndex--;
        }
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        //self.tableView.pullLastRefreshDate = [NSDate date];
        self.B_ListTable.pullTableIsRefreshing = NO;
        self.B_ListTable.pullTableIsLoadingMore = NO;
        
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
    return self.Activityarray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    ActivityTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray*cellarray=[[NSBundle mainBundle]
                           loadNibNamed:@"ActivityTableCell" owner:self options:nil];
        cell =[cellarray objectAtIndex:0];
    }
    
    
    
    if ( self.Activityarray.count != 0 )
    {
        
        ActivityDetailData *data = [self.Activityarray objectAtIndex:indexPath.row];
        self.A_photoarray=[[NSMutableArray alloc]initWithCapacity:0];
        [self.A_photoarray addObjectsFromArray:data.ActivityPosterList];
        
        for (int i=0; i<self.A_photoarray.count; i++)
        {
            ActivityPhontoData *photoData = [self.A_photoarray objectAtIndex:i];
            
            if ([[NSString stringWithFormat:@"%@",photoData.IsFrontCover] isEqualToString:@"1"])
            {
                UIImage *reSizeImage = [self.imagechage getImage:photoData.SmlPoster];
                
                if (reSizeImage != nil)
                {
                    cell.Activity_photo.image=reSizeImage;
                }
                // 图片加载
                
                [cell.Activity_photo setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",photoData.SmlPoster]]] placeholderImage:[UIImage imageNamed:@""] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                    
                    cell.Activity_photo.image=[CommonUtil scaleImage:image toSize:CGSizeMake(74, 60)];
                    
                    [self.imagechage addImage:reSizeImage andUrl:photoData.SmlPoster];
                } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                }];
            }
            
        }
        
        cell.Activity_NameLable.text=data.ActivityName;


        if ([[NSString stringWithFormat:@"%@",data.ActStartDate]isEqualToString:[NSString stringWithFormat:@"%@",data.ActEndDate]])
        {
            
             NSString *date = [data.ActStartDate substringToIndex:10];
            cell.Activity_TimeLable.text=[NSString stringWithFormat:@"%@%@%@%@%@",date,@"  ",@"-",@"  ",date];
        }else
        {
            NSString *date1 = [data.ActStartDate substringToIndex:10];
            NSString *date2 = [data.ActEndDate substringToIndex:10];

            cell.Activity_TimeLable.text=[NSString stringWithFormat:@"%@%@%@%@%@",date1,@" ",@"-",@" ",date2];
        }
        cell.Activity_AddressLable.text=data.Address;
        cell.Activity_NewMoneylabel.text=[NSString stringWithFormat:@"￥%@",data.Price];
        cell.Activity_OldMoneyLable.text=[NSString stringWithFormat:@"￥%@",data.OriginalPrice];
        cell.Activity_PerMoneyLable.text=[NSString stringWithFormat:@"%@%@%@%@",data.Brokerage,@"%",data.BrokerageAmount,@"元"];
        
        
    }
    

    
    
    return cell;
}

//选中CELL
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

    ActivitydetailsViewController*ActivitydetailsTableVC=[[ActivitydetailsViewController alloc]initWithNibName:@"ActivitydetailsViewController" bundle:nil];
    
    ActivityDetailData *data = [self.Activityarray objectAtIndex:indexPath.row];
    ActivitydetailsTableVC.activityDetailData=data;
    ActivitydetailsTableVC.activityphotoarray =[[NSMutableArray alloc]initWithCapacity:0];
    [ActivitydetailsTableVC.activityphotoarray addObjectsFromArray:data.ActivityPosterList];
    [self .navigationController pushViewController:ActivitydetailsTableVC animated:YES];
    
}



- (void)pullTableViewDidTriggerRefresh:(PullTableView*)pullTableView {
    
    A_pageIndex=1;
    [self.Activityarray removeAllObjects];
    
    if ([self.title isEqualToString:@"待审核活动"]) {
        [self performSelector:@selector(getDataFromServer_A) withObject:nil];
        
    }else
    {
        [self getDataFromServer_A:self.itemType second:@"1"];
        
        
    }
    
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView*)pullTableView {
    
    A_pageIndex++;
    
    if ([self.title isEqualToString:@"待审核活动"]) {
        [self performSelector:@selector(getDataFromServer_A) withObject:nil];
        
    }else
    {
        [self getDataFromServer_A:self.itemType second:@"1"];
        
    }
    
}



@end
