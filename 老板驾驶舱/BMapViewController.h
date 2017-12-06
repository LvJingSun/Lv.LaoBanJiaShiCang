//
//  BMapViewController.h
//  BusinessCenter
//
//  Created by 冯海强 on 13-12-1.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
#import "BasicData.h"
#import "BaseViewController.h"
//BMKSearchDelegate
@interface BMapViewController : BaseViewController<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate,UITextFieldDelegate>
{
    
    IBOutlet BMKMapView* _mapView;
    IBOutlet UITextField* _addrText;
//    BMKSearch* _search;
//    BMKPoiSearch *_search;
    BMKGeoCodeSearch *_search;
    BMKLocationService              *_locService;
    
    int _mapzoomlevel;//图层；
    float _mapx;
    float _mapy;
    

}

@property(nonatomic,strong)ShopDetailData*MAPshopdetail;


@end
