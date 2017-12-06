//
//  EditSupplierController.m
//  BusinessCenter
//
//  Created by mac on 16/5/11.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import "EditSupplierController.h"
#import "AddSupplierView.h"
#import "DeleteView.h"
#import "AppHttpClient.h"

@interface EditSupplierController ()<UITableViewDelegate,UITableViewDataSource> {
    
    NSString *name;
    NSString *suppliername;
    NSString *phone;
    NSString *address;
    
}

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, weak) AddSupplierView *addview;

@property (nonatomic, weak) DeleteView *deleteview;

@end

@implementation EditSupplierController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"修改供应商";
    
    self.view.backgroundColor = [UIColor colorWithRed:230/255. green:230/255. blue:230/255. alpha:1.];
    
    [self setRightBtns];
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    AddSupplierView *addview = [[AddSupplierView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 172)];
    
    self.addview = addview;
    
    tableview.tableHeaderView = addview;
    
    self.tableview = tableview;
    
    tableview.backgroundColor = [UIColor colorWithRed:230/255. green:230/255. blue:230/255. alpha:1.];
    
    addview.nameField.text = self.name;
    
    addview.titleField.text = self.suppliername;
    
    addview.telField.text = self.phone;
    
    addview.genderField.text = self.address;
    
    [self initFooterView];
    
    [self.view addSubview:tableview];
    // Do any additional setup after loading the view.
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)BtnClick {

    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *paeameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId,@"memberID",
                                self.supplierID,@"supplierID",
                                nil];
    
    [httpClient request:@"ErpGongYingShangDel.ashx" parameters:paeameters success:^(NSJSONSerialization* json){
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }failure:^(NSError *error){
        
        
        
    }];
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
        
        suppliername = self.addview.titleField.text;
        
        phone = self.addview.telField.text;
        
        address = self.addview.genderField.text;
        
        if ([name isEqualToString:self.name] && [suppliername isEqualToString:self.suppliername] && [phone isEqualToString:self.phone] && [address isEqualToString:self.address]) {
            
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
                                self.supplierID,@"supplierID",
                                name,@"xingMing",
                                suppliername,@"supplierName",
                                address,@"address",
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
