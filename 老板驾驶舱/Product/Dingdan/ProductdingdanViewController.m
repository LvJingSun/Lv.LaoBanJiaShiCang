//
//  ProductdingdanViewController.m
//  BusinessCenter
//
//  Created by 冯海强 on 13-11-28.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import "ProductdingdanViewController.h"
#import "ProductdingdanCell.h"
#import "DingdandetailViewController.h"

#import "SVProgressHUD.h"
#import "DingdangData.h"
#import "HttpClientRequest.h"

@interface ProductdingdanViewController ()

@property (weak, nonatomic) IBOutlet UIButton *btnNO;
@property (weak, nonatomic) IBOutlet UIButton *btnYES;

@end

@implementation ProductdingdanViewController
@synthesize label;

//@synthesize Dingdangarray;
@synthesize DingdangarrayNO;
@synthesize DingdangarrayYES;


//- (id)initWithStyle:(UITableViewStyle)style
//{
//    self = [super initWithStyle:style];
//    if (self) {
//        // Custom initialization
//        
//    }
//    return self;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title=@"产品订单";
    
//    Dingdangarray=[[NSMutableArray alloc]initWithCapacity:0];
    DingdangarrayNO = [[NSMutableArray alloc]initWithCapacity:0];
    DingdangarrayYES = [[NSMutableArray alloc]initWithCapacity:0];
    
    self.tableView.hidden=YES;

    self.itemType = @"NO";
    self.btnNO.userInteractionEnabled = NO;
    self.btnYES.userInteractionEnabled = YES;
    [self.btnNO setBackgroundImage:[UIImage imageNamed:@"comm_tabar_selected.png"] forState:UIControlStateNormal];
    

    self.tableView.hidden = NO;
    label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0,320,[ UIScreen mainScreen ].bounds.size.height)];
    label.backgroundColor=[UIColor clearColor];
    label.textAlignment=NSTextAlignmentCenter;
    label.text=@"暂无数据";
    label.font = [UIFont boldSystemFontOfSize:20];
    label.textColor=[UIColor darkGrayColor];
    [self.view addSubview:label];
    
    
    [self getDataFromServer];
    

}

-(IBAction)changeType:(UIButton*)sender {
    [self.btnNO setBackgroundImage:[UIImage imageNamed:@"comm_tabar_def.png"] forState:UIControlStateNormal];
    [self.btnNO setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btnYES setBackgroundImage:[UIImage imageNamed:@"comm_tabar_def.png"] forState:UIControlStateNormal];
    [self.btnYES setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    if (sender == self.btnNO) {
        
        self.btnNO.userInteractionEnabled = NO;
        self.btnYES.userInteractionEnabled = YES;
        
        [self.btnNO setBackgroundImage:[UIImage imageNamed:@"comm_tabar_selected.png"] forState:UIControlStateNormal];
        self.itemType = @"NO";
        [self.tableView reloadData];
    }
    if (sender == self.btnYES) {
        
        self.btnNO.userInteractionEnabled = YES;
        self.btnYES.userInteractionEnabled = NO;
        
        [self.btnYES setBackgroundImage:[UIImage imageNamed:@"comm_tabar_selected.png"] forState:UIControlStateNormal];
        self.itemType = @"YES";
        [self.tableView reloadData];
    }
    

}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)getDataFromServer;
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

    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId, @"memberId",
                           [NSString stringWithFormat:@"%@",self.DingdanData.ServiceId],@"serviceId",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中..."];
    
    [httpClient request:@"ProductOrdersList.ashx" parameters:param successed:^(JSONDecoder *jsonDecoder, id responseObject) {
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [jsonDecoder objectWithData:data];
        
        DingdangData *keyData = [[DingdangData alloc]initWithJsonObject:handlJson];
        
        BOOL success = [keyData.status boolValue];
        
        if (success)
        {
            [SVProgressHUD dismiss];

            if (keyData.PrOrderList.count==0)
            {
                [SVProgressHUD showErrorWithStatus:@"暂无数据"];
                
                self.tableView.hidden = YES;
                label.hidden= NO;
                
                return ;
            }
            else
            {
                self.tableView.hidden = NO;
                label.hidden = YES;
                for ( int i=0; i<keyData.PrOrderList.count; i++) {
                    
                    DingdangDetailData *data = [keyData.PrOrderList objectAtIndex:i];
                    
                    if ([data.UseDescript isEqualToString:@"已用完"])
                    {
                        [DingdangarrayYES addObject:data];
                        
                    }
                    else if ([data.UseDescript isEqualToString:@"未使用"])
                    {
                        [DingdangarrayNO addObject:data];
                        
                    }
                    
                }
                
            }
            if (self.DingdangarrayNO.count!=0)
            {
                self.tableView.hidden=NO;
            }

            
            [self.tableView reloadData];
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:keyData.msg];
        }
        
    } failured:^(NSError *error) {
        
        NSLog(@"error:%@",error.description);
        [SVProgressHUD showErrorWithStatus:error.description];
        
    }];
 
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{


    if ([self.itemType isEqualToString:@"NO"])
    {
         if (self.DingdangarrayNO.count==0)
        {
            self.tableView.hidden = YES;
            label.hidden= NO;
        }else
        {
            self.tableView.hidden = NO;
            label.hidden= YES;
        }
        return self.DingdangarrayNO.count;
    }
    else if ([self.itemType isEqualToString:@"YES"])
    {
         if (self.DingdangarrayYES.count==0)
        {
            self.tableView.hidden = YES;
            label.hidden= NO;
        }
         else
         {
             self.tableView.hidden = NO;
             label.hidden= YES;
         }
        return self.DingdangarrayYES.count;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    ProductdingdanCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray*cellarray=[[NSBundle mainBundle]
                           loadNibNamed:@"ProductdingdanCell" owner:self options:nil];
        cell =[cellarray objectAtIndex:0];
    }
    if ([self.itemType isEqualToString:@"NO"])
    {
        if ( self.DingdangarrayNO.count != 0 )
        {
            
            DingdangDetailData *data = [self.DingdangarrayNO objectAtIndex:indexPath.row];
            cell.PDDnamelab.text=data.NickName;
            cell.PDDusedlab.text=data.UseDescript;

            cell.PDDtimelab.text=data.OrdersCode;
            
        }

    }
    else if ([self.itemType isEqualToString:@"YES"])
    {
        if ( self.DingdangarrayYES.count != 0 )
        {
            
            DingdangDetailData *data = [self.DingdangarrayYES objectAtIndex:indexPath.row];
            cell.PDDnamelab.text=data.NickName;
            cell.PDDusedlab.text=data.UseDescript;
            
            cell.PDDusedlab.textColor=[UIColor redColor];
            
            cell.PDDtimelab.text=data.OrdersCode;
            
        }

    }
    
 
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    DingdandetailViewController * VC = [[DingdandetailViewController alloc]initWithNibName:@"DingdandetailViewController" bundle:nil];
    if ([self.itemType isEqualToString:@"NO"])
    {
        DingdangDetailData *data = [self.DingdangarrayNO objectAtIndex:indexPath.row];
        VC.Dingdandetail =data;
  
    }
    else if ([self.itemType isEqualToString:@"YES"])
    {

        DingdangDetailData *data = [self.DingdangarrayYES objectAtIndex:indexPath.row];
        VC.Dingdandetail =data;
        
    }
    [self.navigationController pushViewController:VC animated:YES];

    
}




@end
