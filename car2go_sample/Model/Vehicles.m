//
//  Vehicles.m
//  car2go_sample
//
//  Created by Jonghyun Kim on 2017/05/29.
//  Copyright © 2017 kokaru. All rights reserved.
//

#import "Vehicles.h"

@implementation Vehicles

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"address"             : @"address",
             @"coordinates"         : @"coordinates",
             @"engineType"          : @"engineType",
             @"exterior"            : @"exterior",
             @"fuel"                : @"fuel",
             @"interior"            : @"interior",
             @"name"                : @"name",
             @"smartPhoneRequired"  : @"smartPhoneRequired",
             @"vin"                 : @"vin"
             };
}

+ (NSValueTransformer *)coordinatesByJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSDictionary *value, BOOL *success, NSError *__autoreleasing *error) {
        return @"";
    }];
}

@end
