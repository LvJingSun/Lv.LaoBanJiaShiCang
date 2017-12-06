//
//  BMapViewController.m
//  BusinessCenter
//
//  Created by 冯海强 on 13-12-1.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import "BMapViewController.h"
#import "DDAnnotation.h"
#import "DDAnnotationView.h"
#import "BusshopAddorChangeViewController.h"
#import "SVProgressHUD.h"
#import "BusshopAddorChangeViewController.h"

@interface BMapViewController ()

-(IBAction)onClickGeocode:(id)sender;

//@property(nonatomic,retain)NSMutableArray*annotationarray;//标记数组


@end

@implementation BMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title=@"修改地图";
    }
    return self;
}


-(void)viewWillAppear:(BOOL)animated {
    
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _search.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _locService.delegate = self;

    CGRect rx = [ UIScreen mainScreen ].bounds;//手机尺寸
    _mapView.showMapScaleBar = true;
    _mapView.mapScaleBarPosition = CGPointMake(240,rx.size.height-120);
    
    _mapView.overlooking = -1;//不倾斜指南针消失
    CGPoint zn= CGPointMake(280,0);
    [_mapView setCompassPosition:zn];
 

}


-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _search.delegate = nil;
    _locService.delegate = nil;
    [SVProgressHUD dismiss];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _addrText.placeholder=@"输入城市或区域快速定位";
    _addrText.delegate=self;
    
    
    [self SetRightButton];
    [_mapView setFrame:CGRectMake(0, 35, [ UIScreen mainScreen ].bounds.size.width, [ UIScreen mainScreen ].bounds.size.height)];
    
    
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"Map.x"];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"Map.y"];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"level"];

    [_mapView setZoomLevel:15];
    
//    _search = [[BMKSearch alloc]init];
    _search = [[BMKGeoCodeSearch alloc]init];
    _locService = [[BMKLocationService alloc]init];

    _mapView.zoomEnabled=YES;//支持多点缩放；
    
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){0, 0};
    
	if (self.MAPshopdetail.MapX ==nil &&self.MAPshopdetail.MapY ==nil)
    {
        if ( ![CLLocationManager locationServicesEnabled] || ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusDenied)) {
            UIAlertView*alert=[[UIAlertView alloc]initWithTitle:nil message:@"请在系统设置中开启定位服务" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            return;
        }
        [_locService startUserLocationService];
        _mapView.showsUserLocation = NO;//先关闭显示的定位图层
        _mapView.userTrackingMode = BMKUserTrackingModeFollow;//设置定位的状态
        _mapView.showsUserLocation = YES;//显示定位图层

    }
    else
    {
        [SVProgressHUD showWithStatus:@"正在定位……"];
                
		pt = (CLLocationCoordinate2D){[self.MAPshopdetail.MapY floatValue], [self.MAPshopdetail.MapX floatValue]};
        
        BMKReverseGeoCodeOption *option = [[BMKReverseGeoCodeOption alloc]init];
        option.reverseGeoPoint = pt;
//        [_search reverseGeoCode:pt];
        [_search reverseGeoCode:option];
        
        
	}

}


-(void)SetRightButton
{
    UIButton *Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Btn setFrame:CGRectMake(0, 0, 60, 29)];
    Btn.backgroundColor = [UIColor clearColor];
    [Btn setTitle:@"保存" forState:UIControlStateNormal];
    [Btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    Btn.titleLabel.font = [UIFont systemFontOfSize:17.0f];
    [Btn addTarget:self action:@selector(BMapSaveBtn) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *_barButton = [[UIBarButtonItem alloc] initWithCustomView:Btn];
    [self.navigationItem setRightBarButtonItem:_barButton];
}



-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _addrText) {
        [textField resignFirstResponder];
    }
    return YES;
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField;
{
    
    [self hiddenNumPadDone:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - BMKMapViewDelegate
- (void)mapViewWillStartLocatingUser:(BMKMapView *)mapView
{
    NSLog(@"start locate");
}


// *用户方向更新后，会调用此函数
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
    NSLog(@"heading is %@",userLocation.heading);
    
    if ( userLocation.location.coordinate.latitude != 0.000000 && userLocation.location.coordinate.longitude != 0.000000 ) {
        
        [_locService stopUserLocationService];
        
        _locService.delegate = nil;
        
    }
}

//*用户位置更新后，会调用此函数
- (void)didUpdateUserLocation:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];

    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){0, 0};
    pt = (CLLocationCoordinate2D){userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude};
    
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = pt;
    
   [_search reverseGeoCode:reverseGeocodeSearchOption];
    
}

//根据anntation生成对应的View
- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
{
    NSString *AnnotationViewID = @"annotationViewID";
	//根据指定标识查找一个可被复用的标注View，一般在delegate中使用，用此函数来代替新申请一个View
    BMKAnnotationView *annotationView = [view dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    if (annotationView == nil) {
        annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
		((BMKPinAnnotationView*)annotationView).pinColor = BMKPinAnnotationColorRed;
		((BMKPinAnnotationView*)annotationView).animatesDrop = YES;
    }
	
	annotationView.centerOffset = CGPointMake(0, -(annotationView.frame.size.height * 0.5));
    annotationView.annotation = annotation;
	annotationView.canShowCallout = TRUE;
    
    [annotationView setDraggable:YES];//设置可Dragg
    
    DDAnnotation *annotation1 = (DDAnnotation *)annotation;
    annotation1.subtitle = [NSString	stringWithFormat:@"%f,%f", annotation.coordinate.latitude, annotation.coordinate.longitude];

    return annotationView;
}


//- (void)onGetAddrResult:(BMKAddrInfo*)result errorCode:(int)error
//{
//    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
//	[_mapView removeAnnotations:array];
//	array = [NSArray arrayWithArray:_mapView.overlays];
//	[_mapView removeOverlays:array];
//	if (error == 0) {
//		BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
//		item.coordinate = result.geoPt;
//		item.title = result.strAddr;
//		[_mapView addAnnotation:item];
//        _mapView.centerCoordinate = result.geoPt;
//        
//        [SVProgressHUD dismiss];
////        [SVProgressHUD showWithStatus:@"拖动以正确定位"];
//        
//	}
//}

- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error;
{
    
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:_mapView.overlays];
    [_mapView removeOverlays:array];
    if (error == 0) {
        BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
        item.coordinate = result.location;
        item.title = result.address;
        [_mapView addAnnotation:item];
        _mapView.centerCoordinate = result.location;
        
        [SVProgressHUD dismiss];
        //        [SVProgressHUD showWithStatus:@"拖动以正确定位"];
    }
    // 定位取消
    [_locService stopUserLocationService];

}


//查找
-(IBAction)onClickGeocode:(id)sender
{
    [_addrText resignFirstResponder];
    
    if (_addrText.text.length ==0) {
        [SVProgressHUD showErrorWithStatus:@"请输入城市区域地址"];
        return;
    }
    
    [SVProgressHUD showWithStatus:@"正在定位……"];

//   [_search geocode:_addrText.text withCity:@""];
    BMKGeoCodeSearchOption *addrText = [[BMKGeoCodeSearchOption alloc]init];
    addrText.address = _addrText.text;
    [_search geoCode:addrText];

    [_mapView setZoomLevel:15];

}


//点击地图空白处
- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate;
{
    [_addrText resignFirstResponder];

    
}

//
- (void)mapView:(BMKMapView *)mapView didFailToLocateUserWithError:(NSError *)error;
{
    UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"错误" message:@"定位失败!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
    
    
}

 



//地图改变状态
- (void)mapStatusDidChanged:(BMKMapView *)mapView;
{
    
    [_addrText resignFirstResponder];
    
    _mapzoomlevel=mapView.zoomLevel;

}



/**
 *拖动annotation view时，若view的状态发生变化，会调用此函数。ios3.2以后支持

 */
- (void)mapView:(BMKMapView *)mapView annotationView:(BMKAnnotationView *)view didChangeDragState:(BMKAnnotationViewDragState)newState
   fromOldState:(BMKAnnotationViewDragState)oldState;
{
    
    if (oldState == BMKAnnotationViewDragStateDragging)
    {
		DDAnnotation *annotation = (DDAnnotation *)view.annotation;
		annotation.subtitle = [NSString	stringWithFormat:@"%f,%f", annotation.coordinate.latitude, annotation.coordinate.longitude];
        NSLog(@"%f,%f",annotation.coordinate.latitude,annotation.coordinate.longitude);
        _mapy=annotation.coordinate.latitude;
        _mapx=annotation.coordinate.longitude;

	}
    
}


////取消保存
//- (IBAction)BMapCacleBtn
//{
//    [SVProgressHUD dismiss];
//
// [self dismissViewControllerAnimated:YES completion:nil];
//}


- (void)BMapSaveBtn
{
    
    [SVProgressHUD dismiss];

    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%f",_mapx] forKey:@"Map.x"];
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%f",_mapy] forKey:@"Map.y"];
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",_mapzoomlevel] forKey:@"level"];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
    
}



@end
