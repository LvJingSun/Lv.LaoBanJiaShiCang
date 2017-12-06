//
//  CardRLViewController.m
//  BusinessCenter
//
//  Created by 冯海强 on 15-5-14.
//  Copyright (c) 2015年 冯海强. All rights reserved.
//

#import "CardRLViewController.h"
#import "CardRLTableViewCell.h"
#import "CardRDViewController.h"
@interface CardRLViewController ()

@property (nonatomic,strong)NSMutableArray *MyCardsArray;

@end

@implementation CardRLViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.MyCardsArray = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"会员卡列表"];

    [self setExtraCellLineHidden:self.Cardl_tableview];
    
//    self.Cardl_tableview.hidden = YES;
    [self.Cardl_tableview setDelegate:self];
    [self.Cardl_tableview setDataSource:self];
    [self.Cardl_tableview setPullDelegate:self];
    self.Cardl_tableview.pullBackgroundColor = [UIColor whiteColor];
    self.Cardl_tableview.useRefreshView = YES;
    self.Cardl_tableview.useLoadingMoreView = YES;
    m_pageIndex = 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 85;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
//    return self.MyCardsArray.count;
    return 3;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    CardRLTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray*cellarray=[[NSBundle mainBundle]
                           loadNibNamed:@"CardRLTableViewCell" owner:self options:nil];
        cell =[cellarray objectAtIndex:0];
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
    }

    [cell setImageView:nil];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    CardRDViewController *VC = [[CardRDViewController alloc]initWithNibName:@"CardRDViewController" bundle:nil];
    [self.navigationController pushViewController:VC animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//取消选中状态。。

}

#pragma mark - PullTableViewDelegate
- (void)pullTableViewDidTriggerRefresh:(PullTableView*)pullTableView {
    
    m_pageIndex = 1;
    
    [self performSelector:@selector(CardRequestSubmit) withObject:nil];
    
    
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView*)pullTableView {
    
    m_pageIndex++;
    
    [self performSelector:@selector(CardRequestSubmit) withObject:nil];
    
}

- (void)CardRequestSubmit{
    
    if ( ![self isConnectionAvailable] ) {
        return;
    }



}







@end
