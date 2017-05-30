//
//  ClusterAnnotationView.h
//  car2go_sample
//
//  Created by Jonghyun Kim on 2017/05/29.
//  Copyright © 2017 kokaru. All rights reserved.
//

@interface ClusterAnnotationView : MKAnnotationView

@property (nonatomic) UILabel *countLabel;
@property (nonatomic) NSUInteger count;
@property (nonatomic, getter = isBlue) BOOL blue;
@property (nonatomic, getter = isUniqueLocation) BOOL uniqueLocation;

@end
