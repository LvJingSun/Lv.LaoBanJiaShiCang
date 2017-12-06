//
//  InCome_List_ViewController.m
//  BusinessCenter
//
//  Created by mac on 2017/11/1.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import "InCome_List_ViewController.h"
#import "AppHttpClient.h"
#import "SVProgressHUD.h"
#import <MJRefresh.h>
#import "InCome_List_Model.h"
#import "InCome_List_Frame.h"
#import "InCome_List_Cell.h"
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

@interface InCome_List_ViewController () <UITableViewDelegate,UITableViewDataSource> {
    
    NSInteger pageIndex;
    
}

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation InCome_List_ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    if ([self.type isEqualToString:@"1"]) {
        
        self.title = @"今日收入";
        
    }else if ([self.type isEqualToString:@"2"]) {
        
        self.title = @"本周收入";
        
    }else if ([self.type isEqualToString:@"3"]) {
        
        self.title = @"本月收入";
        
    }else if ([self.type isEqualToString:@"4"]) {
        
        self.title = @"近三月收入";
        
    }else if ([self.type isEqualToString:@"5"]) {
        
        self.title = @"今日收入";
        
    }else if ([self.type isEqualToString:@"6"]) {
        
        self.title = @"本周收入";
        
    }else if ([self.type isEqualToString:@"7"]) {
        
        self.title = @"本月收入";
        
    }else if ([self.type isEqualToString:@"8"]) {
        
        self.title = @"近三月收入";
        
    }
    
    pageIndex = 1;
    
    [self allocWithTableview];
    
    [self requestData];

}

- (void)requestData {
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         memberId,@"memberid",
                         [NSString stringWithFormat:@"%ld",(long)pageIndex],@"pageIndex",
                         @"1",@"tradingOperations",
                         self.type,@"searchtype",
                         nil];
    
    AppHttpClient *http = [AppHttpClient sharedClient];
    
    [http request:@"MerchantTranRcdsList_Red.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
        NSDictionary *dic = (NSDictionary *)json;
        
        BOOL isSuccess = [dic[@"status"] boolValue];
        
        if (isSuccess) {
            
            NSArray *arr = dic[@"MerchantTranRcdsList"];
            
            if (pageIndex == 1) {
                
                NSMutableArray *mut = [NSMutableArray array];
                
                for (NSDictionary *dd in arr) {
                    
                    InCome_List_Model *model = [[InCome_List_Model alloc] initWithDict:dd];
                    
                    InCome_List_Frame *frame = [[InCome_List_Frame alloc] init];
                    
                    frame.listmodel = model;
                    
                    [mut addObject:frame];
                    
                }
                
                self.dataArray = mut;
                
                [self endRefreshing];
                
            }else {
                
                NSMutableArray *temp = [NSMutableArray arrayWithArray:self.dataArray];
                
                for (NSDictionary *dd in arr) {
                    
                    InCome_List_Model *model = [[InCome_List_Model alloc] initWithDict:dd];
                    
                    InCome_List_Frame *frame = [[InCome_List_Frame alloc] init];
                    
                    frame.listmodel = model;
                    
                    [temp addObject:frame];
                    
                }
                
                self.dataArray = temp;
                
                [self endRefreshing];
                
            }
            
            [self.tableview reloadData];
            
        }else {
            
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",dic[@"msg"]]];
            
            if (pageIndex > 1) {
                
                pageIndex --;
                
            }
            
            [self endRefreshing];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
        if (pageIndex > 1) {
            
            pageIndex --;
            
        }
        
        [self endRefreshing];
        
    }];
    
}

- (void)allocWithTableview {
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64)];
    
    self.tableview = tableview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        pageIndex = 1;
        
        [self requestData];
        
    }];
    
    tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        pageIndex ++;
        
        [self requestData];
        
    }];
    
    [self.view addSubview:tableview];
    
}

- (void)endRefreshing {
    
    [self.tableview.mj_header endRefreshing];
    
    [self.tableview.mj_footer endRefreshing];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    InCome_List_Cell *cell = [[InCome_List_Cell alloc] init];
    
    InCome_List_Frame *frame = self.dataArray[indexPath.row];
    
    cell.frameModel = frame;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    InCome_List_Frame *frame = self.dataArray[indexPath.row];
    
    return frame.height;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

}

@end
