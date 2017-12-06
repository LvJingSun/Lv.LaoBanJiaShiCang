//
//  PIPViewController.h
//  BusinessCenter
//
//  Created by 冯海强 on 13-11-18.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "BaseViewController.h"


@interface PIPViewController : BaseViewController

{
    
    NSMutableArray*PIP_bankArray;
    NSMutableArray*PIP_InorOutrecortArray;
    
//    IBOutlet UITableView* PIPtableview;
    
    UILabel *label;
    
}


@property(nonatomic,strong)NSDictionary*PIPdic;

@end
