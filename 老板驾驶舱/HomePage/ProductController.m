

#import "ProductController.h"
#import "Product.h"
#import "EditProductController.h"
#import "AddProductController.h"
#import "ProductCell.h"
#import "AppHttpClient.h"
#import "SVProgressHUD.h"
#import "GMDCircleLoader.h"

@interface ProductController ()<UITableViewDelegate,UITableViewDataSource> {

    NSString *jxcProID;
    
}

@property (nonatomic, strong) NSMutableArray *productArr;

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) UIImage *CopyImage;

@property (nonatomic, weak) UILabel *noLabel;

@end

@implementation ProductController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"产品管理";
    
    self.view.backgroundColor = [UIColor colorWithRed:230/255. green:230/255. blue:230/255. alpha:1.];
    
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    
    CGRect rectNav = self.navigationController.navigationBar.frame;
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 2, self.view.bounds.size.width, self.view.bounds.size.height - rectStatus.size.height - rectNav.size.height - 2)];
    
    tableview.backgroundColor = [UIColor whiteColor];
    
    self.tableView = tableview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    [self.view addSubview:tableview];
    
    [self setRightBtn];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 100, self.view.bounds.size.width - 100, 30)];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    label.text = @"暂无数据";
    
    self.noLabel = label;
    
    label.textColor = [UIColor lightGrayColor];
    
    [self.view addSubview:label];

}

- (void)setRightBtn {
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    addBtn.frame = CGRectMake(0, 0, 30, 20);
    
    [addBtn setTitle:@"编辑" forState:UIControlStateNormal];
    
    addBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    
    [addBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    
    [addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    editBtn.frame = CGRectMake(0, 0, 15, 15);
    
    [editBtn setImage:[UIImage imageNamed:@"sotckjia.png"] forState:UIControlStateNormal];
    
    [editBtn addTarget:self action:@selector(editBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *addBarBtn = [[UIBarButtonItem alloc] initWithCustomView:addBtn];
    
    UIBarButtonItem *screenBarBtn=[[UIBarButtonItem alloc]initWithCustomView:editBtn];
    
    self.navigationItem.rightBarButtonItems = @[screenBarBtn,addBarBtn];
    
}

- (void)addBtnClick {
    
    if (self.tableView.editing) {
        
        [self.tableView setEditing:NO animated:YES];
        
    }else {
        
        [self.tableView setEditing:YES animated:YES];
        
    }
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dic = self.productArr[indexPath.row];
    
    jxcProID = dic[@"JxcProID"];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSInteger row = [indexPath row];
        
        [self.productArr removeObjectAtIndex:row];
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        [GMDCircleLoader setOnView:self.view withTitle:@"删除中..." animated:YES];
        
        [self deleteData];
        
    }
    
}

- (void)deleteData {

    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *paeameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId,@"memberID",
                                jxcProID,@"jxcProID",
                                nil];
    
    [httpClient request:@"ErpChanPinDel.ashx" parameters:paeameters success:^(NSJSONSerialization* json){
        
        [GMDCircleLoader hideFromView:self.view animated:YES];
        
    }failure:^(NSError *error){
        
        [GMDCircleLoader hideFromView:self.view animated:YES];
        
    }];
    
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
    
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleDelete;
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [GMDCircleLoader setOnView:self.view withTitle:@"加载中..." animated:YES];

    [self requestProductList];
    
}

- (void)editBtnClick {

    AddProductController *vc = [[AddProductController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.productArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dic = self.productArr[indexPath.row];
    
    ProductCell *cell = [[ProductCell alloc] init];
    
    cell.nameLab.text = dic[@"ProName"];
    
    cell.picImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:dic[@"FengMian"]]]];
    
    cell.inPriceLab.text = [NSString stringWithFormat:@"进价：%@",dic[@"PingJunJinJia"]];
    
    cell.outPriceLab.text = [NSString stringWithFormat:@"售价：%@",dic[@"PingJunXiaoShouJia"]];
    
    cell.countLab.text = [NSString stringWithFormat:@"库存数量：%@",dic[@"KuCunShuLiang"]];
    
    cell.supplierLab.text = [NSString stringWithFormat:@"备注：%@",dic[@"Descript"]];
    
    return cell;
    
}

- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 获取沙盒目录
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    // 将图片写入文件
    [imageData writeToFile:fullPath atomically:NO];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ProductCell *cell = [[ProductCell alloc] init];
    
    return cell.height;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dic = self.productArr[indexPath.row];
    
    EditProductController *vc = [[EditProductController alloc] init];
    
    vc.ProjxcProID = dic[@"JxcProID"];
    
    vc.ProName = dic[@"ProName"];
    
    vc.ProHuoHao = dic[@"HuoHao"];
    
    vc.CategoryID1 = dic[@"CategoryID1"];
    
    vc.CategoryID1Name = dic[@"CategoryID1Name"];
    
    vc.CategoryID2 = dic[@"CategoryID2"];
    
    vc.CategoryID2Name = dic[@"CategoryID2Name"];
    
    vc.CategoryID3 = dic[@"CategoryID3"];
    
    vc.CategoryID3Name = dic[@"CategoryID3Name"];
    
    vc.ProDesc = dic[@"Descript"];
    
    vc.ProFengmian = dic[@"FengMian"];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)requestProductList {

    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *paeameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId,@"memberID",
                                nil];
    
    [httpClient request:@"ErpChanPinList.ashx" parameters:paeameters success:^(NSJSONSerialization* json){
        
        [GMDCircleLoader hideFromView:self.view animated:YES];
        
        NSDictionary *dic = (NSDictionary *)json;
        
        NSArray *trueArr = dic[@"ChanPinModelList"];
        
        if (trueArr.count == 0) {
            
            self.noLabel.hidden = NO;
            
            self.tableView.hidden = YES;

        }else {
            
            self.noLabel.hidden = YES;
            
            self.tableView.hidden = NO;
            
            self.productArr = dic[@"ChanPinModelList"];
            
            [self.tableView reloadData];
        
        }
        
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
