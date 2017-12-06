//
//  BalanceRecordsViewController.m
//  BusinessCenter
//
//  Created by mac on 2017/10/13.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import "BalanceRecordsViewController.h"
#import "M_Record_Model.h"
#import "M_Record_Frame.h"
#import "M_Record_Cell.h"

#import "AppHttpClient.h"
#import "SVProgressHUD.h"
#import <MJRefresh.h>

#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

@interface BalanceRecordsViewController () <UITableViewDelegate,UITableViewDataSource> {
    
    NSInteger pageIndex;
    
}

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation BalanceRecordsViewController

//-(NSArray *)dataArray {
//    
//    if (_dataArray == nil) {
//        
//        M_Record_Model *model = [[M_Record_Model alloc] init];
//        
//        model.type = @"商户充值";
//        
//        model.date = @"2017-09-29 08:30";
//        
//        model.count = @"+300";
//        
//        M_Record_Frame *frame = [[M_Record_Frame alloc] init];
//        
//        frame.recordModel = model;
//        
//        NSMutableArray *mut = [NSMutableArray array];
//        
//        [mut addObject:frame];
//        
//        _dataArray = mut;
//        
//    }
//    
//    return _dataArray;
//    
//}

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.title = @"记录";
    
    pageIndex = 1;
    
    [self allocWithTableview];
    
    [self requestData];
    
}

- (void)requestData {
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *Merchant_ID = [userDefau objectForKey:@"Merchant_ID"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         Merchant_ID,@"merchantid",
                         [NSString stringWithFormat:@"%ld",(long)pageIndex],@"pageIndex",
                         self.type,@"type",
                         nil];
    
    AppHttpClient *http = [AppHttpClient sharedClient];
    
    [http request:@"Account_balanceList.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
        NSDictionary *dic = (NSDictionary *)json;
        
        BOOL isSuccess = [dic[@"status"] boolValue];
        
        if (isSuccess) {
            
            NSArray *arr = dic[@"balancelist"];
            
            if (pageIndex == 1) {
                
                NSMutableArray *mut = [NSMutableArray array];
                
                for (NSDictionary *dd in arr) {
                    
                    M_Record_Model *model = [[M_Record_Model alloc] initWithDict:dd];
                    
                    M_Record_Frame *frame = [[M_Record_Frame alloc] init];
                    
                    frame.recordModel = model;
                    
                    [mut addObject:frame];
                    
                }
                
                self.dataArray = mut;
                
            }else {
                
                NSMutableArray *temp = [NSMutableArray arrayWithArray:self.dataArray];
                
                for (NSDictionary *dd in arr) {
                    
                    M_Record_Model *model = [[M_Record_Model alloc] initWithDict:dd];
                    
                    M_Record_Frame *frame = [[M_Record_Frame alloc] init];
                    
                    frame.recordModel = model;
                    
                    [temp addObject:frame];
                    
                }
                
                self.dataArray = temp;
                
            }
            
            [self.tableview reloadData];
            
            [self endRefreshing];
            
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
    
    M_Record_Cell *cell = [[M_Record_Cell alloc] init];
    
    M_Record_Frame *frame = self.dataArray[indexPath.row];
    
    cell.frameModel = frame;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    M_Record_Frame *frame = self.dataArray[indexPath.row];
    
    return frame.height;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
