//
//  L_SendViewController.m
//  BusinessCenter
//
//  Created by mac on 2017/3/15.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import "L_SendViewController.h"
#import "F_ListModel.h"
#import "SendFrameModel.h"
#import "SendListCell.h"
#import "L_NoRecordCell.h"
#import "New_DetailController.h"

#import "AppHttpClient.h"
#import "SVProgressHUD.h"
#import "HttpClientRequest.h"

#import "JSDropDownMenu.h"
#import "KeHu.h"
#import "RiQi.h"
#import "JingBanRen.h"
#import "CuXiaoYuan.h"
#import "DianPu.h"
#import <MJRefresh.h>

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define TableColor [UIColor colorWithRed:245/255. green:245/255. blue:249/255. alpha:1.]

@interface L_SendViewController () <UITableViewDelegate,UITableViewDataSource,JSDropDownMenuDelegate,JSDropDownMenuDataSource> {

    NSMutableArray *_kehuArray;
    
    NSMutableArray *_riqiArray;
    
    NSMutableArray *_jingbanrenArray;
    
    NSMutableArray *_cuxiaoyuanArray;
    
    NSMutableArray *_dianpuArray;
    
    NSInteger _kehuIndex;
    
    NSInteger _riqiIndex;
    
    NSInteger _jingbanrenIndex;
    
    NSInteger _cuxiaoyuanIndex;
    
    NSInteger _dianpuIndex;
    
    JSDropDownMenu *menu;
    
    int pageindex;
    
}

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation L_SendViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    pageindex = 1;
    
    [self initWithTableview];
    
    [self requestChooseData];
    
    [self RequestDataWithKeHu:@"0" WithRiQi:@"0" WithJingBanRen:@"0" WithCuXiaoYuan:@"0" WithDianPu:@"0"];
    
}

- (void)requestChooseData {
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         memberId,@"memberid", nil];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    
    [httpClient request:@"NewGetGldList.ashx" parameters:dic success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            NSArray *kehuarr = [json valueForKey:@"MemberidList"];
            
            _kehuArray = [NSMutableArray array];
            
            for (NSDictionary *dd in kehuarr) {
                
                KeHu *kk = [[KeHu alloc] initWithDict:dd];
                
                [_kehuArray addObject:kk];
                
            }
            
            NSArray *riqiarr = [json valueForKey:@"CreateDateList"];
            
            _riqiArray = [NSMutableArray array];
            
            for (NSDictionary *dd in riqiarr) {
                
                RiQi *kk = [[RiQi alloc] initWithDict:dd];
                
                [_riqiArray addObject:kk];
                
            }
            
            NSArray *jingbanrenarr = [json valueForKey:@"CashierList"];
            
            _jingbanrenArray = [NSMutableArray array];
            
            for (NSDictionary *dd in jingbanrenarr) {
                
                JingBanRen *kk = [[JingBanRen alloc] initWithDict:dd];
                
                [_jingbanrenArray addObject:kk];
                
            }
            
            NSArray *cuxiaoyuanarr = [json valueForKey:@"CuxiaoyuanList"];
            
            _cuxiaoyuanArray = [NSMutableArray array];
            
            for (NSDictionary *dd in cuxiaoyuanarr) {
                
                CuXiaoYuan *kk = [[CuXiaoYuan alloc] initWithDict:dd];
                
                [_cuxiaoyuanArray addObject:kk];
                
            }
            
            NSArray *dianpuarr = [json valueForKey:@"MerchantShopList"];
            
            _dianpuArray = [NSMutableArray array];
            
            for (NSDictionary *dd in dianpuarr) {
                
                DianPu *kk = [[DianPu alloc] initWithDict:dd];
                
                [_dianpuArray addObject:kk];
                
            }
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

- (void)initWithTableview {
    
    menu = [[JSDropDownMenu alloc] initWithOrigin:CGPointMake(0, 0) andHeight:45];
    
    menu.indicatorColor = [UIColor colorWithRed:175.0f/255.0f green:175.0f/255.0f blue:175.0f/255.0f alpha:1.0];
    
    menu.separatorColor = [UIColor colorWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1.0];
    
    menu.textColor = [UIColor colorWithRed:83.f/255.0f green:83.f/255.0f blue:83.f/255.0f alpha:1.0f];
    
    menu.dataSource = self;
    
    menu.delegate = self;
    
    [self.view addSubview:menu];
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(menu.frame), SCREEN_WIDTH, SCREEN_HEIGHT - 149)];
    
    self.tableview = tableview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableview.backgroundColor = TableColor;
    
    tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        pageindex = 1;
        
        KeHu *kehu = _kehuArray[_kehuIndex];
        
        RiQi *riqi = _riqiArray[_riqiIndex];
        
        JingBanRen *jingbanren = _jingbanrenArray[_jingbanrenIndex];
        
        CuXiaoYuan *cuxiaoyuan = _cuxiaoyuanArray[_cuxiaoyuanIndex];
        
        DianPu *dianpu = _dianpuArray[_dianpuIndex];
        
        [self RequestDataWithKeHu:[NSString stringWithFormat:@"%@",kehu.memID] WithRiQi:[NSString stringWithFormat:@"%@",riqi.CreateDateID] WithJingBanRen:[NSString stringWithFormat:@"%@",jingbanren.CashierAccountID] WithCuXiaoYuan:[NSString stringWithFormat:@"%@",cuxiaoyuan.CuxiaoyuanID] WithDianPu:[NSString stringWithFormat:@"%@",dianpu.MerchantShopID]];
        
    }];
    
    tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        pageindex ++;
        
        KeHu *kehu = _kehuArray[_kehuIndex];
        
        RiQi *riqi = _riqiArray[_riqiIndex];
        
        JingBanRen *jingbanren = _jingbanrenArray[_jingbanrenIndex];
        
        CuXiaoYuan *cuxiaoyuan = _cuxiaoyuanArray[_cuxiaoyuanIndex];
        
        DianPu *dianpu = _dianpuArray[_dianpuIndex];
        
        [self RequestDataWithKeHu:[NSString stringWithFormat:@"%@",kehu.memID] WithRiQi:[NSString stringWithFormat:@"%@",riqi.CreateDateID] WithJingBanRen:[NSString stringWithFormat:@"%@",jingbanren.CashierAccountID] WithCuXiaoYuan:[NSString stringWithFormat:@"%@",cuxiaoyuan.CuxiaoyuanID] WithDianPu:[NSString stringWithFormat:@"%@",dianpu.MerchantShopID]];
        
    }];
    
    [self.view addSubview:tableview];
    
}

- (void)headAndFootEndRefreshing {
    
    [self.tableview.mj_header endRefreshing];
    
    [self.tableview.mj_footer endRefreshing];
    
}

- (NSInteger)numberOfColumnsInMenu:(JSDropDownMenu *)menu {
    
    return 5;
    
}

-(BOOL)displayByCollectionViewInColumn:(NSInteger)column{
    
    return NO;
    
}

-(BOOL)haveRightTableViewInColumn:(NSInteger)column{
    
    return NO;
    
}

-(CGFloat)widthRatioOfLeftColumn:(NSInteger)column{
    
    return 1;
    
}

-(NSInteger)currentLeftSelectedRow:(NSInteger)column{
    if (column==0) {
        
        return _kehuIndex;
        
    }else if (column==1){
        
        return _riqiIndex;
        
    }else if (column==2){
        
        return _jingbanrenIndex;
        
    }else if (column==3){
        
        return _cuxiaoyuanIndex;
        
    }else if (column==4){
        
        return _dianpuIndex;
        
    }
    return 0;
}

- (NSInteger)currentRightSelectedRow:(NSInteger)column;{
    
    if (column==0) {
        
        return _kehuIndex;
        
    }
    
    if (column==1) {
        
        return _riqiIndex;
        
    }
    
    if (column==2) {
        
        return _jingbanrenIndex;
        
    }
    
    if (column==3) {
        
        return _cuxiaoyuanIndex;
        
    }
    
    if (column==4) {
        
        return _dianpuIndex;
        
    }
    
    return 0;
    
}

- (NSInteger)menu:(JSDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column leftOrRight:(NSInteger)leftOrRight leftRow:(NSInteger)leftRow{
    
    if (column==0) {
        
        return _kehuArray.count;
        
    }else if (column==1){
        
        return _riqiArray.count;
        
    }else if (column==2){
        
        return _jingbanrenArray.count;
        
    }else if (column==3){
        
        return _cuxiaoyuanArray.count;
        
    }else if (column==4){
        
        return _dianpuArray.count;
        
    }
    
    return 0;
}

- (NSString *)menu:(JSDropDownMenu *)menu titleForColumn:(NSInteger)column{
    
    switch (column) {
        case 0: return @"客户";
            break;
        case 1: return @"日期";
            break;
        case 2: return @"经办人";
            break;
        case 3: return @"促销员";
            break;
        case 4: return @"店铺";
            break;
        default:
            return nil;
            break;
    }
    
}

- (NSString *)menu:(JSDropDownMenu *)menu titleForRowAtIndexPath:(JSIndexPath *)indexPath {
    
    if (indexPath.column == 0) {
        
        KeHu *kehu = _kehuArray[indexPath.row];
        
        if (indexPath.row == 0) {
            
            return @"客户";
            
        }else {
        
            return kehu.Memberid;
            
        }
        
    }else if (indexPath.column == 1) {
        
        RiQi *riqi = _riqiArray[indexPath.row];
        
        if (indexPath.row == 0) {
            
            return @"日期";
            
        }else {
        
            return riqi.CreateDate;
            
        }
        
    }else if (indexPath.column == 2) {
        
        JingBanRen *jingbanren = _jingbanrenArray[indexPath.row];
        
        if (indexPath.row == 0) {
            
            return @"经办人";
            
        }else {
        
            return jingbanren.CashierAccount;
            
        }
        
    }else if (indexPath.column == 3) {
        
        CuXiaoYuan *cuxiao = _cuxiaoyuanArray[indexPath.row];
        
        if (indexPath.row == 0) {
            
            return @"促销员";
            
        }else {
        
            return cuxiao.Cuxiaoyuan;
            
        }
        
    }else if (indexPath.column == 4) {
        
        DianPu *dianpu = _dianpuArray[indexPath.row];
        
        if (indexPath.row == 0) {
            
            return @"店铺";
            
        }else {
        
            return dianpu.MerchantShop;
            
        }
        
    }
    
    return 0;
    
}

- (void)menu:(JSDropDownMenu *)menu didSelectRowAtIndexPath:(JSIndexPath *)indexPath {
    
    if (indexPath.column == 0) {
        
        _kehuIndex = indexPath.row;
        
    } else if(indexPath.column == 1){
        
        _riqiIndex = indexPath.row;
        
    } else if(indexPath.column == 2){
        
        _jingbanrenIndex = indexPath.row;
        
    } else if(indexPath.column == 3){
        
        _cuxiaoyuanIndex = indexPath.row;
        
    } else if(indexPath.column == 4){
        
        _dianpuIndex = indexPath.row;
        
    }
    
    KeHu *kehu = _kehuArray[_kehuIndex];
    
    RiQi *riqi = _riqiArray[_riqiIndex];
    
    JingBanRen *jingbanren = _jingbanrenArray[_jingbanrenIndex];
    
    CuXiaoYuan *cuxiaoyuan = _cuxiaoyuanArray[_cuxiaoyuanIndex];
    
    DianPu *dianpu = _dianpuArray[_dianpuIndex];
    
    [self RequestDataWithKeHu:[NSString stringWithFormat:@"%@",kehu.memID] WithRiQi:[NSString stringWithFormat:@"%@",riqi.CreateDateID] WithJingBanRen:[NSString stringWithFormat:@"%@",jingbanren.CashierAccountID] WithCuXiaoYuan:[NSString stringWithFormat:@"%@",cuxiaoyuan.CuxiaoyuanID] WithDianPu:[NSString stringWithFormat:@"%@",dianpu.MerchantShopID]];
    
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
        
        SendListCell *cell = [[SendListCell alloc] init];
        
        cell.frameModel = self.dataArray[indexPath.row];
        
        return cell;
        
    }else {
        
        L_NoRecordCell *cell = [[L_NoRecordCell alloc] init];
        
        return cell;
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.dataArray.count != 0) {
        
        SendFrameModel *model = self.dataArray[indexPath.row];
        
        return model.height;
        
    }else {
        
        L_NoRecordCell *cell = [[L_NoRecordCell alloc] init];
        
        return cell.height;
        
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.dataArray.count != 0) {
    
        New_DetailController *vc = [[New_DetailController alloc] init];
        
        SendFrameModel *model = self.dataArray[indexPath.row];
        
        vc.record = model.model;
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
}

- (void)RequestDataWithKeHu:(NSString *)kehu WithRiQi:(NSString *)riqi WithJingBanRen:(NSString *)jingbanren WithCuXiaoYuan:(NSString *)cuxiaoyuan WithDianPu:(NSString *)dianpu {

    [SVProgressHUD showWithStatus:@"加载中..."];
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *paeameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId,@"memberid",
                                @"2",@"status",
                                kehu,@"Gust",
                                riqi,@"Date",
                                jingbanren,@"Jingbanren",
                                cuxiaoyuan,@"Cuxiaoyuan",
                                dianpu,@"Shop",
                                [NSString stringWithFormat:@"%d",pageindex],@"pageIndex",
                                nil];
    
    [httpClient request:@"GetGldTranList_5.ashx" parameters:paeameters success:^(NSJSONSerialization* json){
        
        [SVProgressHUD dismiss];
        
        NSDictionary *dic = (NSDictionary *)json;
        
        NSArray *array = dic[@"ybtrList"];
        
        if (array.count != 0) {
            
            NSMutableArray *mutarr = [NSMutableArray array];
            
            for (NSDictionary *dd in array) {
                
                F_ListModel *model = [[F_ListModel alloc] initWithDict:dd];
                
                SendFrameModel *frameModel = [[SendFrameModel alloc] init];
                
                frameModel.model = model;
                
                [mutarr addObject:frameModel];
                
            }
            
            if (pageindex == 1) {
                
                self.dataArray = mutarr;
                
            }else {
            
                NSMutableArray *temp = [NSMutableArray arrayWithArray:self.dataArray];
                
                [temp addObjectsFromArray:mutarr];
                
                self.dataArray = temp;
                
            }
            
        }else {
        
            self.dataArray = array;
            
        }
        
        [self.tableview reloadData];
        
        [self headAndFootEndRefreshing];
        
    }failure:^(NSError *error){
        
        [SVProgressHUD dismiss];
        
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
