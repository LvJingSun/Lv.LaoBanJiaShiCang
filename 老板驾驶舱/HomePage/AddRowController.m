//
//  AddRowController.m
//  BusinessCenter
//
//  Created by mac on 16/5/13.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import "AddRowController.h"
#import "StaffModel.h"
#import "RowNumCell.h"
#import "SortViewController.h"
#import "AppHttpClient.h"
#import "SVProgressHUD.h"

@interface AddRowController ()<UITableViewDelegate,UITableViewDataSource> {
    
    NSMutableArray *dataArray;
    
}

@property (nonatomic, strong) NSArray *staffArr;

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, weak) UILabel *NoLabel;

@end

@implementation AddRowController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dataArray = [NSMutableArray array];
    
    self.title = @"选择员工";
    
    self.view.backgroundColor = [UIColor colorWithRed:230/255. green:230/255. blue:230/255. alpha:1.];
    
    [self setRightBtns];
    
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    
    CGRect rectNav = self.navigationController.navigationBar.frame;
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 2, self.view.bounds.size.width, self.view.bounds.size.height - rectStatus.size.height - rectNav.size.height - 2)];
    
    tableview.backgroundColor = [UIColor whiteColor];
    
    self.tableView = tableview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    [self.view addSubview:tableview];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 100, self.view.bounds.size.width - 100, 30)];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    label.text = @"暂无员工";
    
    label.textColor = [UIColor lightGrayColor];
    
    self.NoLabel = label;
    
    [self.view addSubview:label];
    
    [SVProgressHUD showWithStatus:@"请求中..."];
    
    [self requestData];

}

- (void)setRightBtns {
    
    UIButton *screenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    screenBtn.frame = CGRectMake(0, 0, 60, 20);
    
    [screenBtn setTitle:@"开始排号" forState:UIControlStateNormal];
    
    screenBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    
    [screenBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    
    [screenBtn addTarget:self action:@selector(screenBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *screenBarBtn=[[UIBarButtonItem alloc]initWithCustomView:screenBtn];
    
    self.navigationItem.rightBarButtonItem = screenBarBtn;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.staffArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RowNumCell *cell = [[RowNumCell alloc] init];
    
    NSDictionary *dic = self.staffArr[indexPath.row];
    
    cell.nameLab.text = dic[@"RealName"];
    
    cell.picImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:dic[@"PhotoBigUrl"]]]];
    
    cell.titleLab.text = dic[@"ZhiWeiMingCheng"];
    
    cell.countLab.hidden = YES;
    
    cell.telLab.text = dic[@"Phone"];
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 70;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    RowNumCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell.accessoryType == UITableViewCellAccessoryNone) {
        
        [dataArray addObject:self.staffArr[indexPath.row]];
        
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        
    }else {
    
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        NSDictionary *dic = self.staffArr[indexPath.row];
        
        for (int i = 0; i < dataArray.count; i++) {
            
            if ([dic[@"RealName"] isEqualToString:((NSDictionary *)dataArray[i])[@"RealName"]]) {
                
                [dataArray removeObject:dataArray[i]];
                
            }
        }
        
    }
   
}

- (void)screenBtnClick {

    if (dataArray.count == 0) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择即将排号的员工" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alert show];
        
    }else {
    
        SortViewController *vc = [[SortViewController alloc] init];
        
        vc.dataArr = dataArray;
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
}

- (void)requestData {
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *paeameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId,@"memberID",
                                nil];
    
    [httpClient request:@"ErpPaiHaoXuanZeList.ashx" parameters:paeameters success:^(NSJSONSerialization* json){
        
        [SVProgressHUD dismiss];
        
        NSDictionary *dic = (NSDictionary *)json;
        
        NSArray *trueArr = dic[@"YuanGongModelList"];
        
        if (trueArr.count == 0) {
            
            self.tableView.hidden = YES;
            
            self.NoLabel.hidden = NO;
            
        }else {
            
            self.tableView.hidden = NO;
            
            self.NoLabel.hidden = YES;
            
            self.staffArr = trueArr;
            
            [self.tableView reloadData];
            
        }

        
    }failure:^(NSError *error){
        
        [SVProgressHUD dismiss];
        
    }];
}

//-(void)viewWillAppear:(BOOL)animated {
//
//    NSUserDefaults*pushJudge = [NSUserDefaults standardUserDefaults];
//    if([[pushJudge objectForKey:@"push"]isEqualToString:@"push"]) {
////        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(rebackToRootViewAction)];
//        
//        self.tableView.frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64);
//        
//    }
//    
//}

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
