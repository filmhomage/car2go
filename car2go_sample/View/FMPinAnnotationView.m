//
//  FMPinAnnotationView.m
//  car2go_sample
//
//  Created by Jonghyun Kim on 2017/05/29.
//  Copyright © 2017 kokaru. All rights reserved.
//

#import "FMPinAnnotationView.h"

@implementation FMPinAnnotationView

-(instancetype)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    
    if(self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier]) {
        self.canShowCallout = YES;
        self.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        self.image = [UIImage imageNamed:@"car2go_with_text"];
        
        FMAnnotation* annotation = (FMAnnotation*)annotation;
        UIView* viewLeftAccessory = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.height, self.frame.size.height)];
        UIImageView * temp = [[UIImageView alloc] initWithFrame:CGRectMake(5, 3, self.frame.size.height- 10, self.frame.size.height -10)];
        temp.image = [UIImage imageNamed:@"car"];
        temp.contentMode = UIViewContentModeScaleAspectFit;
        [viewLeftAccessory addSubview:temp];
        viewLeftAccessory.tag = 0x9000;
        self.leftCalloutAccessoryView = viewLeftAccessory;
    }
    return self;
}

-(UIView*)hitTest:(CGPoint)point withEvent:(UIEvent*)event {
    
    UIView* hitView = [super hitTest:point withEvent:event];
    if (hitView != nil) {
        [self.superview bringSubviewToFront:self];
    }
    return hitView;
}

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)event {
    
    CGRect rect = self.bounds;
    BOOL isInside = CGRectContainsPoint(rect, point);
    if(!isInside) {
        for (UIView *view in self.subviews) {
            isInside = CGRectContainsPoint(view.frame, point);
            if(isInside)
                break;
        }
    }
    return isInside;
}

@end
