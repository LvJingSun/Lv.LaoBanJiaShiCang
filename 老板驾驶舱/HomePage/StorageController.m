//
//  StorageController.m
//  BusinessCenter
//
//  Created by mac on 16/5/12.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import "StorageController.h"
#import "StorageView.h"
#import "AppHttpClient.h"

@interface StorageController ()<UITableViewDelegate,UITableViewDataSource,UIPickerViewDataSource,UITextFieldDelegate,UIPickerViewDelegate> {

    NSArray *pickArray;
    NSString *type;
    NSString *jxcProID;
    NSString *supplierID;
    NSString *jingBanRenID;
    NSString *jinHuoPrice;
    NSString *lingShouPrice;
    NSString *shuLiang;
    NSString *kuCunType;
    
    
}

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, weak) StorageView *addview;

@property (nonatomic, weak) UIPickerView *pickerview;

@property (nonatomic, weak) UIButton *cancleBtn;

@property (nonatomic, weak) UIButton *sureBtn;

@end

@implementation StorageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.titleLab;
    
    self.view.backgroundColor = [UIColor colorWithRed:230/255. green:230/255. blue:230/255. alpha:1.];
    
    [self setRightBtns];
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    StorageView *addview = [[StorageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 257)];
    
    self.addview = addview;
    
    tableview.tableHeaderView = addview;
    
    self.tableview = tableview;
    
    [addview.selectGood addTarget:self action:@selector(chooseGood) forControlEvents:UIControlEventTouchUpInside];
    
    [addview.selectJBR addTarget:self action:@selector(chooseJBR) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    tableview.backgroundColor = [UIColor colorWithRed:230/255. green:230/255. blue:230/255. alpha:1.];
    
    [self.view addSubview:tableview];
    
    if ([self.titleLab isEqualToString:@"入库"]) {
        
        kuCunType = @"1";
        
        self.addview.supplierLab.text = @"供应商";
        
        self.addview.supplierField.placeholder = @"请选择供应商";
        
        [addview.selectGYS addTarget:self action:@selector(chooseGYS) forControlEvents:UIControlEventTouchUpInside];
        
    }else if ([self.titleLab isEqualToString:@"出库"]) {
        
        kuCunType = @"2";
        
        self.addview.supplierLab.text = @"客户";
        
        self.addview.supplierField.placeholder = @"请选择客户";
        
        [addview.selectGYS addTarget:self action:@selector(chooseKH) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
}

- (void)chooseJBR {
    
    type = @"2";
    
    pickArray = self.JBRArray;
    
    if (pickArray.count == 0) {
        
        self.addview.selectJBR.enabled = NO;
        
        self.addview.titleField.enabled = NO;
        
        self.addview.titleField.placeholder = @"暂无经办人请添加";
        
    }else {
    
        if (self.pickerview) {
            
            [self cancleBtnClick];
            
        }
        
        [self allocPickerview];
        
    }
    
}

- (void)chooseKH {
    
    type = @"3";
    
    pickArray = self.KHArray;
    
    if (pickArray.count == 0) {
        
        self.addview.selectJBR.enabled = NO;
        
        self.addview.telField.enabled = NO;
        
        self.addview.telField.placeholder = @"暂无客户请添加";
        
    }else {
        
        if (self.pickerview) {
            
            [self cancleBtnClick];
            
        }
        
        [self allocPickerview];
        
    }
    
}

- (void)chooseGYS {
    
    type = @"3";
    
    pickArray = self.GYSArray;
    
    if (pickArray.count == 0) {
        
        self.addview.selectGYS.enabled = NO;
        
        self.addview.telField.enabled = NO;
        
        self.addview.telField.placeholder = @"暂无供应商请添加";
        
    }else {
    
        if (self.pickerview) {
            
            [self cancleBtnClick];
            
        }
        
        [self allocPickerview];
        
    }
    
}

- (void)chooseGood {
    
    type = @"1";

    pickArray = self.CPArray;
    
    if (pickArray.count == 0) {
        
        self.addview.selectGood.enabled = NO;
        
        self.addview.nameField.enabled = NO;
        
        self.addview.nameField.placeholder = @"暂无商品请添加";
        
    }else {
    
        if (self.pickerview) {
            
            [self cancleBtnClick];
            
        }
        
        [self allocPickerview];
        
    }
    
}

- (void)allocPickerview {
    
    UIButton *sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width * 0.8, self.view.bounds.size.height * 0.65, self.view.bounds.size.width * 0.2, self.view.bounds.size.height * 0.05)];
    
    [sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    
    [sureBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    
    self.sureBtn = sureBtn;
    
    [self.view addSubview:sureBtn];
    
    UIButton *cancleBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height * 0.65, self.view.bounds.size.width * 0.2, self.view.bounds.size.height * 0.05)];
    
    [cancleBtn addTarget:self action:@selector(cancleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    
    [cancleBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    
    self.cancleBtn = cancleBtn;
    
    [self.view addSubview:cancleBtn];
    
    UIPickerView *pickerview = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height * 0.7, self.view.bounds.size.width, self.view.bounds.size.height * 0.3)];
    
    pickerview.showsSelectionIndicator = YES;
    
    pickerview.delegate = self;
    
    pickerview.dataSource = self;
    
    pickerview.backgroundColor = [UIColor lightGrayColor];
    
    self.pickerview = pickerview;
    
    [pickerview selectRow:0 inComponent:0 animated:NO];
    
    [self.view addSubview:pickerview];
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
    
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return pickArray.count;
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    NSDictionary *dic = pickArray[row];
    
    return dic[@"Value"];
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    NSDictionary *dic = pickArray[row];
    
    if ([type isEqualToString:@"1"]) {
        
        self.addview.nameField.text = dic[@"Value"];
        
    }else if ([type isEqualToString:@"2"]) {
    
        self.addview.titleField.text = dic[@"Value"];
        
    }else if ([type isEqualToString:@"3"]) {
    
        self.addview.supplierField.text = dic[@"Value"];
        
    }else {
    
    }
    
}


- (void)sureBtnClick {
    
    [self.pickerview removeFromSuperview];
    
    [self.sureBtn removeFromSuperview];
    
    [self.cancleBtn removeFromSuperview];
    
    if ([type isEqualToString:@"1"]) {
        
        NSInteger select = [self.pickerview selectedRowInComponent:0];
        
        NSDictionary *dic = self.CPArray[select];
        
        self.addview.nameField.text = dic[@"Value"];
        
    }else if ([type isEqualToString:@"2"]) {
        
        NSInteger select = [self.pickerview selectedRowInComponent:0];
        
        NSDictionary *dic = self.JBRArray[select];
        
        self.addview.titleField.text = dic[@"Value"];
        
    }else if ([type isEqualToString:@"3"]) {
        
        if ([kuCunType isEqualToString:@"1"]) {
            
            NSInteger select = [self.pickerview selectedRowInComponent:0];
            
            NSDictionary *dic = self.GYSArray[select];
            
            self.addview.supplierField.text = dic[@"Value"];
            
        }else {
        
            NSInteger select = [self.pickerview selectedRowInComponent:0];
            
            NSDictionary *dic = self.KHArray[select];
            
            self.addview.supplierField.text = dic[@"Value"];
            
        }
        
    }else {
        
    }
    
}

- (void)cancleBtnClick {
    
    [self.pickerview removeFromSuperview];
    
    [self.sureBtn removeFromSuperview];
    
    [self.cancleBtn removeFromSuperview];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self cancleBtnClick];
    
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
    
    if ([self.addview.nameField.text isEqualToString:@""] && [self.addview.titleField.text isEqualToString:@""] && [self.addview.supplierField.text isEqualToString:@""] && [self.addview.telField.text isEqualToString:@""] && [self.addview.genderField.text isEqualToString:@""] && [self.addview.countField.text isEqualToString:@""]) {
        
        [alert show];
        
    }else {
        
        for (NSDictionary *dic in self.CPArray) {
            
            if ([dic[@"Value"] isEqualToString:self.addview.nameField.text]) {
                
                jxcProID = dic[@"Key"];
                
            }
        }
        
        for (NSDictionary *dic in self.JBRArray) {
            
            if ([dic[@"Value"] isEqualToString:self.addview.titleField.text]) {
                
                jingBanRenID = dic[@"Key"];
                
            }
        }
        
        if ([kuCunType isEqualToString:@"1"]) {
            
            for (NSDictionary *dic in self.GYSArray) {
                
                if ([dic[@"Value"] isEqualToString:self.addview.supplierField.text]) {
                    
                    supplierID = dic[@"Key"];
                    
                }
            }
            
        }else {
        
            for (NSDictionary *dic in self.KHArray) {
                
                if ([dic[@"Value"] isEqualToString:self.addview.supplierField.text]) {
                    
                    supplierID = dic[@"Key"];
                    
                }
            }
            
        }
        
        jinHuoPrice = self.addview.telField.text;
        
        lingShouPrice = self.addview.genderField.text;
        
        shuLiang = self.addview.countField.text;
    
        [self requestSaveData];
    }
}

- (void)requestSaveData {
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *paeameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId,@"memberID",
                                kuCunType,@"kuCunType",
                                jxcProID,@"jxcProID",
                                supplierID,@"supplierID",
                                jinHuoPrice,@"jinHuoPrice",
                                lingShouPrice,@"lingShouPrice",
                                shuLiang,@"shuLiang",
                                jingBanRenID,@"jingBanRenID",
                                @"",@"remark",
                                nil];
    
    [httpClient request:@"ErpKuCunAdd.ashx" parameters:paeameters success:^(NSJSONSerialization* json){
        
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
