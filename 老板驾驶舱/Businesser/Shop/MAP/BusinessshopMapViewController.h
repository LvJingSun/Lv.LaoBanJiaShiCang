//
//  BusinessshopMapViewController.h
//  BusinessCenter
//
//  Created by 冯海强 on 13-11-26.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface BusinessshopMapViewController : UIViewController<MKMapViewDelegate>
{

	MKMapView *mapView;

}

@property (nonatomic, retain) IBOutlet MKMapView *mapView;



@end
