//
//  AddSupplierController.m
//  BusinessCenter
//
//  Created by mac on 16/5/11.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import "AddSupplierController.h"
#import "AddSupplierView.h"
#import "AppHttpClient.h"

@interface AddSupplierController ()<UITableViewDelegate,UITableViewDataSource> {
    
    NSString *name;
    NSString *address;
    NSString *phone;
    NSString *sex;
    
}

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, weak) AddSupplierView *addview;

@end

@implementation AddSupplierController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"新增供应商";
    
    self.view.backgroundColor = [UIColor colorWithRed:230/255. green:230/255. blue:230/255. alpha:1.];
    
    [self setRightBtns];
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    AddSupplierView *addview = [[AddSupplierView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 172)];
    
    self.addview = addview;
    
    tableview.tableHeaderView = addview;
    
    self.tableview = tableview;
    
    tableview.backgroundColor = [UIColor colorWithRed:230/255. green:230/255. blue:230/255. alpha:1.];
    
    [self.view addSubview:tableview];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 0;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return nil;
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [self.addview resignFirstResponderKey];
    
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
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请完善所填信息" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    if ([self.addview.nameField.text isEqualToString:@""]) {
        
        [alert show];
        
    }else if ([self.addview.titleField.text isEqualToString:@""]) {
        
        [alert show];
        
    }else if ([self.addview.telField.text isEqualToString:@""]) {
        
        [alert show];
        
    }else if ([self.addview.genderField.text isEqualToString:@""]) {
        
        [alert show];
        
    }else {
        
        name = self.addview.nameField.text;
        
        address = self.addview.titleField.text;
        
        phone = self.addview.telField.text;
        
        sex = self.addview.genderField.text;
        
        [self requestSaveData];
        
    }

    
}

- (void)requestSaveData {

    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *paeameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId,@"memberID",
                                @"0",@"supplierID",
                                name,@"xingMing",
                                sex,@"address",
                                address,@"supplierName",
                                phone,@"phone",
                                @"",@"remark",
                                nil];
    
    [httpClient request:@"ErpGongYingShangAdd.ashx" parameters:paeameters success:^(NSJSONSerialization* json){
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }failure:^(NSError *error){
        
        
        
    }];
    
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
