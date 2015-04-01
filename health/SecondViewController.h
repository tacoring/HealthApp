//
//  SecondViewController.h
//  health
//
//  Created by Casper on 10/15/14.
//  Copyright (c) 2014 CHHD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface SecondViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>


@property (weak, nonatomic) IBOutlet MKMapView *myMapView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *myNavigatorButton;
@property (nonatomic) Boolean isMap;
@property (weak, nonatomic) IBOutlet UIButton *mapHomeButton;


- (IBAction)GoCurrentLocation:(id)sender;
- (IBAction)SwitchView:(id)sender;

@end

