//
//  FMViewController+Location.h
//  car2go_sample
//
//  Created by Jonghyun Kim on 2017/05/29.
//  Copyright © 2017 kokaru. All rights reserved.
//

#import "FMViewController.h"

@interface FMViewController (Location) <CLLocationManagerDelegate>

-(void)requestLocation;
-(void)initializeLocation;
+(BOOL)locationServicesEnabled;
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error;
-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status;
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations;

@end
