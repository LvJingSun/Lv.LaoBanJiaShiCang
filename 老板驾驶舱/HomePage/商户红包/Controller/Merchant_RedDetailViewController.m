//
//  Merchant_RedDetailViewController.m
//  BusinessCenter
//
//  Created by mac on 2017/10/13.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import "Merchant_RedDetailViewController.h"
#import "MR_GetModel.h"
#import "MR_GetFrame.h"
#import "MR_GetCell.h"

#import "AppHttpClient.h"
#import "SVProgressHUD.h"
#import <MJRefresh.h>

@interface Merchant_RedDetailViewController () <UITableViewDelegate,UITableViewDataSource> {
    
    NSInteger pageIndex;
    
}

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation Merchant_RedDetailViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"详情";
    
    pageIndex = 1;
    
    [self requestData];
    
    [self allocWithTableview];

}

- (void)requestData {
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *Merchant_ID = [userDefau objectForKey:@"Merchant_ID"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         Merchant_ID,@"merchantid",
                         [NSString stringWithFormat:@"%ld",(long)pageIndex],@"pageIndex",
                         self.date,@"time",
                         nil];
    
    AppHttpClient *http = [AppHttpClient sharedClient];
    
    [http request:@"ReceiveInfoList.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
        NSDictionary *dic = (NSDictionary *)json;
        
        BOOL isSuccess = [dic[@"status"] boolValue];
        
        if (isSuccess) {
            
            NSArray *arr = dic[@"receivelist"];
            
            if (pageIndex == 1) {
                
                NSMutableArray *mut = [NSMutableArray array];
                
                for (NSDictionary *dd in arr) {
                    
                    MR_GetModel *model = [[MR_GetModel alloc] initWithDict:dd];
                    
                    MR_GetFrame *frame = [[MR_GetFrame alloc] init];
                    
                    frame.getModel = model;
                    
                    [mut addObject:frame];
                    
                }
                
                self.dataArray = mut;
                
            }else {
                
                NSMutableArray *temp = [NSMutableArray arrayWithArray:self.dataArray];
                
                for (NSDictionary *dd in arr) {
                    
                    MR_GetModel *model = [[MR_GetModel alloc] initWithDict:dd];
                    
                    MR_GetFrame *frame = [[MR_GetFrame alloc] init];
                    
                    frame.getModel = model;
                    
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
    
    tableview.backgroundColor = [UIColor colorWithRed:245/255. green:245/255. blue:245/255. alpha:1.];
    
    tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        pageIndex = 1;
        
        [self requestData];
        
    }];
    
    tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
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
    
    MR_GetCell *cell = [[MR_GetCell alloc] init];
    
    MR_GetFrame *frame = self.dataArray[indexPath.row];
    
    cell.frameModel = frame;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MR_GetFrame *frame = self.dataArray[indexPath.row];
    
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
