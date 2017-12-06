//
//  AddStaffController.m
//  BusinessCenter
//
//  Created by mac on 16/5/11.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import "AddStaffController.h"
#import "AddStaffView.h"
#import "AddAdminView.h"
#import "AccountController.h"
#import "GMDCircleLoader.h"
#import "AppHttpClient.h"

@interface AddStaffController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate> {

    NSString *memberID;
    
    NSString *yuanGongID;
    
    NSString *merchantShopID;
    
    NSString *realName;
    
    NSString *role;
    
    NSString *zhiWeiID;
    
    NSString *nickName;
    
    NSString *phone;
    
    NSString *jiBenGongZi;
    
    NSString *yongJinLevelID;
    
    NSMutableDictionary *touXiangDic;
    
    //判断哪一个pickerView
    NSString *pickerType;
    
}

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, weak) AddAdminView *addview;

@property (nonatomic, weak) UISegmentedControl *segmView;

@property (nonatomic, strong) NSArray *pickerArray;

@property (nonatomic, weak) UIPickerView *pickerview;

@property (nonatomic, weak) UIButton *cancleBtn;

@property (nonatomic, weak) UIButton *sureBtn;

@end

@implementation AddStaffController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    touXiangDic = [[NSMutableDictionary alloc]initWithCapacity:0];
    
    self.title = @"新增员工";
    
    [self setRightBtns];
    
    self.view.backgroundColor = [UIColor colorWithRed:245/255. green:245/255. blue:249/255. alpha:1.];
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    AddAdminView *addview = [[AddAdminView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    
    self.addview = addview;
    
    [addview.selectSP addTarget:self action:@selector(selectShangPu) forControlEvents:UIControlEventTouchUpInside];
    
    [addview.selectZW addTarget:self action:@selector(selectZhiWei) forControlEvents:UIControlEventTouchUpInside];
    
    [addview.selectLevel addTarget:self action:@selector(selectDengJi) forControlEvents:UIControlEventTouchUpInside];
    
    [addview.selectIcon addTarget:self action:@selector(selectTuBiao) forControlEvents:UIControlEventTouchUpInside];
    
    self.segmView = addview.segm;
    
    tableview.tableHeaderView = addview;
    
    addview.type = @"收银员";
    
    role = @"CashierAccountRole_1";
    
    self.tableview = tableview;
    
    tableview.backgroundColor = [UIColor colorWithRed:230/255. green:230/255. blue:230/255. alpha:1.];
    
    [self.view addSubview:tableview];
    
    [self.segmView addTarget:self action:@selector(segmchange:) forControlEvents:UIControlEventValueChanged];
    
}

- (void)selectTuBiao {
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"相册", nil];
    
    [sheet showInView:self.view];
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (buttonIndex) {
        case 0:
        {
            [self PaiZhao];
        }
            break;
        case 1:
        {
            [self XiangCe];
        }
            break;
            
        default:
            break;
    }
}

- (void)PaiZhao {
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        
        picker.delegate = self;
        
        picker.allowsEditing = YES;
        
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:nil];
        
    }else {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您的设备暂不支持拍照" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alert show];
        
    }
}

- (void)XiangCe {
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        
        picker.delegate = self;
        
        picker.allowsEditing = YES;
        
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        [self presentViewController:picker animated:YES completion:nil];
        
    }else {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您的设备暂不支持相册" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alert show];
        
    }
    
}

//拍照完成实现的代理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    
    self.addview.iconImageview.image = image;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

//点击cancle实现的代理
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)selectShangPu {
    
    pickerType = @"shangpu";
    
    self.pickerArray = self.shangpuArray;
    
    if (self.pickerArray.count == 0) {
        
        self.addview.shopsField.enabled = NO;
        
        self.addview.selectSP.enabled = NO;
        
        self.addview.shopsField.placeholder = @"请添加商铺";
        
    }else {
    
        if (self.pickerview) {
            
            [self cancleBtnClick];
            
        }
        
        [self allocPickerview];
        
    }
    
}

- (void)selectDengJi {

    pickerType = @"dengji";
    
    self.pickerArray = self.levelArray;
    
    if (self.pickerArray.count == 0) {
        
        self.addview.shopsField.enabled = NO;
        
        self.addview.selectSP.enabled = NO;
        
        self.addview.shopsField.placeholder = @"请添加等级";
        
    }else {
        
        if (self.pickerview) {
            
            [self cancleBtnClick];
            
        }
        
        [self allocPickerview];
        
    }
    
}

- (void)selectZhiWei {
    
    pickerType = @"position";
    
    self.pickerArray = self.positionArray;
    
    if (self.pickerArray.count == 0) {
        
        self.addview.positionField.enabled = NO;
        
        self.addview.selectZW.enabled = NO;
        
        self.addview.positionField.placeholder = @"请添加职位";
        
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

- (void)sureBtnClick {
    
    [self.pickerview removeFromSuperview];
    
    [self.sureBtn removeFromSuperview];
    
    [self.cancleBtn removeFromSuperview];
    
    if ([pickerType isEqualToString:@"shangpu"]) {
        
        NSInteger selectRow = [self.pickerview selectedRowInComponent:0];
        
        NSDictionary *dic = self.shangpuArray[selectRow];
        
        if (dic.count == 0) {
            
            self.addview.shopsField.text = @"";
            
        }else {
        
            self.addview.shopsField.text = dic[@"Value"];
            
        }
        
    }else if ([pickerType isEqualToString:@"position"]) {
    
        NSInteger selectRow = [self.pickerview selectedRowInComponent:0];
        
        NSDictionary *dic = self.positionArray[selectRow];
        
        if (dic.count == 0) {
            
            self.addview.positionField.text = @"";
            
        }else {
            
            self.addview.positionField.text = dic[@"Value"];
            
        }
        
    }else if ([pickerType isEqualToString:@"dengji"]) {
    
        NSInteger selectRow = [self.pickerview selectedRowInComponent:0];
        
        NSDictionary *dic = self.levelArray[selectRow];
        
        if (dic.count == 0) {
            
            self.addview.levelField.text = @"";
            
        }else {
            
            self.addview.levelField.text = dic[@"Value"];
            
        }
        
    }
    
}

- (void)cancleBtnClick {
    
    [self.pickerview removeFromSuperview];
    
    [self.sureBtn removeFromSuperview];
    
    [self.cancleBtn removeFromSuperview];
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
    
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return self.pickerArray.count;
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    NSDictionary *dic = self.pickerArray[row];
    
    return dic[@"Value"];
    
}

- (void)segmchange:(UISegmentedControl *)segm {
    
    NSInteger index = segm.selectedSegmentIndex;
    
    switch (index) {
        case 0:
        {
            self.addview.type = @"收银员";
            
            role = @"CashierAccountRole_1";
            
            [self cancleBtnClick];

        }
            
            break;
            
        case 1:
        {
            self.addview.type = @"普通员工";
            
            role = @"CashierAccountRole_2";
            
            [self cancleBtnClick];

        }
            
            break;
            
        default:
            break;
    }
    
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
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];
    
    memberID = memberId;
    
    yuanGongID = @"0";
    
    realName = self.addview.nameField.text;
    
    nickName = self.addview.nickNameField.text;
    
    phone = self.addview.phoneField.text;
    
    jiBenGongZi = self.addview.gongziField.text;
    
    [touXiangDic setValue:UIImageJPEGRepresentation(self.addview.iconImageview.image, 1) forKey:[NSString stringWithFormat:@"touXiang"]];
    
    if ([self.addview.shopsField.text isEqualToString:@""]) {
        
        UIAlertView *alertSP = [[UIAlertView alloc] initWithTitle:@"提示" message:@"商铺信息未完善" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alertSP show];
        
        merchantShopID = @"";
        
    }else {
    
        for (NSDictionary *dic in self.shangpuArray) {
            
            if ([self.addview.shopsField.text isEqualToString:dic[@"Value"]]) {
                
                merchantShopID = dic[@"Key"];
            }
        }
    }
    
    if ([self.addview.positionField.text isEqualToString:@""]) {
        
        UIAlertView *alertZW = [[UIAlertView alloc] initWithTitle:@"提示" message:@"职位信息未完善" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alertZW show];
        
        zhiWeiID = @"";
        
    }else {
        
        for (NSDictionary *dic in self.positionArray) {
            
            if ([self.addview.positionField.text isEqualToString:dic[@"Value"]]) {
                
                zhiWeiID = dic[@"Key"];
            }
        }
    }
    
    if ([self.addview.levelField.text isEqualToString:@""]) {
        
        UIAlertView *alertDJ = [[UIAlertView alloc] initWithTitle:@"提示" message:@"等级信息未完善" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alertDJ show];
        
        yongJinLevelID = @"";
        
    }else {
        
        for (NSDictionary *dic in self.levelArray) {
            
            if ([self.addview.levelField.text isEqualToString:dic[@"Value"]]) {
                
                yongJinLevelID = dic[@"Key"];
            }
        }
    }
    
    if ([merchantShopID isEqualToString:@""] || [realName isEqualToString:@""] || [zhiWeiID isEqualToString:@""] || [yongJinLevelID isEqualToString:@""] || [jiBenGongZi isEqualToString:@""]) {
        
        UIAlertView *allAlert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请完善所填信息" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [allAlert show];
        
    }else {
    
        if (touXiangDic.count == 0) {
            
            UIAlertView *iconAlert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择图片" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            
            [iconAlert show];
            
        }else {
            
            if ([self.addview.type isEqualToString:@"收银员"]) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您所创建的员工角色为收银员，需要为其添加收银账号，前往添加？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                
                alert.tag = 1122;
                
                [alert show];
                
            }else {
                
                [GMDCircleLoader setOnView:self.view withTitle:@"正在提交员工信息" animated:YES];
                
                [self pushData];
                
            }
        }
    }
}

- (void)pushData {
    
    AppHttpClient *httpClient = [AppHttpClient sharedClient];
    
    NSDictionary *pardic = [NSDictionary dictionaryWithObjectsAndKeys:
                            memberID,@"memberID",
                            yuanGongID,@"yuanGongID",
                            merchantShopID,@"merchantShopID",
                            @"",@"account",
                            @"",@"password",
                            realName,@"realName",
                            role,@"role",
                            zhiWeiID,@"zhiWeiID",
                            nickName,@"nickName",
                            phone,@"phone",
                            yongJinLevelID,@"yongJinLevelID",
                            jiBenGongZi,@"jiBenGongZi",
                            nil];
    
    [httpClient multiRequest:@"ErpYuanGongAdd.ashx" parameters:pardic files:touXiangDic success:^(NSJSONSerialization *json) {
        
        [GMDCircleLoader hideFromView:self.view animated:YES];
        
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(NSError *error) {
        
        [GMDCircleLoader hideFromView:self.view animated:YES];
        
    }];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {

    if (alertView.tag == 1122) {
        
        switch (buttonIndex) {
            case 1:
            {
                AccountController *vc = [[AccountController alloc] init];
                
                vc.memberID = memberID;
                
                vc.yuanGongID = yuanGongID;
                
                vc.merchantShopID = merchantShopID;
                
                vc.account = @"";
                
                vc.password = @"";
                
                vc.realName = realName;
                
                vc.role = role;
                
                vc.zhiWeiID = zhiWeiID;
                
                vc.nickName = nickName;
                
                vc.phone = phone;
                
                vc.touXiangDic = touXiangDic;
                
                vc.yongJinLevelID = yongJinLevelID;
                
                vc.jiBenGongZi = jiBenGongZi;
                
                [self.navigationController pushViewController:vc animated:YES];
                
            }
                break;
                
            default:
                break;
        }
        
    }
    
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
