//
//  ManagerController.m
//  BusinessCenter
//
//  Created by mac on 16/4/26.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import "ManagerController.h"
#import "ManagerCell.h"
#import "Manager.h"
#import "StorageController.h"
#import "EditManagerController.h"
#import "AppHttpClient.h"
#import "StockController.h"
#import "KuCunController.h"
#import <MJRefresh.h>
#import "ProductCell.h"
#import "GMDCircleLoader.h"
#define HOME_BACK_COLOR [UIColor colorWithRed:230/255. green:230/255. blue:230/255. alpha:1.]
#define Width  ([[UIScreen mainScreen] bounds].size.width)
#define Height  ([[UIScreen mainScreen] bounds].size.height)

@interface ManagerController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate> {

    NSString *kuCun;
    
    NSIndexPath *_indexPath;
    
}

@property (nonatomic, weak) UISegmentedControl *segmview;

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, assign) NSInteger pageIndex;

@property (nonatomic, strong) NSArray *jingbanrenArray;

@property (nonatomic, strong) NSArray *gongyingshangArray;

@property (nonatomic, strong) NSArray *chanpinArray;

@property (nonatomic, strong) NSArray *kehuArray;

@property (nonatomic, weak) UILabel *noLabel;

@end

@implementation ManagerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];
    
    kuCun = @"0";
    
    self.title = @"库存管理";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setRightBtn];
    
    UISegmentedControl *segmview = [[UISegmentedControl alloc] initWithItems:@[@"库存",@"出库",@"入库"]];
    
    segmview.frame = CGRectMake(Width * 0.25, 5, Width * 0.5, 30);
    
    self.segmview = segmview;
    
    segmview.selectedSegmentIndex = 0;
    
    segmview.tintColor = [UIColor colorWithRed:19/255. green:151/255. blue:36/255. alpha:1.];
    
    [segmview addTarget:self action:@selector(segmchange:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:segmview];
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(segmview.frame) + 5, Width, Height - CGRectGetMaxY(segmview.frame) - 69)];
    
    self.tableview = tableview;
    
    tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        self.pageIndex = 1;
        
        [self requestDataWithMemberID:memberId WithPageIndex:[NSString stringWithFormat:@"%ld",(long)self.pageIndex] withkuCunType:kuCun];
        
    }];
    
    tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        self.pageIndex ++;
        
        [self requestDataWithMemberID:memberId WithPageIndex:[NSString stringWithFormat:@"%ld",(long)self.pageIndex] withkuCunType:kuCun];
        
    }];
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    [self.view addSubview:tableview];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressClick:)];
    
    longPress.minimumPressDuration = 1.0;
    
    [tableview addGestureRecognizer:longPress];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 100, self.view.bounds.size.width - 100, 30)];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    label.text = @"暂无数据";
    
    label.textColor = [UIColor lightGrayColor];
    
    self.noLabel = label;
    
    [self.view addSubview:label];

}

- (void)setRightBtn {
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    addBtn.frame = CGRectMake(0, 0, 30, 20);
    
    [addBtn setTitle:@"设置" forState:UIControlStateNormal];
    
    addBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    
    [addBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    
    [addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    editBtn.frame = CGRectMake(0, 0, 15, 15);
    
    [editBtn setImage:[UIImage imageNamed:@"sotckjia.png"] forState:UIControlStateNormal];
    
    [editBtn addTarget:self action:@selector(editBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *addBarBtn = [[UIBarButtonItem alloc] initWithCustomView:addBtn];
    
    UIBarButtonItem *screenBarBtn=[[UIBarButtonItem alloc]initWithCustomView:editBtn];
    
    self.navigationItem.rightBarButtonItems = @[screenBarBtn,addBarBtn];
    
}

- (void)addBtnClick {

    KuCunController *vc = [[KuCunController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)longPressClick:(UILongPressGestureRecognizer *)gesture {
    
    if ([kuCun isEqualToString:@"0"]) {
        
        
        
    }else {
    
        if (gesture.state == UIGestureRecognizerStateBegan) {
            
            CGPoint point = [gesture locationInView:self.tableview];
            
            _indexPath = [self.tableview indexPathForRowAtPoint:point];
            
            if (_indexPath == nil) {
                
                return;
                
            }else {
                
                UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"删除", nil];
                
                sheet.tag = 111;
                
                [sheet showInView:self.view];
                
            }
        }
        
    }
}

- (void)requestCPArrayWithMemberID:(NSString *)memberID {
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *paeameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberID,@"memberID",
                                @"3",@"keyType",
                                nil];
    
    [httpClient request:@"ErpKeValueList.ashx" parameters:paeameters success:^(NSJSONSerialization* json){
        
        NSDictionary *dic = (NSDictionary *)json;
        
        self.chanpinArray = dic[@"KuCunModelList"];
        
    }failure:^(NSError *error){
        
    }];
    
}

- (void)requestJBRArrayWithMemberID:(NSString *)memberID {

    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *paeameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberID,@"memberID",
                                @"1",@"keyType",
                                nil];
    
    [httpClient request:@"ErpKeValueList.ashx" parameters:paeameters success:^(NSJSONSerialization* json){
        
        NSDictionary *dic = (NSDictionary *)json;
        
        self.jingbanrenArray = dic[@"KuCunModelList"];
        
    }failure:^(NSError *error){
        
    }];

}

- (void)requestKHArrayWithMemberID:(NSString *)memberID {
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *paeameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberID,@"memberID",
                                @"8",@"keyType",
                                nil];
    
    [httpClient request:@"ErpKeValueList.ashx" parameters:paeameters success:^(NSJSONSerialization* json){
        
        NSDictionary *dic = (NSDictionary *)json;
        
        self.kehuArray = dic[@"KuCunModelList"];
        
    }failure:^(NSError *error){
        
    }];
    
}

- (void)requestGYSArrayWithMemberID:(NSString *)memberID {
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *paeameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberID,@"memberID",
                                @"2",@"keyType",
                                nil];
    
    [httpClient request:@"ErpKeValueList.ashx" parameters:paeameters success:^(NSJSONSerialization* json){
        
        NSDictionary *dic = (NSDictionary *)json;
        
        self.gongyingshangArray = dic[@"KuCunModelList"];
        
    }failure:^(NSError *error){
        
    }];
    
}

- (void)headAndFootEndRefreshing {
    
    [self.tableview.mj_header endRefreshing];
    
    [self.tableview.mj_footer endRefreshing];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];

    [self requestDataWithMemberID:memberId WithPageIndex:@"1" withkuCunType:kuCun];
    
    [self requestJBRArrayWithMemberID:memberId];
    
    [self requestGYSArrayWithMemberID:memberId];
    
    [self requestCPArrayWithMemberID:memberId];
    
    [self requestKHArrayWithMemberID:memberId];
    
}

- (void)requestDataWithMemberID:(NSString *)memberId WithPageIndex:(NSString *)pageIndex withkuCunType:(NSString *)kuCunType{

    if ([kuCunType isEqualToString:@"0"]) {
        
        AppHttpClient* httpClient = [AppHttpClient sharedClient];
        NSDictionary *paeameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                    memberId,@"memberID",
                                    nil];
        
        [httpClient request:@"ErpChanPinList.ashx" parameters:paeameters success:^(NSJSONSerialization* json){
            
            [self headAndFootEndRefreshing];
            
            NSDictionary *dic = (NSDictionary *)json;
                
            self.dataArray = dic[@"ChanPinModelList"];
            
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
        
    }else {
    
        AppHttpClient* httpClient = [AppHttpClient sharedClient];
        NSDictionary *paeameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                    memberId,@"memberID",
                                    pageIndex,@"pageIndex",
                                    kuCunType,@"kuCunType",
                                    nil];
        
        [httpClient request:@"ErpKuCunList.ashx" parameters:paeameters success:^(NSJSONSerialization* json){
            
            [self headAndFootEndRefreshing];
            
            NSDictionary *dic = (NSDictionary *)json;
            
            if ([pageIndex intValue] == 1) {
                
                self.dataArray = dic[@"KuCunModelList"];
                
            }else {
                
                [self.dataArray addObjectsFromArray:dic[@"KuCunModelList"]];
                
            }
            
            if (self.dataArray.count == 0) {
                
                self.noLabel.hidden = NO;
                
                self.tableview.hidden = YES;
                
            }else {
                
                self.tableview.hidden = NO;
                
                self.noLabel.hidden = YES;
                
                [self.tableview reloadData];
                
            }
            
        }failure:^(NSError *error){
            
            [self headAndFootEndRefreshing];
            
        }];
        
    }
}

- (void)editBtnClick {

    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"出库" otherButtonTitles:@"入库", nil];
    
    [sheet showInView:self.view];
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (actionSheet.tag == 111) {
        
        if ((int)buttonIndex == 0) {
            
            NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
            
            NSString *memberId = [userDefau objectForKey:@"memberId"];

            NSDictionary *dic = self.dataArray[_indexPath.row];
            
            NSString *kucunID = dic[@"KunCunID"];
            
            AppHttpClient* httpClient = [AppHttpClient sharedClient];
            NSDictionary *paeameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                        memberId,@"memberID",
                                        kucunID,@"kunCunID",
                                        nil];
            
            [httpClient request:@"ErpKuCunDel.ashx" parameters:paeameters success:^(NSJSONSerialization* json){
                
                [self requestDataWithMemberID:memberId WithPageIndex:@"0" withkuCunType:kuCun];
                
            }failure:^(NSError *error){
                
                [self headAndFootEndRefreshing];
                
            }];
            
        }
        
    }else {
    
        if ((int)buttonIndex == 0) {
            
            StorageController *vc = [[StorageController alloc] init];
            
            vc.titleLab = @"出库";
            
            vc.JBRArray = self.jingbanrenArray;
            
            vc.GYSArray = self.gongyingshangArray;
            
            vc.CPArray = self.chanpinArray;
            
            vc.KHArray = self.kehuArray;
            
            [self.navigationController pushViewController:vc animated:YES];
            
        }else {
            
            StorageController *vc = [[StorageController alloc] init];
            
            vc.titleLab = @"入库";
            
            vc.JBRArray = self.jingbanrenArray;
            
            vc.GYSArray = self.gongyingshangArray;
            
            vc.CPArray = self.chanpinArray;
            
            vc.KHArray = self.kehuArray;
            
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if ([kuCun isEqualToString:@"0"]) {
        
        NSDictionary *dic = self.dataArray[indexPath.row];
        
        ProductCell *cell = [[ProductCell alloc] init];
        
        cell.nameLab.text = dic[@"ProName"];
        
        cell.picImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:dic[@"FengMian"]]]];
        
        cell.inPriceLab.text = [NSString stringWithFormat:@"进价：%@",dic[@"PingJunJinJia"]];
        
        cell.outPriceLab.text = [NSString stringWithFormat:@"售价：%@",dic[@"PingJunXiaoShouJia"]];
        
        cell.countLab.text = [NSString stringWithFormat:@"库存数量：%@",dic[@"KuCunShuLiang"]];
        
        cell.supplierLab.text = [NSString stringWithFormat:@"备注：%@",dic[@"Descript"]];
        
        return cell;
        
    }else {
    
        ManagerCell *cell = [[ManagerCell alloc] init];
        
        NSDictionary *dic = self.dataArray[indexPath.row];
        
        cell.picImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:dic[@"FengMian"]]]];
        
        cell.nameLab.text = dic[@"ChanPinMingCheng"];
        
        cell.sellNameLab.text = [NSString stringWithFormat:@"经办人:%@",dic[@"JingBanRen"]];
        
        cell.countLab.text = [NSString stringWithFormat:@"数量:%@",dic[@"ShuLiang"]];
        
        cell.inPriceLab.text = [NSString stringWithFormat:@"进价:%@",dic[@"JinHuoPrice"]];
        
        cell.outPriceLab.text = [NSString stringWithFormat:@"售价:%@",dic[@"LingShouPrice"]];
        
        cell.supplierLab.text = [NSString stringWithFormat:@"供应商:%@",dic[@"GongYingShangName"]];
        
        return cell;
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if ([kuCun isEqualToString:@"0"]) {
        
        ProductCell *cell = [[ProductCell alloc] init];
        
        return cell.height;
        
    }else {
    
        ManagerCell *cell = [[ManagerCell alloc] init];
        
        return cell.height;
        
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)segmchange:(UISegmentedControl *)segm {
    
    NSInteger index = segm.selectedSegmentIndex;
    
    switch (index) {
        case 0:
        {
            kuCun = @"0";
            NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
            NSString *memberId = [userDefau objectForKey:@"memberId"];
            self.pageIndex = 1;
            [self requestDataWithMemberID:memberId WithPageIndex:[NSString stringWithFormat:@"%ld",(long)self.pageIndex] withkuCunType:kuCun];
        }
            break;
            
        case 1:
        {
            kuCun = @"2";
            NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
            NSString *memberId = [userDefau objectForKey:@"memberId"];
            self.pageIndex = 1;
            [self requestDataWithMemberID:memberId WithPageIndex:[NSString stringWithFormat:@"%ld",(long)self.pageIndex] withkuCunType:kuCun];
        }

            break;
            
        case 2:
        {
            kuCun = @"1";
            NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
            NSString *memberId = [userDefau objectForKey:@"memberId"];
            self.pageIndex = 1;
            [self requestDataWithMemberID:memberId WithPageIndex:[NSString stringWithFormat:@"%ld",(long)self.pageIndex] withkuCunType:kuCun];
        }
            
            break;
            
        default:
            break;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
