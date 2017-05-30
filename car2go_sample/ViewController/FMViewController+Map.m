//
//  FMViewController+Map.m
//  car2go_sample
//
//  Created by Jonghyun Kim on 2017/05/29.
//  Copyright © 2017 kokaru. All rights reserved.
//

#import "FMViewController+Map.h"

@implementation FMViewController (Map)

-(void)initializeMap {
    
    self.mapView.delegate = self;
    self.mapView.tintColor = FMThemeColor;
    self.mapView.showsUserLocation = YES;
}

-(void)addAnnotation:(NSArray*)array {
    
    [self clearRoute];
    [self.mapView removeAnnotations:self.mapView.annotations];
    [self addCurrentAnnotation];
    
    NSMutableArray* arrayAnnotations = [NSMutableArray array];
    for(Vehicles* vehicle in array) {
        NSArray* coordinates = vehicle.coordinates;
        if(coordinates.count == 3) {
            
            CLLocation *startLocation = [[CLLocation alloc] initWithLatitude:self.mapView.userLocation.coordinate.latitude longitude:self.mapView.userLocation.coordinate.longitude];
            CLLocation *endLocation = [[CLLocation alloc] initWithLatitude:((NSString*)coordinates[1]).doubleValue longitude:((NSString*)coordinates[0]).doubleValue];
            CLLocationDistance distance = [startLocation distanceFromLocation:endLocation];
            vehicle.distance = [NSNumber numberWithDouble:distance].copy;
            FMAnnotation* annotation = [[FMAnnotation alloc] init];
            annotation.coordinate = CLLocationCoordinate2DMake(((NSString*)coordinates[1]).doubleValue, ((NSString*)coordinates[0]).doubleValue);
            annotation.vehicles = vehicle;
            annotation.title = vehicle.name;
            [arrayAnnotations addObject:vehicle];
            [self.mapView addAnnotation:annotation];
        }
    }
    
    self.arrayVehicles = [NSMutableArray sortArrayList:arrayAnnotations filterKeyName:@"distance" ascending:YES];
    [self.arrayVehicles enumerateObjectsUsingBlock:^(Vehicles* vehicle, NSUInteger index, BOOL* stop) {
        vehicle.index = [NSNumber numberWithInteger:index+1];
    }];
    NSLog(@"🤥count : [%ld] %@", (unsigned long)self.arrayVehicles.count, self.arrayVehicles);
    [self updateTableView:self.arrayVehicles];
}

-(void)drawFirstTimeNearestPlace {
    
    Vehicles* vehicleFirst = self.arrayVehicles[0];
    double latitude = ((NSString*)vehicleFirst.coordinates[1]).doubleValue;
    double longitude = ((NSString*)vehicleFirst.coordinates[0]).doubleValue;
    [self drawRoute:CLLocationCoordinate2DMake(self.mapView.userLocation.coordinate.latitude, self.mapView.userLocation.coordinate.longitude)
      coordinateEnd:CLLocationCoordinate2DMake(latitude, longitude) complection:^{}];
}

-(void)addCurrentAnnotation {
    
    [self.mapView removeAnnotation:self.mapView.userLocation];
    [self.mapView addAnnotation:[[FMAnnotationCurrent alloc] initWithCoordinate:self.mapView.userLocation.coordinate]];
}

-(MKOverlayRenderer*)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {

    FMPolylineRenderer *renderer = [[FMPolylineRenderer alloc] initWithPolyline:self.routeDetails.polyline];
    renderer.strokeColor = FMMapLineColor;
    renderer.alpha = 0.7;
    renderer.lineWidth = 4;
    renderer.lineDashPattern = @[@2, @5];
    return renderer;
}

-(void)clearRoute {
    
    [self.mapView removeOverlay:self.routeDetails.polyline];
    [self.mapView setNeedsDisplay];
    [self.mapView.layer setNeedsDisplay];
}

-(void)drawRoute:(CLLocationCoordinate2D)coordinateStart coordinateEnd:(CLLocationCoordinate2D)coordinateEnd complection:(complection)complection {
    
    MKDirectionsRequest* directionsRequest = [[MKDirectionsRequest alloc] init];
    MKPlacemark *placemarkStart = [[MKPlacemark alloc] initWithCoordinate:coordinateStart];
    MKPlacemark *placemarkEnd = [[MKPlacemark alloc] initWithCoordinate:coordinateEnd];
    [directionsRequest setSource:[[MKMapItem alloc] initWithPlacemark:placemarkStart]];
    [directionsRequest setDestination:[[MKMapItem alloc] initWithPlacemark:placemarkEnd]];
    directionsRequest.transportType = MKDirectionsTransportTypeAutomobile;
    
    MKDirections *directions = [[MKDirections alloc] initWithRequest:directionsRequest];
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
        if (!error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self clearRoute];
                self.routeDetails = response.routes.lastObject;
                [self.mapView addOverlay:self.routeDetails.polyline level:MKOverlayLevelAboveRoads];
                [self.mapView setNeedsDisplay];
                [self.mapView.layer setNeedsDisplay];
                if(complection) {
                    complection();
                }
                NSLog(@"🏡 %@ / %ld m/ %ld min", self.routeDetails.name, (long)ceil(self.routeDetails.distance), (long)ceil(self.routeDetails.expectedTravelTime/60));
            });
        } else {
            NSLog(@"Error %@", error.description);
        }
    }];
}

-(void)updatePinToCenter:(NSInteger)index withDrawRoute:(BOOL)withRoute {
    
    FMAnnotation* selectedAnnotation = nil;
    Vehicles* vehicle = self.arrayVehicles[index];
    NSArray* coordinates = vehicle.coordinates;
    CLLocation* location = [[CLLocation alloc] initWithLatitude:((NSString*)coordinates[1]).doubleValue longitude:((NSString*)coordinates[0]).doubleValue];
    
    BOOL bExist = NO;
    CLLocationCoordinate2D center = self.mapView.centerCoordinate;
    for(id <MKAnnotation> annotation in self.mapView.annotations) {
        if(annotation.coordinate.latitude == location.coordinate.latitude) {
            if(annotation.coordinate.longitude == location.coordinate.longitude) {
                center = annotation.coordinate;
                bExist = YES;
                selectedAnnotation = annotation;
                break;
            }
        }
    }
    if(withRoute) {
        [self drawRoute:CLLocationCoordinate2DMake(self.mapView.userLocation.coordinate.latitude, self.mapView.userLocation.coordinate.longitude)
          coordinateEnd:CLLocationCoordinate2DMake(center.latitude, center.longitude) complection:^{}];
        if(selectedAnnotation != nil) {
            [self.mapView selectAnnotation:selectedAnnotation animated:YES];
        }
    }
    
    MKCoordinateRegion mapRegion;
    mapRegion.center = center;
    mapRegion.span.latitudeDelta = self.mapView.region.span.latitudeDelta;
    mapRegion.span.longitudeDelta = self.mapView.region.span.longitudeDelta;
    [self.mapView setRegion:mapRegion animated:YES];
}

-(void)updateCurrentLocationWithoutZoom {
    
    MKCoordinateRegion mapRegion;
    mapRegion.center = self.currentLocation.coordinate;
    mapRegion.span.latitudeDelta = 0.013;
    mapRegion.span.longitudeDelta = 0.013;
    [self.mapView setRegion:mapRegion animated:NO];
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    if([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    if([annotation isKindOfClass:[FMAnnotationCurrent class]]) {
        static NSString *identifier = @"FMAnnotationCurrent";
        SVPulsingAnnotationView *pulsingView = (SVPulsingAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if(pulsingView == nil) {
            pulsingView = [[SVPulsingAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
            pulsingView.annotationColor = FMThemeColor;
        }
        pulsingView.canShowCallout = NO;
        return pulsingView;
    }
    if([annotation isKindOfClass:[FMAnnotation class]]){
        static NSString *identifier = @"FMAnnotation";
        FMPinAnnotationView* pivView = (FMPinAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if(pivView == nil) {
            pivView = [[FMPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        }
        return pivView;
    }
    return nil;
}

-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    
    if([view isKindOfClass:[FMPinAnnotationView class]]){
        view.image = [UIImage imageNamed:@"car2go_selected_with_text"];
        view.selected = YES;
        FMAnnotation* annotation = (FMAnnotation*)view.annotation;
        NSIndexPath* indexPath = [NSIndexPath indexPathForRow:annotation.vehicles.index.integerValue-1  inSection:0];
        UITableViewScrollPosition scrollPosition = UITableViewScrollPositionNone;
        if([[self.tableView indexPathsForVisibleRows] containsObject:indexPath] == NO) {
            scrollPosition = UITableViewScrollPositionTop;
        }
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:annotation.vehicles.index.integerValue-1  inSection:0] animated:YES scrollPosition:scrollPosition];
        
        for(UIGestureRecognizer* recognizer in view.subviews) {
            [view removeGestureRecognizer:recognizer];
            break;
        }
        [self drawRoute:CLLocationCoordinate2DMake(self.mapView.userLocation.coordinate.latitude, self.mapView.userLocation.coordinate.longitude)
          coordinateEnd:CLLocationCoordinate2DMake(annotation.coordinate.latitude, annotation.coordinate.longitude) complection:^{}];
    }
}

-(void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    
    if([view isKindOfClass:[FMPinAnnotationView class]]){
        view.image = [UIImage imageNamed:@"car2go_with_text"];
        view.selected = YES;
    }
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    
    id <MKAnnotation> annotation = [view annotation];
    if ([annotation isKindOfClass:[FMAnnotation class]]) {
        Vehicles* vehicle = ((FMAnnotation*)annotation).vehicles;
        [self openCar2GoApp:vehicle];
    }
}

-(void)openCar2GoApp:(Vehicles*)vehicle {
    
    // car2go://vehicle/WME4513341K828695?latlng=53.58775,10.12023
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"car2go://vehicle/%@?latlng=%@,%@", vehicle.vin, (NSString*)vehicle.coordinates[1], (NSString*)vehicle.coordinates[0]]] options:@{} completionHandler:^(BOOL success) {
        if (success) {
            NSLog(@"Opened url");
        }
    }];
}

@end
