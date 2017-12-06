//
//  TiXian_List_ViewController.m
//  BusinessCenter
//
//  Created by mac on 2017/11/1.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import "TiXian_List_ViewController.h"
#import "AppHttpClient.h"
#import "SVProgressHUD.h"
#import <MJRefresh.h>
#import "T_ListModel.h"
#import "T_ListFrame.h"
#import "T_ListCell.h"
#import "RechargeHeader.h"
#import "T_ListHeadView.h"

@interface TiXian_List_ViewController () <UITableViewDelegate,UITableViewDataSource> {
    
    NSInteger pageIndex;
    
}

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, weak) T_ListHeadView *headview;

@end

@implementation TiXian_List_ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"提现记录";
    
    pageIndex = 1;
    
    [self allocWithTableview];
    
    [self requestData];

}

- (void)requestData {
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         memberId,@"memberid",
                         [NSString stringWithFormat:@"%ld",(long)pageIndex],@"pageindex",
                         nil];
    
    AppHttpClient *http = [AppHttpClient sharedClient];
    
    [http request:@"GetwithDrawals_List.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
        NSDictionary *dic = (NSDictionary *)json;
        
        BOOL isSuccess = [dic[@"status"] boolValue];
        
        if (isSuccess) {
            
            self.headview.countLab.text = [NSString stringWithFormat:@"%@",dic[@"SumBalance"]];
            
            NSArray *arr = dic[@"RBX"];
            
            if (pageIndex == 1) {
                
                NSMutableArray *mut = [NSMutableArray array];
                
                for (NSDictionary *dd in arr) {
                    
                    T_ListModel *model = [[T_ListModel alloc] initWithDict:dd];
                    
                    T_ListFrame *frame = [[T_ListFrame alloc] init];
                    
                    frame.listModel = model;
                    
                    [mut addObject:frame];
                    
                }
                
                self.dataArray = mut;
                
                [self endRefreshing];
                
            }else {
                
                NSMutableArray *temp = [NSMutableArray arrayWithArray:self.dataArray];
                
                for (NSDictionary *dd in arr) {
                    
                    T_ListModel *model = [[T_ListModel alloc] initWithDict:dd];
                    
                    T_ListFrame *frame = [[T_ListFrame alloc] init];
                    
                    frame.listModel = model;
                    
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
    
    T_ListHeadView *headview = [[T_ListHeadView alloc] init];
    
    headview.frame = CGRectMake(0, 0, ScreenWidth, headview.height);
    
    self.headview = headview;
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64)];
    
    self.tableview = tableview;
    
    tableview.tableHeaderView = headview;
    
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
    
    T_ListCell *cell = [[T_ListCell alloc] init];
    
    T_ListFrame *frame = self.dataArray[indexPath.row];
    
    cell.frameModel = frame;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    T_ListFrame *frame = self.dataArray[indexPath.row];
    
    return frame.height;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

}

@end
