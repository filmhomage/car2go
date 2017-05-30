//
//  FMProgress.m
//  car2go_sample
//
//  Created by Jonghyun Kim on 2017/05/29.
//  Copyright © 2017 kokaru. All rights reserved.
//

#import "FMProgress.h"

@implementation FMProgress

+(instancetype)sharedInstance {
    
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    return sharedInstance;
}

-(void)showProgress {
    
    [self hideProgress];
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:[[FMUtility sharedInstance]topPresentedViewController].view animated:NO];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.bezelView.color = FMThemeColor;
    hud.alpha = 0.95f;
    hud.minSize = CGSizeMake(100.0f, 100.0f);
}

-(void)showProgress:(NSString*)labelText backgroundColor:(UIColor*)backgroundColor {
    
    [self hideProgress];
    
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:[[FMUtility sharedInstance]topPresentedViewController].view animated:NO];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.bezelView.color = FMThemeColor;
    hud.alpha = 0.95f;
    hud.minSize = CGSizeMake(100.0f, 100.0f);
    
    if(labelText && [labelText isEqualToString:kEmptyString] == NO) {
        hud.label.text = labelText;
    }
    if(backgroundColor) {
        hud.backgroundColor = backgroundColor;
    }
}

-(void)showProgress:(NSString*)labelText
               mode:(MBProgressHUDMode)mode
              alpha:(CGFloat)alpha
              color:(UIColor*)color
    backgroundColor:(UIColor*)backgroundColor
            minsize:(CGSize)minSize {
    
    [self hideProgress];
    
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:[[FMUtility sharedInstance]topPresentedViewController].view animated:NO];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.bezelView.color = FMThemeColor;
    hud.alpha = 0.95f;
    hud.minSize = CGSizeMake(100.0f, 100.0f);
    
    if(labelText && [labelText isEqualToString:kEmptyString] == NO) {
        hud.label.text = labelText;
    }
    if(mode) {
        hud.mode = mode;
    }
    if(alpha) {
        hud.alpha = alpha;
    }
    if(color) {
        hud.bezelView.color = color;
    }
    if(backgroundColor) {
        hud.backgroundColor = backgroundColor;
    }
    if(!CGSizeEqualToSize(CGSizeZero, minSize)) {
        hud.minSize = minSize;
    }
}

-(void)hideProgress {
    [MBProgressHUD hideHUDForView:[[FMUtility sharedInstance]topPresentedViewController].view  animated:YES];
}

-(void)determinateLoop:(MBProgressHUD*)hud {
    
    float progress = 0.0f;
    while (progress < 1.0f) {
        progress += 0.01f;
        hud.progress = progress;
        usleep(5000);
    }
}

@end
