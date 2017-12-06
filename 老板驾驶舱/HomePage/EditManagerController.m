//
//  EditManagerController.m
//  BusinessCenter
//
//  Created by mac on 16/5/12.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import "EditManagerController.h"
#import "StorageView.h"
#import "DeleteView.h"

@interface EditManagerController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, weak) StorageView *addview;

@property (nonatomic, weak) DeleteView *deleteview;

@end

@implementation EditManagerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"库存修改";
    
    self.view.backgroundColor = [UIColor colorWithRed:230/255. green:230/255. blue:230/255. alpha:1.];
    
    [self setRightBtns];
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    StorageView *addview = [[StorageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 257)];
    
    self.addview = addview;
    
    tableview.tableHeaderView = addview;
    
    self.tableview = tableview;
    
    tableview.backgroundColor = [UIColor colorWithRed:230/255. green:230/255. blue:230/255. alpha:1.];
    
    DeleteView *deleteview = [[DeleteView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 20)];
    
    self.deleteview = deleteview;
    
    tableview.tableFooterView = deleteview;
    
    [self.view addSubview:tableview];
    // Do any additional setup after loading the view.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 0;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return nil;
    
}

- (void)setRightBtns {
    
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    saveBtn.frame = CGRectMake(0, 0, 30, 20);
    
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    
    saveBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    
    [saveBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    
    [saveBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *saveBarBtn=[[UIBarButtonItem alloc]initWithCustomView:saveBtn];
    
    self.navigationItem.rightBarButtonItem = saveBarBtn;
    
}

- (void)saveBtnClick {
    
    
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
