//
//  Type1Controller.m
//  BusinessCenter
//
//  Created by mac on 16/5/19.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import "Type1Controller.h"
#import "AppHttpClient.h"
#import "Type2Controller.h"
#import "AddTypeController.h"
#import "EditTypeController.h"

@interface Type1Controller ()<UITableViewDelegate,UITableViewDataSource> {

    NSString *CategoryID;
    
    NSIndexPath *_indexPath;
    
}

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSArray *level1;

@property (nonatomic, strong) NSArray *level2;

@property (nonatomic, strong) NSArray *level3;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, weak) UILabel *noLabel;

@end

@implementation Type1Controller

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"类别";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    
    self.tableview = tableview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    [self.view addSubview:tableview];
    
    [self setRightBtn];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressClick:)];
    
    longPress.minimumPressDuration = 1.0;
    
    [self.tableview addGestureRecognizer:longPress];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 100, self.view.bounds.size.width - 100, 30)];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    label.text = @"请添加分类";
    
    self.noLabel = label;
    
    label.textColor = [UIColor lightGrayColor];
    
    [self.view addSubview:label];

}

- (void)longPressClick:(UILongPressGestureRecognizer *)gesture {
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        
        CGPoint point = [gesture locationInView:self.tableview];
        
        _indexPath = [self.tableview indexPathForRowAtPoint:point];
        
        if (_indexPath == nil) {
            
            return;
            
        }else {
            
            EditTypeController *vc = [[EditTypeController alloc] init];
            
            NSDictionary *dic = self.dataArray[_indexPath.row];
            
            vc.name = dic[@"CatgName"];
            
            vc.categoryID = dic[@"CategoryID"];
            
            vc.ParentID = @"0";
            
            [self.navigationController pushViewController:vc animated:YES];
            
        }
    }
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

- (void)editBtnClick {

    AddTypeController *vc = [[AddTypeController alloc] init];
    
    vc.ParentID = @"0";
    
    vc.categoryID = @"0";
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dic = self.dataArray[indexPath.row];
    
    CategoryID= dic[@"CategoryID"];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSInteger row = [indexPath row];
        
        [self.dataArray removeObjectAtIndex:row];
        
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
                                CategoryID,@"categoryID",
                                nil];
    
    [httpClient request:@"ErpFenLeiDel.ashx" parameters:paeameters success:^(NSJSONSerialization* json){
        
        
    }failure:^(NSError *error){
        
    }];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
    
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleDelete;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *cellID = @"cellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    NSDictionary *dic = self.dataArray[indexPath.row];
    
    cell.textLabel.text = dic[@"CatgName"];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dic = self.dataArray[indexPath.row];
    
    Type2Controller *vc = [[Type2Controller alloc] init];
    
    vc.ParentID = dic[@"CategoryID"];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)requestData {
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *paeameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId,@"memberId",
                                nil];
    
    [httpClient request:@"ErpFenLeiList.ashx" parameters:paeameters success:^(NSJSONSerialization* json){
        
        NSDictionary *dict = (NSDictionary *)json;
        
        NSArray *CategroyModelList = dict[@"CategroyModelList"];
        
        NSMutableArray *level1 = [NSMutableArray array];
        
        for (int i = 0; i < CategroyModelList.count; i++) {
            
            if ([((NSDictionary *)CategroyModelList[i])[@"Levels"] isEqualToString:@"1"]) {
                
                [level1 addObject:CategroyModelList[i]];
                
            }
            
        }
        
        self.level1 = level1;
        
        self.dataArray = level1;
        
        if (self.level1.count == 0) {
            
            self.tableview.hidden = YES;
            
            self.noLabel.hidden = NO;
            
        }else {
        
            self.noLabel.hidden = YES;
            
            self.tableview.hidden = NO;
            
            NSMutableArray *level2 = [NSMutableArray array];
            
            for (int i = 0; i < CategroyModelList.count; i++) {
                
                if ([((NSDictionary *)CategroyModelList[i])[@"Levels"] isEqualToString:@"2"]) {
                    
                    [level2 addObject:CategroyModelList[i]];
                    
                }
                
            }
            
            self.level2 = level2;
            
            NSMutableArray *level3 = [NSMutableArray array];
            
            for (int i = 0; i < CategroyModelList.count; i++) {
                
                if ([((NSDictionary *)CategroyModelList[i])[@"Levels"] isEqualToString:@"3"]) {
                    
                    [level3 addObject:CategroyModelList[i]];
                    
                }
                
            }
            
            self.level3 = level3;
            
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
