//
//  SettingController.m
//  BusinessCenter
//
//  Created by mac on 16/4/25.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import "SettingController.h"
#import "EarlyController.h"
#import "AppHttpClient.h"
#import <MJRefresh.h>
#import "KuCunController.h"

@interface SettingController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, assign) NSInteger pageIndex;

@property (nonatomic, weak) UILabel *noLabel;

@end

@implementation SettingController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.dataArray = [NSMutableArray array];
    
    self.title = @"库存预警";
    
    self.view.backgroundColor = [UIColor colorWithRed:230/255. green:230/255. blue:230/255. alpha:1.];
    
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    
    CGRect rectNav = self.navigationController.navigationBar.frame;
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 2, self.view.bounds.size.width, self.view.bounds.size.height - rectStatus.size.height - rectNav.size.height - 2)];
    
    tableview.backgroundColor = [UIColor whiteColor];
    
    self.tableview = tableview;
    
    tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        self.pageIndex = 1;
        
        [self requestDataWithPageIndex:[NSString stringWithFormat:@"%ld",(long)self.pageIndex]];
        
    }];
    
    tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        self.pageIndex ++;
        
        [self requestDataWithPageIndex:[NSString stringWithFormat:@"%ld",(long)self.pageIndex]];

    }];
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    [self.view addSubview:tableview];
    
    [self setRightBtn];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 100, self.view.bounds.size.width - 100, 30)];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    label.text = @"请添加预警";
    
    label.textColor = [UIColor lightGrayColor];
    
    self.noLabel = label;
    
    [self.view addSubview:label];

}

- (void)viewWillAppear:(BOOL)animated {
    
    [self requestDataWithPageIndex:@"1"];
    
}

- (void)headAndFootEndRefreshing {
    
    [self.tableview.mj_header endRefreshing];
    
    [self.tableview.mj_footer endRefreshing];
    
}

- (void)setRightBtn {
    
    UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    editBtn.frame = CGRectMake(0, 0, 15, 15);
    
    [editBtn setImage:[UIImage imageNamed:@"sotckjia.png"] forState:UIControlStateNormal];
    
    [editBtn addTarget:self action:@selector(editBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *screenBarBtn=[[UIBarButtonItem alloc]initWithCustomView:editBtn];
    
    self.navigationItem.rightBarButtonItem = screenBarBtn;
    
}

- (void)editBtnClick {
    
    EarlyController *vc = [[EarlyController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 50;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dic = self.dataArray[indexPath.row];

    static NSString *ID = @"ID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.textLabel.text = [NSString stringWithFormat:@"商品名称：%@",dic[@"YuJingMiaoShu"]];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"预警数量：%@",dic[@"ShuLiang"]];
    
    return cell;
    
}

- (void)requestDataWithPageIndex:(NSString *)pageIndex {

    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *paeameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId,@"memberID",
                                pageIndex,@"pageIndex",
                                @"",@"yuJingType",
                                nil];
    
    [httpClient request:@"ErpYuJingList.ashx" parameters:paeameters success:^(NSJSONSerialization* json){
        
        [self headAndFootEndRefreshing];
        
        NSDictionary *dic = (NSDictionary *)json;
        
        if ([pageIndex intValue] == 1) {

            self.dataArray = dic[@"YuJingModelList"];

        }else {
        
            if (((NSArray *)dic[@"YuJingModelList"]).count == 0) {
                
                
            }else {
                
                [self.dataArray addObject:dic[@"YuJingModelList"]];
                
            }
        
        }
        
        if (self.dataArray.count == 0) {
            
            self.noLabel.hidden = NO;
            
            self.tableview.hidden = YES;
            
        }else {
            
            self.noLabel.hidden = YES;
            
            self.tableview.hidden = NO;
            
            [self.tableview reloadData];
            
        }
        
    }failure:^(NSError *error){
        
        [self headAndFootEndRefreshing];
        
    }];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

}



@end
