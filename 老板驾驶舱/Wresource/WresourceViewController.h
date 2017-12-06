//
//  WresourceViewController.h
//  BusinessCenter
//
//  Created by 冯海强 on 14-2-8.
//  Copyright (c) 2014年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"

@interface WresourceViewController : UIViewController
{
    NSMutableArray*ProductArray;
    NSMutableArray*ActivityArray;
    NSMutableArray*WebArray;
}

@property (weak, nonatomic) IBOutlet UITableView *ListTable;

@end
