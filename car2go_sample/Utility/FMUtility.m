//
//  FMUtility.m
//  car2go_sample
//
//  Created by Jonghyun Kim on 2017/05/29.
//  Copyright © 2017 kokaru. All rights reserved.
//

#import "FMUtility.h"

@implementation FMUtility

+(instancetype)sharedInstance {
    
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    return sharedInstance;
}

-(UIViewController*)rootViewController {
    
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    window.rootViewController = [[UIViewController alloc] init];
    window.windowLevel = UIWindowLevelAlert + 1;
    [window makeKeyAndVisible];
//    NSLog(@"RootViewController: %@", window.rootViewController);
    return window.rootViewController;
}

-(UIViewController*)topPresentedViewController {
    
    UIViewController *topVC = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
//    NSLog(@"ToptopPresentedViewController is: %@", topVC);
    return topVC;
}

-(UIViewController*)findTopViewController {
    
    id  topController  = [self topPresentedViewController];
    UIViewController* topViewController;
    if([topController isKindOfClass:[UINavigationController class]]) {
        topViewController = [[(UINavigationController*)topController viewControllers] lastObject];
    } else if ([topController isKindOfClass:[UITabBarController class]]) {
    } else if ([topController isKindOfClass:[UIAlertController class]]) {
    } else {
        topViewController = (UIViewController*)topController;
    }
//    NSLog(@"Top ViewController is: %@", topViewController);
    return topViewController;
}

+(id)loadStubJson:(NSString*)filename {
    
    NSError *error = nil;
    NSData *jsonData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:filename ofType:@"json"] options:NSDataReadingMappedIfSafe error:&error];
    if(error) NSLog(@"jsonData ERROR : %@", error);
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if(error) NSLog(@"jsonData ERROR : %@", error);
    return jsonObject;
}

-(BOOL)online {
    return self.isReachable;
}

+(NSString*)decodeJSONString:(NSString*)input {

    NSString *esc1 = [input stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString *esc2 = [esc1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *quoted = [[@"\"" stringByAppendingString:esc2] stringByAppendingString:@"\""];
    NSData *data = [quoted dataUsingEncoding:NSUTF8StringEncoding];
    NSString *unesc = [NSPropertyListSerialization propertyListWithData:data options:NSPropertyListImmutable format:NULL error:NULL];
//    assert([unesc isKindOfClass:[NSString class]]);
    return unesc;
}

+(BOOL)isSimulator {
    return TARGET_OS_SIMULATOR != 0;
}

+(NSString*)apiUrl:(NSString*)apiUrl {
    
    return [NSString stringWithFormat:@"%@%@", BASE_URL, apiUrl];
}

@end
