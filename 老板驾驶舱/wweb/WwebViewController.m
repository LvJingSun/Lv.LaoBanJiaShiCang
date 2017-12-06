//
//  WwebViewController.m
//  BusinessCenter
//
//  Created by 冯海强 on 14-2-10.
//  Copyright (c) 2014年 冯海强. All rights reserved.
//

#import "WwebViewController.h"
#import "WIPTableViewController.h"

@interface WwebViewController ()

@end

@implementation WwebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        AdvertisementArray=[[NSMutableArray alloc]initWithCapacity:0];
        InformationArray=[[NSMutableArray alloc]initWithCapacity:0];
        PhotoArray=[[NSMutableArray alloc]initWithCapacity:0];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if ([self.Type isEqualToString:@"1"])
    {
        [AdvertisementArray addObject:@"待审核广告"];
        [AdvertisementArray addObject:@"已通过广告"];
        [AdvertisementArray addObject:@"已退回广告"];
        [AdvertisementArray addObject:@"已违规广告"];
        self.title=@"我的微广告";
        
    }else if ([self.Type isEqualToString:@"2"])
    {
        [InformationArray addObject:@"待审核资讯"];
        [InformationArray addObject:@"已通过资讯"];
        [InformationArray addObject:@"已退回资讯"];
        [InformationArray addObject:@"已违规资讯"];
        self.title=@"我的微资讯";

    }else if ([self.Type isEqualToString:@"3"])
    {
        [PhotoArray addObject:@"待审核相册"];
        [PhotoArray addObject:@"已通过相册"];
        [PhotoArray addObject:@"已退回相册"];
        [PhotoArray addObject:@"已违规相册"];
        self.title=@"我的微相册";
    }


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
    //ios7下cell上第一区域离导航距离

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
    else if (section==1)
    {
        return 1;
    }
    else if (section==2)
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
    //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;

    }

    if ([self.Type isEqualToString:@"1"])
    {
        cell.textLabel.text=[AdvertisementArray objectAtIndex:indexPath.row+indexPath.section];
        
    }else if ([self.Type isEqualToString:@"2"])
    {
        cell.textLabel.text=[InformationArray objectAtIndex:indexPath.row+indexPath.section];
        
    }else if ([self.Type isEqualToString:@"3"])
    {
        cell.textLabel.text=[PhotoArray objectAtIndex:indexPath.row+indexPath.section];
    }
    
    return cell;
}



//选中CELL
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    WIPTableViewController*WIPTableVC=[[WIPTableViewController alloc]initWithNibName:@"WIPTableViewController" bundle:nil];
    
    if ([self.Type isEqualToString:@"1"])
    {
        if (indexPath.section==0)
        {
           WIPTableVC.WIPTabelType=@"10";
        }
        else if (indexPath.section==1)
        {
            WIPTableVC.WIPTabelType=@"11";
        }
        else if (indexPath.section==2&&indexPath.row==0)
        {
            WIPTableVC.WIPTabelType=@"12";
        }
        else if (indexPath.section==2&&indexPath.row==1)
        {
            WIPTableVC.WIPTabelType=@"13";
        }
        
    }else if ([self.Type isEqualToString:@"2"])
    {
        if (indexPath.section==0)
        {
            WIPTableVC.WIPTabelType=@"20";
        }
        else if (indexPath.section==1)
        {
            WIPTableVC.WIPTabelType=@"21";
        }
        else if (indexPath.section==2&&indexPath.row==0)
        {
            WIPTableVC.WIPTabelType=@"22";
        }
        else if (indexPath.section==2&&indexPath.row==1)
        {
            WIPTableVC.WIPTabelType=@"23";
        }
        
    }else if ([self.Type isEqualToString:@"3"])
    {
        if (indexPath.section==0)
        {
            WIPTableVC.WIPTabelType=@"30";
        }
        else if (indexPath.section==1)
        {
            WIPTableVC.WIPTabelType=@"31";
        }
        else if (indexPath.section==2&&indexPath.row==0)
        {
            WIPTableVC.WIPTabelType=@"32";
        }
        else if (indexPath.section==2&&indexPath.row==1)
        {
            WIPTableVC.WIPTabelType=@"33";
        }
    }
    
    [self .navigationController pushViewController:WIPTableVC animated:YES];

    
}


@end
