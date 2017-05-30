//
//  FMViewController+Map.h
//  car2go_sample
//
//  Created by Jonghyun Kim on 2017/05/29.
//  Copyright © 2017 kokaru. All rights reserved.
//

@interface FMViewController (Map) <MKMapViewDelegate>

-(void)initializeMap;
-(void)updateCurrentLocationWithoutZoom;
-(void)addAnnotation:(NSArray*)array;
-(void)updatePinToCenter:(NSInteger)index withDrawRoute:(BOOL)withRoute;

@end
