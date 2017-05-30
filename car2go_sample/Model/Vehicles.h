//
//  Vehicles.h
//  car2go_sample
//
//  Created by Jonghyun Kim on 2017/05/29.
//  Copyright © 2017 kokaru. All rights reserved.
//

#import "Coordinates.h"

@interface Vehicles : MTLModel<MTLJSONSerializing>

@property(nonatomic, readonly) NSString* address;
@property(nonatomic, readonly) NSArray* coordinates;
@property(nonatomic, readonly) NSString* engineType;
@property(nonatomic, readonly) NSString* exterior;
@property(nonatomic, readonly) NSNumber* fuel;
@property(nonatomic, readonly) NSString* interior;
@property(nonatomic, readonly) NSString* name;
@property(nonatomic, readonly) NSNumber* smartPhoneRequired;
@property(nonatomic, readonly) NSString* vin;
@property(nonatomic, strong) NSNumber* index;
@property(nonatomic, strong) NSNumber* distance;

@end
