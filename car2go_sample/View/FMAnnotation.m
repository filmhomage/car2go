//
//  FMAnnotation.m
//  car2go_sample
//
//  Created by Jonghyun Kim on 2017/05/29.
//  Copyright © 2017 kokaru. All rights reserved.
//

#import "FMAnnotation.h"

@implementation FMAnnotation

-(NSString*)modifyAnnotationTitle {
    
    if (self.title.length > 18) {
        self.title = [self.title substringToIndex:18];
        self.title = [self.title stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        return [NSString stringWithFormat:@"%@...",self.title];
    }
    return self.title;
}

@end
