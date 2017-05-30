//
//  FMViewController+Location.m
//  car2go_sample
//
//  Created by Jonghyun Kim on 2017/05/29.
//  Copyright © 2017 kokaru. All rights reserved.
//

#import "FMViewController+Location.h"

@implementation FMViewController (Location)

-(void)initializeLocation {
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;;
    if([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]){
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startUpdatingLocation];
    [self.locationManager requestLocation];
}

+(BOOL)locationServicesEnabled {
    
    BOOL bEnalble = YES;
    CLAuthorizationStatus status  = [CLLocationManager authorizationStatus];
    switch(status) {
        case kCLAuthorizationStatusNotDetermined:
            bEnalble = NO;
            break;
            
        case kCLAuthorizationStatusRestricted:
            [[FMAlert sharedInstance] showCustomAlertBlock:ALERT_TITLE_LOCATION_AuthorizationRestricted
                                                   message:ALERT_MESSAGE_LOCATION_AuthorizationRestricted
                                              buttonsTitle:[NSArray arrayWithObjects:ALERT_BUTTON_TITLE_SETTING, ALERT_BUTTON_TITLE_CANCEL, nil]
                                                     close:^(NSString *buttonTitle) {
                                                         if([buttonTitle isEqualToString:ALERT_BUTTON_TITLE_SETTING]) {
                                                             
                                                             UIApplication* application = [UIApplication sharedApplication];
                                                             NSURL* url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                                                             if ([application respondsToSelector:@selector(openURL:options:completionHandler:)]) {
                                                                 [application openURL:url
                                                                              options:@{}
                                                                    completionHandler:^(BOOL success) {
                                                                        NSLog(@"Open %ld", (long)success);
                                                                    }];
                                                             } else {
//                                                                 NSLog(@"Open %ld", (long)[application openURL:url]);
                                                             }
                                                         }
                                                     }];
            bEnalble = NO;
            break;
            
        case kCLAuthorizationStatusDenied:
            [[FMAlert sharedInstance] showCustomAlertBlock:ALERT_TITLE_LOCATION_AuthorizationDenied
                                                   message:ALERT_MESSAGE_LOCATION_AuthorizationDenied
                                              buttonsTitle:[NSArray arrayWithObjects:ALERT_BUTTON_TITLE_SETTING, ALERT_BUTTON_TITLE_CANCEL, nil]
                                                     close:^(NSString *buttonTitle) {
                                                         if([buttonTitle isEqualToString:ALERT_BUTTON_TITLE_SETTING]) {
                                                             
                                                             UIApplication* application = [UIApplication sharedApplication];
                                                             NSURL* url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                                                             if ([application respondsToSelector:@selector(openURL:options:completionHandler:)]) {
                                                                 [application openURL:url
                                                                              options:@{}
                                                                    completionHandler:^(BOOL success) {
                                                                        NSLog(@"Open %ld", (long)success);
                                                                    }];
                                                             } else {
//                                                                 NSLog(@"Open %ld", (long)[application openURL:url]);
                                                             }
                                                         }
                                                     }];
            bEnalble = NO;
            break;
            
        default:
            bEnalble = YES;
            break;
    }
    return bEnalble;
}

-(void)requestLocation {
    if(self.locationManager) {
        [self.locationManager requestLocation];
    }
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError: %@", error);
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
        case kCLAuthorizationStatusRestricted:
        case kCLAuthorizationStatusDenied:
        {
            NSLog(@"locationMananger status : %ld", (long)status);
        }
            break;
            
        default:
            [self requestLocation];
            break;
    }
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    CLLocation *currentLocation = locations.lastObject;
    if (currentLocation != nil) {
        self.currentLocation = currentLocation;
        NSLog(@"\n✅ GPS [ %@ ] [%lf -- %lf]", locations.lastObject, self.currentLocation.coordinate.latitude, self.currentLocation.coordinate.longitude);
    }
    [self updateCurrentLocationWithoutZoom];
}

@end
