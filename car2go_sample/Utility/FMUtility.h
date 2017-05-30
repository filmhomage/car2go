//
//  FMUtility.h
//  car2go_sample
//
//  Created by Jonghyun Kim on 2017/05/29.
//  Copyright © 2017 kokaru. All rights reserved.
//

@interface FMUtility : NSObject

+(instancetype)sharedInstance;

@property(nonatomic) BOOL isReachable;

-(UIViewController*)rootViewController;
-(UIViewController*)topPresentedViewController;
-(UIViewController*)findTopViewController;
+(id)loadStubJson:(NSString*)filename;
-(BOOL)online;
+(NSString*)decodeJSONString:(NSString*)input;
+(BOOL)isSimulator;
+(NSString*)apiUrl:(NSString*)apiUrl;
@end
