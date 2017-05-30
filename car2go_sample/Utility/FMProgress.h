//
//  FMProgress.h
//  car2go_sample
//
//  Created by Jonghyun Kim on 2017/05/29.
//  Copyright © 2017 kokaru. All rights reserved.
//

@interface FMProgress : NSObject

+(instancetype)sharedInstance;

-(void)showProgress;

-(void)showProgress:(NSString*)labelText
    backgroundColor:(UIColor*)backgroundColor;

-(void)showProgress:(NSString*)labelText
               mode:(MBProgressHUDMode)mode
              alpha:(CGFloat)alpha
              color:(UIColor*)color
    backgroundColor:(UIColor*)backgroundColor
            minsize:(CGSize)minSize;

-(void)hideProgress;

@end
