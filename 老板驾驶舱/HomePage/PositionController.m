//
//  PositionController.m
//  BusinessCenter
//
//  Created by mac on 16/5/18.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import "PositionController.h"
#import "AppHttpClient.h"
#import "AddPositionController.h"
#import "EditPositionController.h"

@interface PositionController ()<UITableViewDelegate,UITableViewDataSource> {

    BOOL isSelect;
    NSString *zhiWeiID;
    
}

@property (nonatomic, strong) NSMutableArray *PositionArray;

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, weak) UILabel *noLabel;

@end

@implementation PositionController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    isSelect = NO;
    
    self.title = @"职位管理";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initWithTableView];
    
    [self setRightBtn];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 100, self.view.bounds.size.width - 100, 30)];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    label.text = @"请添加职位";
    
    label.textColor = [UIColor lightGrayColor];
    
    [self.view addSubview:label];
    
    self.noLabel = label;

}

- (void)viewWillAppear:(BOOL)animated {

    [self requestData];
    
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

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dic = self.PositionArray[indexPath.row];
    
    zhiWeiID = dic[@"ZhiWeiID"];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSInteger row = [indexPath row];
        
        [self.PositionArray removeObjectAtIndex:row];
        
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
                                zhiWeiID,@"zhiWeiID",
                                nil];
    
    [httpClient request:@"ErpZhiWeiDel.ashx" parameters:paeameters success:^(NSJSONSerialization* json){
        
        
    }failure:^(NSError *error){
        
    }];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
    
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleDelete;
    
}

- (void)editBtnClick {
    
    AddPositionController *vc = [[AddPositionController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.PositionArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dic = self.PositionArray[indexPath.row];

    static NSString *cellID = @"cellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    cell.textLabel.text = dic[@"MingCheng"];

    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dic = self.PositionArray[indexPath.row];
    
    EditPositionController *vc = [[EditPositionController alloc] init];
    
    vc.zhiweiid = dic[@"ZhiWeiID"];
    
    vc.zhiweimingcheng = dic[@"MingCheng"];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)requestData {

    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *paeameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId,@"memberID",
                                nil];
    
    [httpClient request:@"ErpZhiWeiList.ashx" parameters:paeameters success:^(NSJSONSerialization* json){
        
        NSDictionary *dic = (NSDictionary *)json;
        
        NSArray *trueArr = dic[@"ZhiWeiModelList"];
        
        if (trueArr.count == 0) {
            
            self.noLabel.hidden = NO;
            
            self.tableview.hidden = YES;
            
        }else {
            
            self.noLabel.hidden = YES;
            
            self.tableview.hidden = NO;
            
            self.PositionArray = dic[@"ZhiWeiModelList"];
            
            [self.tableview reloadData];
            
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
