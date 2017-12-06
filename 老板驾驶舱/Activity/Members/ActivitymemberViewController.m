//
//  ActivitymemberViewController.m
//  BusinessCenter
//
//  Created by 冯海强 on 13-11-28.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import "ActivitymemberViewController.h"
#import "ActivitymemberCell.h"

#import "SVProgressHUD.h"
#import "ActMemberData.h"
#import "HttpClientRequest.h"
@interface ActivitymemberViewController ()

@end

@implementation ActivitymemberViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    pageIndex=1;
    
    [self.B_ListTable setDelegate:self];
    [self.B_ListTable setDataSource:self];
    [self.B_ListTable setPullDelegate:self];
    self.B_ListTable.pullBackgroundColor = [UIColor whiteColor];
    self.B_ListTable.useRefreshView = YES;
    self.B_ListTable.useLoadingMoreView= YES;

    self.title=@"活动成员";
    self.memberarray=[[NSMutableArray alloc]initWithCapacity:0];
    self.tableView.hidden=YES;

    [self getDataFromServer];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getDataFromServer
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
    NSString*pagde=[[NSNumber numberWithInt:pageIndex] stringValue];

    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId, @"memberId",
                           [NSString stringWithFormat:@"%@",self.activitydata.ActivityId],@"activityId",
                           pagde,@"pageIndex",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中..."];
    
    [httpClient request:@"ActivityMember.ashx" parameters:param successed:^(JSONDecoder *jsonDecoder, id responseObject) {
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [jsonDecoder objectWithData:data];
        
        MemberData *keyData = [[MemberData alloc]initWithJsonObject:handlJson];
        
        BOOL success = [keyData.status boolValue];
  
    if (success)
    {
        [SVProgressHUD dismiss];
        
        if (pageIndex == 1)
        {
            if (keyData.ActMemberList== nil ||keyData.ActMemberList.count==0)
            {
                [self.memberarray removeAllObjects];
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
                [self.tableView addSubview:label];
                return;
            }
            else
            {
                [self.memberarray addObjectsFromArray:keyData.ActMemberList];
            }
        }
        else
        {
            if (keyData.ActMemberList == nil ||keyData.ActMemberList.count== 0)
            {
                pageIndex--;
            }
            else
            {
                [self.memberarray addObjectsFromArray:keyData.ActMemberList];
            }
        }
        
        [self.B_ListTable reloadData];
        self.B_ListTable.hidden = NO;
    }
    else
    {
        if (pageIndex > 1)
        {
            pageIndex--;
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
    
    if (pageIndex > 1)
    {
        pageIndex--;
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
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.memberarray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 52;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    ActivitymemberCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray*cellarray=[[NSBundle mainBundle]
                           loadNibNamed:@"ActivitymemberCell" owner:self options:nil];
        cell =[cellarray objectAtIndex:0];
    }
    
    
    if (self.memberarray.count!=0)
    {
        MemberDetailData *data = [self.memberarray objectAtIndex:indexPath.row];
        cell.Amembernamelab.text=data.NickName;
        NSString *fensi=[NSString stringWithFormat:@"粉丝:%@",data.FenSi];
        NSString *guanzhu=[NSString stringWithFormat:@" 关注:%@",data.GuanZhu];
        NSString *fenxiang=[NSString stringWithFormat:@" 分享:%@",data.FenXiang];
        cell.Amembersharelab.text=[NSString stringWithFormat:@"%@%@%@",fensi,guanzhu,fenxiang];
        
        
        UIImage *reSizeImage = [self.imagechage getImage:data.PhotoHead];
        
        if (reSizeImage != nil)
        {
            cell.Amemberimage.image=reSizeImage;
            
        }
        // 图片加载
        
        [cell.Amemberimage setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",data.PhotoHead]]] placeholderImage:[UIImage imageNamed:@""] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            
            cell.Amemberimage.image=[CommonUtil scaleImage:image toSize:CGSizeMake(60, 50)];
            
            [self.imagechage addImage:reSizeImage andUrl:data.PhotoHead];
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        }];

        
        
        

    }
    
    
    
    // Configure the cell...
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



- (void)pullTableViewDidTriggerRefresh:(PullTableView*)pullTableView {
    
    pageIndex=1;
    [self.memberarray removeAllObjects];
    [self performSelector:@selector(getDataFromServer) withObject:nil];
    
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView*)pullTableView {
    
    pageIndex++;
    [self performSelector:@selector(getDataFromServer) withObject:nil];
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];

    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
 
 */

@end
