//
//  AddProductController.m
//  BusinessCenter
//
//  Created by mac on 16/5/10.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import "AddProductController.h"
#import "AddProductView.h"
#import "AppHttpClient.h"
#import "GMDCircleLoader.h"

@interface AddProductController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIPickerViewDataSource,UITextFieldDelegate,UIPickerViewDelegate> {

    NSArray *type1Array;
    NSArray *type2Array;
    NSArray *type3Array;
    
    NSString *jxcProID;
    NSString *categoryID1;
    NSString *categoryID2;
    NSString *categoryID3;
    NSString *proName;
    NSString *descript;
    NSString *huoHao;
    NSMutableDictionary *imageDic;
    
}

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, weak) AddProductView *addview;

@property (nonatomic, weak) UIPickerView *pickerview;

@property (nonatomic, weak) UIButton *cancleBtn;

@property (nonatomic, weak) UIButton *sureBtn;

@property (nonatomic, strong) NSMutableArray *level2;

@property (nonatomic, strong) NSMutableArray *level3;

@end

@implementation AddProductController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    imageDic = [[NSMutableDictionary alloc]initWithCapacity:0];
    
    self.title = @"新增商品";
    
    self.view.backgroundColor = [UIColor colorWithRed:230/255. green:230/255. blue:230/255. alpha:1.];
    
    [self setRightBtns];
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    AddProductView *addview = [[AddProductView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 284)];
    
    self.addview = addview;
    
    tableview.tableHeaderView = addview;
    
    self.tableview = tableview;
    
    [addview.imageviewBtn addTarget:self action:@selector(selectImage) forControlEvents:UIControlEventTouchUpInside];
    
    [addview.typeBtn addTarget:self action:@selector(typeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    tableview.backgroundColor = [UIColor colorWithRed:230/255. green:230/255. blue:230/255. alpha:1.];
    
    [self.view addSubview:tableview];
    
    [self requestTypeData];

}

- (void)typeBtnClick {

    if (self.pickerview) {
        
        [self cancleBtnClick];
        
    }
    
    [self allocPickerview];
}

- (void)sureBtnClick {
    
    [self.pickerview removeFromSuperview];
    
    [self.sureBtn removeFromSuperview];
    
    [self.cancleBtn removeFromSuperview];
    
    if (type1Array.count == 0) {
        
        categoryID1 = @"0";
        
        categoryID2 = @"0";
        
        categoryID3 = @"0";
        
    }else {
    
        NSInteger select1 = [self.pickerview selectedRowInComponent:0];
        
        NSDictionary *dic1 = type1Array[select1];
        
        categoryID1 = dic1[@"CategoryID"];
        
        self.addview.typeField.text = dic1[@"CatgName"];
        
        if (self.level2.count == 0) {
            
            categoryID2 = @"0";
            
            categoryID3 = @"0";
            
        }else {
        
            NSInteger select2 = [self.pickerview selectedRowInComponent:1];
            
            NSDictionary *dic2 = self.level2[select2];
            
            categoryID2 = dic2[@"CategoryID"];
            
            self.addview.typeField.text = dic2[@"CatgName"];
            
            if (self.level3.count == 0) {
                
                categoryID3 = @"0";
                
            }else {
            
                NSInteger select3 = [self.pickerview selectedRowInComponent:2];
                
                NSDictionary *dic3 = self.level3[select3];
                
                categoryID3 = dic3[@"CategoryID"];
                
                self.addview.typeField.text = dic3[@"CatgName"];
                
            }
        }
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
    
    [self initWithPickerView];
    
}

- (void)initWithPickerView {

    UIPickerView *pickerview = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height * 0.7, self.view.bounds.size.width, self.view.bounds.size.height * 0.3)];
    
    pickerview.showsSelectionIndicator = YES;
    
    pickerview.delegate = self;
    
    pickerview.dataSource = self;
    
    pickerview.backgroundColor = [UIColor whiteColor];
    
    self.pickerview = pickerview;
    
    [self.view addSubview:pickerview];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    if (type1Array.count == 0) {
        
        return 0;
        
    }else {
    
        return 3;
        
    }
    
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {

    if (component == 0) {
        
        if (type1Array.count == 0) {
            
            return 0;
            
        }else {
        
            return type1Array.count;
            
        }
        
    }else if (component == 1) {
        
        [self.level2 removeAllObjects];
        
        NSInteger rowLevel2 = [self.pickerview selectedRowInComponent:0];
        
        NSDictionary *dic = type1Array[rowLevel2];
        
        NSMutableArray *array2 = [NSMutableArray array];
        
        for (NSDictionary *dd in type2Array) {
            
            if ([dd[@"ParentID"] isEqualToString:dic[@"CategoryID"]]) {
                
                [array2 addObject:dd];
                
            }
            
        }
        
        self.level2 = array2;
        
        if (self.level2.count == 0) {
            
            return 0;
            
        }else {
        
            return self.level2.count;
            
        }
    
    }else if (component == 2) {
        
        [self.level3 removeAllObjects];
        
        if (self.level2.count == 0) {
            
            return 0;
            
        }else {
        
            NSInteger rowLevel3 = [self.pickerview selectedRowInComponent:1];
            
            NSDictionary *dic = self.level2[rowLevel3];
            
            NSMutableArray *array3 = [NSMutableArray array];
            
            for (NSDictionary *dd in type3Array) {
                
                if ([dd[@"ParentID"] isEqualToString:dic[@"CategoryID"]]) {
                    
                    [array3 addObject:dd];
                    
                }
                
            }
            
            self.level3 = array3;
            
            if (self.level3.count == 0) {
                
                return 0;
                
            }else {
                
                return self.level3.count;
                
            }
            
        }
    
    }else {
    
        return 0;
        
    }
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {

    if (component == 0) {
        
        [self.pickerview reloadAllComponents];
        
    }else if (component == 1) {
        
        [self.pickerview reloadAllComponents];
    
    }else if (component == 2) {
    
    }else {
    
    }
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {

    if (component == 0) {
        
        if (type1Array.count == 0) {
            
            return nil;
            
        }else {
        
            NSDictionary *dic = type1Array[row];
            
            return dic[@"CatgName"];
            
        }
        
    }else if (component == 1) {
        
        if (self.level2.count == 0) {
            
            return nil;
            
        }else {
        
            NSDictionary *dic = self.level2[row];
            
            return dic[@"CatgName"];
            
        }
    
    }else if (component == 2) {
        
        if (self.level3.count == 0) {
            
            return nil;
            
        }else {
        
            NSDictionary *dic = self.level3[row];
            
            return dic[@"CatgName"];
            
        }
    
    }else {
    
        return nil;
        
    }
    
}

- (void)requestTypeData {
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *paeameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId,@"memberId",
                                nil];
    
    [httpClient request:@"ErpFenLeiList.ashx" parameters:paeameters success:^(NSJSONSerialization* json){
        
        NSDictionary *dict = (NSDictionary *)json;
        
        NSArray *CategroyModelList = dict[@"CategroyModelList"];
        
        NSMutableArray *level1 = [NSMutableArray array];
        
        for (int i = 0; i < CategroyModelList.count; i++) {
            
            if ([((NSDictionary *)CategroyModelList[i])[@"Levels"] isEqualToString:@"1"]) {
                
                [level1 addObject:CategroyModelList[i]];
                
            }
            
        }
        
        type1Array = level1;
        
        if (type1Array.count == 0) {
            
            self.addview.typeBtn.enabled = NO;
            
            self.addview.typeField.enabled = NO;
            
            self.addview.typeField.placeholder = @"暂无分类请添加";
        }
        
        NSMutableArray *level2 = [NSMutableArray array];
        
        for (int i = 0; i < CategroyModelList.count; i++) {
            
            if ([((NSDictionary *)CategroyModelList[i])[@"Levels"] isEqualToString:@"2"]) {
                
                [level2 addObject:CategroyModelList[i]];
                
            }
            
        }
        
        type2Array = level2;
        
        NSMutableArray *level3 = [NSMutableArray array];
        
        for (int i = 0; i < CategroyModelList.count; i++) {
            
            if ([((NSDictionary *)CategroyModelList[i])[@"Levels"] isEqualToString:@"3"]) {
                
                [level3 addObject:CategroyModelList[i]];
                
            }
            
        }
        
        type3Array = level3;
        
    }failure:^(NSError *error){
        
        
    }];
    
}

- (void)selectImage {

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
    
    self.addview.tuBiaoImageView.image = image;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

//点击cancle实现的代理
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
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
    
    jxcProID = @"0";
    
    proName = self.addview.nameField.text;
    
    descript = self.addview.descField.text;
    
    huoHao = self.addview.titleField.text;
    
    [imageDic setValue:UIImageJPEGRepresentation(self.addview.tuBiaoImageView.image, 1) forKey:[NSString stringWithFormat:@"fengMian"]];
    
    if ([proName isEqualToString:@""] || [huoHao isEqualToString:@""] || imageDic.count == 0) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请完善所填信息" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alert show];
        
    }else {
        
        [GMDCircleLoader setOnView:self.view withTitle:@"提交中..." animated:YES];
    
        [self pushData];
        
    }
}



- (void)pushData {

    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *paeameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId,@"memberID",
                                jxcProID,@"jxcProID",
                                categoryID1,@"categoryID1",
                                categoryID2,@"categoryID2",
                                categoryID3,@"categoryID3",
                                proName,@"proName",
                                descript,@"descript",
                                huoHao,@"huoHao",
                                nil];

    [httpClient multiRequest:@"ErpChanPinAdd.ashx" parameters:paeameters files:imageDic success:^(NSJSONSerialization *json) {
        
        [GMDCircleLoader hideFromView:self.view animated:YES];
        
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(NSError *error) {
        
        NSLog(@"333false");
        
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
