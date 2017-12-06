//
//  ActivitydetailsViewController.h
//  BusinessCenter
//
//  Created by 冯海强 on 13-11-20.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "ActivityData.h"
#import "ImageCache.h"
#import "UIImageView+AFNetworking.h"
#import "CommonUtil.h"


@interface ActivitydetailsViewController : UIViewController<UIScrollViewDelegate>

{
    IBOutlet UIScrollView*Activitydetails_scrollview;

    int iphonenum;
    
    int offsetPageActivity ;

    NSString*auditType;

}


@property(nonatomic,strong)ActivityDetailData *activityDetailData;
@property(nonatomic,strong)NSMutableArray *activityphotoarray;

@property(nonatomic,strong)ImageCache *Aimagecache;

@end
