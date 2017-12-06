//
//  EditTypeController.m
//  BusinessCenter
//
//  Created by mac on 16/5/16.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import "EditTypeController.h"
#import "AddTypeView.h"
#import "AppHttpClient.h"

@interface EditTypeController ()<UITableViewDelegate,UITableViewDataSource> {
    
    NSString *name;
    
}

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, weak) AddTypeView *addview;

@end

@implementation EditTypeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"修改类别";
    
    self.view.backgroundColor = [UIColor colorWithRed:230/255. green:230/255. blue:230/255. alpha:1.];
    
    [self setRightBtns];
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    AddTypeView *addview = [[AddTypeView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 40)];
    
    self.addview = addview;
    
    addview.nameField.text = self.name;
    
    tableview.tableHeaderView = addview;
    
    self.tableview = tableview;
    
    tableview.backgroundColor = [UIColor colorWithRed:230/255. green:230/255. blue:230/255. alpha:1.];
    
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
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请完善所填信息" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    if ([self.addview.nameField.text isEqualToString:@""]) {
        
        [alert show];
        
    }else {
        
        name = self.addview.nameField.text;
        
        if ([name isEqualToString:self.name]) {
            
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
                                self.categoryID,@"categoryID",
                                name,@"catgName",
                                self.ParentID,@"parentID",
                                nil];
    
    [httpClient request:@"ErpFenLeiAdd.ashx" parameters:paeameters success:^(NSJSONSerialization* json){
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }failure:^(NSError *error){
        
        
        
    }];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.addview resignFirstResponderKey];
    
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
