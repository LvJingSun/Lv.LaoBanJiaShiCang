//
//  WIPTableViewController.h
//  BusinessCenter
//
//  Created by 冯海强 on 14-2-10.
//  Copyright (c) 2014年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "WIPTableCell.h"
#import "PullTableView.h"


@interface WIPTableViewController : UITableViewController<PullTableViewDelegate>
{
    NSString *memberID;
    int padge;
    NSString *type;
    
    
}

@property (weak, nonatomic) IBOutlet PullTableView *W_ListTable;

@property(nonatomic,weak)NSString *WIPTabelType;

@property (nonatomic,strong)NSMutableArray*Warray;


@end
