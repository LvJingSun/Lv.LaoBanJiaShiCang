//
//  EarlyController.m
//  BusinessCenter
//
//  Created by mac on 16/4/25.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import "EarlyController.h"
#import "AppHttpClient.h"

@interface EarlyController ()<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource> {

    NSString *yuJingType;
    
    NSString *guanLianID;
    
    NSString *shuLiang;
    
}

@property (nonatomic, weak) UIPickerView *pickerview;

@property (nonatomic, weak) UITextField *goodsField;

@property (nonatomic, weak) UITextField *countField;

@property (nonatomic, strong) NSArray *goodsArray;

@property (nonatomic, strong) NSArray *goodNameArr;

@property (nonatomic, weak) UIButton *cancleBtn;

@property (nonatomic, weak) UIButton *sureBtn;

@end

@implementation EarlyController

- (void)requestCP {

    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *paeameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId,@"memberID",
                                nil];
    
    [httpClient request:@"ErpChanPinList.ashx" parameters:paeameters success:^(NSJSONSerialization* json){
        
        NSDictionary *dic = (NSDictionary *)json;
        
        NSArray *truearr = dic[@"ChanPinModelList"];
        
        self.goodsArray = dic[@"ChanPinModelList"];
        
        if (self.goodsArray.count == 0) {
            
            self.goodsField.enabled = NO;
            
            self.goodsField.placeholder = @"暂无商品请添加";
            
        }
        
        NSMutableArray *mutArr = [NSMutableArray array];
        
        for (NSDictionary *dict in truearr) {
            
            [mutArr addObject:dict[@"ProName"]];
            
        }
        
        self.goodNameArr = mutArr;
        
    }failure:^(NSError *error){
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self requestCP];
    
    CGFloat sizeW = self.view.bounds.size.width;
    
    self.title = @"预警设置";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(sizeW * 0.05, 20, sizeW * 0.25, 30)];
    
    lab1.text = @"商品名：";
    
    lab1.font = [UIFont systemFontOfSize:15];
    
    [self.view addSubview:lab1];
    
    UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(sizeW * 0.05, CGRectGetMaxY(lab1.frame) + 20, sizeW * 0.25, 30)];
    
    lab2.text = @"预警数：";
    
    lab2.font = [UIFont systemFontOfSize:15];
    
    [self.view addSubview:lab2];
    
    UITextField *field1 = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lab1.frame), 20, sizeW * 0.4, 30)];
    
    field1.tag = 101;
    
    field1.delegate = self;
    
    field1.placeholder = @"请选择商品";
    
    self.goodsField = field1;
    
    [self.view addSubview:field1];
    
    UITextField *field2 = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lab2.frame), CGRectGetMaxY(lab1.frame) + 20, sizeW * 0.4, 30)];
    
    field2.placeholder = @"请输入预警数量";
    
    field2.delegate = self;
    
    self.countField = field2;
    
    [self.view addSubview:field2];
    
    [self setRightBtns];
    
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
    
    if ([self.goodsField.text isEqualToString:@""]) {
        
        [alert show];
        
    }else if ([self.countField.text isEqualToString:@""]) {
        
        [alert show];
    
    }else {
    
        yuJingType = @"YuJingType_1";
        
        shuLiang = self.countField.text;
        
        for (NSDictionary *dic in self.goodsArray) {
            
            if ([self.goodsField.text isEqualToString:dic[@"ProName"]]) {
                
                guanLianID = dic[@"JxcProID"];
            }
        }
        
        [self pushData];
        
    }


    
}

- (void)pushData {

    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *paeameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId,@"memberID",
                                yuJingType,@"yuJingType",
                                guanLianID,@"guanLianID",
                                shuLiang,@"shuLiang",
                                nil];
    
    [httpClient request:@"ErpYuJingAdd.ashx" parameters:paeameters success:^(NSJSONSerialization* json){
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }failure:^(NSError *error){
        
    }];
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if (textField.tag == 101) {

        [self allocPickerview];
        
        [self.countField resignFirstResponder];
        
        return NO;
        
    }else {
    
        return YES;
    }
    
}

- (void)allocPickerview {
    
    if (self.pickerview) {
        
        [self cancleBtnClick];
        
    }else {
    
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
        
        [self.view addSubview:pickerview];
        
    }
    
}

- (void)sureBtnClick {

    [self.pickerview removeFromSuperview];
    
    [self.sureBtn removeFromSuperview];
    
    [self.cancleBtn removeFromSuperview];
    
    NSInteger select = [self.pickerview selectedRowInComponent:0];
    
    NSDictionary *dic = self.goodsArray[select];
    
    self.goodsField.text = dic[@"ProName"];
    
}

- (void)cancleBtnClick {

    [self.pickerview removeFromSuperview];
    
    [self.sureBtn removeFromSuperview];
    
    [self.cancleBtn removeFromSuperview];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [self.countField resignFirstResponder];
    
    [self cancleBtnClick];
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {

    return 1;
    
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {

    return self.goodNameArr.count;
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {

    return self.goodNameArr[row];
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {

    self.goodsField.text = self.goodNameArr[row];
    
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
