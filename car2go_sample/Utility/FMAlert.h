//
//  FMAlert.h
//  car2go_sample
//
//  Created by Jonghyun Kim on 2017/05/29.
//  Copyright © 2017 kokaru. All rights reserved.
//

@interface FMAlert : NSObject {

    UIAlertController* _alertController;
}

@property(nonatomic) CGFloat showDelayTime;

+(instancetype)sharedInstance;

-(void)showOKAlert:(NSString*)title
           message:(NSString*)message;

-(void)showOKAlertBlock:(NSString*)title
                message:(NSString*)message
                  close:(void(^)(BOOL close))close;

-(void)showYesNoAlertBlock:(NSString*)title
                   message:(NSString*)message
                     close:(void(^)(BOOL yes))close;

-(void)showYesNoAlertBlock:(NSString*)title
                   message:(NSString*)message
            yesButtonTitle:(NSString*)yesButtonTitle
             noButtonTitle:(NSString*)noButtonTitle
                     close:(void(^)(BOOL yes))close;

-(void)showYesNoOKAlertBlock:(NSString*)title
                     message:(NSString*)message
              yesButtonTitle:(NSString*)yesButtonTitle
               noButtonTitle:(NSString*)noButtonTitle
               okButtonTitle:(NSString*)okButtonTitle
                       close:(void(^)(NSString* buttonTitle))close;

-(void)showCustomAlertBlock:(NSString*)title
                    message:(NSString*)message
               buttonsTitle:(NSArray*)arrayButtonsTitle
                      close:(void(^)(NSString* buttonTitle))close;

@end
