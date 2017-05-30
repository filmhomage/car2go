//
//  FMPolylineRenderer.h
//  car2go_sample
//
//  Created by Jonghyun Kim on 2017/05/29.
//  Copyright © 2017 kokaru. All rights reserved.
//

@interface FMPolylineRenderer : MKPolylineRenderer {
    CADisplayLink* _displayLink;
    NSInteger _ticks;
}

@end
