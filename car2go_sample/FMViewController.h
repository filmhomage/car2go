//
//  FMViewController.h
//  car2go_sample
//
//  Created by Jonghyun Kim on 2017/05/29.
//  Copyright © 2017 kokaru. All rights reserved.
//

@interface FMViewController : UIViewController

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *viewLeftContainer;
@property (weak, nonatomic) IBOutlet UIButton *buttonCurrentLocation;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintLeftWidth;

@property (strong, nonatomic) MKRoute* routeDetails;
@property (strong, nonatomic) NSArray* arrayVehicles;
@property (strong, nonatomic) CLLocation *currentLocation;
@property (strong, nonatomic) UIRefreshControl* refreshControl;
@property (strong, nonatomic) CLLocationManager* locationManager;
@property (strong, nonatomic) NSString* memoryFirst;

@end

