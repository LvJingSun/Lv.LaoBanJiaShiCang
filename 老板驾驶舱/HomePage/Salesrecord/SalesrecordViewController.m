//
//  SalesrecordViewController.m
//  BusinessCenter
//
//  Created by 冯海强 on 13-11-19.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import "SalesrecordViewController.h"
#import "SalesrecordCell.h"
#import "SRdetailsViewController.h"

#import "SVProgressHUD.h"
#import "salesrecordData.h"
#import "HttpClientRequest.h"

@interface SalesrecordViewController ()

@end

@implementation SalesrecordViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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
      
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.B_ListTable.hidden=YES;
    
    [self.B_ListTable setDelegate:self];
    [self.B_ListTable setDataSource:self];
    [self.B_ListTable setPullDelegate:self];
    self.B_ListTable.pullBackgroundColor = [UIColor whiteColor];
    self.B_ListTable.useRefreshView = YES;
    self.B_ListTable.useLoadingMoreView= YES;
    
    self.title=@"近期销售记录";
    
    self.salesrecordarray=[[NSMutableArray alloc]init];
    [self getDataFromSever];
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


-(void)getDataFromSever
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
                           memberId,@"memberId",
                           nil];
    
    
    [SVProgressHUD showWithStatus:@"数据加载中..."];
    
    [httpClient request:@"OrderList.ashx" parameters:param successed:^(JSONDecoder *jsonDecoder, id responseObject) {
        
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [jsonDecoder objectWithData:data];
        
        salesrecordData *keyData = [[salesrecordData alloc]initWithJsonObject:handlJson];
        
        BOOL success = [keyData.status boolValue];
        
        if (success)
        {
            [SVProgressHUD dismiss];

            if (keyData.OrderList.count==0)
            {
                [SVProgressHUD showErrorWithStatus:@"暂无数据!"];
                
                self.B_ListTable.hidden = NO;
                self.B_ListTable.scrollEnabled = NO;
                [self.B_ListTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
                UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0,320,[ UIScreen mainScreen ].bounds.size.height)];
                label.backgroundColor=[UIColor whiteColor];
                label.textAlignment=NSTextAlignmentCenter;
                label.text=@"暂无数据";
                label.font = [UIFont boldSystemFontOfSize:20];
                label.textColor=[UIColor darkGrayColor];
                [self.tableView addSubview:label];
            }
            else
            {
                [self.salesrecordarray addObjectsFromArray:keyData.OrderList];
            }
            
            if (self.salesrecordarray.count!=0)
            {
                self.B_ListTable.hidden=NO;
            }
         

            [self.B_ListTable reloadData];
            self.B_ListTable.pullLastRefreshDate = [NSDate date];
            self.B_ListTable.pullTableIsRefreshing = NO;
            self.B_ListTable.pullTableIsLoadingMore = NO;
            
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

    return self.salesrecordarray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    salesrecordDetailData *data = [self.salesrecordarray objectAtIndex:indexPath.row];
    
    CGSize size = [data.SvcName sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(280, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    
    return size.height +30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    SalesrecordCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray*cellarray=[[NSBundle mainBundle]
                           loadNibNamed:@"SalesrecordCell" owner:self options:nil];
        cell =[cellarray objectAtIndex:0];
    }
    
    if (self.salesrecordarray.count!=0)
    {
        salesrecordDetailData *data = [self.salesrecordarray objectAtIndex:indexPath.row];
        
        cell.Salesrecord_contenttextview.text=data.SvcName;
        
        CGSize size = [data.SvcName sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(280, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        cell.Salesrecord_contenttextview.frame = CGRectMake(cell.Salesrecord_contenttextview.frame.origin.x, cell.Salesrecord_contenttextview.frame.origin.y, 280, size.height+5);
        cell.Salesrecord_contenttextview.numberOfLines = 0;// 不可少Label属性
        
        cell.Salesrecord_timelabel.text=data.OrdCode;
        
    }


    // Configure the cell...
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SRdetailsViewController*SRdetailsVC=[[SRdetailsViewController alloc]initWithNibName:@"SRdetailsViewController" bundle:nil];
    
    SRdetailsVC.saledetail = [self.salesrecordarray objectAtIndex:indexPath.row];
    
    [self .navigationController pushViewController:SRdetailsVC animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    
    
}



- (void)pullTableViewDidTriggerRefresh:(PullTableView*)pullTableView {
    
    [self.salesrecordarray removeAllObjects];
    [self performSelector:@selector(getDataFromSever) withObject:nil];
    
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView*)pullTableView {
    
    [self.salesrecordarray removeAllObjects];

    [self performSelector:@selector(getDataFromSever) withObject:nil];
    
}


@end
