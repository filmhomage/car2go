//
//  FMAlert.m
//  car2go_sample
//
//  Created by Jonghyun Kim on 2017/05/29.
//  Copyright © 2017 kokaru. All rights reserved.
//

#import "FMAlert.h"

@implementation FMAlert

+(instancetype)sharedInstance {
    
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    return sharedInstance;
}

-(void)presentAlertControl {
    
    if(_alertController) {
        [[[FMUtility sharedInstance]rootViewController] presentViewController:_alertController animated:YES completion:nil];
    }
}

-(void)dismissAlertController {
    
    if(_alertController) {
        [_alertController dismissViewControllerAnimated:NO completion:nil];
    }
}

-(void)showOKAlert:(NSString*)title message:(NSString*)message {
    
    [self dismissAlertController];
    _alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [_alertController addAction:[UIAlertAction actionWithTitle:ALERT_BUTTON_OK style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action) {}]];
    [self performSelector:@selector(presentAlertControl) withObject:nil afterDelay:self.showDelayTime > 0.0 ? self.showDelayTime : 0.0];
}

-(void)showOKAlertBlock:(NSString*)title message:(NSString*)message close:(void(^)(BOOL close))close {
    
    [self dismissAlertController];
    _alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [_alertController addAction:[UIAlertAction actionWithTitle:ALERT_BUTTON_OK
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action) {
                                                           if(close) {
                                                               close(YES);
                                                           }
                                                       }]];
    [self performSelector:@selector(presentAlertControl) withObject:nil afterDelay:self.showDelayTime > 0.0 ? self.showDelayTime : 0.0];
}

-(void)showYesNoAlertBlock:(NSString*)title
                   message:(NSString*)message
                     close:(void(^)(BOOL yes))close {
    
    [self dismissAlertController];
    _alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [_alertController addAction:[UIAlertAction actionWithTitle:ALERT_BUTTON_NO
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action) {
                                                           if(close) {
                                                               close(NO);
                                                           }
                                                       }]];
    [_alertController addAction:[UIAlertAction actionWithTitle:ALERT_BUTTON_YES
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action) {
                                                           if(close) {
                                                               close(YES);
                                                           }
                                                       }]];
    [self performSelector:@selector(presentAlertControl) withObject:nil afterDelay:self.showDelayTime > 0.0 ? self.showDelayTime : 0.0];
}

-(void)showYesNoAlertBlock:(NSString*)title
                   message:(NSString*)message
            yesButtonTitle:(NSString*)yesButtonTitle
             noButtonTitle:(NSString*)noButtonTitle
                     close:(void(^)(BOOL yes))close {
    
    [self dismissAlertController];
    _alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [_alertController addAction:[UIAlertAction actionWithTitle:noButtonTitle
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action) {
                                                           if(close) {
                                                               close(NO);
                                                           }
                                                       }]];
    [_alertController addAction:[UIAlertAction actionWithTitle:yesButtonTitle
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action) {
                                                           if(close) {
                                                               close(YES);
                                                           }
                                                       }]];
    [self performSelector:@selector(presentAlertControl) withObject:nil afterDelay:self.showDelayTime > 0.0 ? self.showDelayTime : 0.0];
}

-(void)showYesNoOKAlertBlock:(NSString*)title
                     message:(NSString*)message
              yesButtonTitle:(NSString*)yesButtonTitle
               noButtonTitle:(NSString*)noButtonTitle
               okButtonTitle:(NSString*)okButtonTitle
                       close:(void(^)(NSString* buttonTitle))close {
    
    [self dismissAlertController];
    _alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [_alertController addAction:[UIAlertAction actionWithTitle:yesButtonTitle
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action) {
                                                           if(close) {
                                                               close(yesButtonTitle);
                                                           }
                                                       }]];
    
    [_alertController addAction:[UIAlertAction actionWithTitle:noButtonTitle
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action) {
                                                           if(close) {
                                                               close(noButtonTitle);
                                                           }
                                                       }]];
    
    [_alertController addAction:[UIAlertAction actionWithTitle:okButtonTitle
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action) {
                                                           if(close) {
                                                               close(okButtonTitle);
                                                           }
                                                       }]];
    [self performSelector:@selector(presentAlertControl) withObject:nil afterDelay:self.showDelayTime > 0.0 ? self.showDelayTime : 0.0];
}

-(void)showCustomAlertBlock:(NSString*)title
                    message:(NSString*)message
               buttonsTitle:(NSArray*)arrayButtonsTitle
                      close:(void(^)(NSString* buttonTitle))close {
    
    if(!arrayButtonsTitle) {
        return;
    }
    
    [self dismissAlertController];
    _alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    for(NSString* buttonTitle in arrayButtonsTitle) {
        [_alertController addAction:[UIAlertAction actionWithTitle:buttonTitle
                                                             style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction *action) {
                                                               if(close) {
                                                                   close(buttonTitle);
                                                               }
                                                           }]];
    }
    [self performSelector:@selector(presentAlertControl) withObject:nil afterDelay:self.showDelayTime > 0.0 ? self.showDelayTime : 0.0];
}

@end
