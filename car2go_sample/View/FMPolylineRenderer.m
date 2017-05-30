//
//  FMPolylineRenderer.m
//  car2go_sample
//
//  Created by Jonghyun Kim on 2017/05/29.
//  Copyright © 2017 kokaru. All rights reserved.
//

#import "FMPolylineRenderer.h"

@implementation FMPolylineRenderer

-(instancetype)initWithOverlay:(id<MKOverlay>)overlay {
    
    self = [super initWithOverlay:overlay];
    if(self) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateRoutePolyline)];
        [_displayLink addToRunLoop:[NSRunLoop mainRunLoop]  forMode:NSRunLoopCommonModes];
        _displayLink.preferredFramesPerSecond = 2.0;
    }
    return self;
}

-(void)updateRoutePolyline {
    
    if(_ticks < 3) {
        _ticks++;
    } else {
        _ticks = 0;
    }
    if(_ticks == 0) {
        [self setNeedsDisplay];
    }
}

-(void)dealloc {
    if(_displayLink != nil) {
        [_displayLink invalidate];
    }
}

@end
