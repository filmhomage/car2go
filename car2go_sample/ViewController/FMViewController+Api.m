//
//  FMViewController+Api.m
//  car2go_sample
//
//  Created by Jonghyun Kim on 2017/05/29.
//  Copyright © 2017 kokaru. All rights reserved.
//

#import "FMViewController+Api.h"

@implementation FMViewController (Api)

-(void)vehiclesAPI:(complectionList)aCompletion {

    // FIXME: As a developer you must register as a so called "consumer" at car2go. See registration for more details.
    // About oauth_consumer_key, check to https://github.com/car2go/openAPI/wiki/Access-protected-Functions-via-OAuth-1.0
    NSDictionary* dictionary = @{@"loc"                : @"Berlin",
                                 @"oauth_consumer_key" : @"oauth_consumer_key",
                                 @"format"             : @"json"};
    
    [[FMAPIManager sharedInstance] get:[NSString stringWithFormat:@"%@%@", BASE_URL, API_VEHICLES]
                                 param:dictionary
                               success:^(NSURLSessionDataTask *sessionDataTask, id responseObject) {
                                   NSArray* vehicles = [MTLJSONAdapter modelsOfClass:Vehicles.class fromJSONArray:responseObject[@"placemarks"] error:nil];
                                   [[FMProgress sharedInstance] hideProgress];
                                   aCompletion(vehicles);
                               } failure:^(NSURLSessionDataTask *sessionDataTask, NSError *error) {
                                   [[FMProgress sharedInstance] hideProgress];
                                   NSLog(@"failure");
                                   aCompletion(nil);
                               }];
}

@end
