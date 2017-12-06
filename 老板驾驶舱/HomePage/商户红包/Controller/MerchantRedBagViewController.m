//
//  MerchantRedBagViewController.m
//  BusinessCenter
//
//  Created by mac on 2017/9/29.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import "MerchantRedBagViewController.h"
#import "AppHttpClient.h"
#import "SVProgressHUD.h"
#import "HttpClientRequest.h"
#import <MJRefresh.h>

#import "F_ListModel.h"
#import "SendFrameModel.h"
#import "SendListCell.h"
#import "L_NoRecordCell.h"
#import "New_DetailController.h"

#import "MR_GetModel.h"
#import "MR_GetFrame.h"
#import "MR_GetCell.h"
#import "MR_GetGroupModel.h"
#import "MR_GetGroupFrame.h"
#import "MR_GetGroupCell.h"

#import "MR_SendModel.h"
#import "MR_Send_Frame.h"
#import "MR_Send_Cell.h"

#import "Merchant_RedDetailViewController.h"

#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

@interface MerchantRedBagViewController () <UITableViewDelegate,UITableViewDataSource> {
    
    NSString *recordType; //1-发放记录 2-领取记录
    
    NSInteger pageIndex;
    
}

@property (nonatomic, weak) UITableView *tableview;

//赠送记录
@property (nonatomic, strong) NSArray *jifenRecordArray;

//发放记录
@property (nonatomic, strong) NSArray *sendRecordArray;

//领取记录
@property (nonatomic, strong) NSArray *getRecordArray;

@property (nonatomic, weak) UISegmentedControl *segmview;

@end

@implementation MerchantRedBagViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.title = @"记录";
    
    self.view.backgroundColor = [UIColor colorWithRed:245/255. green:245/255. blue:245/255. alpha:1.];
    
    recordType = @"0";
    
    pageIndex = 1;
    
    [self allocWithTableview];
    
    [self requestForJiFenData];
    
}

- (void)requestForJiFenData {
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *paeameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId,@"memberid",
                                @"",@"Gust",
                                @"",@"Date",
                                @"",@"Jingbanren",
                                @"",@"Cuxiaoyuan",
                                @"",@"Shop",
                                [NSString stringWithFormat:@"%ld",(long)pageIndex],@"pageIndex",
                                nil];
    
    [httpClient request:@"GetGldTranList_merchant.ashx" parameters:paeameters success:^(NSJSONSerialization* json){

        NSDictionary *dic = (NSDictionary *)json;
        
        BOOL isSuccess = [dic[@"status"] boolValue];
        
        if (isSuccess) {
            
            NSArray *arr = dic[@"ybtrList"];
            
            if (pageIndex == 1) {
                
                NSMutableArray *mut = [NSMutableArray array];
                
                for (NSDictionary *dd in arr) {
                    
                    F_ListModel *model = [[F_ListModel alloc] initWithDict:dd];
                    
                    model.isMerchantRed = YES;
                    
                    SendFrameModel *frameModel = [[SendFrameModel alloc] init];
                    
                    frameModel.model = model;
                    
                    [mut addObject:frameModel];
                    
                }
                
                self.jifenRecordArray = mut;
                
            }else {
                
                NSMutableArray *temp = [NSMutableArray arrayWithArray:self.jifenRecordArray];
                
                for (NSDictionary *dd in arr) {
                    
                    F_ListModel *model = [[F_ListModel alloc] initWithDict:dd];
                    
                    model.isMerchantRed = YES;
                    
                    SendFrameModel *frameModel = [[SendFrameModel alloc] init];
                    
                    frameModel.model = model;
                    
                    [temp addObject:frameModel];
                    
                }
                
                self.jifenRecordArray = temp;
                
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
        
    }failure:^(NSError *error){
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
        if (pageIndex > 1) {
            
            pageIndex --;
            
        }
        
        [self endRefreshing];
        
    }];
    
}

- (void)requestForGetData {
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *Merchant_ID = [userDefau objectForKey:@"Merchant_ID"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         Merchant_ID,@"merchantid",
                         nil];
    
    AppHttpClient *http = [AppHttpClient sharedClient];
    
    [http request:@"ReceiveList.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
        NSDictionary *dic = (NSDictionary *)json;
        
        BOOL isSuccess = [dic[@"status"] boolValue];
        
        if (isSuccess) {
            
            NSArray *arr = dic[@"receivelist"];
            
            if (pageIndex == 1) {
                
                NSMutableArray *mut = [NSMutableArray array];
                
                for (NSDictionary *dd in arr) {
                    
                    MR_GetGroupModel *model = [[MR_GetGroupModel alloc] initWithDict:dd];
                    
                    MR_GetGroupFrame *frame = [[MR_GetGroupFrame alloc] init];
                    
                    frame.groupModel = model;
                    
                    [mut addObject:frame];
                    
                }
                
                self.getRecordArray = mut;
                
            }else {
                
                NSMutableArray *temp = [NSMutableArray arrayWithArray:self.getRecordArray];
                
                for (NSDictionary *dd in arr) {
                    
                    MR_GetGroupModel *model = [[MR_GetGroupModel alloc] initWithDict:dd];
                    
                    MR_GetGroupFrame *frame = [[MR_GetGroupFrame alloc] init];
                    
                    frame.groupModel = model;
                    
                    [temp addObject:frame];
                    
                }
                
                self.getRecordArray = temp;
                
            }
            
            [self.tableview reloadData];
            
        }else {
            
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",dic[@"msg"]]];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

- (void)requestForSendData {
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *Merchant_ID = [userDefau objectForKey:@"Merchant_ID"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         Merchant_ID,@"merchantid",
                         [NSString stringWithFormat:@"%ld",(long)pageIndex],@"pageIndex",
                         nil];
    
    AppHttpClient *http = [AppHttpClient sharedClient];
    
    [http request:@"GrantList.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
        NSDictionary *dic = (NSDictionary *)json;
        
        BOOL isSuccess = [dic[@"status"] boolValue];
        
        if (isSuccess) {
            
            NSArray *arr = dic[@"grantlist"];
            
            if (pageIndex == 1) {
                
                NSMutableArray *mut = [NSMutableArray array];
                
                for (NSDictionary *dd in arr) {
                    
                    MR_SendModel *model = [[MR_SendModel alloc] initWithDict:dd];
                    
                    MR_Send_Frame *frame = [[MR_Send_Frame alloc] init];
                    
                    frame.send_model = model;
                    
                    [mut addObject:frame];
                    
                }
                
                self.sendRecordArray = mut;
                
            }else {
                
                NSMutableArray *temp = [NSMutableArray arrayWithArray:self.sendRecordArray];
                
                for (NSDictionary *dd in arr) {
                    
                    MR_SendModel *model = [[MR_SendModel alloc] initWithDict:dd];
                    
                    MR_Send_Frame *frame = [[MR_Send_Frame alloc] init];
                    
                    frame.send_model = model;
                    
                    [temp addObject:frame];
                    
                }
                
                self.sendRecordArray = temp;
                
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
    
    UISegmentedControl *segmview = [[UISegmentedControl alloc] initWithItems:@[@"赠送记录",@"发放记录",@"领取记录"]];
    
    segmview.frame = CGRectMake(SCREENWIDTH * 0.15, 10, SCREENWIDTH * 0.7, 35);
    
    self.segmview = segmview;
    
    segmview.selectedSegmentIndex = 0;
    
    segmview.tintColor = [UIColor colorWithRed:32/255. green:143/255. blue:250/255. alpha:1.];
    
    [segmview addTarget:self action:@selector(segmchange:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:segmview];
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(segmview.frame) + 10, SCREENWIDTH, SCREENHEIGHT - 64 - 10 - CGRectGetMaxY(segmview.frame))];
    
    self.tableview = tableview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.backgroundColor = [UIColor colorWithRed:245/255. green:245/255. blue:245/255. alpha:1.];
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if ([recordType isEqualToString:@"0"]) {
        
        tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            pageIndex = 1;
            
            [self requestForJiFenData];
            
        }];
        
        tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            
            pageIndex ++;
            
            [self requestForJiFenData];
            
        }];
        
    }
    
    [self.view addSubview:tableview];
    
}

- (void)endRefreshing {
    
    [self.tableview.mj_header endRefreshing];
    
    [self.tableview.mj_footer endRefreshing];
    
}

- (void)segmchange:(UISegmentedControl *)segm {
    
    switch (segm.selectedSegmentIndex) {
        case 0:
        {
            
            recordType = @"0";
            
            pageIndex = 1;
            
            [self requestForJiFenData];
            
        }
            break;
            
        case 1:
        {
            
            recordType = @"1";
            
            pageIndex = 1;
            
            [self requestForSendData];
            
        }
            break;
            
        case 2:
        {
            
            recordType = @"2";
            
            pageIndex = 1;
            
            [self requestForGetData];
            
        }
            break;
            
        default:
            break;
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if ([recordType isEqualToString:@"0"]) {
        
        return self.jifenRecordArray.count;
        
    }else if ([recordType isEqualToString:@"1"]) {
    
        return self.sendRecordArray.count;
        
    }else if ([recordType isEqualToString:@"2"]) {

        return self.getRecordArray.count;

    }else {

        return 0;

    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([recordType isEqualToString:@"0"]) {
        
        SendListCell *cell = [[SendListCell alloc] init];
        
        cell.frameModel = self.jifenRecordArray[indexPath.row];
        
        return cell;
        
    }else if ([recordType isEqualToString:@"1"]) {
    
        MR_Send_Cell *cell = [[MR_Send_Cell alloc] init];
        
        MR_Send_Frame *frame = self.sendRecordArray[indexPath.row];
        
        cell.frameModel = frame;
        
        return cell;
        
    }else if ([recordType isEqualToString:@"2"]) {

        MR_GetGroupCell *cell = [[MR_GetGroupCell alloc] init];
        
        MR_GetGroupFrame *frame = self.getRecordArray[indexPath.row];
        
        cell.frameModel = frame;
        
        return cell;

    }else {

        return nil;

    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([recordType isEqualToString:@"0"]) {
        
        SendFrameModel *frameModel = self.jifenRecordArray[indexPath.row];
        
        return frameModel.height;
        
    }else if ([recordType isEqualToString:@"1"]) {
    
        MR_Send_Frame *frame = self.sendRecordArray[indexPath.row];
        
        return frame.height;
        
    }else if ([recordType isEqualToString:@"2"]) {

        MR_GetGroupFrame *frame = self.getRecordArray[indexPath.row];

        return frame.height;

    }else {

        return 0;

    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([recordType isEqualToString:@"2"]) {
        
        MR_GetGroupFrame *frame = self.getRecordArray[indexPath.row];
        
        Merchant_RedDetailViewController *vc = [[Merchant_RedDetailViewController alloc] init];
        
        vc.date = frame.groupModel.time;
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if ([recordType isEqualToString:@"0"]) {
        
        New_DetailController *vc = [[New_DetailController alloc] init];
        
        SendFrameModel *model = self.jifenRecordArray[indexPath.row];
        
        vc.record = model.model;
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
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
