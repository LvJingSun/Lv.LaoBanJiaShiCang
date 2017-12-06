//
//  MemberShipController.m
//  BusinessCenter
//
//  Created by mac on 16/4/22.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import "MemberShipController.h"
#import "Income.h"
#import "MainViewController.h"
#import "HttpClientRequest.h"
#import "RecordCell.h"
#import "AppHttpClient.h"
#import <MJRefresh.h>
#import <AFNetworking.h>
#import <MBProgressHUD.h>
#import "TitleView.h"
#import "DetailMembershipController.h"


@interface MemberShipController ()<UITableViewDelegate,UITableViewDataSource> 

@property (nonatomic, weak) UITableView *shouruTableView;

@property (nonatomic, strong) NSArray *incomeArray;

@property (nonatomic, strong) NSMutableArray *incomeCountArray;

@property (nonatomic, assign) NSInteger pageIndex;

@property (nonatomic, strong) NSMutableArray *array;

@property (nonatomic, weak) TitleView *titleView;

@end

@implementation MemberShipController

-(NSArray *)incomeArray {
    
    if (_incomeArray == nil) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Income.plist" ofType:nil];
        
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *tempArray = [NSMutableArray array];
        
        for (NSDictionary *dic in array) {
            
            Income *incomemodel = [[Income alloc] initWithDict:dic];
            
            [tempArray addObject:incomemodel];
            
        }
        
        _incomeArray = tempArray;
        
    }
    
    return _incomeArray;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];
    
    self.pageIndex = 0;
    
    [self requestDataWithMemberID:memberId WithPageIndex:[NSString stringWithFormat:@"%ld",(long)self.pageIndex]];
    
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    
    CGRect rectNav = self.navigationController.navigationBar.frame;
    
    self.title = @"会员卡消费记录";
    
    self.view.backgroundColor = [UIColor colorWithRed:230/255. green:230/255. blue:230/255. alpha:1.];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - rectNav.size.height - rectStatus.size.height)];
    
    tableView.delegate = self;
    
    tableView.dataSource = self;
    
    self.shouruTableView = tableView;
    

    
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        self.pageIndex = 0;
        
        [self requestDataWithMemberID:memberId WithPageIndex:[NSString stringWithFormat:@"%ld",(long)self.pageIndex]];
        
    }];
    
    tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        self.pageIndex ++;
        
        [self requestDataWithMemberID:memberId WithPageIndex:[NSString stringWithFormat:@"%ld",(long)self.pageIndex]];
        
    }];
    
    [self.view addSubview:tableView];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return self.incomeCountArray.count;
        
    }else {
        
        return self.array.count;
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return 20;
        
    }else {
        
        return 0;
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        static NSString *ID = @"ID";
        
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        cell.textLabel.text = ((Income *)self.incomeArray[indexPath.row]).typeName;
        
        NSString *countText = [NSString stringWithFormat:@"¥%@",self.incomeCountArray[indexPath.row]];
        
        cell.detailTextLabel.text = countText;
        
        return cell;
        
    }else {
        
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
        
        cell.nameLab.text = ((NSDictionary *)self.array[indexPath.row])[@"nickName"];
        
        cell.nameLab.font = [UIFont systemFontOfSize:13];
        
        return cell;
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RecordCell *cell = [RecordCell RecordCellWithTableView:tableView];
    
    return cell.height;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DetailMembershipController *vc = [[DetailMembershipController alloc] init];
    
    vc.membershipID = ((NSDictionary *)self.array[indexPath.row])[@"memberId"];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)headAndFootEndRefreshing {
    
    [self.shouruTableView.mj_header endRefreshing];
    
    [self.shouruTableView.mj_footer endRefreshing];
    
}

- (void)requestDataWithMemberID:(NSString *)memberId WithPageIndex:(NSString *)pageIndex {

    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *paeameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId,@"memberId",
                                pageIndex,@"pageIndex",
                                nil];
    
    [httpClient request:@"GetVIPCardTransactionRecords.ashx" parameters:paeameters success:^(NSJSONSerialization* json){
        
        [self headAndFootEndRefreshing];
        
        NSDictionary *dic = (NSDictionary *)json;
        
        NSArray *trueArr = dic[@"RecordList"];
        
        if (trueArr == nil) {
            
            [self.shouruTableView removeFromSuperview];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 100, self.view.bounds.size.width - 100, 30)];
            
            label.textAlignment = NSTextAlignmentCenter;
            
            label.text = @"暂无数据";
            
            label.textColor = [UIColor lightGrayColor];
            
            [self.view addSubview:label];
            
        }else {
            
            if ([pageIndex intValue] == 0) {
                
                if (self.array.count == 0) {
                    
                }else {
                    
                    [self.array removeAllObjects];
                    
                }
                
                self.array = dic[@"RecordList"];
                
                if (self.incomeCountArray == nil) {
                    
                }else {
                    
                    [self.incomeCountArray removeAllObjects];
                    
                }
                
                
                
                TitleView *titleview = [[TitleView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 202)];
                
                titleview.todayMoneyLab.text = [NSString stringWithFormat:@"消费：¥%@",dic[@"JinRiShouRu"]];
                
                titleview.weekMoneyLab.text = [NSString stringWithFormat:@"消费：¥%@",dic[@"BenZhouShouRu"]];
                
                titleview.monthMoneyLab.text = [NSString stringWithFormat:@"消费：¥%@",dic[@"BenYueShouRu"]];
                
                titleview.allMoneyLab.text = [NSString stringWithFormat:@"消费：¥%@",dic[@"JinSanYueShouRu"]];
                
                titleview.todayMoneyOutLab.text = [NSString stringWithFormat:@"充值：¥%@",dic[@"JinRiXiaoFei"]];
                
                titleview.weekMoneyOutLab.text = [NSString stringWithFormat:@"充值：¥%@",dic[@"BenZhouXiaoFei"]];
                
                titleview.monthMoneyOutLab.text = [NSString stringWithFormat:@"充值：¥%@",dic[@"BenYueXiaoFei"]];
                
                titleview.allMoneyOutLab.text = [NSString stringWithFormat:@"充值：¥%@",dic[@"JinSanYueXiaoFei"]];
                
                self.shouruTableView.tableHeaderView = titleview;
                
            }else {
                
                [self.array addObjectsFromArray:dic[@"RecordList"]];
                
            }
            
        }

        [self.shouruTableView reloadData];
        
    }failure:^(NSError *error){
        
        [self headAndFootEndRefreshing];
        
    }];

}

@end
