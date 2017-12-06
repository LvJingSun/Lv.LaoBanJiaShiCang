//
//  InComeViewController.h
//  BusinessCenter
//
//  Created by 冯海强 on 13-11-19.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "PullTableView.h"



@interface InComeViewController : UITableViewController<PullTableViewDelegate,UIWebViewDelegate>
{

    int  n_pageIndex;//页数；
    
    NSString*searchType;
    NSString*tradingOperations;
    
    int  m_current;

}

@property (weak, nonatomic)  NSString *Allmoney;//汇总金额

@property (weak, nonatomic) IBOutlet PullTableView *B_ListTable;

@property(nonatomic,strong)NSMutableArray *Indayarray;

@property (nonatomic, strong) NSMutableArray *m_webViewArray;



@end
