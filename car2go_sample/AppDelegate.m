//
//  AppDelegate.m
//  car2go_sample
//
//  Created by Jonghyun Kim on 2017/05/29.
//  Copyright © 2017 kokaru. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status){
        [FMUtility sharedInstance].isReachable = status >= AFNetworkReachabilityStatusReachableViaWWAN ? YES : NO;
        NSLog(@"\nReachable %@", [[FMUtility sharedInstance] online] ? @"🔵YES" : @"🔴NO");
    }];
    [FMViewController locationServicesEnabled];
    NSLog(@"🍋Direcotry [%@]", ((NSArray*)NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject));
    return YES;
}

-(void)applicationWillResignActive:(UIApplication *)application {
}

-(void)applicationDidEnterBackground:(UIApplication *)application {
}

-(void)applicationWillEnterForeground:(UIApplication *)application {
}

-(void)applicationDidBecomeActive:(UIApplication *)application {
}

-(void)applicationWillTerminate:(UIApplication *)application {
}

@end
