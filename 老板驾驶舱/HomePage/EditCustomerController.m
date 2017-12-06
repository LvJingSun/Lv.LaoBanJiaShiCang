//
//  EditCustomerController.m
//  BusinessCenter
//
//  Created by mac on 16/5/11.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import "EditCustomerController.h"
#import "AddCustomerView.h"
#import "DeleteView.h"
#import "AppHttpClient.h"

@interface EditCustomerController ()<UITableViewDelegate,UITableViewDataSource> {
    
    NSString *name;
    NSString *address;
    NSString *phone;
    NSString *sex;
    
}

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, weak) AddCustomerView *addview;

@property (nonatomic, weak) DeleteView *deleteview;

@end

@implementation EditCustomerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"修改客户";
    
    self.view.backgroundColor = [UIColor colorWithRed:230/255. green:230/255. blue:230/255. alpha:1.];
    
    [self setRightBtns];
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    AddCustomerView *addview = [[AddCustomerView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 172)];
    
    self.addview = addview;
    
    addview.nameField.text = self.name;
    
    addview.titleField.text = self.address;
    
    addview.telField.text = self.phone;
    
    addview.genderField.text = self.sex;
    
    tableview.tableHeaderView = addview;
    
    self.tableview = tableview;
    
    tableview.backgroundColor = [UIColor colorWithRed:230/255. green:230/255. blue:230/255. alpha:1.];
    
    [self initFooterView];
    
    [self.view addSubview:tableview];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.addview resignFirstResponderKey];
    
}

- (void)initFooterView {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 30, self.view.bounds.size.width, 100)];
    
    view.backgroundColor = [UIColor whiteColor];

    UIButton *deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width * 0.05, 30, self.view.bounds.size.width * 0.9, 40)];
    
    [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    
    [deleteBtn setBackgroundColor:[UIColor colorWithRed:239/255. green:71/255. blue:57/255. alpha:1.]];
    
    deleteBtn.layer.cornerRadius = 5;
    
    [deleteBtn addTarget:self action:@selector(BtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:deleteBtn];
    
    self.tableview.tableFooterView = view;

}

- (void)BtnClick {

    [self deleteData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        
        if ([name isEqualToString:self.name] && [address isEqualToString:self.address] && [phone isEqualToString:self.phone] && [sex isEqualToString:self.sex]) {
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }else {
        
            [self requestSaveData];
            
        }
        
    }
    
}

- (void)requestSaveData {

    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *paeameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId,@"memberID",
                                self.kehuId,@"keHuID",
                                name,@"xingMing",
                                sex,@"sex",
                                address,@"address",
                                phone,@"phone",
                                @"",@"remark",
                                nil];
    
    [httpClient request:@"ErpKeHuAdd.ashx" parameters:paeameters success:^(NSJSONSerialization* json){
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }failure:^(NSError *error){
        
        
        
    }];
    
}

- (void)deleteData {
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *paeameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId,@"memberID",
                                self.kehuId,@"keHuID",
                                nil];
    
    [httpClient request:@"ErpKeHuDel.ashx" parameters:paeameters success:^(NSJSONSerialization* json){
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }failure:^(NSError *error){
        
        
        
    }];
    
}




@end
