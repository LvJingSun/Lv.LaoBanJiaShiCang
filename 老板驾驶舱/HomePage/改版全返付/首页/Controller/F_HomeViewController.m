//
//  F_HomeViewController.m
//  BusinessCenter
//
//  Created by mac on 2017/3/14.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import "F_HomeViewController.h"
#import "F_TitleView.h"
#import "XieYiViewController.h"
#import "F_HeadView.h"
#import "F_BrokenLineView.h"
#import "F_BrokenLineCell.h"
#import "F_SegmCell.h"
#import "F_RoundView.h"
#import "F_RoundCell.h"
#import "F_ListViewController.h"
#import "TiXingView.h"
#import "F_DateRecord.h"

#import "AppHttpClient.h"
#import "SVProgressHUD.h"
#import "HttpClientRequest.h"

//导航栏颜色
#define TableColor [UIColor colorWithRed:245/255. green:245/255. blue:249/255. alpha:1.]
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface F_HomeViewController () <F_TitleDelegate,UITableViewDelegate,UITableViewDataSource> {

    //周期字段（五天、五周、五月）
    NSString *f_time;
    
    //状态字段（充值、赠送）
    NSString *f_status1;
    
    //状态字段（充值、赠送）
    NSString *f_status2;
    
    //默认选中的周期
    NSInteger moren;
    
    //是否签订合同
    NSString *isTongYi;
    
    //本月赠送总数
    NSString *sendCount;
    
}

//折线图数据
@property (nonatomic, strong) NSMutableArray *LineDataArray;

//x轴数据
@property (nonatomic, strong) NSMutableArray *xDataArray;

@property (nonatomic, weak) UITableView *tableview;

//总资产
@property (nonatomic, weak) UILabel *allCountLab;

//五天的赠送数组
@property (nonatomic, strong) NSMutableArray *ReturnFiveDaysBeforeGiving;

//五周的赠送数组
@property (nonatomic, strong) NSMutableArray *ReturnfirsFiveWeeksGiving;

//五月的赠送数组
@property (nonatomic, strong) NSMutableArray *ReturnfirstFiveMonthsGiving;

//五天的充值数组
@property (nonatomic, strong) NSMutableArray *ReturnFiveDaysBeforeTopUp;

//五周的充值数组
@property (nonatomic, strong) NSMutableArray *ReturnfirsFiveWeeksTopUp;

//五月的充值数组
@property (nonatomic, strong) NSMutableArray *ReturnfirstFiveMonthsTopUp;

@end

@implementation F_HomeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    f_time = @"5天";
    
    f_status1 = @"赠送";
    
    f_status2 = @"充值";
    
    moren = 0;
    
    [self initWithTitleView];
    
    [self initWithTableview];
    
    self.xDataArray = [NSMutableArray array];
    
    self.LineDataArray = [NSMutableArray array];
    
    [self RequestForBrokenLine];
    
    [self initWithRightBtn];
    
    [self yanZheng];
    
    [self RequestForBrokenView];

}

//验证是否签订合同
- (void)yanZheng {
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           nil];
    
    [httpClient request:@"Default_Red.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        isTongYi = [json valueForKey:@"FirstLogin"];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        [defaults setObject:isTongYi forKey:@"ljYanZheng"];
        
        if ([isTongYi isEqualToString:@"未同意"]) {
            
            TiXingView *view = [[TiXingView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
            
            view.icon.image = [UIImage imageNamed:@"fen_yuan.png"];
            
            [view.sureBtn addTarget:self action:@selector(tongyiRequest) forControlEvents:UIControlEventTouchUpInside];
            
            [view.backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            NSString *fensibaoExtension = [defaults objectForKey:@"fensibao_extension"];
            
            view.xieyiTextView.text = fensibaoExtension;
            
            [[[UIApplication sharedApplication].delegate window] addSubview:view];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

//不签订协议返回上一页
- (void)backBtnClick {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

//签订合同
- (void)tongyiRequest {
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [httpClient request:@"Firstlogin2.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            [SVProgressHUD showSuccessWithStatus:@"欢迎加入全返付"];
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

//获取折线图数据
- (void)RequestForBrokenView {

    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"MemID",
                           nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [httpClient request:@"StageSummaryNew.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            NSDictionary *dic1 = [json valueForKey:@"ReturnFiveDaysBeforeGiving"];
            
            NSArray *arr1 = dic1[@"MctReList"];
            
            NSMutableArray *temp1 = [NSMutableArray array];
            
            for (NSDictionary *dd in arr1) {
                
                F_DateRecord *record = [[F_DateRecord alloc] initWithDict:dd];
                
                [temp1 addObject:record];
                
            }
            
            self.ReturnFiveDaysBeforeGiving = temp1;
            
            NSDictionary *dic2 = [json valueForKey:@"ReturnfirsFiveWeeksGiving"];
            
            NSArray *arr2 = dic2[@"MctReList"];
            
            NSMutableArray *temp2 = [NSMutableArray array];
            
            for (NSDictionary *dd in arr2) {
                
                F_DateRecord *record = [[F_DateRecord alloc] initWithDict:dd];
                
                [temp2 addObject:record];
                
            }
            
            self.ReturnfirsFiveWeeksGiving = temp2;
            
            NSDictionary *dic3 = [json valueForKey:@"ReturnfirstFiveMonthsGiving"];
            
            NSArray *arr3 = dic3[@"MctReList"];
            
            NSMutableArray *temp3 = [NSMutableArray array];
            
            for (NSDictionary *dd in arr3) {
                
                F_DateRecord *record = [[F_DateRecord alloc] initWithDict:dd];
                
                [temp3 addObject:record];
                
            }
            
            self.ReturnfirstFiveMonthsGiving = temp3;
            
            NSDictionary *dic4 = [json valueForKey:@"ReturnFiveDaysBeforeTopUp"];
            
            NSArray *arr4 = dic4[@"MctReList"];
            
            NSMutableArray *temp4 = [NSMutableArray array];
            
            for (NSDictionary *dd in arr4) {
                
                F_DateRecord *record = [[F_DateRecord alloc] initWithDict:dd];
                
                [temp4 addObject:record];
                
            }
            
            self.ReturnFiveDaysBeforeTopUp = temp4;
            
            NSDictionary *dic5 = [json valueForKey:@"ReturnfirsFiveWeeksTopUp"];
            
            NSArray *arr5 = dic5[@"MctReList"];
            
            NSMutableArray *temp5 = [NSMutableArray array];
            
            for (NSDictionary *dd in arr5) {
                
                F_DateRecord *record = [[F_DateRecord alloc] initWithDict:dd];
                
                [temp5 addObject:record];
                
            }
            
            self.ReturnfirsFiveWeeksTopUp = temp5;
            
            NSDictionary *dic6 = [json valueForKey:@"ReturnfirstFiveMonthsTopUp"];
            
            NSArray *arr6 = dic6[@"MctReList"];
            
            NSMutableArray *temp6 = [NSMutableArray array];
            
            for (NSDictionary *dd in arr6) {
                
                F_DateRecord *record = [[F_DateRecord alloc] initWithDict:dd];
                
                [temp6 addObject:record];
                
            }
            
            self.ReturnfirstFiveMonthsTopUp = temp6;
            
            [self RequestForBrokenLine];
            
            [SVProgressHUD dismiss];
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

//设置右上角的按钮
- (void)initWithRightBtn {

    self.navigationItem.rightBarButtonItem = [self SetNavigationBarRightTitle:@"明细" andaction:@selector(listClick)];
    
}

//明细按钮点击
- (void)listClick {

    F_ListViewController *vc = [[F_ListViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

//创建tableview
- (void)initWithTableview {

    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    
    self.tableview = tableview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableview.backgroundColor = TableColor;
    
    F_HeadView *headview = [[F_HeadView alloc] init];
    
    headview.frame = CGRectMake(0, 0, SCREEN_WIDTH, headview.height);
    
    self.allCountLab = headview.countLab;
    
    tableview.tableHeaderView = headview;
    
    [self.view addSubview:tableview];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 3;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        F_BrokenLineCell *cell = [[F_BrokenLineCell alloc] init];
        
        cell.lineView.xArr = self.xDataArray;
        
        cell.lineView.data1Arr = self.LineDataArray;
        
        cell.titleLab.text = [NSString stringWithFormat:@"近%@%@情况",f_time,f_status1];
        
        [cell.changeBtn setTitle:[NSString stringWithFormat:@"切换%@情况",f_status2] forState:0];
        
        [cell.changeBtn addTarget:self action:@selector(statusChange) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
        
    }else if (indexPath.row == 1) {
    
        F_SegmCell *cell = [[F_SegmCell alloc] init];
        
        [cell.segm addTarget:self action:@selector(SegmChange:) forControlEvents:UIControlEventValueChanged];
        
        return cell;
        
    }else {
    
        F_RoundCell *cell = [[F_RoundCell alloc] init];
        
        cell.countLab.text = [NSString stringWithFormat:@"%@(个)",sendCount];
        
        return cell;
        
    }

}

//请求赠送的总数
- (void)RequestForSendCount {

    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    
    NSDictionary *paeameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId,@"MemID",
                                nil];
    
    [httpClient request:@"PieChartData.ashx" parameters:paeameters success:^(NSJSONSerialization* json){
        
        NSDictionary *dic = (NSDictionary *)json;
        
        if ([dic[@"status"] boolValue]) {
            
            sendCount = dic[@"Total"];
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
            
            [self.tableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
            
        }
        
    }failure:^(NSError *error){
        
    }];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        F_BrokenLineCell *cell = [[F_BrokenLineCell alloc] init];
        
        return cell.height;
        
    }else if (indexPath.row == 1) {
    
        F_SegmCell *cell = [[F_SegmCell alloc] init];
        
        return cell.height;
        
    }else {
    
        F_RoundCell *cell = [[F_RoundCell alloc] init];
        
        return cell.height;
        
    }

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

//自定义标题
- (void)initWithTitleView {

    F_TitleView *view = [[F_TitleView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH * 0.6, 30)];
    
    view.delegate = self;
    
    self.navigationItem.titleView = view;

}

//代理——标题问号点击
- (void)TitleClick {

    XieYiViewController *vc = [[XieYiViewController alloc] init];
    
    vc.type = @"1";
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)viewWillAppear:(BOOL)animated {

    //每次进入首页更新总资产数据
    [self RequestForAllCount];
    
    //请求赠送总数
    [self RequestForSendCount];
    
}

//赠送和充值情况切换
- (void)statusChange {

    if ([f_status2 isEqualToString:@"赠送"]) {
        
        f_status1 = @"赠送";
        
        f_status2 = @"充值";
        
        if ([f_time isEqualToString:@"5天"]) {
            
            NSMutableArray *mutArr1 = [NSMutableArray array];
            
            NSMutableArray *mutArr2 = [NSMutableArray array];
            
            for (int i = 0; i < self.ReturnFiveDaysBeforeGiving.count; i ++) {
                
                F_DateRecord *record = self.ReturnFiveDaysBeforeGiving[i];
                
                [mutArr1 addObject:[NSString stringWithFormat:@"%.2f",record.Num]];
                
                if (i == 4) {
                    
                    [mutArr2 addObject:@"今天"];
                    
                }else {
                
                    [mutArr2 addObject:[NSString stringWithFormat:@"%@号",record.DTime]];
                    
                }
                
            }
            
            self.LineDataArray = mutArr1;
            
            self.xDataArray = mutArr2;
            
        }else if ([f_time isEqualToString:@"5周"]) {
            
            NSMutableArray *mutArr1 = [NSMutableArray array];
            
            NSMutableArray *mutArr2 = [NSMutableArray array];
            
            for (int i = 0; i < self.ReturnfirsFiveWeeksGiving.count; i ++) {
                
                F_DateRecord *record = self.ReturnfirsFiveWeeksGiving[i];
                
                [mutArr1 addObject:[NSString stringWithFormat:@"%.2f",record.Num]];
                
                if (i == 4) {
                    
                    [mutArr2 addObject:@"本周"];
                    
                }else {
                    
                    [mutArr2 addObject:[NSString stringWithFormat:@"前%d周",record.ID - 1]];
                    
                }
                
            }
            
            self.LineDataArray = mutArr1;
            
            self.xDataArray = mutArr2;
            
        }else if ([f_time isEqualToString:@"5月"]) {
            
            NSMutableArray *mutArr1 = [NSMutableArray array];
            
            NSMutableArray *mutArr2 = [NSMutableArray array];
            
            for (int i = 0; i < self.ReturnfirstFiveMonthsGiving.count; i ++) {
                
                F_DateRecord *record = self.ReturnfirstFiveMonthsGiving[i];
                
                [mutArr1 addObject:[NSString stringWithFormat:@"%.2f",record.Num]];
                
                if (i == 4) {
                    
                    [mutArr2 addObject:@"本月"];
                    
                }else {
                    
                    [mutArr2 addObject:[NSString stringWithFormat:@"%@月",record.DTime]];
                    
                }
                
            }
            
            self.LineDataArray = mutArr1;
            
            self.xDataArray = mutArr2;
            
        }
        
    }else if ([f_status2 isEqualToString:@"充值"]) {
        
        f_status1 = @"充值";
    
        f_status2 = @"赠送";
        
        if ([f_time isEqualToString:@"5天"]) {
            
            NSMutableArray *mutArr1 = [NSMutableArray array];
            
            NSMutableArray *mutArr2 = [NSMutableArray array];
            
            for (int i = 0; i < self.ReturnFiveDaysBeforeTopUp.count; i ++) {
                
                F_DateRecord *record = self.ReturnFiveDaysBeforeTopUp[i];
                
                [mutArr1 addObject:[NSString stringWithFormat:@"%.2f",record.Num]];
                
                if (i == 4) {
                    
                    [mutArr2 addObject:@"今天"];
                    
                }else {
                    
                    [mutArr2 addObject:[NSString stringWithFormat:@"%@号",record.DTime]];
                    
                }
                
            }
            
            self.LineDataArray = mutArr1;
            
            self.xDataArray = mutArr2;
            
        }else if ([f_time isEqualToString:@"5周"]) {
            
            NSMutableArray *mutArr1 = [NSMutableArray array];
            
            NSMutableArray *mutArr2 = [NSMutableArray array];
            
            for (int i = 0; i < self.ReturnfirsFiveWeeksTopUp.count; i ++) {
                
                F_DateRecord *record = self.ReturnfirsFiveWeeksTopUp[i];
                
                [mutArr1 addObject:[NSString stringWithFormat:@"%.2f",record.Num]];
                
                if (i == 4) {
                    
                    [mutArr2 addObject:@"本周"];
                    
                }else {
                    
                    [mutArr2 addObject:[NSString stringWithFormat:@"前%d周",record.ID - 1]];
                    
                }
                
            }
            
            self.LineDataArray = mutArr1;
            
            self.xDataArray = mutArr2;
            
        }else if ([f_time isEqualToString:@"5月"]) {
            
            NSMutableArray *mutArr1 = [NSMutableArray array];
            
            NSMutableArray *mutArr2 = [NSMutableArray array];
            
            for (int i = 0; i < self.ReturnfirstFiveMonthsTopUp.count; i ++) {
                
                F_DateRecord *record = self.ReturnfirstFiveMonthsTopUp[i];
                
                [mutArr1 addObject:[NSString stringWithFormat:@"%.2f",record.Num]];
                
                if (i == 4) {
                    
                    [mutArr2 addObject:@"本月"];
                    
                }else {
                    
                    [mutArr2 addObject:[NSString stringWithFormat:@"%@月",record.DTime]];
                    
                }
                
            }
            
            self.LineDataArray = mutArr1;
            
            self.xDataArray = mutArr2;
            
        }

    }
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    [self.tableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
    
}

//周期变化
- (void)SegmChange:(UISegmentedControl *)segm {

    NSInteger index = segm.selectedSegmentIndex;
    
    if (index != moren) {
        
        switch (index) {
            case 0:
            {
            
                moren = index;
                
                f_time = @"5天";
                
                if ([f_status1 isEqualToString:@"赠送"]) {
                    
                    NSMutableArray *mutArr1 = [NSMutableArray array];
                    
                    NSMutableArray *mutArr2 = [NSMutableArray array];
                    
                    for (int i = 0; i < self.ReturnFiveDaysBeforeGiving.count; i ++) {
                        
                        F_DateRecord *record = self.ReturnFiveDaysBeforeGiving[i];
                        
                        [mutArr1 addObject:[NSString stringWithFormat:@"%.2f",record.Num]];
                        
                        if (i == 4) {
                            
                            [mutArr2 addObject:@"今天"];
                            
                        }else {
                            
                            [mutArr2 addObject:[NSString stringWithFormat:@"%@号",record.DTime]];
                            
                        }
                        
                    }
                    
                    self.LineDataArray = mutArr1;
                    
                    self.xDataArray = mutArr2;
                    
                }else if ([f_status1 isEqualToString:@"充值"]) {
                
                    NSMutableArray *mutArr1 = [NSMutableArray array];
                    
                    NSMutableArray *mutArr2 = [NSMutableArray array];
                    
                    for (int i = 0; i < self.ReturnFiveDaysBeforeTopUp.count; i ++) {
                        
                        F_DateRecord *record = self.ReturnFiveDaysBeforeTopUp[i];
                        
                        [mutArr1 addObject:[NSString stringWithFormat:@"%.2f",record.Num]];
                        
                        if (i == 4) {
                            
                            [mutArr2 addObject:@"今天"];
                            
                        }else {
                            
                            [mutArr2 addObject:[NSString stringWithFormat:@"%@号",record.DTime]];
                            
                        }
                        
                    }
                    
                    self.LineDataArray = mutArr1;
                    
                    self.xDataArray = mutArr2;
                    
                }
                
            }
                break;
                
            case 1:
            {
                
                moren = index;
                
                f_time = @"5周";
                
                if ([f_status1 isEqualToString:@"赠送"]) {
                    
                    NSMutableArray *mutArr1 = [NSMutableArray array];
                    
                    NSMutableArray *mutArr2 = [NSMutableArray array];
                    
                    for (int i = 0; i < self.ReturnfirsFiveWeeksGiving.count; i ++) {
                        
                        F_DateRecord *record = self.ReturnfirsFiveWeeksGiving[i];
                        
                        [mutArr1 addObject:[NSString stringWithFormat:@"%.2f",record.Num]];
                        
                        if (i == 4) {
                            
                            [mutArr2 addObject:@"本周"];
                            
                        }else {
                            
                            [mutArr2 addObject:[NSString stringWithFormat:@"前%d周",record.ID - 1]];
                            
                        }
                        
                    }
                    
                    self.LineDataArray = mutArr1;
                    
                    self.xDataArray = mutArr2;
                    
                }else if ([f_status1 isEqualToString:@"充值"]) {
                    
                    NSMutableArray *mutArr1 = [NSMutableArray array];
                    
                    NSMutableArray *mutArr2 = [NSMutableArray array];
                    
                    for (int i = 0; i < self.ReturnfirsFiveWeeksTopUp.count; i ++) {
                        
                        F_DateRecord *record = self.ReturnfirsFiveWeeksTopUp[i];
                        
                        [mutArr1 addObject:[NSString stringWithFormat:@"%.2f",record.Num]];
                        
                        if (i == 4) {
                            
                            [mutArr2 addObject:@"本周"];
                            
                        }else {
                            
                            [mutArr2 addObject:[NSString stringWithFormat:@"前%d周",record.ID - 1]];
                            
                        }
                        
                    }
                    
                    self.LineDataArray = mutArr1;
                    
                    self.xDataArray = mutArr2;
                    
                }
                
            }
                break;
                
            case 2:
            {
                
                moren = index;
                
                f_time = @"5月";
                
                if ([f_status1 isEqualToString:@"赠送"]) {
                    
                    NSMutableArray *mutArr1 = [NSMutableArray array];
                    
                    NSMutableArray *mutArr2 = [NSMutableArray array];
                    
                    for (int i = 0; i < self.ReturnfirstFiveMonthsGiving.count; i ++) {
                        
                        F_DateRecord *record = self.ReturnfirstFiveMonthsGiving[i];
                        
                        [mutArr1 addObject:[NSString stringWithFormat:@"%.2f",record.Num]];
                        
                        if (i == 4) {
                            
                            [mutArr2 addObject:@"本月"];
                            
                        }else {
                            
                            [mutArr2 addObject:[NSString stringWithFormat:@"%@月",record.DTime]];
                            
                        }
                        
                    }
                    
                    self.LineDataArray = mutArr1;
                    
                    self.xDataArray = mutArr2;
                    
                }else if ([f_status1 isEqualToString:@"充值"]) {
                    
                    NSMutableArray *mutArr1 = [NSMutableArray array];
                    
                    NSMutableArray *mutArr2 = [NSMutableArray array];
                    
                    for (int i = 0; i < self.ReturnfirstFiveMonthsTopUp.count; i ++) {
                        
                        F_DateRecord *record = self.ReturnfirstFiveMonthsTopUp[i];
                        
                        [mutArr1 addObject:[NSString stringWithFormat:@"%.2f",record.Num]];
                        
                        if (i == 4) {
                            
                            [mutArr2 addObject:@"本月"];
                            
                        }else {
                            
                            [mutArr2 addObject:[NSString stringWithFormat:@"%@月",record.DTime]];
                            
                        }
                        
                    }
                    
                    self.LineDataArray = mutArr1;
                    
                    self.xDataArray = mutArr2;
                    
                }
                
            }
                break;
                
            default:
                break;
        }
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        
        [self.tableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
        
    }
    
}

//请求折线图数据
- (void)RequestForBrokenLine {

    NSMutableArray *mutArr1 = [NSMutableArray array];
    
    NSMutableArray *mutArr2 = [NSMutableArray array];
    
    for (int i = 0; i < self.ReturnFiveDaysBeforeGiving.count; i ++) {
        
        F_DateRecord *record = self.ReturnFiveDaysBeforeGiving[i];
        
        [mutArr1 addObject:[NSString stringWithFormat:@"%.2f",record.Num]];
        
        if (i == 4) {
            
            [mutArr2 addObject:@"今天"];
            
        }else {
            
            [mutArr2 addObject:[NSString stringWithFormat:@"%@号",record.DTime]];
            
        }
        
    }
    
    self.LineDataArray = mutArr1;
    
    self.xDataArray = mutArr2;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    [self.tableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
    
}

//请求总资产
- (void)RequestForAllCount {

    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    
    NSDictionary *paeameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId,@"memberid",
                                nil];
    
    [httpClient request:@"GetGldbalance.ashx" parameters:paeameters success:^(NSJSONSerialization* json){
        
        NSDictionary *dic = (NSDictionary *)json;
        
        NSDictionary *dict = dic[@"yuEMore"];
        
        if (![dict[@"Balance"] isEqualToString:@""]) {
            
            self.allCountLab.text = dict[@"Balance"];
            
        }
        
    }failure:^(NSError *error){
        
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
