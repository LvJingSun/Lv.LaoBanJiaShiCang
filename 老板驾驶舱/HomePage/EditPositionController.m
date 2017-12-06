//
//  EditPositionController.m
//  BusinessCenter
//
//  Created by mac on 16/5/18.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import "EditPositionController.h"
#import "AppHttpClient.h"

@interface EditPositionController ()<UITableViewDelegate,UITableViewDataSource> {
    
    NSString *zhiWeiID;
    NSString *mingCheng;
    NSString *remark;
    
}

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, weak) UITextField *textField;

@end

@implementation EditPositionController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"修改职位";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initWithTableView];
    
    [self setRightBtns];
    // Do any additional setup after loading the view.
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
    
    zhiWeiID = self.zhiweiid;
    
    remark = @"";
    
    if ([self.textField.text isEqualToString:@""]) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请完善所填信息" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alert show];
        
    }else {
        
        mingCheng = self.textField.text;
        
        if ([mingCheng isEqualToString:self.zhiweimingcheng]) {
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }else {
        
            [self pushData];
            
        }
        
    }
  
}

- (void)pushData {
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *paeameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId,@"memberID",
                                zhiWeiID,@"zhiWeiID",
                                mingCheng,@"mingCheng",
                                remark,@"remark",
                                nil];
    
    [httpClient request:@"ErpZhiWeiAdd.ashx" parameters:paeameters success:^(NSJSONSerialization* json){
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }failure:^(NSError *error){
        
        
        
    }];
    
}

- (void)initWithTableView {
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableview = tableview;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 100)];
    
    view.backgroundColor = [UIColor colorWithRed:230/255. green:230/255. blue:230/255. alpha:1.];
    
    [self.view addSubview:view];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, 50)];
    
    textField.placeholder = @"请输入职位名称";
    
    textField.backgroundColor = [UIColor whiteColor];
    
    self.textField = textField;
    
    textField.text = self.zhiweimingcheng;
    
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
