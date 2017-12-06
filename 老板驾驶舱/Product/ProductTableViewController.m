//
//  ProductTableViewController.m
//  BusinessCenter
//
//  Created by 冯海强 on 13-11-18.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import "ProductTableViewController.h"
#import "ProductTableCell.h"
#import "ProductdetailsViewController.h"

#import "SVProgressHUD.h"
#import "ProductData.h"
#import "HttpClientRequest.h"


@interface ProductTableViewController ()

@property (weak, nonatomic) IBOutlet UIButton *btnxiaoshou;
@property (weak, nonatomic) IBOutlet UIButton *btnfanli;
@property (weak, nonatomic) IBOutlet UIButton *btnxiajia;

@property (weak, nonatomic) IBOutlet UIView *btnview;


@end


int productNumTime;//全局的改变数量和时间的名称；


@implementation ProductTableViewController


//- (id)initWithStyle:(UITableViewStyle)style
//{
//    self = [super initWithStyle:style];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.productarray=[[NSMutableArray alloc]initWithCapacity:0];
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.B_ListTable setPullDelegate:self];
    self.B_ListTable.pullBackgroundColor = [UIColor whiteColor];
    self.B_ListTable.useRefreshView = YES;
    self.B_ListTable.useLoadingMoreView= YES;

    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"Product.ID"];

    P_pageIndex=1;
    self.B_ListTable.hidden=YES;
    
    self.itemType = @"Soldout";//销售数量
    self.btnxiaoshou.userInteractionEnabled = NO;
    self.btnfanli.userInteractionEnabled = YES;
    self.btnxiajia.userInteractionEnabled = YES;
    [self.btnxiaoshou setBackgroundImage:[UIImage imageNamed:@"comm_tabar_selected.png"] forState:UIControlStateNormal];
    
    NSUserDefaults*product=[NSUserDefaults standardUserDefaults];
    NSString *str = [NSString stringWithFormat:@"%@",[product objectForKey:@"product"]];
    if (str.intValue==1)
    {
        self.title=@"待审核产品";
        P_searchType=1;
        productNumTime=1;
        
        self.btnview.hidden = YES;
        
        if (iPhone5) {

            self.B_ListTable.frame = CGRectMake(0, 0, viewsize.size.width, viewsize.size.height - 68);

        }else
        {
        
        self.B_ListTable.frame = CGRectMake(0, 0, viewsize.size.width, viewsize.size.height + 20);
        }
        
        
        
        
        [self getDataFromSever];


    }
    else if (str.intValue==2)
    {
        self.title=@"销售中产品";
        P_searchType=2;

        productNumTime=2;
        
        if ([self.itemType isEqualToString:@"ShelfTime"]) {
            [self getDataFromSever:self.itemType second:@"0"];
        }else
        {
            [self getDataFromSever:self.itemType second:@"1"];
        }

    }
   else if (str.intValue==3)
    {
        self.title=@"已下架产品";
        P_searchType=3;

        productNumTime=3;
        
        if ([self.itemType isEqualToString:@"ShelfTime"]) {
            [self getDataFromSever:self.itemType second:@"0"];
        }else
        {
            [self getDataFromSever:self.itemType second:@"1"];
        }
    }
   else if (str.intValue==4)
    {
        self.title=@"已售完产品";
        P_searchType=4;

        productNumTime=4;
        
        if ([self.itemType isEqualToString:@"ShelfTime"]) {
            [self getDataFromSever:self.itemType second:@"0"];
        }else
        {
            [self getDataFromSever:self.itemType second:@"1"];
        }
    }

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"Product.ID"]!=nil)
    {
        self.productarray=[[NSMutableArray alloc]initWithCapacity:0];

        P_pageIndex=1;
        
        if ([self.title isEqualToString:@"待审核产品"]) {
            [self getDataFromSever];

        }else
        {
            if ([self.itemType isEqualToString:@"ShelfTime"]) {
                [self getDataFromSever:self.itemType second:@"0"];
            }else
            {
                [self getDataFromSever:self.itemType second:@"1"];
            }
        }
        
    }
   
 
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"Product.ID"];

}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)changeType:(UIButton*)sender {
    
    P_pageIndex=1;
    [self.productarray removeAllObjects];
    
    [self.btnxiaoshou setBackgroundImage:[UIImage imageNamed:@"comm_tabar_def.png"] forState:UIControlStateNormal];
    [self.btnxiaoshou setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btnfanli setBackgroundImage:[UIImage imageNamed:@"comm_tabar_def.png"] forState:UIControlStateNormal];
    [self.btnfanli setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btnxiajia setBackgroundImage:[UIImage imageNamed:@"comm_tabar_def.png"] forState:UIControlStateNormal];
    [self.btnxiajia setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    if (sender == self.btnxiaoshou) {
        
        self.B_ListTable.hidden = YES;
        self.btnxiaoshou.userInteractionEnabled = NO;
        self.btnfanli.userInteractionEnabled = YES;
        self.btnxiajia.userInteractionEnabled = YES;

        [self.btnxiaoshou setBackgroundImage:[UIImage imageNamed:@"comm_tabar_selected.png"] forState:UIControlStateNormal];
        self.itemType = @"Soldout";
        [self getDataFromSever:self.itemType second:@"1"];
        
    }
    if (sender == self.btnfanli) {
        
        self.B_ListTable.hidden = YES;

        self.btnxiaoshou.userInteractionEnabled = YES;
        self.btnfanli.userInteractionEnabled = NO;
        self.btnxiajia.userInteractionEnabled = YES;

        [self.btnfanli setBackgroundImage:[UIImage imageNamed:@"comm_tabar_selected.png"] forState:UIControlStateNormal];
        self.itemType = @"CommissionRate";
        [self getDataFromSever:self.itemType second:@"1"];
    }
    if (sender == self.btnxiajia) {
        
        self.B_ListTable.hidden = YES;
        
        self.btnxiaoshou.userInteractionEnabled = YES;
        self.btnfanli.userInteractionEnabled = YES;
        self.btnxiajia.userInteractionEnabled = NO;
        
        [self.btnxiajia setBackgroundImage:[UIImage imageNamed:@"comm_tabar_selected.png"] forState:UIControlStateNormal];
        self.itemType = @"ShelfTime";
        [self getDataFromSever:self.itemType second:@"0"];
        
    }
    
    
}


//通过排序后的接口
-(void)getDataFromSever:(NSString* )sortFiled second:(NSString *)sort;
{
    MainViewController*mainVC=[MainViewController shareobject];
    // 判断网络是否存在
    if ( ![mainVC isConnectionAvailable] )
    {
        return;
    }
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    NSString*memberId=[userDefau objectForKey:@"memberId"];
    
    HttpClientRequest *httpClient = [HttpClientRequest sharedInstance];
    NSString*pagde=[[NSNumber numberWithInt:P_pageIndex] stringValue];
    NSString*search=[[NSNumber numberWithInt:P_searchType] stringValue];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId, @"memberId",
                           pagde,@"pageIndex",
                           search,@"searchType",
                           sortFiled,@"sortFiled",
                           sort,@"sort",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中..."];
    
    NSLog(@"%@",param);
    
    [httpClient request:@"ProductsList_1_0.ashx" parameters:param successed:^(JSONDecoder *jsonDecoder, id responseObject) {
        
        NSData* data = [NSData dataWithData:responseObject];
        NSDictionary* handlJson = [jsonDecoder objectWithData:data];
        ProductData*keyData = [[ProductData alloc]initWithJsonObject:handlJson];
        BOOL success = [keyData.status boolValue];
        if (success)
        {
            [SVProgressHUD dismiss];
            
            if (P_pageIndex == 1)
            {
                if (keyData.ProductsList == nil || keyData.ProductsList.count==0)
                {
                    [self.productarray removeAllObjects];
                    [SVProgressHUD showErrorWithStatus:@"暂无数据"];
                    
                    self.B_ListTable.hidden = NO;
                    self.B_ListTable.scrollEnabled = NO;
                    [self.B_ListTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
                    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0,320,[ UIScreen mainScreen ].bounds.size.height)];
                    label.backgroundColor=[UIColor whiteColor];
                    label.textAlignment=NSTextAlignmentCenter;
                    label.text=@"暂无数据";
                    label.font = [UIFont boldSystemFontOfSize:20];
                    label.textColor=[UIColor darkGrayColor];
                    [self.B_ListTable addSubview:label];
                    return;
                }
                else
                {
                    
                    [self.productarray addObjectsFromArray:keyData.ProductsList];
                    
                }
            }
            else
            {
                if (keyData.ProductsList == nil ||keyData.ProductsList.count == 0)
                {
                    P_pageIndex--;
                }
                else
                {
                    [self.productarray addObjectsFromArray:keyData.ProductsList];
                }
            }
            self.B_ListTable.hidden = NO;

            [self.B_ListTable reloadData];
        }
        else
        {
            if (P_pageIndex > 1)
            {
                P_pageIndex--;
            }
            NSString *msg = keyData.msg;
            [SVProgressHUD showErrorWithStatus:msg];
        }
        self.B_ListTable.pullLastRefreshDate = [NSDate date];
        self.B_ListTable.pullTableIsRefreshing = NO;
        self.B_ListTable.pullTableIsLoadingMore = NO;
        
        
    } failured:^(NSError *error) {
        
        NSLog(@"error:%@",error.description);
        
        [SVProgressHUD showErrorWithStatus:error.description];
        
        if (P_pageIndex > 1)
        {
            P_pageIndex--;
        }
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        //self.tableView.pullLastRefreshDate = [NSDate date];
        self.B_ListTable.pullTableIsRefreshing = NO;
        self.B_ListTable.pullTableIsLoadingMore = NO;
        
    }];
    
    
}


//待审核状态下调接口
-(void)getDataFromSever
{
    MainViewController*mainVC=[MainViewController shareobject];
    // 判断网络是否存在
    if ( ![mainVC isConnectionAvailable] )
    {
        return;
    }
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    NSString*memberId=[userDefau objectForKey:@"memberId"];
    
    HttpClientRequest *httpClient = [HttpClientRequest sharedInstance];
    
    
    NSString*pagde=[[NSNumber numberWithInt:P_pageIndex] stringValue];
    NSString*search=[[NSNumber numberWithInt:P_searchType] stringValue];
    NSLog(@"%@",search);


    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId, @"memberId",
                           pagde,@"pageIndex",
                           search,@"searchType",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中..."];
    
    [httpClient request:@"ProductsList.ashx" parameters:param successed:^(JSONDecoder *jsonDecoder, id responseObject) {
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [jsonDecoder objectWithData:data];
        
        ProductData*keyData = [[ProductData alloc]initWithJsonObject:handlJson];
        
        
        BOOL success = [keyData.status boolValue];
        

    if (success)
    {
        [SVProgressHUD dismiss];
        
        if (P_pageIndex == 1)
        {
            if (keyData.ProductsList == nil || keyData.ProductsList.count==0)
            {
                [self.productarray removeAllObjects];
                [SVProgressHUD showErrorWithStatus:@"暂无数据"];
                
                self.B_ListTable.hidden = NO;
                self.B_ListTable.scrollEnabled = NO;
                [self.B_ListTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
                UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0,320,[ UIScreen mainScreen ].bounds.size.height)];
                label.backgroundColor=[UIColor whiteColor];
                label.textAlignment=NSTextAlignmentCenter;
                label.text=@"暂无数据";
                label.font = [UIFont boldSystemFontOfSize:20];
                label.textColor=[UIColor darkGrayColor];
                [self.B_ListTable addSubview:label];
                return;
            }
            else
            {
                [self.productarray addObjectsFromArray:keyData.ProductsList];

            }
        }
        else
        {
            if (keyData.ProductsList == nil ||keyData.ProductsList.count == 0)
            {
                P_pageIndex--;
            }
            else
            {
                [self.productarray addObjectsFromArray:keyData.ProductsList];
            }
        }
        
        [self.B_ListTable reloadData];
        self.B_ListTable.hidden = NO;
    }
    else
    {
        if (P_pageIndex > 1)
        {
            P_pageIndex--;
        }
        NSString *msg = keyData.msg;
        [SVProgressHUD showErrorWithStatus:msg];
    }
    self.B_ListTable.pullLastRefreshDate = [NSDate date];
    self.B_ListTable.pullTableIsRefreshing = NO;
    self.B_ListTable.pullTableIsLoadingMore = NO;
    
    
} failured:^(NSError *error) {
    
    NSLog(@"error:%@",error.description);
    
    [SVProgressHUD showErrorWithStatus:error.description];
    
    if (P_pageIndex > 1)
    {
        P_pageIndex--;
    }
    //NSLog(@"failed:%@", error);
    [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    //self.tableView.pullLastRefreshDate = [NSDate date];
    self.B_ListTable.pullTableIsRefreshing = NO;
    self.B_ListTable.pullTableIsLoadingMore = NO;
    
}];


}





#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.productarray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    ProductTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray*cellarray=[[NSBundle mainBundle]
                           loadNibNamed:@"ProductTableCell" owner:self options:nil];
        cell =[cellarray objectAtIndex:0];
        
    }

    if (productNumTime==2)
    {
    cell.Product_NumLablename.text=@"已售数量:";
    cell.Product_TimeLablename.text=@"下架时间:";
    }
    else if (productNumTime==3)
    {
        cell.Product_NumLablename.text=@"已售数量:";
        cell.Product_TimeLablename.text=@"下架时间:";
    }
    else if (productNumTime==4)
    {
        cell.Product_NumLablename.text=@"已售数量:";
        cell.Product_TimeLablename.text=@"下架时间:";
    }
    
        if ( self.productarray.count != 0 )
   {

       ProductDetailData *data = [self.productarray objectAtIndex:indexPath.row];
       self.photoarray=[[NSMutableArray alloc]initWithCapacity:0];
       [self.photoarray addObjectsFromArray:data.ProductPostersList];
       

       
       for (int i=0; i<self.photoarray.count; i++)
       {
           ProductPhontoData *photoData = [self.photoarray objectAtIndex:i];
           
           if ([[NSString stringWithFormat:@"%@",photoData.IsFrontCover] isEqualToString:@"1"])
           {
               UIImage *reSizeImage = [self.imagechage getImage:photoData.SmlPoster];
               
               if (reSizeImage != nil)
               {
                   cell.Product_photoImage.image=reSizeImage;
                   
               }
               // 图片加载
               
               [cell.Product_photoImage setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",photoData.SmlPoster]]] placeholderImage:[UIImage imageNamed:@""] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                   
                cell.Product_photoImage.image = [CommonUtil scaleImage:image toSize:CGSizeMake(74, 60)];
                   
                 [self.imagechage addImage:reSizeImage andUrl:photoData.SmlPoster];
                   
               } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                   
               }];
           }
           
       }
       
       cell.Product_NameTitleLable.text=data.SvcName;
       if ([self.title isEqualToString:@"待审核产品"]) {
           cell.Product_TimeLable.text=data.CreateDate;
       }else{
        cell.Product_TimeLable.text=data.ShelfTime;
       }
       cell.Product_NewMoneylabel.text=[NSString stringWithFormat:@"￥%@",data.Price];
        cell.Porduct_OldMoneyLable.text=[NSString stringWithFormat:@"￥%@",data.OriginalPrice];
       float pri=data.Price.floatValue*data.Commissionrate.floatValue/100;
        cell.Porduct_PerMoneyLable.text=[NSString stringWithFormat:@"%@%@%@%0.2f%@",data.Commissionrate,@"%",@"(",pri,@"元)"];

       if (productNumTime==1)
       {
           cell.Product_NumLable.text=[NSString stringWithFormat:@"%@",data.Quantity];
       }else
       {
           cell.Product_NumLable.text=[NSString stringWithFormat:@"%@/%@",data.SvcSoldAmount,data.Quantity];
       }

    }

    // Configure the cell...
    
    return cell;
}


//选中CELL
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

    ProductdetailsViewController*ProdetailsTableVC=[[ProductdetailsViewController alloc]initWithNibName:@"ProductdetailsViewController" bundle:nil];
    
    ProductDetailData *data = [self.productarray objectAtIndex:indexPath.row];
    ProdetailsTableVC.productdetail=data;
    ProdetailsTableVC.produtctphotoarray =[[NSMutableArray alloc]initWithCapacity:0];
    [ProdetailsTableVC.produtctphotoarray addObjectsFromArray:data.ProductPostersList];
    
    [self .navigationController pushViewController:ProdetailsTableVC animated:YES];
    
}


- (void)pullTableViewDidTriggerRefresh:(PullTableView*)pullTableView {
    
    P_pageIndex=1;
    
    [self.productarray removeAllObjects];
    
    
    if ([self.title isEqualToString:@"待审核产品"]) {
        
        [self performSelector:@selector(getDataFromSever) withObject:nil];
        
    }else
    {
        if ([self.itemType isEqualToString:@"ShelfTime"]) {
            [self getDataFromSever:self.itemType second:@"0"];
        }else
        {
            [self getDataFromSever:self.itemType second:@"1"];
        }
    }
    
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView*)pullTableView {
    
    P_pageIndex++;
    
    if ([self.title isEqualToString:@"待审核产品"]) {
        
        [self performSelector:@selector(getDataFromSever) withObject:nil];
        
    }else
    {
        if ([self.itemType isEqualToString:@"ShelfTime"]) {
            [self getDataFromSever:self.itemType second:@"0"];
        }else
        {
            [self getDataFromSever:self.itemType second:@"1"];
        }
        
    }
}



@end
