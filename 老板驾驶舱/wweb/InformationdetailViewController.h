//
//  InformationdetailViewController.h
//  BusinessCenter
//
//  Created by 冯海强 on 14-2-10.
//  Copyright (c) 2014年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"

@interface InformationdetailViewController : UIViewController<UIWebViewDelegate>
{
    NSString *InfoID;
}

@property(nonatomic,weak) NSString *Ishidden;
@property (nonatomic,strong)NSMutableDictionary*Indic;

@end
