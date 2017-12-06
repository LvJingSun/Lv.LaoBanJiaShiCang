//
//  HuiViewController.m
//  BusinessCenter
//
//  Created by 冯海强 on 14-2-13.
//  Copyright (c) 2014年 冯海强. All rights reserved.
//

#import "HuiViewController.h"
#import "ColourViewController.h"

@interface HuiViewController ()

@end

@implementation HuiViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title=@"诲诲设置";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
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
        tableView.contentInset = UIEdgeInsetsMake(-35, 0, 0, 0);
    }
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //#warning Incomplete method implementation.

    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 50;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%d%d", [indexPath section], [indexPath row]];//以indexPath来唯一确定cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier]; //出列可重用的cell
    
    if (cell == nil) {

        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        
    }
    
    if (indexPath.section==0)
    {
        cell.textLabel.text=@"风格色彩";
    }
    else if (indexPath.section==1)
    {
        cell.textLabel.text=@"APP引导页";
    }
    
 
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section==0)
    {
        ColourViewController *colourVC=[[ColourViewController alloc]initWithNibName:@"ColourViewController" bundle:nil];
        [self.navigationController pushViewController:colourVC animated:YES];
    }
    else if (indexPath.section==1)
    {
        
    }
    
    
}



@end
