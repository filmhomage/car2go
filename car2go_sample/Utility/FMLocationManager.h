//
//  FMLocationManager.h
//  car2go_sample
//
//  Created by Jonghyun Kim on 2017/05/29.
//  Copyright © 2017 kokaru. All rights reserved.
//

@interface FMLocationManager : NSObject

@property(nonatomic, strong) CLLocationManager* locationManager;

+(instancetype)sharedInstance;
-(void)requestWhenInUseAuthorization;

@end
