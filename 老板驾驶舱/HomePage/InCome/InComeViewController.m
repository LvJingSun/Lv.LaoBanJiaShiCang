//
//  InComeViewController.m
//  BusinessCenter
//
//  Created by 冯海强 on 13-11-19.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import "InComeViewController.h"
#import "InComeCell.h"

#import "SVProgressHUD.h"
#import "TodayMoneyData.h"
#import "HttpClientRequest.h"

@interface InComeViewController ()



@end

@implementation InComeViewController

@synthesize Indayarray;

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
        Indayarray = [[NSMutableArray alloc]initWithCapacity:0];
        self.m_webViewArray = [[NSMutableArray alloc]initWithCapacity:0];
        m_current = 0;
        

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.B_ListTable.hidden = YES;
    
    searchType=@"1";
    n_pageIndex=1;


    [self.B_ListTable setDelegate:self];
    [self.B_ListTable setDataSource:self];
    [self.B_ListTable setPullDelegate:self];
    self.B_ListTable.pullBackgroundColor = [UIColor whiteColor];
    self.B_ListTable.useRefreshView = YES;
    self.B_ListTable.useLoadingMoreView= YES;
    
    NSUserDefaults*product=[NSUserDefaults standardUserDefaults];
    NSString *str = [NSString stringWithFormat:@"%@",[product objectForKey:@"Income"]];
    if (str.intValue==1)
    {
        self.title=@"今日收入";
        tradingOperations=@"1";

    }
    if (str.intValue==2)
    {
        self.title=@"本周收入";
        tradingOperations=@"2";

    }
    if (str.intValue==3)
    {
        self.title=@"本月收入";
        tradingOperations=@"3";

        
    }
    if (str.intValue==4)
    {
        self.title=@"近三月收入";
        tradingOperations=@"4";

    }
    
    UIBarButtonItem *wangcheng =[[UIBarButtonItem alloc] initWithTitle:self.Allmoney style:UIBarButtonItemStyleBordered target:nil action:nil];

    self.navigationItem.rightBarButtonItem=wangcheng;
    self.navigationItem.rightBarButtonItem.enabled=NO;


    [self getDataFromServerIn];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    

}


-(void)getDataFromServerIn
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
    
       NSString*pagde=[[NSNumber numberWithInt:n_pageIndex] stringValue];
    


        NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                               memberId, @"memberId",
                               pagde,@"pageIndex",
                               tradingOperations,@"searchType",
                               searchType,@"tradingOperations",
                               nil];
        
        
        [SVProgressHUD showWithStatus:@"数据加载中..."];
        
        [httpClient request:@"MerchantTranRcdsList.ashx" parameters:param successed:^(JSONDecoder *jsonDecoder, id responseObject) {
            
            
            NSData* data = [NSData dataWithData:responseObject];
            
            NSDictionary* handlJson = [jsonDecoder objectWithData:data];
            
            TodayMoneyData *keyData = [[TodayMoneyData alloc]initWithJsonObject:handlJson];

            BOOL success = [keyData.status boolValue];
            
            if (success)
            {
                [SVProgressHUD dismiss];

                if (n_pageIndex == 1)
                {
                    if (keyData.MerchantTranRcdsList == nil || keyData.MerchantTranRcdsList.count==0)
                    {
                        [self.Indayarray removeAllObjects];
                        self.B_ListTable.hidden = NO;
                        self.B_ListTable.scrollEnabled = NO;
                        [self.B_ListTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
                        [SVProgressHUD showErrorWithStatus:@"暂无数据"];
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
                        [self.Indayarray addObjectsFromArray: keyData.MerchantTranRcdsList];
                    }
                }
                else
                {
                    if (keyData.MerchantTranRcdsList == nil || keyData. MerchantTranRcdsList.count == 0)
                    {
                        n_pageIndex--;
                    }
                    else
                    {
                        [self.Indayarray addObjectsFromArray:keyData.   MerchantTranRcdsList];
                    }
                }
                
                [self initData];
            }

            else
            {
                if (n_pageIndex > 1)
                {
                    n_pageIndex--;
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
            
            if (n_pageIndex > 1)
            {
                n_pageIndex--;
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
    
    for (int i = 0; i < self.Indayarray.count; i ++) {

        TodayDetailData *data = [self.Indayarray objectAtIndex:i];
        
        NSString*str=[NSString stringWithFormat:@"%@",data.Description];
        
        UIWebView *l_webView = [[UIWebView alloc]initWithFrame:CGRectMake(95,2, 220,145)];
        
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
    [webView stringByEvaluatingJavaScriptFromString:jsString];
    //获取webView的自适应高度
    high = [webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"].floatValue/3.0f;
    
    CGRect frame = [webView frame];
    frame.size.height = high;
    [webView setFrame:CGRectMake(95,2, 220, high+5)];

    NSLog(@"%f",high);
    
    
    
    // 当计算到最后一个webView的高度时刷新列表
    m_current ++;

    if ( m_current >= self.Indayarray.count ) {
        
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

    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.Indayarray.count;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UIWebView *webView = (UIWebView *)[self.m_webViewArray objectAtIndex:indexPath.row];
    
    return webView.frame.size.height+30;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    InComeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray*cellarray=[[NSBundle mainBundle]
                           loadNibNamed:@"InComeCell" owner:self options:nil];
        cell =[cellarray objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    
    if ( self.Indayarray.count != 0 )
    {

        TodayDetailData *data = [self.Indayarray objectAtIndex:indexPath.row];
        
        cell.InCome_timelabel.text=data.TransactionDate;
        cell.InCome_moneylabel.text=[NSString stringWithFormat:@"￥%@",data.Amount];
        NSString*str=[NSString stringWithFormat:@"%@",data.Description];
        [cell.m_webView loadHTMLString:str baseURL:nil];
        cell.m_webView.userInteractionEnabled = NO;
        UIWebView *webView = (UIWebView *)[self.m_webViewArray objectAtIndex:indexPath.row];
        cell.m_webView.frame = CGRectMake(cell.m_webView.frame.origin.x, cell.m_webView.frame.origin.y, cell.m_webView.frame.size.width, webView.frame.size.height);
        cell.InCome_timelabel.frame = CGRectMake(cell.InCome_timelabel.frame.origin.x, cell.m_webView.frame.origin.y+webView.frame.size.height, cell.InCome_timelabel.frame.size.width, cell.InCome_timelabel.frame.size.height);
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}




#pragma mark - PullTableViewDelegate

- (void)pullTableViewDidTriggerRefresh:(PullTableView*)pullTableView {

        n_pageIndex=1;
        m_current=0;
    
        [self.Indayarray removeAllObjects];
        [self performSelector:@selector(getDataFromServerIn) withObject:nil];

}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView*)pullTableView {
  
        n_pageIndex++;
        
        [self performSelector:@selector(getDataFromServerIn) withObject:nil];

}

@end
