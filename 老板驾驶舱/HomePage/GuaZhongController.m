//
//  GuaZhongController.m
//  BusinessCenter
//
//  Created by mac on 16/5/22.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import "GuaZhongController.h"
#import "MassageCell.h"
#import "AppHttpClient.h"
#import <MJRefresh.h>
#import "SureController.h"
#import "SVProgressHUD.h"

@interface GuaZhongController ()<UITableViewDelegate,UITableViewDataSource> {

    int count;
    
    NSString *menuClassID;
    
    NSInteger pageIndex;
    
    NSString *moren;

}

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, weak) UILabel *allCountLabel;

@property (nonatomic, weak) UILabel *allPriceLabel;

@property (nonatomic, weak) UILabel *allTimeLabel;

@property (nonatomic, weak) UILabel *allYongjinLabel;

@property (nonatomic, weak) UITableView *typeTableview;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) NSArray *typeArray;

@property (nonatomic, strong) NSMutableArray *xiangmuArr;

@end

@implementation GuaZhongController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    moren = @"默认";
    
    self.xiangmuArr = [NSMutableArray array];
    
    count = 0;
    
    pageIndex = 1;
    
    self.title = self.titletext;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initWithTableview];
    
    [self initWithFootView];
    
    [self requestData];
    
    [SVProgressHUD showWithStatus:@"请求中..."];
    
    [self requestFuWuDataWithMenuClassID:@"" withPageIndex:[NSString stringWithFormat:@"%ld",(long)pageIndex]];

}

- (void)initWithTableview {
    
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    
    CGRect rectNav = self.navigationController.navigationBar.frame;

    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - rectNav.size.height - rectStatus.size.height - 40)];
    
    self.tableview = tableview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.backgroundColor = [UIColor whiteColor];
    
//    
    
    tableview.delaysContentTouches = NO;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        if ([moren isEqualToString:@"默认"]) {
            
            pageIndex = 1;
            
            [self requestFuWuDataWithMenuClassID:@"" withPageIndex:[NSString stringWithFormat:@"%ld",(long)pageIndex]];
            
        }else {
        
            pageIndex = 1;
            
            [self requestFuWuDataWithMenuClassID:menuClassID withPageIndex:[NSString stringWithFormat:@"%ld",(long)pageIndex]];
            
        }
        
    }];
    
    tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        if ([moren isEqualToString:@"默认"]) {
            
            pageIndex ++;
            
            [self requestFuWuDataWithMenuClassID:@"" withPageIndex:[NSString stringWithFormat:@"%ld",(long)pageIndex]];
            
        }else {
        
            pageIndex ++;
            
            [self requestFuWuDataWithMenuClassID:menuClassID withPageIndex:[NSString stringWithFormat:@"%ld",(long)pageIndex]];
            
        }
        
    }];
    
    [self.view addSubview:tableview];
    
    UITableView *typetableview = [[UITableView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width * 0.7, 0, self.view.bounds.size.width * 0.3, 200)];
    
    self.typeTableview = typetableview;
    
    typetableview.backgroundColor = [UIColor lightGrayColor];
    
    typetableview.tag = 101;
    
    typetableview.delegate = self;
    
    typetableview.dataSource = self;
    
    typetableview.hidden = YES;
    
    [self.view addSubview:typetableview];
    
    [self setRightBtns];
    
}

- (void)headAndFootEndRefreshing {
    
    [self.tableview.mj_header endRefreshing];
    
    [self.tableview.mj_footer endRefreshing];
    
}

- (void)requestData {
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *paeameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId,@"memberID",
                                @"6",@"keyType",
                                nil];
    
    [httpClient request:@"ErpKeValueList.ashx" parameters:paeameters success:^(NSJSONSerialization* json){
        
        NSDictionary *dic = (NSDictionary *)json;
        
        NSArray *trueArr = dic[@"KuCunModelList"];
        
        self.typeArray = trueArr;

        [self.typeTableview reloadData];
        
    }failure:^(NSError *error){
        
    }];
    
}

- (void)requestFuWuDataWithMenuClassID:(NSString *)menuClass withPageIndex:(NSString *)pageInde {

    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *paeameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId,@"memberID",
                                self.yuangongID,@"cashierAccountID",
                                menuClass,@"menuClassID",
                                pageInde,@"pageIndex",
                                nil];
    
    [httpClient request:@"ErpXuanZeXiangMuList.ashx" parameters:paeameters success:^(NSJSONSerialization* json){
        
        [SVProgressHUD dismiss];
        
        [self headAndFootEndRefreshing];
        
        NSDictionary *dic = (NSDictionary *)json;
        
        if ([pageInde intValue] == 1) {
            
            if (self.dataArray.count == 0) {
                
            }else {
                
                [self.dataArray removeAllObjects];
                
            }
            
            self.dataArray = dic[@"XiangMuModelList"];
            
        }else {
            
            if (self.dataArray.count < 10) {
                
            }else {
                
                [self.dataArray addObjectsFromArray:dic[@"XiangMuModelList"]];
                
            }
            
        }
       
        [self.tableview reloadData];
        
    }failure:^(NSError *error){
        
        [SVProgressHUD dismiss];
        
        [self headAndFootEndRefreshing];
        
    }];
    
}

- (void)setRightBtns {
    
    UIButton *screenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    screenBtn.frame = CGRectMake(0, 0, 30, 20);
    
    [screenBtn setTitle:@"分类" forState:UIControlStateNormal];
    
    screenBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    
    [screenBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    
    [screenBtn addTarget:self action:@selector(screenBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *screenBarBtn=[[UIBarButtonItem alloc]initWithCustomView:screenBtn];
    
    self.navigationItem.rightBarButtonItem = screenBarBtn;
    
}

- (void)screenBtnClick {

    if (self.typeTableview.hidden) {
        
        self.typeTableview.hidden = NO;
        
    }else {
    
        self.typeTableview.hidden = YES;
        
    }
    
}

- (void)initWithFootView {

    UIButton *sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width * 0.75, CGRectGetMaxY(self.tableview.frame), self.view.bounds.size.width * 0.25, 40)];
    
    [sureBtn setBackgroundColor:[UIColor colorWithRed:255/255. green:88/255. blue:0/255. alpha:1.]];
    
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    
    [sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.view addSubview:sureBtn];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.tableview.frame), self.view.bounds.size.width * 0.15, 40)];
    
    imageView.image = [UIImage imageNamed:@"购物车.jpg"];
    
    [self.view addSubview:imageView];
    
    UILabel *countLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.size.width * 0.1, CGRectGetMaxY(self.tableview.frame) + 3, self.view.bounds.size.width * 0.05, self.view.bounds.size.width * 0.05)];
    
    [countLabel setBackgroundColor:[UIColor colorWithRed:255/255. green:88/255. blue:0/255. alpha:1.]];
    
    self.allCountLabel = countLabel;
    
    countLabel.text = @"0";
    
    countLabel.layer.masksToBounds = YES;
    
    countLabel.font = [UIFont systemFontOfSize:9];
    
    [countLabel setTextColor:[UIColor whiteColor]];
    
    countLabel.layer.cornerRadius = countLabel.bounds.size.width / 2;
    
    countLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:countLabel];
    
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.size.width * 0.2, CGRectGetMaxY(self.tableview.frame) + 3, self.view.bounds.size.width * 0.25, 20)];
    
    priceLabel.text = @"0元";
    
    self.allPriceLabel = priceLabel;
    
    priceLabel.font = [UIFont systemFontOfSize:14];
    
    [priceLabel setTextColor:[UIColor colorWithRed:255/255. green:88/255. blue:0/255. alpha:1.]];
    
    [self.view addSubview:priceLabel];
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.size.width * 0.2, CGRectGetMaxY(priceLabel.frame), self.view.bounds.size.width * 0.25, 20)];
    
    timeLabel.text = @"0分钟";
    
    self.allTimeLabel = timeLabel;
    
    [timeLabel setTextColor:[UIColor lightGrayColor]];
    
    timeLabel.font = [UIFont systemFontOfSize:10];
    
    [self.view addSubview:timeLabel];
    
    UILabel *yongjinLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(priceLabel.frame), CGRectGetMaxY(self.tableview.frame) + 10, self.view.bounds.size.width * 0.25, 20)];
    
    yongjinLabel.text = @"0元";
    
    self.allYongjinLabel = yongjinLabel;
    
    yongjinLabel.font = [UIFont systemFontOfSize:12];
    
    [yongjinLabel setTextColor:[UIColor colorWithRed:3/255. green:168/255. blue:226/255. alpha:1.]];
    
    [self.view addSubview:yongjinLabel];
                                                                   
    
}

- (void)sureBtnClick {
    
    if (self.xiangmuArr.count == 0) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择项目" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alert show];
        
    }else {
        
        SureController *vc = [[SureController alloc] init];
        
        vc.dataArray = self.xiangmuArr;
        
        vc.yuangongID = self.yuangongID;
        
        vc.optionType = self.optionType;
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (tableView.tag == 101) {
        
        return self.typeArray.count;
        
    }else {
    
        return self.dataArray.count;
        
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (tableView.tag == 101) {
        
        static NSString *cellID = @"cellID";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (cell == nil) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            
        }
        
        NSDictionary *dict = self.typeArray[indexPath.row];
        
        cell.textLabel.text = dict[@"Value"];
        
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        
        cell.backgroundColor = [UIColor lightGrayColor];
        
        return cell;
        
    }else {
    
        NSDictionary *dics = self.dataArray[indexPath.row];
        
//        MassageCell *cell = [[MassageCell alloc] init];
        
//        static NSString *cellID = @"cellID";
        
        NSString *cellID = [NSString stringWithFormat:@"cellID%ld%ld",(long)indexPath.section,(long)indexPath.row];
        
        MassageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (!cell) {
            
            cell = [[MassageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            
        }
        
        for (id obj in cell.subviews) {
            
            if ([NSStringFromClass([obj class])isEqualToString:@"UITableViewCellScrollView"]) {
                
                UIScrollView *scroll = (UIScrollView *)obj;
                
                scroll.delaysContentTouches = NO;
                
                break;
                
            }
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.iconImageview.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:dics[@"MenuImageM"]]]];
        
        cell.nameLabel.text = dics[@"MenuName"];
        
        cell.timeLabel.text = [NSString stringWithFormat:@"%d分钟",[dics[@"ShiChang"] intValue]];
        
        cell.proportionLabel.text = [NSString stringWithFormat:@"%d %@",[dics[@"YongJinBiLi"] intValue],@"%"];
        
        cell.priceLabel.text = [NSString stringWithFormat:@"%d¥",[dics[@"MenuPrice"] intValue]];
        
        count = count + [cell.countLabel.text intValue];
        
        [cell.addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.reduceBtn addTarget:self action:@selector(reduceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.reduceBtn.backgroundColor = [UIColor lightGrayColor];
        
        cell.addBtn.backgroundColor = [UIColor lightGrayColor];
        
        return cell;
        
    }
    
}

- (void)reduceBtnClick:(id)sender {
    
    NSIndexPath *indexPath;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
    
        indexPath = [self.tableview indexPathForCell:(MassageCell *)[sender superview]];
        
    }else {
    
        indexPath = [self.tableview indexPathForCell:(MassageCell *)[[sender superview] superview]];
    }
    
    NSDictionary *dic = self.dataArray[indexPath.row];
    
    if (self.xiangmuArr.count == 0) {
        
    }else {
    
        for (NSDictionary *dd in self.xiangmuArr) {
            
            if ([dd[@"MenuName"] isEqualToString:dic[@"MenuName"]]) {
                
                [self.xiangmuArr removeObject:dd];
                
                return;
            }
        }
    }
    
    MassageCell *cell = [self.tableview cellForRowAtIndexPath:indexPath];
    
    int i = [cell.countLabel.text intValue];
    
    int j = [self.allCountLabel.text intValue];
    
    int allPrice = [self.allPriceLabel.text intValue];
    
    int allTime = [self.allTimeLabel.text intValue];
    
    float allYongjin = [self.allYongjinLabel.text floatValue];
    
    float bili = [cell.proportionLabel.text intValue] * 0.01;
    
    i --;
    
    if ([cell.countLabel.text isEqualToString:@"0"]) {
        
        cell.countLabel.text = @"0";
        
        self.allCountLabel.text = [NSString stringWithFormat:@"%d",j];
        
        self.allPriceLabel.text = [NSString stringWithFormat:@"%d元",allPrice];
        
        self.allTimeLabel.text = [NSString stringWithFormat:@"%d分钟",allTime];
        
        self.allYongjinLabel.text = [NSString stringWithFormat:@"%.1f元",allYongjin];
        
    }else {
    
        cell.countLabel.text = [NSString stringWithFormat:@"%d",i];
        
        j --;
        
        self.allCountLabel.text = [NSString stringWithFormat:@"%d",j];
        
        allPrice = allPrice - [cell.priceLabel.text intValue];
        
        self.allPriceLabel.text = [NSString stringWithFormat:@"%d元",allPrice];
        
        allTime = allTime - [cell.timeLabel.text intValue];
        
        self.allTimeLabel.text = [NSString stringWithFormat:@"%d分钟",allTime];
        
        allYongjin = allYongjin - bili * [cell.priceLabel.text intValue];
        
        self.allYongjinLabel.text = [NSString stringWithFormat:@"%.1f元",allYongjin];
        
    }
 
}

- (void)addBtnClick:(id)sender {
    
    NSIndexPath *indexPath;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        
        indexPath = [self.tableview indexPathForCell:(MassageCell *)[sender superview]];
        
    }else {
        
        indexPath = [self.tableview indexPathForCell:(MassageCell *)[[sender superview] superview]];
    }
    
    NSDictionary *dic = self.dataArray[indexPath.row];
    
    [self.xiangmuArr addObject:dic];

    MassageCell *cell = [self.tableview cellForRowAtIndexPath:indexPath];
    
    //单个数量
    int i = [cell.countLabel.text intValue];
    
    i ++;
    
    cell.countLabel.text = [NSString stringWithFormat:@"%d",i];
    
    //总价格
    int allPrice = [self.allPriceLabel.text intValue];
    
    allPrice = allPrice + [cell.priceLabel.text intValue];
    
    self.allPriceLabel.text = [NSString stringWithFormat:@"%d元",allPrice];
    
    //总数量
    int j = [self.allCountLabel.text intValue];
    
    j ++;
    
    self.allCountLabel.text = [NSString stringWithFormat:@"%d",j];
    
    //总时长
    int allTime = [self.allTimeLabel.text intValue];
    
    allTime = allTime + [cell.timeLabel.text intValue];
    
    self.allTimeLabel.text = [NSString stringWithFormat:@"%d分钟",allTime];
    
    //总佣金
    float allYongjin = [self.allYongjinLabel.text floatValue];
    
    float bili = [cell.proportionLabel.text intValue] * 0.01;
    
    self.allYongjinLabel.text = [NSString stringWithFormat:@"%.1f元",allYongjin + bili * [cell.priceLabel.text intValue]];
    
    NSLog(@"%@",self.allPriceLabel.text);

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (tableView.tag == 101) {
        
        return 40;
        
    }else {
    
        MassageCell *cell = [[MassageCell alloc] init];
        
        return cell.height;
        
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (tableView.tag == 101) {
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        moren = @"选择";
        
        NSDictionary *dic = self.typeArray[indexPath.row];
        
        menuClassID = dic[@"Key"];
        
        pageIndex = 1;
        
        [self requestFuWuDataWithMenuClassID:menuClassID withPageIndex:[NSString stringWithFormat:@"%ld",(long)pageIndex]];
        
        self.typeTableview.hidden = YES;
        
    }
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

}

@end
