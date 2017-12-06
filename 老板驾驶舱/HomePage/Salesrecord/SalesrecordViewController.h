//
//  SalesrecordViewController.h
//  BusinessCenter
//
//  Created by 冯海强 on 13-11-19.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "PullTableView.h"


@interface SalesrecordViewController : UITableViewController<PullTableViewDelegate>

@property (weak, nonatomic) IBOutlet PullTableView *B_ListTable;

@property(nonatomic,strong)NSMutableArray *salesrecordarray;

@end
