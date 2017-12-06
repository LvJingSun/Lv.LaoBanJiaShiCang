//
//  PIPincomeViewController.m
//  BusinessCenter
//
//  Created by 冯海强 on 13-11-20.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import "PIPincomeViewController.h"
#import "PIPincomeCell.h"

#import "SVProgressHUD.h"
#import "PIPinorexData.h"
#import "HttpClientRequest.h"

@interface PIPincomeViewController ()

- (IBAction)showCalendar:(id)sender;
- (IBAction)showCalendarright:(id)sender;

@property(nonatomic,weak)IBOutlet UITextField*PIPincome_daytextfiled;//前面日期
@property(nonatomic,weak)IBOutlet UITextField*PIPincome_enddaytextfiled;//后日期
@property(nonatomic,strong) NSMutableArray*soonviewarray;//子视图数组；
@property (nonatomic,strong)  UIDatePicker *datePicker;


@end

@implementation PIPincomeViewController
@synthesize datePicker;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.PIPincomearray=[[NSMutableArray alloc]initWithCapacity:0];
        self.m_webViewArray=[[NSMutableArray alloc]initWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    label=[[UILabel alloc]initWithFrame:CGRectMake(0,33,320,[ UIScreen mainScreen ].bounds.size.height)];
    label.backgroundColor=[UIColor whiteColor];
    label.textAlignment=NSTextAlignmentCenter;
    label.text=@"暂无数据";
    label.textColor=[UIColor darkGrayColor];
    [PIPincome_view addSubview:label];
    
    [self.PIPincome_tableview setDelegate:self];
    [self.PIPincome_tableview setDataSource:self];
    [self.PIPincome_tableview setPullDelegate:self];
    self.PIPincome_tableview.pullBackgroundColor = [UIColor whiteColor];
    self.PIPincome_tableview.useRefreshView = YES;
    self.PIPincome_tableview.useLoadingMoreView= YES;
    
    NSUserDefaults*product=[NSUserDefaults standardUserDefaults];
    NSString *str = [NSString stringWithFormat:@"%@",[product objectForKey:@"PIPInEx"]];
    if (str.intValue==1)
    {
        self.title=@"收入记录";
        
    }
    
    if (str.intValue==2)
    {
        self.title=@"支出记录";
    }

 
    self.soonviewarray=[[NSMutableArray alloc]init];
    self.PIPincome_daytextfiled.delegate=self;
    self.PIPincome_enddaytextfiled.delegate=self;
    
    PI_pageindex=1;

    self.PIPincome_tableview.hidden=YES;
    self.PIPincome_daytextfiled.enabled=NO;
    self.PIPincome_enddaytextfiled.enabled=NO;
    
    [self.view addSubview:PIPincome_view];
    CGRect rx = [ UIScreen mainScreen ].bounds;//手机尺寸
    PIPincome_view.frame  = CGRectMake(0, 0, 320,rx.size.height);
    double version = [[UIDevice currentDevice].systemVersion doubleValue];//判定系统版本。
    if (version==7)
    {
        PIPincome_view.center=CGPointMake(PIPincome_view.center.x,PIPincome_view.center.y);
    }
//    [self.PIPincome_tableview setCenter:CGPointMake(160, self.PIPincome_tableview.center.y)];
    
    
    NSDate *now=[[NSDate alloc] init];
    self.datePicker=[[UIDatePicker alloc]init];
    [datePicker setDate:now animated:NO];
    [datePicker setDatePickerMode:UIDatePickerModeDate];


    NSString *c = [[self StringFromdate:self.datePicker.date] substringToIndex:8];

    self.PIPincome_daytextfiled.text=[NSString stringWithFormat:@"%@01",c];
    self.PIPincome_enddaytextfiled.text=[self StringFromdate:self.datePicker.date];

    [self getDataFromServer];

    [self initWithPickerView];

    [self.m_datePicker setHidden:YES];
    [self.m_toolbar setHidden:YES];
    
    // Do any additional setup after loading the view from its nib.
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self doPCAPickerCancel];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//将nsdate转换成string
- (NSString *)StringFromdate:(NSDate *)dateString
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    
    [format setDateFormat:@"yyyy-MM-dd"];// HH:mm:ss
    
    NSString *timestr = [format stringFromDate:dateString];
    
    return timestr;
    
}



#pragma 初始化pickerView
- (void)initWithPickerView{
	
    UIWindow *window = self.navigationController.view.window;
	//  datePickerView初始化
	self.m_datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 210, 320, 200)];
    [self.m_datePicker setDatePickerMode:UIDatePickerModeDate];
	[self.m_datePicker addTarget:self action:@selector(togglePicker) forControlEvents:UIControlEventValueChanged];
    self.m_datePicker.backgroundColor = [UIColor whiteColor];
	[window addSubview:self.m_datePicker];
    
    
    
    
    UIToolbar *pickerBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.m_datePicker.frame.origin.y - 44, 320, 44)];
    pickerBar.barStyle = UIBarStyleBlackTranslucent;
    
    UIBarButtonItem *cancelBarButton = [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                                        style:UIBarButtonItemStyleDone
                                                                       target:self
                                                                       action:@selector(doPCAPickerCancel)];
    
    
    UIBarButtonItem *spaceButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                    target:nil
                                                                                    action:nil];
    
    
    UIBarButtonItem *lastButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成"
                                                                       style:UIBarButtonItemStyleDone
                                                                      target:self
                                                                      action:@selector(doPCAPickerDone)];
    
    NSArray *pickArray = [NSArray arrayWithObjects: cancelBarButton, spaceButtonItem, lastButtonItem, nil];
    [pickerBar setItems:pickArray animated:YES];
    [window addSubview:pickerBar];
    pickerBar.backgroundColor = [UIColor clearColor];
    self.m_toolbar = pickerBar;
    
    [window addSubview:self.m_toolbar];
    

    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYY-MM-dd"];
    
    self.m_dataString = [formatter stringFromDate:self.m_datePicker.date];

    //    self.PE_Data.text = [NSString stringWithFormat:@"%@",str];
    
}


#pragma mark - PickerBar按钮//完成
- (void)doPCAPickerDone{
    
    [self.m_datePicker setHidden:YES];
    
    [self.m_toolbar setHidden:YES];
    
    if ([self.KeyString isEqualToString:@"1"]) {

        if ( self.isSelected ) {
            
            self.PIPincome_daytextfiled.text = [NSString stringWithFormat:@"%@",self.m_dataString];
            
        }else{
            
            self.PIPincome_daytextfiled.text = [NSString stringWithFormat:@"%@",self.m_dataString];
            
        }
    }else if ([self.KeyString isEqualToString:@"2"])
    {
        if ( self.isSelected ) {
            
            self.PIPincome_enddaytextfiled.text = [NSString stringWithFormat:@"%@",self.m_dataString];
            
        }else{
            
            self.PIPincome_enddaytextfiled.text = [NSString stringWithFormat:@"%@",self.m_dataString];
            
        }

        
    }

}


- (void)doPCAPickerCancel{
    
    [self.m_datePicker setHidden:YES];
    
    [self.m_toolbar setHidden:YES];
    
}


// pickerView的选择事件
- (void) togglePicker{
    
    self.isSelected = YES;
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYY-MM-dd"];
    
    NSString *str = [formatter stringFromDate:self.m_datePicker.date];
    
    self.m_dataString = [NSString stringWithFormat:@"%@",str];

}





- (IBAction)showCalendar:(id)sender
{
    self.KeyString=@"1";

    [self.view endEditing:YES];
    
    self.m_datePicker.hidden = NO;
    
    self.m_toolbar.hidden = NO;
}



- (IBAction)showCalendarright:(id)sender
{
    
    self.KeyString=@"2";
    
    [self.view endEditing:YES];
    
    self.m_datePicker.hidden = NO;
    
    self.m_toolbar.hidden = NO;
}



-(IBAction)CheckInfordate:(id)sender
{
    [self.PIPincomearray removeAllObjects];
    
    [self getDataFromServer];
    
}





-(void)getDataFromServer
{
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    NSString*memberId=[userDefau objectForKey:@"memberId"];
    NSString*tradingOperations=[userDefau objectForKey:@"PIPInEx"];
    
    MainViewController*mainVC=[MainViewController shareobject];
    // 判断网络是否存在
    if ( ![mainVC isConnectionAvailable] )
    {
        return;
    }
    
    HttpClientRequest *httpClient = [HttpClientRequest sharedInstance];
  
    NSString*pagde=[[NSNumber numberWithInt:PI_pageindex] stringValue];

    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId, @"memberId",
                           pagde,@"pageIndex",
                           tradingOperations,@"tradingOperations",
                           self.PIPincome_daytextfiled.text,@"createTimeS",
                           self.PIPincome_enddaytextfiled.text,@"createTimeE",
                           nil];

    [SVProgressHUD showWithStatus:@"数据加载中..."];
    
    [httpClient request:@"MctInOrExRcdsList.ashx" parameters:param successed:^(JSONDecoder *jsonDecoder, id responseObject) {
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [jsonDecoder objectWithData:data];
        
        PIPinorexData *keyData = [[PIPinorexData alloc]initWithJsonObject:handlJson];
        
        BOOL success = [keyData.status boolValue];

    if (success)
    {
        [SVProgressHUD dismiss];
        
        if (PI_pageindex == 1)
        {
            if (keyData.MerchantTranRcdsList == nil || keyData.MerchantTranRcdsList.count==0)
            {
                [self.PIPincomearray removeAllObjects];
                [SVProgressHUD showErrorWithStatus:@"暂无数据"];
                self.PIPincome_tableview.hidden = YES;
                label.hidden=NO;
                return;
            }
            else
            {
                [self.PIPincomearray addObjectsFromArray:keyData.MerchantTranRcdsList];
            }
        }
        else
        {
            if (keyData.MerchantTranRcdsList == nil ||keyData.MerchantTranRcdsList.count == 0)
            {
                PI_pageindex--;

            }
            else
            {
    
                [self.PIPincomearray addObjectsFromArray:keyData.MerchantTranRcdsList ];
            }
        }
        
        [self initData];
        
    }
    else
    {
        if (PI_pageindex > 1)
        {
            PI_pageindex--;
        }
        NSString *msg = keyData.msg;
        [SVProgressHUD showErrorWithStatus:msg];
    }
    self.PIPincome_tableview.pullLastRefreshDate = [NSDate date];
    self.PIPincome_tableview.pullTableIsRefreshing = NO;
    self.PIPincome_tableview.pullTableIsLoadingMore = NO;
    
    
} failured:^(NSError *error) {
    
    NSLog(@"error:%@",error.description);
    
    [SVProgressHUD showErrorWithStatus:error.description];
    
    if (PI_pageindex > 1)
    {
        PI_pageindex--;
    }
    //NSLog(@"failed:%@", error);
    [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    //self.tableView.pullLastRefreshDate = [NSDate date];
    self.PIPincome_tableview.pullTableIsRefreshing = NO;
    self.PIPincome_tableview.pullTableIsLoadingMore = NO;
    
}];
    
}




- (void)initData{
    
    [self.m_webViewArray removeAllObjects];
    
    for (int i = 0; i < self.PIPincomearray.count; i ++) {
        
        PIPinorexDetailData *data = [self.PIPincomearray objectAtIndex:i];
        
        NSString*str=[NSString stringWithFormat:@"%@",data.Description];
        
        UIWebView *l_webView = [[UIWebView alloc]initWithFrame:CGRectMake(5, 50, 310, 120)];
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
    
    label.hidden=YES;

	CGFloat high=0.0;
    //UIWebView字体大小设为190
	NSString *jsString = [[NSString alloc] initWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%f%%'",190.0f];
    [webView stringByEvaluatingJavaScriptFromString:jsString];
    //获取webView的自适应高度
    high = [webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"].floatValue/3.0f;
    
    CGRect frame = [webView frame];
    frame.size.height = high;
    [webView setFrame:CGRectMake(5,45, 310, high+15)];

    
    // 当计算到最后一个webView的高度时刷新列表
    m_current ++;
    
    if ( m_current >= self.PIPincomearray.count ) {
        
        self.PIPincome_tableview.hidden = NO;
		[self.PIPincome_tableview reloadData];
        
    }
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
	
	[SVProgressHUD dismiss];
    
}



//tableview

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView//区块
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section//一块有几行；
{
    
    return self.PIPincomearray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIWebView *webView = (UIWebView *)[self.m_webViewArray objectAtIndex:indexPath.row];
    return webView.frame.size.height + 50;
}

//显示tableview
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    PIPincomeCell*cell =[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell )
    {
        NSArray*cellarray=[[NSBundle mainBundle]
                           loadNibNamed:@"PIPincomeCell" owner:self options:nil];
        cell =[cellarray objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    NSString*tradingOperations=[userDefau objectForKey:@"PIPInEx"];
    
    if ([[NSString stringWithFormat:@"%@",tradingOperations] isEqualToString:@"1"])
    {
        cell.PIPincome_moneylabelname.text=@"收入金额:";
        cell.PIPincome_explainlabelname.text=@"收入说明";
    }
    if ([[NSString stringWithFormat:@"%@",tradingOperations] isEqualToString:@"2"])
    {
        cell.PIPincome_moneylabelname.text=@"支出金额:";
        cell.PIPincome_explainlabelname.text=@"支出说明";
    }
    
    
    if ( self.PIPincomearray.count != 0 )
    {
        
        PIPinorexDetailData *data = [self.PIPincomearray objectAtIndex:indexPath.row];
        cell.PIPincome_timelabel.text=data.TransactionDate;
        cell.PIPincome_moneylabel.text=[NSString stringWithFormat:@"￥%@",data.Amount];
        
        NSString*str=[NSString stringWithFormat:@"%@",data.Description];
        [cell.m_PIPwebView loadHTMLString:str baseURL:nil];
        cell.m_PIPwebView.userInteractionEnabled = NO;
        UIWebView *webView = (UIWebView *)[self.m_webViewArray objectAtIndex:indexPath.row];
        cell.m_PIPwebView= webView;
        NSLog(@"width=%f,height=%f",cell.m_PIPwebView.frame.size.width,cell.m_PIPwebView.frame.size.height);

    }
 
       return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)pullTableViewDidTriggerRefresh:(PullTableView*)pullTableView {
    
    PI_pageindex=1;
    m_current=0;
    [self.PIPincomearray removeAllObjects];
    [self performSelector:@selector(getDataFromServer) withObject:nil];
    
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView*)pullTableView {
    
    PI_pageindex++;
    
    [self performSelector:@selector(getDataFromServer) withObject:nil];
    
}

@end
