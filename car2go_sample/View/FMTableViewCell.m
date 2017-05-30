//
//  FMTableViewCell.m
//  car2go_sample
//
//  Created by Jonghyun Kim on 2017/05/29.
//  Copyright © 2017 kokaru. All rights reserved.
//

#import "FMTableViewCell.h"

@implementation FMTableViewCell

-(void)configureCell:(Vehicles*)vehicle withIndex:(NSInteger)index {
    
    [self selectedColor];
    self.labelAddress.text = vehicle.address;
    self.labelName.text = vehicle.name;
    self.labelNumber.text = [NSString stringWithFormat:@"%@", vehicle.index.stringValue];
    [self.buttonFuel setTitle:vehicle.fuel.stringValue forState:UIControlStateNormal];
    int meter = (int)ceil(vehicle.distance.doubleValue);
    self.labelDistance.text = meter >= 1000 ? [NSString stringWithFormat:@"%.2f km", vehicle.distance.doubleValue / 1000] : [NSString stringWithFormat:@"%d m", (int)meter];
}

-(void)selectedColor {
    UIView* bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = FMThemeColorAlpha;
    [self setSelectedBackgroundView:bgColorView];
}

@end
