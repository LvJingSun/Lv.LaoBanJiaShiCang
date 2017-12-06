//
//  PIPrecordViewController.m
//  BusinessCenter
//
//  Created by 冯海强 on 13-11-20.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import "PIPrecordViewController.h"

#import "SVProgressHUD.h"
#import "HttpClientRequest.h"
#import <MJRefresh.h>
#import "N_TiXianRecord.h"
#import "N_TiXianListFrame.h"
#import "N_TiXianListCell.h"
#import "N_TiXianNoticeCell.h"
#import "New_TiXianData.h"
#import "N_NoDataCell.h"

#define TabBGCOLOR [UIColor colorWithRed:244/255. green:244/255. blue:244/255. alpha:1.]
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface PIPrecordViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation PIPrecordViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"提现记录";
    
    P_pageindex=1;
    
    self.view.backgroundColor = TabBGCOLOR;
    
    [self initWithTableview];
    
    [self getDataFromServer];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];
    
    self.navigationItem.backBarButtonItem = backItem;
    
    self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];

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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        
        return 1;
        
    }else {
        
        if (self.dataArray.count == 0) {
            
            return 1;
            
        }else {
        
            return self.dataArray.count;
            
        }
        
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        
        N_TiXianNoticeCell *cell = [[N_TiXianNoticeCell alloc] init];
        
        cell.noticeLab.text = [NSString stringWithFormat:@"提现%@次,总计%@元",self.tixianData.TotalNumber,self.tixianData.TotalAmount];
        
        return cell;
        
    }else {
        
        if (self.dataArray.count == 0) {
            
            N_NoDataCell *cell = [[N_NoDataCell alloc] init];
            
            return cell;
            
        }else {
            
            N_TiXianListFrame *frame = self.dataArray[indexPath.row];
            
            N_TiXianListCell *cell = [[N_TiXianListCell alloc] init];
            
            cell.frameModel = frame;
            
            return cell;
            
        }
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        
        N_TiXianNoticeCell *cell = [[N_TiXianNoticeCell alloc] init];
        
        return cell.height;
        
    }else {
        
        if (self.dataArray.count == 0) {
            
            N_NoDataCell *cell = [[N_NoDataCell alloc] init];
            
            return cell.height;
            
        }else {
            
            N_TiXianListFrame *frame = self.dataArray[indexPath.row];
            
            return frame.height;
            
        }
        
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

}


-(void)getDataFromServer {
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString*memberId=[userDefau objectForKey:@"memberId"];
    
    HttpClientRequest *httpClient = [HttpClientRequest sharedInstance];
    
    NSString*pagde=[[NSNumber numberWithInt:P_pageindex] stringValue];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId, @"memberId",
                           pagde,@"pageIndex",
                           nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中..."];
    
    [httpClient request:@"MerchantWithdrawalList.ashx" parameters:param successed:^(JSONDecoder *jsonDecoder, id responseObject) {
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [jsonDecoder objectWithData:data];
        
        BOOL success = [handlJson[@"status"] boolValue];
        
        if (success) {
            
            [SVProgressHUD dismiss];
            
            NSArray *arr = handlJson[@"MctWithdrawalList"];
            
            if (P_pageindex == 1) {
                
                if (self.dataArray.count != 0) {
                    
                    [self.dataArray removeAllObjects];
                    
                }
            
                if (arr.count != 0) {
                    
                    NSMutableArray *temp = [NSMutableArray array];
                    
                    for (NSDictionary *dd in arr) {
                        
                        N_TiXianRecord *record = [[N_TiXianRecord alloc] initWithDict:dd];
                        
                        record.Type = @"提现";
                        
                        N_TiXianListFrame *frame = [[N_TiXianListFrame alloc] init];
                        
                        frame.recordModel = record;
                        
                        [temp addObject:frame];
                        
                    }
                    
                    self.dataArray = temp;
                    
                }
                
            }else {
            
                if (arr.count != 0) {
                    
                    NSMutableArray *temp = [NSMutableArray array];
                    
                    for (NSDictionary *dd in arr) {
                        
                        N_TiXianRecord *record = [[N_TiXianRecord alloc] initWithDict:dd];
                        
                        record.Type = @"提现";
                        
                        N_TiXianListFrame *frame = [[N_TiXianListFrame alloc] init];
                        
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

@end
