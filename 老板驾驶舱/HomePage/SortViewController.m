//
//  SortViewController.m
//  BusinessCenter
//
//  Created by mac on 16/5/13.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import "SortViewController.h"
#import "StaffModel.h"
#import "RowNumCell.h"
#import "RowNumberController.h"
#import "AppHttpClient.h"

@interface SortViewController ()<UITableViewDelegate,UITableViewDataSource> {

    NSDictionary *paiHaoJSON;
    
}

@property (nonatomic, weak) UITableView *tableView;

@end

@implementation SortViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"排序";
    
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

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RowNumCell *cell = [[RowNumCell alloc] init];
    
    NSDictionary *dic = self.dataArr[indexPath.row];
    
    cell.nameLab.text = dic[@"RealName"];
    
    cell.picImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:dic[@"PhotoBigUrl"]]]];
    
    cell.titleLab.text = dic[@"ZhiWeiMingCheng"];
    
    cell.telLab.text = dic[@"Phone"];
    
    cell.countLab.hidden = YES;
    
    cell.countLab.hidden = NO;
    
    cell.countLab.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row + 1];
    
    return cell;
    
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {

    return YES;
    
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    NSUInteger fromRow = [sourceIndexPath row];
    
    NSUInteger toRow = [destinationIndexPath row];
    
    id object = [self.dataArr objectAtIndex:fromRow];
    
    [self.dataArr removeObjectAtIndex:fromRow];
    
    [self.dataArr insertObject:object atIndex:toRow];
    
    [self.tableView reloadData];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 70;
    
}

- (void)setRightBtns {
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    addBtn.frame = CGRectMake(0, 0, 30, 20);
    
    [addBtn setTitle:@"编辑" forState:UIControlStateNormal];
    
    addBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    
    [addBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    
    [addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *screenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    screenBtn.frame = CGRectMake(0, 0, 30, 20);
    
    [screenBtn setTitle:@"确定" forState:UIControlStateNormal];
    
    screenBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    
    [screenBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    
    [screenBtn addTarget:self action:@selector(screenBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *addBarBtn = [[UIBarButtonItem alloc] initWithCustomView:addBtn];
    
    UIBarButtonItem *screenBarBtn=[[UIBarButtonItem alloc]initWithCustomView:screenBtn];
    
    self.navigationItem.rightBarButtonItems = @[screenBarBtn,addBarBtn];
    
}

- (void)addBtnClick:(UIButton *)sender {
    
    if (self.tableView.editing) {
        
        [self.tableView setEditing:NO animated:YES];
        
        [sender setTitle:@"编辑" forState:UIControlStateNormal];
        
    }else {
    
        [self.tableView setEditing:YES animated:YES];
        
        [sender setTitle:@"完成" forState:UIControlStateNormal];
        
    }

}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {

    return UITableViewCellEditingStyleDelete;
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {

    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSInteger row = [indexPath row];
        
        [self.dataArr removeObjectAtIndex:row];
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        [self.tableView reloadData];
        
    }
    
}


- (void)screenBtnClick {
    
    [self.tableView setEditing:NO animated:YES];
    
    NSMutableArray *mutArray = [NSMutableArray array];
    
    for (int i = 0; i < self.dataArr.count; i++) {
        
        NSString *OrderSort = [NSString stringWithFormat:@"%d",i + 1];
        
        NSDictionary *dic = self.dataArr[i];
        
        NSDictionary *json = @{@"CashierAccountID":dic[@"YuanGongID"],@"OrderSort":OrderSort};
        
        [mutArray addObject:json];
        
    }
    
    [self pushDataWithJsonData:[self arrayToJson:mutArray]];
    
}

//数组转Json
- (NSString *)arrayToJson:(NSArray *)array {

    NSError *parseError = nil;
    NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

//字典转Json
- (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}


- (void)pushDataWithJsonData:(NSString *)jsondata {

    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *paeameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId,@"memberID",
                                jsondata,@"paiHaoJSON",
                                nil];
    
    [httpClient request:@"ErpPaiHaoAdd.ashx" parameters:paeameters success:^(NSJSONSerialization* json){
        
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
        
        
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
