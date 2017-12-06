//
//  ProductViewController.m
//  BusinessCenter
//
//  Created by 冯海强 on 13-11-18.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import "ProductViewController.h"
#import "ProductTableViewController.h"



@interface ProductViewController ()

@end

@implementation ProductViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    //self = [super initWithStyle:style];
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
        self.title = NSLocalizedString(@"微●资源", @"1");
        self.tabBarItem.image = [UIImage imageNamed:@"Wresource.png"];

    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated;
{
    //    self.tabBarController.navigationItem.rightBarButtonItem=nil;
    self.tabBarController.title=self.title;
    
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    PD_WaitArray=[[NSMutableArray alloc]init];
    PD_SellArray=[[NSMutableArray alloc]init];
    PD_SoldoutoroverArray=[[NSMutableArray alloc]init];

    [PD_WaitArray addObject:@"待审核产品"];
    [PD_SellArray  addObject:@"销售中产品"];
    [PD_SoldoutoroverArray  addObject:@"已下架产品"];
    [PD_SoldoutoroverArray  addObject:@"已售完产品"];




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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([[UIDevice currentDevice].systemVersion doubleValue]>=7)
        
    {
        tableView.center=CGPointMake(self.view.center.x, self.view.center.y-34);
        
    }
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    if (section==0)
    {
        return 1;
    }
    if (section==1)
    {
        return 1;
    }
    if (section==2)
    {
        return 2;
    }
    return 0;
 

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...


    
    if (indexPath.section==0)
    {
        cell.textLabel.text=[PD_WaitArray objectAtIndex:indexPath.row];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;

        
    }
    if (indexPath.section==1)
    {
        cell.textLabel.text=[PD_SellArray objectAtIndex:indexPath.row];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;

        
    }
    
    
    if (indexPath.section==2)
    {
        cell.textLabel.text=[PD_SoldoutoroverArray objectAtIndex:indexPath.row];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        //        cell.imageView.image = [UIImage imageNamed:@"强信.png"];
        
    }

    
    
    return cell;
}


//选中CELL
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    int a=1;int b=2;int c=3;int d=4;
    
    if (indexPath.section==0)
    {
        [accountDefaults setInteger:a forKey:@"product"];//销售产品

    }
    if (indexPath.section==1)
    {
        [accountDefaults setInteger:b forKey:@"product"];//
        
    }
    if (indexPath.section==2&&indexPath.row==0)
    {
        [accountDefaults setInteger:c forKey:@"product"];//
        
    }
    if (indexPath.section==2&&indexPath.row==1)
    {
        [accountDefaults setInteger:d forKey:@"product"];//
        
    }
    [[NSUserDefaults standardUserDefaults] synchronize];//立即读取；

    
    
    ProductTableViewController*ProTableVC=[[ProductTableViewController alloc]initWithNibName:@"ProductTableViewController" bundle:nil];
    
    [self .navigationController pushViewController:ProTableVC animated:YES];
    
    
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
