//
//  JiluDetailController.m
//  BusinessCenter
//
//  Created by mac on 16/5/20.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import "JiluDetailController.h"
#import "JiluDetailHeadView.h"
#import "ServiceCell.h"
#import <MJRefresh.h>
#import "AppHttpClient.h"
#import "SVProgressHUD.h"

@interface JiluDetailController ()<UITableViewDelegate,UITableViewDataSource> {

    NSString *GuaZhongNumber;
    
    NSInteger pageIndex;
    
}

@property (nonatomic, weak) JiluDetailHeadView *headView;

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation JiluDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    GuaZhongNumber = self.GuaZhongNumber;
    
    self.title = @"详情";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initWithTableView];
    
    [self initWithHeadView];
    
    pageIndex = 1;
    
    [SVProgressHUD showWithStatus:@"请求中..."];
    
    [self requestFuWuWithPageIndex:[NSString stringWithFormat:@"%ld",(long)pageIndex]];

}

- (void)initWithTableView {

    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    
    self.tableview = tableview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        pageIndex = 1;
        
        [self requestFuWuWithPageIndex:[NSString stringWithFormat:@"%ld",(long)pageIndex]];
        
    }];
    
    tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{

            
        pageIndex ++;
        
        [self requestFuWuWithPageIndex:[NSString stringWithFormat:@"%ld",(long)pageIndex]];

        
    }];
    
    [self.view addSubview:tableview];
    
}

- (void)requestFuWuWithPageIndex:(NSString *)pageInde {
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *paeameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId,@"memberID",
                                GuaZhongNumber,@"guaZhongNumber",
                                pageInde,@"pageIndex",
                                nil];
    
    [httpClient request:@"ErpPaiHaoJiLuDetailList.ashx" parameters:paeameters success:^(NSJSONSerialization* json){
        
        [SVProgressHUD dismiss];
        
        [self headAndFootEndRefreshing];
        
        NSDictionary *dic = (NSDictionary *)json;
        
        self.headView.nameLabel.text = dic[@"StatusDes"];
        
        self.headView.countLabel.text = [NSString stringWithFormat:@"共%d种服务",[dic[@"ZongShuLiang"] intValue]];
        
        self.headView.priceLabel.text = [NSString stringWithFormat:@"%d¥",[dic[@"ZongJinE"] intValue]];
        
        self.headView.dianzhongImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:dic[@"DianZhongImg"]]]];
        
        if ([pageInde intValue] == 1) {
            
            if (self.dataArray.count == 0) {
                
            }else {
                
                [self.dataArray removeAllObjects];
                
            }
            
            self.dataArray = dic[@"PaiHaoJiLuModelList"];
            
        }else {
            
            if (self.dataArray.count < 10) {
                
            }else {
                
                [self.dataArray addObjectsFromArray:dic[@"PaiHaoJiLuModelList"]];
                
            }
            
        }
        
        [self.tableview reloadData];
        
    }failure:^(NSError *error){
        
        [SVProgressHUD dismiss];
        
        [self headAndFootEndRefreshing];
        
    }];
    
}

- (void)headAndFootEndRefreshing {
    
    [self.tableview.mj_header endRefreshing];
    
    [self.tableview.mj_footer endRefreshing];
    
}

- (void)initWithHeadView {
    
    JiluDetailHeadView *headView = [[JiluDetailHeadView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 80)];
    
    self.headView = headView;
    
//    headView.nameLabel.text = @"点钟";
//    
//    headView.countLabel.text = @"共5种服务";
//    
//    headView.priceLabel.text = @"180¥";
//    
//    headView.dianzhongImageView.image = [UIImage imageNamed:@"足浴.jpg"];
    
    self.tableview.tableHeaderView = headView;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    NSDictionary *dic = self.dataArray[indexPath.row];
    
    ServiceCell *cell = [[ServiceCell alloc] init];
    
    cell.serviceImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:dic[@"XiangMuPic"]]]];
    
    cell.nameLabel.text = dic[@"PaiHaoXiangMu"];
    
    cell.timeLabel.text = [NSString stringWithFormat:@"时长:%d分钟",[dic[@"ShiChang"] intValue]];
    
    cell.priceLabel.text = [NSString stringWithFormat:@"%d¥",[dic[@"JinE"] intValue]];
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    ServiceCell *cell = [[ServiceCell alloc] init];
    
    return cell.height;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

}

//- (void)viewWillAppear:(BOOL)animated {
//
//    NSUserDefaults*pushJudge = [NSUserDefaults standardUserDefaults];
//    if([[pushJudge objectForKey:@"push"]isEqualToString:@"push"]) {
//        
//        self.tableview.frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64);
//        
//    }
//    
//}

- (void)viewWillDisappear:(BOOL)animated {

    self.navigationController.navigationBarHidden = YES;
    
}

@end
