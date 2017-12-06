//
//  BusinesserViewController.h
//  BusinessCenter
//
//  Created by 冯海强 on 13-11-18.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"



@interface BusinesserViewController : UIViewController


{
    NSMutableArray*Bus_shopcArray;
    NSMutableArray*Bus_otherArray;

    IBOutlet UITableView *B_tableview;
    
    
}


@end
