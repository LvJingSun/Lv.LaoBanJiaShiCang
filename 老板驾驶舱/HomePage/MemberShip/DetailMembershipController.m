//
//  DetailMembershipController.m
//  BusinessCenter
//
//  Created by mac on 16/5/12.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import "DetailMembershipController.h"
#import "DetailMemberView.h"
#import "HttpClientRequest.h"
#import "RecordCell.h"
#import "AppHttpClient.h"
#import <MJRefresh.h>
#import <AFNetworking.h>
#import <MBProgressHUD.h>

@interface DetailMembershipController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSMutableArray *array;

@property (nonatomic, assign) NSInteger pageIndex;

@end

@implementation DetailMembershipController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];
    
    self.pageIndex = 0;
    
    [self requestDataWithMemberID:memberId WithPageIndex:[NSString stringWithFormat:@"%ld",(long)self.pageIndex] withToMemberID:self.membershipID];
    
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    
    CGRect rectNav = self.navigationController.navigationBar.frame;
    
    self.view.backgroundColor = [UIColor colorWithRed:230/255. green:230/255. blue:230/255. alpha:1.];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - rectNav.size.height - rectStatus.size.height)];
    
    tableView.delegate = self;
    
    tableView.dataSource = self;
    
    self.tableview = tableView;
    
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        self.pageIndex = 0;
        
        [self requestDataWithMemberID:memberId WithPageIndex:[NSString stringWithFormat:@"%ld",(long)self.pageIndex] withToMemberID:self.membershipID];
        
    }];
    
    tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        self.pageIndex ++;
        
        [self requestDataWithMemberID:memberId WithPageIndex:[NSString stringWithFormat:@"%ld",(long)self.pageIndex] withToMemberID:self.membershipID];
        
    }];
    
    [self.view addSubview:tableView];

    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        
    return self.array.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 20;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        
    RecordCell *cell = [RecordCell RecordCellWithTableView:tableView];
    
    cell.countLab.text = ((NSDictionary *)self.array[indexPath.row])[@"amount"];
    
    cell.countLab.font = [UIFont systemFontOfSize:20];
    
    if ([cell.countLab.text intValue] > 0) {
        
        cell.countLab.textColor = [UIColor colorWithRed:64/255. green:165/255. blue:219/255. alpha:1.0];
        
    }else {
        
        cell.countLab.textColor = [UIColor redColor];
        
    }
    
    cell.timeLab.text = ((NSDictionary *)self.array[indexPath.row])[@"transDate"];
    
    cell.timeLab.font = [UIFont systemFontOfSize:13];
    
    cell.addressLab.text = ((NSDictionary *)self.array[indexPath.row])[@"shopName"];
    
    cell.addressLab.font = [UIFont systemFontOfSize:11];
    
    cell.typeLab.text = ((NSDictionary *)self.array[indexPath.row])[@"transTypeName"];
    
    cell.typeLab.font = [UIFont systemFontOfSize:13];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RecordCell *cell = [RecordCell RecordCellWithTableView:tableView];
    
    return cell.height;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)headAndFootEndRefreshing {
    
    [self.tableview.mj_header endRefreshing];
    
    [self.tableview.mj_footer endRefreshing];
    
}

- (void)requestDataWithMemberID:(NSString *)memberId WithPageIndex:(NSString *)pageIndex withToMemberID:(NSString *)toMemberID{
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *paeameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId,@"memberId",
                                pageIndex,@"pageIndex",
                                toMemberID,@"toMemberID",
                                nil];
    
    [httpClient request:@"GetMemVIPCardTransactionRecords.ashx" parameters:paeameters success:^(NSJSONSerialization* json){
        
        [self headAndFootEndRefreshing];
        
        NSDictionary *dic = (NSDictionary *)json;
        
        NSArray *trueArr = dic[@"RecordList"];
        
        if (trueArr == nil) {
            
            [self.tableview removeFromSuperview];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 100, self.view.bounds.size.width - 100, 30)];
            
            label.textAlignment = NSTextAlignmentCenter;
            
            label.text = @"暂无数据";
            
            label.textColor = [UIColor lightGrayColor];
            
            [self.view addSubview:label];
            
        }else {
            
            if ([pageIndex intValue] == 0) {
                
                if (self.array == nil) {
                    
                }else {
                    
                    [self.array removeAllObjects];
                    
                }
                
                self.array = dic[@"RecordList"];
                
                DetailMemberView *titleview = [[DetailMemberView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 202)];
                
                titleview.todayInLab.text = [NSString stringWithFormat:@"收入:¥%@",dic[@"JinRiShouRu"]];
                
                titleview.todayOutLab.text = [NSString stringWithFormat:@"支出:¥%@",dic[@"JinRiXiaoFei"]];
                
                titleview.weekInLab.text = [NSString stringWithFormat:@"收入:¥%@",dic[@"BenZhouShouRu"]];
                
                titleview.weekOutLab.text = [NSString stringWithFormat:@"支出:¥%@",dic[@"BenZhouXiaoFei"]];
                
                titleview.monthInLab.text = [NSString stringWithFormat:@"收入:¥%@",dic[@"BenYueShouRu"]];
                
                titleview.monthOutLab.text = [NSString stringWithFormat:@"支出:¥%@",dic[@"BenYueXiaoFei"]];
                
                titleview.allInLab.text = [NSString stringWithFormat:@"收入:¥%@",dic[@"JinSanYueShouRu"]];
                
                titleview.allOutLab.text = [NSString stringWithFormat:@"支出:¥%@",dic[@"JinSanYueXiaoFei"]];

                self.tableview.tableHeaderView = titleview;
                
            }else {
                
                [self.array addObjectsFromArray:dic[@"RecordList"]];
                
            }
            
        }
        
        [self.tableview reloadData];
        
    }failure:^(NSError *error){
        
        [self headAndFootEndRefreshing];
        
    }];
    
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
