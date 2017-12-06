//
//  AddLevelController.m
//  BusinessCenter
//
//  Created by mac on 16/5/27.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import "AddLevelController.h"
#import "AppHttpClient.h"

@interface AddLevelController ()<UITableViewDelegate,UITableViewDataSource> {

    NSString *memberID;
    
    NSString *yongJinLevelID;
    
    NSString *mingCheng;
    
    NSString *yongJinBiLi;
    
    NSString *remark;
    
}

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, weak) UITextField *textField;

@end

@implementation AddLevelController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];
    
    memberID = memberId;
    
    yongJinLevelID = @"0";
    
    yongJinBiLi = @"0";
    
    remark = @"";
    
    self.title = @"添加职位";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setRightBtns];
    
    [self initWithTableView];
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

- (void)initWithTableView {
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableview = tableview;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 100)];
    
    view.backgroundColor = [UIColor colorWithRed:230/255. green:230/255. blue:230/255. alpha:1.];
    
    [self.view addSubview:view];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, 50)];
    
    textField.placeholder = @"请输入等级名称";
    
    textField.backgroundColor = [UIColor whiteColor];
    
    self.textField = textField;
    
    [view addSubview:textField];
    
    tableview.tableHeaderView = view;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.backgroundColor = [UIColor colorWithRed:230/255. green:230/255. blue:230/255. alpha:1.];
    
    [self.view addSubview:tableview];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 0;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return nil;
    
}

- (void)saveBtnClick {
    
    if ([self.textField.text isEqualToString:@""]) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请完善所填信息" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alert show];
        
    }else {
        
        mingCheng = self.textField.text;
        
        [self pushData];
        
    }
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    if ([self.textField isFirstResponder]) {
        
        [self.textField resignFirstResponder];
        
    }
}

- (void)pushData {
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *paeameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberID,@"memberID",
                                yongJinLevelID,@"yongJinLevelID",
                                mingCheng,@"mingCheng",
                                remark,@"remark",
                                yongJinBiLi,@"yongJinBiLi",
                                nil];
    
    [httpClient request:@"ErpDengJiAdd.ashx" parameters:paeameters success:^(NSJSONSerialization* json){
        
        [self.navigationController popViewControllerAnimated:YES];
        
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
