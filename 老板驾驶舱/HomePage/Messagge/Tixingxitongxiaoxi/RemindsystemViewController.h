//
//  RemindsystemViewController.h
//  BusinessCenter
//
//  Created by 冯海强 on 13-11-28.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "PullTableView.h"


@interface RemindsystemViewController : UITableViewController<PullTableViewDelegate,UIWebViewDelegate>
{
    int  T_pageIndex;//页数；
    
    int  T_searchType;
    
    int  m_current;
}

@property (weak, nonatomic) IBOutlet PullTableView *B_ListTable;

@property(nonatomic,strong)NSMutableArray *xiaoxiarray;

@property (nonatomic, strong) NSMutableArray *m_webViewArray;


- (void)initData;

@end
