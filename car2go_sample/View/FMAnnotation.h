//
//  FMAnnotation.h
//  car2go_sample
//
//  Created by Jonghyun Kim on 2017/05/29.
//  Copyright © 2017 kokaru. All rights reserved.
//

@interface FMAnnotation : MKPointAnnotation

@property (nonatomic) BOOL highlight;
@property (strong, nonatomic) Vehicles* vehicles;

-(NSString*)modifyAnnotationTitle;

@end
