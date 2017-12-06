//
//  BusinessshopMapViewController.m
//  BusinessCenter
//
//  Created by 冯海强 on 13-11-26.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import "BusinessshopMapViewController.h"
#import "DDAnnotation.h"
#import "DDAnnotationView.h"

@interface BusinessshopMapViewController ()
{
    
    
}

@property(nonatomic,retain) IBOutlet UITextField*BusinessshopMaplab;
- (void)coordinateChanged_:(NSNotification *)notification;
@end

@implementation BusinessshopMapViewController

@synthesize mapView;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	CLLocationCoordinate2D theCoordinate;
    
	theCoordinate.latitude = 32.225454;
    theCoordinate.longitude = 120.368485;
	
	DDAnnotation *annotation = [[DDAnnotation alloc] initWithCoordinate:theCoordinate addressDictionary:nil];
	annotation.title = @"按住后拖动改变";
	annotation.subtitle = [NSString	stringWithFormat:@"%f %f", annotation.coordinate.latitude, annotation.coordinate.longitude];

	[self.mapView addAnnotation:annotation];
    //标注处
    
    
    mapView.showsUserLocation = YES;//显示用户位置
    mapView.mapType = MKMapTypeStandard;//地图类型
    
    
    
    
    CLLocationCoordinate2D coords = CLLocationCoordinate2DMake(32.225454,120.368485);
    float zoomLevel = 0.2;
    //以些点为点心，可见范围；
    MKCoordinateRegion region = MKCoordinateRegionMake(coords, MKCoordinateSpanMake(zoomLevel, zoomLevel));
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    
    
    
    
}

- (void)viewWillAppear:(BOOL)animated {
	
	[super viewWillAppear:animated];
	
	// NOTE: This is optional, DDAnnotationCoordinateDidChangeNotification only fired in iPhone OS 3, not in iOS 4.
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(coordinateChanged_:) name:@"DDAnnotationCoordinateDidChangeNotification" object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
	
	[super viewWillDisappear:animated];
	
	// NOTE: This is optional, DDAnnotationCoordinateDidChangeNotification only fired in iPhone OS 3, not in iOS 4.
	[[NSNotificationCenter defaultCenter] removeObserver:self name:@"DDAnnotationCoordinateDidChangeNotification" object:nil];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	
	self.mapView.delegate = nil;
	self.mapView = nil;
}



#pragma mark -
#pragma mark DDAnnotationCoordinateDidChangeNotification

// NOTE: DDAnnotationCoordinateDidChangeNotification won't fire in iOS 4, use -mapView:annotationView:didChangeDragState:fromOldState: instead.
- (void)coordinateChanged_:(NSNotification *)notification {
	
	DDAnnotation *annotation = notification.object;
	annotation.subtitle = [NSString	stringWithFormat:@"%f %f", annotation.coordinate.latitude, annotation.coordinate.longitude];
}

#pragma mark -
#pragma mark MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)annotationView didChangeDragState:(MKAnnotationViewDragState)newState fromOldState:(MKAnnotationViewDragState)oldState {
    
    [self.BusinessshopMaplab resignFirstResponder];
	
	if (oldState == MKAnnotationViewDragStateDragging) {
		DDAnnotation *annotation = (DDAnnotation *)annotationView.annotation;
		annotation.subtitle = [NSString	stringWithFormat:@"%f,%f", annotation.coordinate.latitude, annotation.coordinate.longitude];
	}
}

//地图即将移动时执行
- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated;
{
    
    
    
    
}


//界面移动完成后执行
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated;
{




    
    
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
	
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
	}
	
	static NSString * const kPinAnnotationIdentifier = @"PinIdentifier";
	MKAnnotationView *draggablePinView = [self.mapView dequeueReusableAnnotationViewWithIdentifier:kPinAnnotationIdentifier];
	
	if (draggablePinView) {
		draggablePinView.annotation = annotation;
	} else {
		// Use class method to create DDAnnotationView (on iOS 3) or built-in draggble MKPinAnnotationView (on iOS 4).
		draggablePinView = [DDAnnotationView annotationViewWithAnnotation:annotation reuseIdentifier:kPinAnnotationIdentifier mapView:self.mapView];
        
		if ([draggablePinView isKindOfClass:[DDAnnotationView class]]) {
			// draggablePinView is DDAnnotationView on iOS 3.
		} else {
			// draggablePinView instance will be built-in draggable MKPinAnnotationView when running on iOS 4.
		}
	}
	
	return draggablePinView;
}



-(IBAction)BusinessshopMapBtn:(id)sender
{
    [self.BusinessshopMaplab resignFirstResponder];
    
}


-(IBAction)BusinessshopMapCacleBtn:(id)sender
{
    [self.BusinessshopMaplab resignFirstResponder];

    [self dismissViewControllerAnimated:YES completion:nil];
    
}
-(IBAction)BusinessshopMapSaveBtn:(id)sender
{
    [self.BusinessshopMaplab resignFirstResponder];
    //传数据  OK
    
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


@end
