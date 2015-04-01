//
//  SecondViewController.m
//  health
//
//  Created by Casper on 10/15/14.
//  Copyright (c) 2014 CHHD. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController () <MKMapViewDelegate, CLLocationManagerDelegate>

@end


@implementation SecondViewController

@synthesize isMap;

- (void)viewDidLoad {
    [super viewDidLoad];
    isMap = YES;
    self.myTableView.hidden = YES;
    // Do any additional setup after loading the view, typically from a nib.
//    [CLLocationManager requestWhenInUseAuthorization];
    self.myMapView.delegate = self;
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    if([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]){
        [self.locationManager requestWhenInUseAuthorization];
        self.myMapView.showsUserLocation = YES;
        [self.myMapView setMapType:MKMapTypeStandard];
        [self.myMapView setZoomEnabled:YES];
        [self.myMapView setScrollEnabled:YES];
        [self.myMapView showsUserLocation];
        [self.myMapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
    }
    
    
//    self.myMapView.showsUserLocation = YES;
    [self.locationManager startUpdatingLocation];
    [self addmark];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    [self.myMapView setCenterCoordinate:userLocation.coordinate animated:YES];
}

- (void) addmark{
    MKPointAnnotation *myAnnotation = [[MKPointAnnotation alloc]init];
    myAnnotation.coordinate = CLLocationCoordinate2DMake(33.8819263, -117.88758);
    myAnnotation.title = @"Panda Express";
    myAnnotation.subtitle = @"Best chinese food on campus";
    [self.myMapView addAnnotation:myAnnotation];
    
//    myAnnotation.coordinate = CLLocationCoordinate2DMake(33.8819263, -117.8876135);
//    myAnnotation.title = @"TOGO's";
//    myAnnotation.subtitle = @"Best Sandwiches on campus";
//    [self.myMapView addAnnotation:myAnnotation];
    
}
- (IBAction)GoCurrentLocation:(id)sender {
//    [self.myMapView setCenter:self.myMapView.userLocation.coordinate animated:YES];
    [self.myMapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
    
}
- (IBAction)SwitchView:(id)sender {
    if (isMap){     //TableView
        isMap = NO;
        self.myTableView.hidden = NO;
        self.myMapView.hidden = YES;
        self.mapHomeButton.hidden = YES;
//        self.myNavigatorButton.description = mapContent;
//        self.navigationController.navigationBar.topItem.title = @"List";
        self.navigationItem.rightBarButtonItem.title = @"Map";
    }else{          //MaView
        isMap = YES;
        self.myTableView.hidden = YES;
        self.myMapView.hidden = NO;
        self.mapHomeButton.hidden = NO;
//        self.navigationController.navigationBar.topItem.title = @"Map";
        self.navigationItem.rightBarButtonItem.title = @"List";
    }
}
@end
