//
//  ProductViewController.h
//  BusinessCenter
//
//  Created by 冯海强 on 13-11-18.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"


@interface ProductViewController : UIViewController

{
    
    NSMutableArray*PD_WaitArray;//产品代审核
    NSMutableArray*PD_SellArray;//正在销售
    NSMutableArray*PD_SoldoutoroverArray;//下架或售完
    
    
    
}


@end
