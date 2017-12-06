//
//  CardRDViewController.m
//  BusinessCenter
//
//  Created by 冯海强 on 15-5-14.
//  Copyright (c) 2015年 冯海强. All rights reserved.
//

#import "CardRDViewController.h"
#import "CardRDTableViewCell.h"

@interface CardRDViewController ()

@property (nonatomic,strong)NSMutableArray *MyCardsArray;
@end

@implementation CardRDViewController

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
    [self setTitle:@"消费记录"];
    
    [self setExtraCellLineHidden:self.CardD_tableview];
    
    //    self.Cardl_tableview.hidden = YES;
    [self.CardD_tableview setDelegate:self];
    [self.CardD_tableview setDataSource:self];
    [self.CardD_tableview setPullDelegate:self];
    self.CardD_tableview.pullBackgroundColor = [UIColor whiteColor];
    self.CardD_tableview.useRefreshView = YES;
    self.CardD_tableview.useLoadingMoreView = YES;
    self.m_emptyLabel.hidden = YES;
    m_pageIndex = 1;
    
    self.m_leftBtn.userInteractionEnabled = NO;
    self.m_rightBtn.userInteractionEnabled = YES;
    [self.m_leftBtn setBackgroundImage:[UIImage imageNamed:@"comm_tabar_selected.png"] forState:UIControlStateNormal];
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
    CardRDTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray*cellarray=[[NSBundle mainBundle]
                           loadNibNamed:@"CardRDTableViewCell" owner:self options:nil];
        cell =[cellarray objectAtIndex:0];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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

-(IBAction)changeType:(UIButton*)sender {
    
    [self.m_leftBtn setBackgroundImage:[UIImage imageNamed:@"comm_tabar_def.png"] forState:UIControlStateNormal];
    [self.m_leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.m_rightBtn setBackgroundImage:[UIImage imageNamed:@"comm_tabar_def.png"] forState:UIControlStateNormal];
    [self.m_rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    if (sender == self.m_leftBtn) {
        
        self.m_leftBtn.userInteractionEnabled = NO;
        self.m_rightBtn.userInteractionEnabled = YES;
        
        [self.m_leftBtn setBackgroundImage:[UIImage imageNamed:@"comm_tabar_selected.png"] forState:UIControlStateNormal];
    }
    if (sender == self.m_rightBtn) {
        
        self.m_leftBtn.userInteractionEnabled = YES;
        self.m_rightBtn.userInteractionEnabled = NO;
        
        [self.m_rightBtn setBackgroundImage:[UIImage imageNamed:@"comm_tabar_selected.png"] forState:UIControlStateNormal];
    }
    
}

- (void)CardRequestSubmit{
    
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    
    
    
}



@end
