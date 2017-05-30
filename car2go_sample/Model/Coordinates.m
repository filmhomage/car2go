//
//  Coordinates.m
//  car2go_sample
//
//  Created by Jonghyun Kim on 2017/05/29.
//  Copyright © 2017 kokaru. All rights reserved.
//

#import "Coordinates.h"

@implementation Coordinates

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"latitude"          : @"latitude",
             @"longitude"         : @"longitude",
             };
}

@end
