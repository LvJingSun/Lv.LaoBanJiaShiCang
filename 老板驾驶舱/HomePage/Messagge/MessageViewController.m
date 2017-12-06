//
//  MessageViewController.m
//  BusinessCenter
//
//  Created by 冯海强 on 13-11-19.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageCell.h"

#import "SVProgressHUD.h"
#import "xitongxiaoxiData.h"
#import "HttpClientRequest.h"

@interface MessageViewController ()

@end

@implementation MessageViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.sixingarray = [[NSMutableArray alloc]initWithCapacity:0];

        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.B_ListTable.hidden=YES;
    
    [self.B_ListTable setDelegate:self];
    [self.B_ListTable setDataSource:self];
    [self.B_ListTable setPullDelegate:self];
    self.B_ListTable.pullBackgroundColor = [UIColor whiteColor];
    self.B_ListTable.useRefreshView = YES;
    self.B_ListTable.useLoadingMoreView= YES;

    M_pageIndex=1;

    self.title=@"私信";
    
    [self getDataFromSeverRemind];
    
    
    if ( isIOS7 ) {
        
        // tableView的线往右移了，添加这代码可以填充
        if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        }

    }
    
   

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)getDataFromSeverRemind
{
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    NSString*memberId=[userDefau objectForKey:@"memberId"];
    
    MainViewController*mainVC=[MainViewController shareobject];
    // 判断网络是否存在
    if ( ![mainVC isConnectionAvailable] )
    {
        
        return;
    }
    
    M_searchType=@"3";

    HttpClientRequest *httpClient = [HttpClientRequest sharedInstance];
    
    NSString*pagde=[[NSNumber numberWithInt:M_pageIndex] stringValue];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId, @"memberId",
                           pagde,@"pageIndex",
                           M_searchType,@"searchType",
                           nil];
    
    
    [SVProgressHUD showWithStatus:@"数据加载中..."];
    
    [httpClient request:@"MerchantMessageList.ashx" parameters:param successed:^(JSONDecoder *jsonDecoder, id responseObject) {
        
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [jsonDecoder objectWithData:data];
        
        xitongxiaoxiData *keyData = [[xitongxiaoxiData alloc]initWithJsonObject:handlJson];
        
        BOOL success = [keyData.status boolValue];

        if (success)
        {
            [SVProgressHUD dismiss];
            
            if (M_pageIndex == 1)
            {
                if (keyData.MerchantMessageList == nil || keyData.MerchantMessageList.count==0)
                {
                    [self.sixingarray removeAllObjects];
                    self.B_ListTable.hidden = YES;
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
                    [self.sixingarray addObjectsFromArray: keyData.MerchantMessageList];
                }
            }
            else
            {
                if (keyData.MerchantMessageList == nil || keyData.MerchantMessageList.count == 0)
                {
                    M_pageIndex--;
                }
                else
                {
                    [self.sixingarray addObjectsFromArray:keyData.MerchantMessageList];
                }
            }
            
            [self.B_ListTable reloadData];
            self.B_ListTable.hidden = NO;
        }
        else
        {
            if (M_pageIndex > 1)
            {
                M_pageIndex--;
            }
            NSString *msg = keyData.msg;
            [SVProgressHUD showErrorWithStatus:msg];
        }
        self.B_ListTable.pullLastRefreshDate = [NSDate date];
        self.B_ListTable.pullTableIsRefreshing = NO;
        self.B_ListTable.pullTableIsLoadingMore = NO;
        
        
    } failured:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:error.description];
        
        if (M_pageIndex > 1)
        {
            M_pageIndex--;
        }
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        self.B_ListTable.pullTableIsRefreshing = NO;
        self.B_ListTable.pullTableIsLoadingMore = NO;
        
    }];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.sixingarray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    xitongxiaoxiDetailData *data = [self.sixingarray objectAtIndex:indexPath.row];
    NSString*str=[NSString stringWithFormat:@"%@",data.MsgCot];
    
    CGSize size = [str sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(300, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
    
    return 28 + size.height + 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray*cellarray=[[NSBundle mainBundle]
                           loadNibNamed:@"MessageCell" owner:self options:nil];
        cell =[cellarray objectAtIndex:0];
        
        // 设置cell的点击状态
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (self.sixingarray.count!=0)
    {
        xitongxiaoxiDetailData *data = [self.sixingarray objectAtIndex:indexPath.row];
        
        cell.Message_titlelabel.text=[NSString stringWithFormat:@"%@:",data.NickName];
        
        NSString *str=[NSString stringWithFormat:@"%@",data.MsgCot];
        
        cell.Message_contenttextview.text=str;
        cell.Message_contenttextview.numberOfLines = 0;

        CGSize size = [cell.Message_contenttextview.text sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(300, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        
        cell.Message_contenttextview.frame = CGRectMake(cell.Message_contenttextview.frame.origin.x, cell.Message_contenttextview.frame.origin.y, 300, size.height);
        
         cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cell.frame.size.width, 28 + size.height + 5);
        
        
        cell.Message_timelabel.text=data.CreateDate;
        
    }
    
    // Configure the cell...
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
 
        return @"删除";
    
}

//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//
//    if (editingStyle == UITableViewCellEditingStyleDelete)
//    {
//        if (tableView == self.searchDisplayController.searchResultsTableView)
//            
//        {
//            
//            [self shanchu];
//            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//            //           return;
//        }
//        
//    }
//    [self.tableView reloadData];
//        
//    
//    
//}

///删除函数；；；；；；；；
-(void)shanchu
{
    
    
    
}





#pragma mark - PullTableViewDelegate

- (void)pullTableViewDidTriggerRefresh:(PullTableView*)pullTableView {
    
    M_pageIndex=1;
    [self.sixingarray removeAllObjects];
    [self performSelector:@selector(getDataFromSeverRemind) withObject:nil];
    
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView*)pullTableView {
    
    M_pageIndex++;
    
    [self performSelector:@selector(getDataFromSeverRemind) withObject:nil];
    
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
