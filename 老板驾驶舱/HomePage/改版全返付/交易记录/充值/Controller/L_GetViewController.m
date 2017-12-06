//
//  L_GetViewController.m
//  BusinessCenter
//
//  Created by mac on 2017/3/15.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import "L_GetViewController.h"
#import "F_ListModel.h"
#import "GetFrameModel.h"
#import "GetListCell.h"
#import "L_NoRecordCell.h"

#import "AppHttpClient.h"
#import "SVProgressHUD.h"
#import "HttpClientRequest.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define TableColor [UIColor colorWithRed:245/255. green:245/255. blue:249/255. alpha:1.]

@interface L_GetViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation L_GetViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initWithTableview];
    
    [self requestData];
    
}

- (void)initWithTableview {

    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 104)];
    
    self.tableview = tableview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableview.backgroundColor = TableColor;
    
    [self.view addSubview:tableview];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.dataArray.count != 0) {
        
        return self.dataArray.count;
        
    }else {
    
        return 1;
        
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.dataArray.count != 0) {

        GetListCell *cell = [[GetListCell alloc] init];
        
        cell.frameModel = self.dataArray[indexPath.row];
        
        return cell;
        
    }else {
    
        L_NoRecordCell *cell = [[L_NoRecordCell alloc] init];
        
        return cell;
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.dataArray.count != 0) {

        GetFrameModel *model = self.dataArray[indexPath.row];
        
        return model.height;
        
    }else {
    
        L_NoRecordCell *cell = [[L_NoRecordCell alloc] init];
        
        return cell.height;
        
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)requestData {

    [SVProgressHUD showWithStatus:@"加载中..."];
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *paeameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId,@"memberid",
                                @"1",@"status",
                                @"0",@"Gust",
                                @"0",@"Date",
                                @"0",@"Jingbanren",
                                @"0",@"Cuxiaoyuan",
                                @"0",@"Shop",
                                nil];
    
    [httpClient request:@"GetGldTranList_5.ashx" parameters:paeameters success:^(NSJSONSerialization* json){
        
        [SVProgressHUD dismiss];
        
        NSDictionary *dic = (NSDictionary *)json;
        
        NSArray *array = dic[@"ybtrList"];
        
        if (array.count != 0) {
        
            NSMutableArray *mutarr = [NSMutableArray array];
            
            for (NSDictionary *dd in array) {
                
                F_ListModel *model = [[F_ListModel alloc] initWithDict:dd];
                
                GetFrameModel *frameModel = [[GetFrameModel alloc] init];
                
                frameModel.listmodel = model;
                
                [mutarr addObject:frameModel];
                
            }
            
            self.dataArray = mutarr;
            
            [self.tableview reloadData];
            
        }

    }failure:^(NSError *error){
        
        [SVProgressHUD dismiss];
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

}

@end
