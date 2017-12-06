//
//  Type3Controller.m
//  BusinessCenter
//
//  Created by mac on 16/5/19.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import "Type3Controller.h"
#import "AppHttpClient.h"
#import "AddTypeController.h"
#import "EditTypeController.h"

@interface Type3Controller ()<UITableViewDelegate,UITableViewDataSource> {
    
    NSString *CategoryID;
    
    NSIndexPath *_indexPath;
    
}

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) NSArray *level3Array;

@property (nonatomic, weak) UILabel *noLabel;

@end

@implementation Type3Controller

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
            
            vc.ParentID = self.ParentID;
            
            [self.navigationController pushViewController:vc animated:YES];
            
        }
    }
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
    
    NSDictionary *dic = self.dataArray[indexPath.row];
    
    cell.textLabel.text = dic[@"CatgName"];
    
    return cell;
    
}

- (void)editBtnClick {
    
    AddTypeController *vc = [[AddTypeController alloc] init];
    
    vc.ParentID = self.ParentID;
    
    vc.categoryID = @"0";
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)requestType3 {
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *paeameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId,@"memberId",
                                nil];
    
    [httpClient request:@"ErpFenLeiList.ashx" parameters:paeameters success:^(NSJSONSerialization* json){
        
        NSDictionary *dict = (NSDictionary *)json;
        
        NSArray *CategroyModelList = dict[@"CategroyModelList"];
        
        NSMutableArray *level2 = [NSMutableArray array];
        
        for (int i = 0; i < CategroyModelList.count; i++) {
            
            if ([((NSDictionary *)CategroyModelList[i])[@"Levels"] isEqualToString:@"3"]) {
                
                [level2 addObject:CategroyModelList[i]];
                
            }
            
        }
        
        self.level3Array = level2;
        
        NSMutableArray *mutArr = [NSMutableArray array];
        
        for (NSDictionary *dic in self.level3Array) {
            
            if ([dic[@"ParentID"] isEqualToString:self.ParentID]) {
                
                [mutArr addObject:dic];
                
            }
        }
        
        self.dataArray = mutArr;
        
        if (self.dataArray.count == 0) {
            
            self.tableview.hidden = YES;
            
            self.noLabel.hidden = NO;
            
        }else {
        
            self.noLabel.hidden = YES;
            
            self.tableview.hidden = NO;
            
            [self.tableview reloadData];
            
        }
        
    }failure:^(NSError *error){
        
        
    }];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [self requestType3];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
