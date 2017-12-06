//
//  RemindsystemViewController.m
//  BusinessCenter
//
//  Created by 冯海强 on 13-11-28.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import "RemindsystemViewController.h"
#import "RemindsystemCell.h"

#import "SVProgressHUD.h"
#import "xitongxiaoxiData.h"
#import "HttpClientRequest.h"

@interface RemindsystemViewController ()

@end

@implementation RemindsystemViewController

@synthesize m_webViewArray;

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
        self.xiaoxiarray = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_webViewArray = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_current = 0;

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self.B_ListTable setDelegate:self];
    [self.B_ListTable setDataSource:self];
    [self.B_ListTable setPullDelegate:self];
    self.B_ListTable.pullBackgroundColor = [UIColor whiteColor];
    self.B_ListTable.useRefreshView = YES;
    self.B_ListTable.useLoadingMoreView= YES;
    
    T_pageIndex=1;
    self.B_ListTable.hidden=YES;
    
    NSUserDefaults*product=[NSUserDefaults standardUserDefaults];
    NSString *str = [NSString stringWithFormat:@"%@",[product objectForKey:@"Message"]];
    if (str.intValue==1)
    {
        self.title=@"提醒";

        T_searchType=1;

    }

    if (str.intValue==3)
    {
        self.title=@"系统消息";

        T_searchType=2;
    }
    
   
    if ( isIOS7 ) {
        
        // tableView的线往右移了，添加这代码可以填充
        if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        }
        
    }

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

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
     // 请求数据
     [self getDataFromSeverRemind];
    
}


-(void)getDataFromSeverRemind;
{
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    NSString*memberId=[userDefau objectForKey:@"memberId"];
  
    MainViewController*mainVC=[MainViewController shareobject];
    // 判断网络是否存在
    if ( ![mainVC isConnectionAvailable] )
    {
        return;
    }
    
    HttpClientRequest *httpClient = [HttpClientRequest sharedInstance];
    
    NSString*pagde=[[NSNumber numberWithInt:T_pageIndex] stringValue];
    NSString*search=[[NSNumber numberWithInt:T_searchType] stringValue];

    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId, @"memberId",
                           pagde,@"pageIndex",
                           search,@"searchType",
                           nil];
    
    
    [SVProgressHUD showWithStatus:@"数据加载中..."];
    
    [httpClient request:@"MerchantMessageList.ashx" parameters:param successed:^(JSONDecoder *jsonDecoder, id responseObject) {
        
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [jsonDecoder objectWithData:data];
        
        xitongxiaoxiData *keyData = [[xitongxiaoxiData alloc]initWithJsonObject:handlJson];
        
        BOOL success = [keyData.status boolValue];
 
    
        if (success)
        {
            [SVProgressHUD dismiss];
            
            if (T_pageIndex == 1)
            {
                if (keyData.MerchantMessageList == nil || keyData.MerchantMessageList.count==0)
                {
                    [self.xiaoxiarray removeAllObjects];
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
                    [self.tableView addSubview:label];
                    
                    return;
                }
                else
                {
                    [self.xiaoxiarray addObjectsFromArray:keyData.MerchantMessageList];
                }
            }
            else
            {
                if (keyData.MerchantMessageList == nil || keyData.MerchantMessageList.count == 0)
                {
                    T_pageIndex--;
                }
                else
                {
                    [self.xiaoxiarray addObjectsFromArray:keyData.MerchantMessageList];
                }
            }
            
            
            // 初始化webView
            [self initData];
            
        }
        else
        {
            if (T_pageIndex > 1)
            {
                T_pageIndex--;
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
        
        if (T_pageIndex > 1)
        {
            T_pageIndex--;
        }
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        //self.tableView.pullLastRefreshDate = [NSDate date];
        self.B_ListTable.pullTableIsRefreshing = NO;
        self.B_ListTable.pullTableIsLoadingMore = NO;
        
    }];
}

- (void)initData{
    
    
    [self.m_webViewArray removeAllObjects];
    for (int i = 0; i < self.xiaoxiarray.count; i ++) {
        
        xitongxiaoxiDetailData *data = [self.xiaoxiarray objectAtIndex:i];
        
        NSString*str=[NSString stringWithFormat:@"%@",data.MsgCot];
        
        UIWebView *l_webView = [[UIWebView alloc]initWithFrame:CGRectMake(10, 27, 300, 97)];
        l_webView.delegate = self;
        [l_webView loadHTMLString:str baseURL:nil];
        
        [self.m_webViewArray addObject:l_webView];
        
    }
    
    m_current=0;
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
	
    [SVProgressHUD showWithStatus:@"加载中..."];
}

//webView加载完成后设置内容字体的大小，内容的高度
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [SVProgressHUD dismiss];
	
	CGFloat high=0.0;
    //UIWebView字体大小设为190
	NSString *jsString = [[NSString alloc] initWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%f%%'",190.0f];
    NSLog(@"jsString === %@",jsString);
    //	NSString *jsString = [[NSString alloc] initWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%d%%'",190];
    [webView stringByEvaluatingJavaScriptFromString:jsString];
    //获取webView的自适应高度
    high = [webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"].floatValue/3.0f;

    CGRect frame = [webView frame];
    frame.size.height = high;
    [webView setFrame:CGRectMake(10, 27, 300, high)];
    
    
    // 当计算到最后一个webView的高度时刷新列表
    m_current ++;
    
    if ( m_current >= self.xiaoxiarray.count ) {
        
        self.B_ListTable.hidden = NO;
		
		[self.B_ListTable reloadData];

    }

}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
	
	[SVProgressHUD dismiss];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.xiaoxiarray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UIWebView *webView = (UIWebView *)[self.m_webViewArray objectAtIndex:indexPath.row];
    
    return webView.frame.size.height + 40;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    RemindsystemCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray*cellarray=[[NSBundle mainBundle]
                           loadNibNamed:@"RemindsystemCell" owner:self options:nil];
        cell =[cellarray objectAtIndex:0];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }

    
    if (self.xiaoxiarray.count!=0)
    {
        xitongxiaoxiDetailData *data = [self.xiaoxiarray objectAtIndex:indexPath.row];
        
        cell.Remindsystem_titlelabel.text=data.MsgTitle;
        NSString*str=[NSString stringWithFormat:@"%@",data.MsgCot];
        
        [cell.m_webView loadHTMLString:str baseURL:nil];
        
        cell.m_webView.userInteractionEnabled = NO;
        
        UIWebView *webView = (UIWebView *)[self.m_webViewArray objectAtIndex:indexPath.row];
        
        cell.m_webView.backgroundColor = [UIColor redColor];
        cell.m_webView.frame = CGRectMake(10, 27, 300, webView.frame.size.height + 10);
        
        cell.Remindsystem_timelabel.text=data.CreateDate;
        
    }

    // Configure the cell...
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - PullTableViewDelegate

- (void)pullTableViewDidTriggerRefresh:(PullTableView*)pullTableView {
    
    T_pageIndex=1;
    m_current=0;
    [self.xiaoxiarray removeAllObjects];
    [self performSelector:@selector(getDataFromSeverRemind) withObject:nil];
    
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView*)pullTableView {
    
    T_pageIndex++;
    
    [self performSelector:@selector(getDataFromSeverRemind) withObject:nil];
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];

    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
 
 */

@end
