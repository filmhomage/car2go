//
//  FMAnnotationCurrent.h
//  car2go_sample
//
//  Created by Jonghyun Kim on 2017/05/29.
//  Copyright © 2017 kokaru. All rights reserved.
//

@interface FMAnnotationCurrent : NSObject <MKAnnotation>

-(id)initWithCoordinate:(CLLocationCoordinate2D)coordinate;

@property (nonatomic, readwrite) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

@end
