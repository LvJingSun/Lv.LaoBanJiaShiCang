//
//  LevelsController.m
//  BusinessCenter
//
//  Created by mac on 16/5/27.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import "LevelsController.h"
#import "AppHttpClient.h"
#import "AddLevelController.h"
#import "EditLevelController.h"

@interface LevelsController ()<UITableViewDelegate,UITableViewDataSource> {

    NSString *yongJinLevelID;
    
}

@property (nonatomic, strong) NSMutableArray *LevelArray;

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, weak) UILabel *noLabel;

@end

@implementation LevelsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"等级";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initWithTableView];
    
    [self setRightBtn];
    
    [self initWithNoLabel];
    
    
}

- (void)viewWillAppear:(BOOL)animated {

    [self requestData];
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dic = self.LevelArray[indexPath.row];
    
    yongJinLevelID = dic[@"YongJinID"];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSInteger row = [indexPath row];
        
        [self.LevelArray removeObjectAtIndex:row];
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        [self deleteData];
        
    }
    
}

- (void)deleteData {
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *paeameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId,@"memberID",
                                yongJinLevelID,@"yongJinLevelID",
                                nil];
    
    [httpClient request:@"ErpDengJiDel.ashx" parameters:paeameters success:^(NSJSONSerialization* json){

    }failure:^(NSError *error){
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.LevelArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dic = self.LevelArray[indexPath.row];
    
    static NSString *cellID = @"cellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    cell.textLabel.text = dic[@"MingCheng"];
    
    return cell;
    
}

- (void)editBtnClick {
    
    AddLevelController *vc = [[AddLevelController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dic = self.LevelArray[indexPath.row];

    EditLevelController *vc = [[EditLevelController alloc] init];
    
    vc.mingCheng = dic[@"MingCheng"];
    
    vc.yongJinLevelID = dic[@"YongJinID"];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleDelete;
    
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
    
}

- (void)initWithTableView {
    
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    
    CGRect rectNav = self.navigationController.navigationBar.frame;
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - rectStatus.size.height - rectNav.size.height)];
    
    self.tableview = tableview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    [self.view addSubview:tableview];
    
}

- (void)setRightBtn {
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    addBtn.frame = CGRectMake(0, 0, 30, 20);
    
    [addBtn setTitle:@"编辑" forState:UIControlStateNormal];
    
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
    
    if (self.tableview.editing) {
        
        [self.tableview setEditing:NO animated:YES];
        
    }else {
        
        [self.tableview setEditing:YES animated:YES];
        
    }
    
}

- (void)initWithNoLabel {

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 100, self.view.bounds.size.width - 100, 30)];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    label.text = @"请添加等级";
    
    label.textColor = [UIColor lightGrayColor];
    
    [self.view addSubview:label];
    
    self.noLabel = label;
    
    self.noLabel.hidden = YES;
    
}

- (void)requestData {
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *paeameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId,@"memberID",
                                nil];
    
    [httpClient request:@"ErpDengJiList.ashx" parameters:paeameters success:^(NSJSONSerialization* json){
        
        NSDictionary *dic = (NSDictionary *)json;
        
        NSArray *trueArr = dic[@"YongJinLevelModelList"];
        
        if (trueArr.count == 0) {
            
            self.noLabel.hidden = NO;
            
            self.tableview.hidden = YES;
            
        }else {
            
            self.noLabel.hidden = YES;
            
            self.tableview.hidden = NO;
            
            self.LevelArray = dic[@"YongJinLevelModelList"];
            
            [self.tableview reloadData];
            
        }
        
    }failure:^(NSError *error){
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

}



@end
