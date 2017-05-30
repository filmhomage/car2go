//
//  FMAnnotationCurrent.m
//  car2go_sample
//
//  Created by Jonghyun Kim on 2017/05/29.
//  Copyright © 2017 kokaru. All rights reserved.
//

#import "FMAnnotationCurrent.h"

@implementation FMAnnotationCurrent

-(id)initWithCoordinate:(CLLocationCoordinate2D)coordinate {
    if(self = [super init])
        self.coordinate = coordinate;
    return self;
}

@end
