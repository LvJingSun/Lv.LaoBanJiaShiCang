//
//  BusinessshopViewController.h
//  BusinessCenter
//
//  Created by 冯海强 on 13-11-21.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "BasicData.h"


@interface BusinessshopViewController : UIViewController


@property (weak, nonatomic) IBOutlet UITableView *B_ListTable;

@property (weak, nonatomic) IBOutlet UIView *addview;

@property (weak, nonatomic) IBOutlet UIButton *addviewBtn;


@property(nonatomic,strong) NSMutableArray *Shoparray;

@end
