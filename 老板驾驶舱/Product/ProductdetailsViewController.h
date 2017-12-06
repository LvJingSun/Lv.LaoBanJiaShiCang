//
//  ProductdetailsViewController.h
//  BusinessCenter
//
//  Created by 冯海强 on 13-11-19.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "ProductData.h"
#import "ImageCache.h"
#import "UIImageView+AFNetworking.h"
#import "CommonUtil.h"
//#import "BaseViewController.h"

@interface ProductdetailsViewController :UIViewController <UIScrollViewDelegate>
{
    
    int iphonenum;
    
    int offsetPage ;
    
    NSString*auditType;
    
}

@property(nonatomic,strong)ProductDetailData *productdetail;
@property(nonatomic,strong)NSMutableArray *produtctphotoarray;

@property(nonatomic,strong)ImageCache *Pimagecache;



@end
