//
//  WresourceViewController.m
//  BusinessCenter
//
//  Created by 冯海强 on 14-2-8.
//  Copyright (c) 2014年 冯海强. All rights reserved.
//

#import "WresourceViewController.h"
#import "ProductTableViewController.h"
#import "ActivityTableViewController.h"
#import "WwebViewController.h"

@interface WresourceViewController ()

@property (strong, nonatomic) NSString *itemType;

@property (weak, nonatomic) IBOutlet UIButton *btnProduct;

@property (weak, nonatomic) IBOutlet UIButton *btnActivity;

@property (weak, nonatomic) IBOutlet UIButton *m_Web;

@end

@implementation WresourceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"微●资源", @"1");
        self.tabBarItem.image = [UIImage imageNamed:@"Wresource.png"];
        ProductArray =[[NSMutableArray alloc]initWithCapacity:0];
        ActivityArray =[[NSMutableArray alloc]initWithCapacity:0];
        WebArray =[[NSMutableArray alloc]initWithCapacity:0];

    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.itemType = @"SERVICE";
    self.btnProduct.userInteractionEnabled = NO;
    self.btnActivity.userInteractionEnabled = YES;
    self.m_Web.userInteractionEnabled = YES;
    [self.btnProduct setBackgroundImage:[UIImage imageNamed:@"comm_tabar_selected.png"] forState:UIControlStateNormal];


    // Do any additional setup after loading the view from its nib.
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)changeType:(UIButton*)sender {
    [self.btnProduct setBackgroundImage:[UIImage imageNamed:@"comm_tabar_def.png"] forState:UIControlStateNormal];
    [self.btnProduct setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btnActivity setBackgroundImage:[UIImage imageNamed:@"comm_tabar_def.png"] forState:UIControlStateNormal];
    [self.btnActivity setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.m_Web setBackgroundImage:[UIImage imageNamed:@"comm_tabar_def.png"] forState:UIControlStateNormal];
    [self.m_Web setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    if (sender == self.btnProduct) {
        
        self.btnProduct.userInteractionEnabled = NO;
        self.btnActivity.userInteractionEnabled = YES;
        self.m_Web.userInteractionEnabled = YES;
        
        
        [self.btnProduct setBackgroundImage:[UIImage imageNamed:@"comm_tabar_selected.png"] forState:UIControlStateNormal];
        self.itemType = @"SERVICE";
        [self.ListTable reloadData];
    }
    if (sender == self.btnActivity) {
        
        self.btnProduct.userInteractionEnabled = YES;
        self.btnActivity.userInteractionEnabled = NO;
        self.m_Web.userInteractionEnabled = YES;
        
        [self.btnActivity setBackgroundImage:[UIImage imageNamed:@"comm_tabar_selected.png"] forState:UIControlStateNormal];
        self.itemType = @"ACTIVITY";
        [self.ListTable reloadData];
    }
    
    if (sender == self.m_Web) {
        
        self.btnProduct.userInteractionEnabled = YES;
        self.btnActivity.userInteractionEnabled = YES;
        self.m_Web.userInteractionEnabled = NO;
        
        [self.m_Web setBackgroundImage:[UIImage imageNamed:@"comm_tabar_selected.png"] forState:UIControlStateNormal];
        self.itemType = @"WEB";
        [self.ListTable reloadData];
    }
}





#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([[UIDevice currentDevice].systemVersion doubleValue]>=7)
    {
       tableView.center=CGPointMake(self.view.center.x, self.view.center.y-11);
    }
    if ([self.itemType isEqualToString:@"ACTIVITY"]) {
        return 2;
    }
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.itemType isEqualToString:@"SERVICE"])
    {
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
    }
    else if ([self.itemType isEqualToString:@"ACTIVITY"])
    {
        if (section==0)
        {
            return 1;
        }
        if (section==1)
        {
            return 2;
        }
    }
    else if ([self.itemType isEqualToString:@"WEB"])
    {
        return 1;
    }
    return 0;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.itemType isEqualToString:@"SERVICE"])
    {
        return 40;
    }

    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;

    if ([self.itemType isEqualToString:@"SERVICE"])
    {
        if (indexPath.section==0)
        {
            cell.textLabel.text=@"待审核产品";
        }
        else if (indexPath.section==1)
        {
            cell.textLabel.text=@"销售中产品";
        }
        else if (indexPath.section==2)
        {
            if (indexPath.row==0)
            {
                cell.textLabel.text=@"已下架产品";
            }
            else if (indexPath.row==1)
            {
                cell.textLabel.text=@"已售完产品";
            }
            
        }
    }
    else if ([self.itemType isEqualToString:@"ACTIVITY"])
    {
        if (indexPath.section==0)
        {
            cell.textLabel.text=@"待审核活动";
        }
        if (indexPath.section==1)
        {
            if (indexPath.row==0)
            {
                cell.textLabel.text=@"进行中活动";
            }
            else if (indexPath.row==1)
            {
                cell.textLabel.text=@"已结束活动";
            }
        }
    }
    else if ([self.itemType isEqualToString:@"WEB"])
    {
        if (indexPath.section==0)
        {
            cell.textLabel.text=@"我的微广告";
        }
        if (indexPath.section==1)
        {
            cell.textLabel.text=@"我的微资讯";
        }
        if (indexPath.section==2)
        {
            cell.textLabel.text=@"我的微相册";
        }
        
    }

    
    return cell;
}


//选中CELL
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    
    if ([self.itemType isEqualToString:@"SERVICE"]){
    if (indexPath.section==0){
        [accountDefaults setInteger:1 forKey:@"product"];//销售产品
    }
    else if (indexPath.section==1){
        [accountDefaults setInteger:2 forKey:@"product"];
    }
    else if (indexPath.section==2&&indexPath.row==0){
        [accountDefaults setInteger:3 forKey:@"product"];
    }
    else if (indexPath.section==2&&indexPath.row==1){
        [accountDefaults setInteger:4 forKey:@"product"];
    }
    
    ProductTableViewController*ProTableVC=[[ProductTableViewController alloc]initWithNibName:@"ProductTableViewController" bundle:nil];
    [self .navigationController pushViewController:ProTableVC animated:YES];
    }
    else if ([self.itemType isEqualToString:@"ACTIVITY"])
    {
        if (indexPath.section==0)
        {
            [accountDefaults setInteger:1 forKey:@"activity"];//销售产品
        }
        else if (indexPath.section==1&&indexPath.row==0)
        {
            [accountDefaults setInteger:2 forKey:@"activity"];//
        }
        else if (indexPath.section==1&&indexPath.row==1)
        {
            [accountDefaults setInteger:3 forKey:@"activity"];//
        }
        
    ActivityTableViewController*ActivityTableVC=[[ActivityTableViewController alloc]initWithNibName:@"ActivityTableViewController" bundle:nil];
    [self .navigationController pushViewController:ActivityTableVC animated:YES];
        
    }
    else if ([self.itemType isEqualToString:@"WEB"])
    {
        WwebViewController*WwebVC=[[WwebViewController alloc]initWithNibName:@"WwebViewController" bundle:nil];

        if (indexPath.section==0)
        {
            WwebVC.Type=@"1";
        }
        else if (indexPath.section==1)
        {
            WwebVC.Type=@"2";
        }
        else if (indexPath.section==2&&indexPath.row==0)
        {
            WwebVC.Type=@"3";
        }
        else if (indexPath.section==2&&indexPath.row==1)
        {
            WwebVC.Type=@"4";
        }
        
        [self .navigationController pushViewController:WwebVC animated:YES];
        
    }
    
}



@end
