//
//  SetupController.m
//  BusinessCenter
//
//  Created by mac on 16/5/13.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import "SetupController.h"
#import "PersonHeadView.h"
#import "ProjectCell.h"
#import "CommissionCell.h"
#import "JiluDetailController.h"
#import "YongjinDetailController.h"
#import "GuaZhongController.h"
#import "AppHttpClient.h"
#import "SVProgressHUD.h"
#import <MJRefresh.h>
#import <AudioUnit/AudioUnit.h>
#import <AVFoundation/AVFoundation.h>
#import "AppDelegate.h"
#import "Timemanage.h"

@interface SetupController ()<BackBtnClickDelegate,UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIAlertViewDelegate,ChangeLabel> {

    NSString *type;
    
    NSString *memberID;
    
    int alltime;
    
    SystemSoundID soundID1;
    
    NSInteger pageIndex;
    
    NSMutableArray *dataArray;
    
    NSMutableArray *yongjinArray;
    
}

@property (nonatomic, weak) PersonHeadView *personHeadView;

@property (nonatomic, weak) UISegmentedControl *segmview;

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, weak) UILabel *noLabel;

@property (nonatomic, weak) NSTimer *currentTimer1;

@property (nonatomic, strong) Timemanage *time;

@end

@implementation SetupController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];
    
    memberID = memberId;
    
    type = @"jilu";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    PersonHeadView *personHeadView = [[PersonHeadView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height * 0.3)];

    self.personHeadView = personHeadView;
    
    [self.view addSubview:personHeadView];
    
    self.navigationController.navigationBarHidden = YES;

    personHeadView.delegate = self;
    
    personHeadView.headImageview.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.iconImageUrl]]];
    
    personHeadView.nameLab.text = self.realName;
    
    personHeadView.statusIconImageview.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.statusIconUrl]]];
    
    [personHeadView.setBtn addTarget:self action:@selector(setBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    if ([self.StatusDes isEqualToString:@"点钟"] || [self.StatusDes isEqualToString:@"排钟"]) {
        
        personHeadView.icon.hidden = NO;
        
    }else {
    
        personHeadView.icon.hidden = YES;
        
    }
    
    [self initSegmView];

    [self initWithTableView];
    
    pageIndex = 1;
    
    [SVProgressHUD showWithStatus:@"请求中..."];
    
    [self requestJiLuDataWithYuangongID:self.yuanGongID withPageIndex:[NSString stringWithFormat:@"%ld",(long)pageIndex]];
    
}

- (void)changeLabelWithString:(int)time {
    
    self.personHeadView.timerLabel.text = [NSString stringWithFormat:@"%@",[self secondToTime:time]];

    if (time == 0) {
        
        [_time timerPause];
        
        self.personHeadView.timerLabel.text = [NSString stringWithFormat:@"时间到"];
        
    }
    
}

- (NSString *)secondToTime:(int)allcount {

    int h = allcount / 3600;
    
    if (h >= 1) {
        
        int yu = allcount % 3600;
        
        int m = yu / 60;
        
        if (m >= 1) {
            
            int y = yu % 60;
            
            return [NSString stringWithFormat:@"%02d:%02d:%02d",h,m,y];
            
        }else {
            
            int y = yu % 60;
        
            return [NSString stringWithFormat:@"00:%02d:%02d",h,y];
            
        }
        
    }else {
    
        int m = allcount / 60;
        
        if (m >= 1) {
            
            int y = allcount % 60;
            
            return [NSString stringWithFormat:@"00:%02d:%02d",m,y];
            
        }else {
        
            return [NSString stringWithFormat:@"00:00:%02d",allcount];
            
        }
    }
}

- (void)setBtnClick {
    
    if ([self.StatusDes isEqualToString:@"停排"]) {
        
        UIActionSheet *sheet1 = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"挂排" otherButtonTitles:@"取消挂排", nil];
        
        sheet1.tag = 1001;
        
        [sheet1 showInView:self.view];
        
    }else if ([self.StatusDes isEqualToString:@"挂排"]) {
    
        UIActionSheet *sheet1 = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"点钟" otherButtonTitles:@"排钟",@"停排",@"取消挂排", nil];
        
        sheet1.tag = 1002;
        
        [sheet1 showInView:self.view];
        
    }else {
        
        UIActionSheet *sheet1 = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"下钟" otherButtonTitles:@"取消服务", nil];
        
        sheet1.tag = 1003;
        
        [sheet1 showInView:self.view];
        
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    self.navigationController.navigationBarHidden = YES;
    
}

- (void)headAndFootEndRefreshing {
    
    [self.tableview.mj_header endRefreshing];
    
    [self.tableview.mj_footer endRefreshing];
    
}

- (void)requestJiLuDataWithYuangongID:(NSString *)yuangongid withPageIndex:(NSString *)pageInde {
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *paeameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId,@"memberID",
                                yuangongid,@"cashierAccountID",
                                pageInde,@"pageIndex",
                                nil];

    [httpClient request:@"ErpPaiHaoJiLuList.ashx" parameters:paeameters success:^(NSJSONSerialization* json){
        
        [SVProgressHUD dismiss];
        
        [self headAndFootEndRefreshing];
        
        NSDictionary *dic = (NSDictionary *)json;
        
        NSDate *nowDate = [self toDate:dic[@"NowTime"]];
        
        NSDate *endDate = [self toDate2:dic[@"EndTime"]];
        
        NSTimeInterval time = [endDate timeIntervalSinceDate:nowDate];
        
        alltime = (int)time;
        
        if ([self.StatusDes isEqualToString:@"点钟"]||[self.StatusDes isEqualToString:@"排钟"]) {
            
            if (alltime > 0) {
                
                _time = [Timemanage shareManage];
                
                _time.delegate = self;
                
                _time.time = alltime;
                
                [_time timerStart];
                
            }else {
            
                [self.currentTimer1 invalidate];
                
                self.personHeadView.timerLabel.text = [NSString stringWithFormat:@"时间到"];
                
            }
        
        }

        if ([pageInde intValue] == 1) {
            
            dataArray = dic[@"PaiHaoJiLuModelList"];
            
        }else {
        
            [dataArray addObjectsFromArray:dic[@"PaiHaoJiLuModelList"]];
            
        }
        
        [self.tableview reloadData];
        
        if (dataArray.count == 0) {
            
            self.tableview.hidden = YES;
            
            self.noLabel.hidden = NO;
            
        }else {
        
            self.tableview.hidden = NO;
            
            self.noLabel.hidden = YES;
            
        }
        
    }failure:^(NSError *error){
        
        [SVProgressHUD dismiss];
        
        [self headAndFootEndRefreshing];
        
    }];
    
}

- (NSDate *)toDate:(NSString *)time {

    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSDate *Date = [fmt dateFromString:time];
    
    return Date;
}

- (NSDate *)toDate2:(NSString *)time {
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    
    fmt.dateFormat = @"yyyy-MM-dd HH:mm";
    
    NSDate *Date = [fmt dateFromString:time];
    
    return Date;
}

- (void)requestYongJinDataWithYuangongID:(NSString *)yuangongid withPageIndex:(NSString *)pageInde {
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *paeameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId,@"memberID",
                                yuangongid,@"cashierAccountID",
                                pageInde,@"pageIndex",
                                nil];
    
    [httpClient request:@"ErpYongJinList.ashx" parameters:paeameters success:^(NSJSONSerialization* json){
        
        [self headAndFootEndRefreshing];
        
        NSDictionary *dic = (NSDictionary *)json;
        
        if ([pageInde intValue] == 1) {
            
            yongjinArray = dic[@"YongJinModelList"];
            
        }else {
            
            [yongjinArray addObjectsFromArray:dic[@"YongJinModelList"]];
            
        }
        
        [self.tableview reloadData];
        
        if (yongjinArray.count == 0) {
            
            self.tableview.hidden = YES;
            
            self.noLabel.hidden = NO;
            
        }else {
            
            self.tableview.hidden = NO;
            
            self.noLabel.hidden = YES;
            
        }
        
    }failure:^(NSError *error){
        
        [self headAndFootEndRefreshing];
        
    }];
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (actionSheet.tag == 1001) {
        
        switch (buttonIndex) {
            case 0:
                
                [self beginSorting];
                
                break;
                
            case 1:
                
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否将该员工移除排号列表？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                
                alert.tag = 888;
                
                [alert show];
            }
                
                break;
                
            default:
                break;
        }
        
    }else if (actionSheet.tag == 1002) {
    
        switch (buttonIndex) {
            case 0:
            {
                GuaZhongController *vc = [[GuaZhongController alloc] init];

                vc.yuangongID = self.yuanGongID;
                
                vc.titletext = @"点钟";
                
                vc.optionType = @"1";

                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
                
            case 1:
            {
                GuaZhongController *vc = [[GuaZhongController alloc] init];
                
                vc.yuangongID = self.yuanGongID;
                
                vc.titletext = @"排钟";
                
                vc.optionType = @"2";
                
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
                
            case 2:
                
                [self stopSorting];
                
                break;
                
            case 3:
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否将该员工移除排号列表？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                
                alert.tag = 888;
                
                [alert show];
            }
                
                break;
                
            default:
                break;
                
        }
        
    }else if (actionSheet.tag == 1003) {
        
        switch (buttonIndex) {
                
            case 0:
                
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否将该员工下钟？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                
                alert.tag = 999;
                
                [alert show];
            }
                
                break;
                
            case 1:
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否取消服务？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                
                alert.tag = 111;
                
                [alert show];
            }
                
                break;
                
            default:
                break;
        }
    }

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex  {

    if (alertView.tag == 888) {
        
        switch (buttonIndex) {
            case 1:
            {
                [self cancelSorting];
            }
                break;
                
            default:
                break;
        }
        
    }else if (alertView.tag == 999) {
    
        switch (buttonIndex) {
            case 1:
            {
                [self dropZhong];
            }
                break;
                
            default:
                break;
        }
        
    }else if (alertView.tag == 111) {
        
        switch (buttonIndex) {
            case 1:
            {
                [self cancleFuWu];
            }
                break;
                
            default:
                break;
        }
        
    }

}

//取消服务
- (void)cancleFuWu {
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *paeameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberID,@"memberID",
                                self.yuanGongID,@"yuanGongID",
                                @"5",@"optionType",
                                nil];
    
    
    [httpClient request:@"ErpPaiHaoOption.ashx" parameters:paeameters success:^(NSJSONSerialization* json){
        
        [SVProgressHUD showSuccessWithStatus:((NSDictionary *)json)[@"msg"]];
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }failure:^(NSError *error){
        
    }];
    
}

//下钟
- (void)dropZhong {

    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *paeameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberID,@"memberID",
                                self.yuanGongID,@"yuanGongID",
                                @"4",@"optionType",
                                nil];
    
    
    [httpClient request:@"ErpPaiHaoOption.ashx" parameters:paeameters success:^(NSJSONSerialization* json){
        
        [SVProgressHUD showSuccessWithStatus:((NSDictionary *)json)[@"msg"]];
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }failure:^(NSError *error){
        
    }];
    
}

//停排
- (void)stopSorting {
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *paeameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberID,@"memberID",
                                self.yuanGongID,@"yuanGongID",
                                @"1",@"optionType",
                                nil];
    
    [httpClient request:@"ErpPaiHaoOption.ashx" parameters:paeameters success:^(NSJSONSerialization* json){

        [SVProgressHUD showSuccessWithStatus:((NSDictionary *)json)[@"msg"]];
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }failure:^(NSError *error){
        
    }];

    
}

//挂排
- (void)beginSorting {

    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *paeameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberID,@"memberID",
                                self.yuanGongID,@"yuanGongID",
                                @"2",@"optionType",
                                nil];
    
    [httpClient request:@"ErpPaiHaoOption.ashx" parameters:paeameters success:^(NSJSONSerialization* json){
        
        [SVProgressHUD showSuccessWithStatus:((NSDictionary *)json)[@"msg"]];
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }failure:^(NSError *error){
        
    }];
    
}

//取消挂排
- (void)cancelSorting {

    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *paeameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberID,@"memberID",
                                self.yuanGongID,@"yuanGongID",
                                @"3",@"optionType",
                                nil];
    
    [httpClient request:@"ErpPaiHaoOption.ashx" parameters:paeameters success:^(NSJSONSerialization* json){
        
        [SVProgressHUD showSuccessWithStatus:((NSDictionary *)json)[@"msg"]];
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }failure:^(NSError *error){
        
    }];
    
}

- (void)viewWillDisappear:(BOOL)animated {

    self.navigationController.navigationBarHidden = NO;
    
}

- (void)initSegmView {

    UISegmentedControl *segmview = [[UISegmentedControl alloc] initWithItems:@[@"记录",@"佣金"]];
    
    segmview.frame = CGRectMake(self.view.bounds.size.width * 0.15,CGRectGetMaxY(self.personHeadView.frame) + 5, self.view.bounds.size.width * 0.7, 30);
    
    self.segmview = segmview;
    
    segmview.selectedSegmentIndex = 0;
    
    segmview.tintColor = [UIColor colorWithRed:3/255. green:168/255. blue:226/255. alpha:1.];
    
    [segmview addTarget:self action:@selector(segmchange:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:segmview];
    
}

- (void)initWithTableView {

    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.segmview.frame) + 5, self.view.bounds.size.width, self.view.bounds.size.height - CGRectGetMaxY(self.segmview.frame) - 5)];
    
    self.tableview = tableview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        if ([type isEqualToString:@"jilu"]) {
            
            pageIndex = 1;
            
            [self requestJiLuDataWithYuangongID:self.yuanGongID withPageIndex:[NSString stringWithFormat:@"%ld",(long)pageIndex]];
            
        }else if ([type isEqualToString:@"yongjin"]) {
        
            pageIndex = 1;
            
            [self requestYongJinDataWithYuangongID:self.yuanGongID withPageIndex:[NSString stringWithFormat:@"%ld",(long)pageIndex]];
            
        }
        
    }];
    
    tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        if ([type isEqualToString:@"jilu"]) {
            
            pageIndex ++;
            
            [self requestJiLuDataWithYuangongID:self.yuanGongID withPageIndex:[NSString stringWithFormat:@"%ld",(long)pageIndex]];
            
        }else if ([type isEqualToString:@"yongjin"]) {
            
            pageIndex ++;
            
            [self requestYongJinDataWithYuangongID:self.yuanGongID withPageIndex:[NSString stringWithFormat:@"%ld",(long)pageIndex]];
            
        }
        
    }];
    
    [self.view addSubview:tableview];
    
    UILabel *noLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.segmview.frame) + 50, self.view.bounds.size.width, 40)];
    
    noLabel.textAlignment = NSTextAlignmentCenter;
    
    noLabel.text = @"暂无记录";
    
    noLabel.textColor = [UIColor lightGrayColor];
    
    self.noLabel = noLabel;
    
    [self.view addSubview:noLabel];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if ([type isEqualToString:@"jilu"]) {
        
        return dataArray.count;
        
    }else {
    
        return yongjinArray.count;
        
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if ([type isEqualToString:@"jilu"]) {
        
        NSDictionary *dic = dataArray[indexPath.row];
        
        ProjectCell *cell = [[ProjectCell alloc] init];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.ProjectImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:dic[@"XiangMuPic"]]]];
        
        cell.ProjectNameLab.text = dic[@"PaiHaoXiangMu"];
        
        cell.ProjectPriceLab.text = [NSString stringWithFormat:@"%@¥",dic[@"ZongJinE"]];
        
        cell.ProjectTimeLab.text = [NSString stringWithFormat:@"时长：%d分钟",[dic[@"ZongShiChang"] intValue]];
        
        cell.ProjectBeginLab.text = [NSString stringWithFormat:@"开始：%@",dic[@"BeginTime"]];
        
        cell.ProjectFinishLab.text = [NSString stringWithFormat:@"结束：%@",dic[@"EndTime"]];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        return cell;
        
    }else {
        
        NSDictionary *dic = yongjinArray[indexPath.row];
    
        CommissionCell *cell = [[CommissionCell alloc] init];
        
        cell.CommissionNameLabel.text = dic[@"InComeOutDes"];
        
        cell.CommissionDateLabel.text = dic[@"ModifyDate"];
        
        cell.CommissionCountLabel.text = [NSString stringWithFormat:@"+%d¥",[dic[@"JinE"] intValue]];
        
        return cell;
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if ([type isEqualToString:@"jilu"]) {
        
        ProjectCell *cell = [[ProjectCell alloc] init];
        
        return cell.height;
        
    }else {
    
        CommissionCell *cell = [[CommissionCell alloc] init];
        
        return cell.height;
        
    }
    
}

- (void)segmchange:(UISegmentedControl *)segm {
    
    NSInteger index = segm.selectedSegmentIndex;
    
    switch (index) {
        case 0:
        {
            if ([type isEqualToString:@"jilu"]) {
                
            }else {
            
                type = @"jilu";
                
                pageIndex = 1;
                
                [self requestJiLuDataWithYuangongID:self.yuanGongID withPageIndex:[NSString stringWithFormat:@"%ld",(long)pageIndex]];
                
            }
            
        }
            break;
            
        case 1:
        {
            if ([type isEqualToString:@"yongjin"]) {
                
            }else {
                
                type = @"yongjin";
                
                pageIndex = 1;
                
                [self requestYongJinDataWithYuangongID:self.yuanGongID withPageIndex:[NSString stringWithFormat:@"%ld",(long)pageIndex]];
                
            }
            
        }
            break;
            
        default:
            break;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([type isEqualToString:@"jilu"]) {
        
        NSDictionary *dic = dataArray[indexPath.row];
        
        JiluDetailController *vc = [[JiluDetailController alloc] init];
        
        vc.GuaZhongNumber = dic[@"GuaZhongNumber"];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
}

- (void)BackBtnClick {

    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

}





@end
