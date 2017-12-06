//
//  N_RevenueViewController.m
//  BusinessCenter
//
//  Created by mac on 2017/4/12.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import "N_RevenueViewController.h"
#import "SVProgressHUD.h"
#import "HttpClientRequest.h"
#import <MJRefresh.h>
#import "RevenueTitleView.h"
#import "DropDownView.h"
#import "N_RevenueModel.h"
#import "N_RevenueFrame.h"
#import "N_RevenueCell.h"
#import "N_NoDataCell.h"

#define TabBGCOLOR [UIColor colorWithRed:244/255. green:244/255. blue:244/255. alpha:1.]
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface N_RevenueViewController () <UITableViewDelegate,UITableViewDataSource> {

    int P_pageindex;
    
    int R_type;
    
}

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) DropDownView *dropview;

@property (nonatomic, weak) RevenueTitleView *titleview;

@end

@implementation N_RevenueViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    P_pageindex = 1;
    
    R_type = 0;
    
    RevenueTitleView *titleview = [[RevenueTitleView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH * 0.6, 30)];
    
    self.titleview = titleview;
    
    titleview.clickBtn.tag = 0;
    
    [titleview.clickBtn addTarget:self action:@selector(N_TitleCkick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = titleview;
    
    self.view.backgroundColor = TabBGCOLOR;
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];
    
    self.navigationItem.backBarButtonItem = backItem;
    
    self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
    
    [self initWithTableview];
    
    [self getDataFromServer];
    
}

- (void)initWithTableview {
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    
    self.tableview = tableview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableview.backgroundColor = TabBGCOLOR;
    
    tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        P_pageindex = 1;
        
        [self getDataFromServer];
        
    }];
    
    tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        P_pageindex ++;
        
        [self getDataFromServer];
        
    }];
    
    [self.view addSubview:tableview];
    
}

- (void)headAndFootEndRefreshing {
    
    [self.tableview.mj_header endRefreshing];
    
    [self.tableview.mj_footer endRefreshing];
    
}


- (void)N_TitleCkick:(UIButton *)sender {
    
    NSArray *arr = @[@"全部",@"收入",@"支出"];

    if (sender.tag == 1) {
        
        if (self.dropview) {
            
            [self.dropview dismissAlert];
            
        }
        
        self.titleview.imageview.image = [UIImage imageNamed:@"N_TitleImg_B.png"];
        
        sender.tag = 0;
        
    }else {
        
        self.dropview = [[DropDownView alloc] initWithTitleArray:arr];
        
        [self.dropview ReturnBlock:^(UIButton *sender) {
            
            if (sender.tag == 0) {
        
                R_type = 0;
                
                self.titleview.titleLab.text = @"收支记录";
        
            }else if (sender.tag == 1) {
        
                R_type = 1;
                
                self.titleview.titleLab.text = @"收入记录";
        
            }else if (sender.tag == 2) {
                
                R_type = 2;
                
                self.titleview.titleLab.text = @"支出记录";
                
            }
            
            P_pageindex = 1;
            
            self.titleview.imageview.image = [UIImage imageNamed:@"N_TitleImg_B.png"];
            
            self.titleview.clickBtn.tag = 0;
            
            [self getDataFromServer];
            
        }];
    
        [self.dropview show];
        
        self.titleview.imageview.image = [UIImage imageNamed:@"N_TitleImg_T.png"];
        
        sender.tag = 1;
        
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        
    if (self.dataArray.count == 0) {
        
        return 1;
        
    }else {
        
        return self.dataArray.count;
        
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        
    if (self.dataArray.count == 0) {
        
        N_NoDataCell *cell = [[N_NoDataCell alloc] init];
        
        return cell;
        
    }else {
        
        N_RevenueFrame *frame = self.dataArray[indexPath.row];
        
        N_RevenueCell *cell = [[N_RevenueCell alloc] init];
        
        cell.frameModel = frame;
        
        return cell;
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
        
    if (self.dataArray.count == 0) {
        
        N_NoDataCell *cell = [[N_NoDataCell alloc] init];
        
        return cell.height;
        
    }else {
        
        N_RevenueFrame *frame = self.dataArray[indexPath.row];
        
        return frame.height;
        
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

-(void)getDataFromServer {
    
    NSUserDefaults *userDefau = [NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];
    
    HttpClientRequest *httpClient = [HttpClientRequest sharedInstance];
    
    NSString *pagde = [[NSNumber numberWithInt:P_pageindex] stringValue];
    
    NSString *type = [[NSNumber numberWithInt:R_type] stringValue];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId, @"memberId",
                           pagde,@"pageIndex",
                           type,@"tradingOperations",
                           nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中..."];
    
    [httpClient request:@"MctInOrExRcdsList_New.ashx" parameters:param successed:^(JSONDecoder *jsonDecoder, id responseObject) {
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [jsonDecoder objectWithData:data];
        
        BOOL success = [handlJson[@"status"] boolValue];
        
        if (success) {
            
            [SVProgressHUD dismiss];
            
            NSArray *arr = handlJson[@"MerchantTranRcdsList"];
            
            if (P_pageindex == 1) {
                
                if (self.dataArray.count != 0) {
                    
                    [self.dataArray removeAllObjects];
                    
                }
                
                if (arr.count != 0) {
                    
                    NSMutableArray *temp = [NSMutableArray array];
                    
                    for (NSDictionary *dd in arr) {
                        
                        N_RevenueModel *record = [[N_RevenueModel alloc] initWithDict:dd];
                        
                        N_RevenueFrame *frame = [[N_RevenueFrame alloc] init];
                        
                        frame.recordModel = record;
                        
                        [temp addObject:frame];
                        
                    }
                    
                    self.dataArray = temp;
                    
                }
                
            }else {
                
                if (arr.count != 0) {
                    
                    NSMutableArray *temp = [NSMutableArray array];
                    
                    for (NSDictionary *dd in arr) {
                        
                        N_RevenueModel *record = [[N_RevenueModel alloc] initWithDict:dd];
                        
                        N_RevenueFrame *frame = [[N_RevenueFrame alloc] init];
                        
                        frame.recordModel = record;
                        
                        [temp addObject:frame];
                        
                    }
                    
                    [self.dataArray addObjectsFromArray:temp];
                    
                }
                
            }
            
            [self.tableview reloadData];
            
        }else {
            
            if (P_pageindex > 1) {
                
                P_pageindex --;
                
            }
            
        }
        
        [self headAndFootEndRefreshing];
        
    } failured:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:error.description];
        
        if (P_pageindex > 1) {
            
            P_pageindex--;
            
        }
        
        [self headAndFootEndRefreshing];
        
    }];
    
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

}

@end
