//
//  FMAPIManager.h
//  car2go_sample
//
//  Created by Jonghyun Kim on 2017/05/29.
//  Copyright © 2017 kokaru. All rights reserved.
//

typedef void (^apisuccess)(NSURLSessionDataTask *sessionDataTask, id responseObject);
typedef void (^apifailure)(NSURLSessionDataTask *sessionDataTask, NSError *error);

@interface FMAPIManager : NSObject

+(instancetype)sharedInstance;

-(void)post:(NSString*)url
      param:(NSDictionary*)params
    success:(void (^)(NSURLSessionDataTask *sessionDataTask, id responseObject))success
    failure:(void (^)(NSURLSessionDataTask *sessionDataTask, NSError *error))failure;


-(void)get:(NSString*)url
     param:(NSDictionary*)params
   success:(void (^)(NSURLSessionDataTask *sessionDataTask, id responseObject))success
   failure:(void (^)(NSURLSessionDataTask *sessionDataTask, NSError *error))failure;

-(void)getImage:(NSString*)url
          param:(NSDictionary*)params
        success:(void (^)(NSURLSessionDataTask *sessionDataTask, id responseObject))success
        failure:(void (^)(NSURLSessionDataTask *sessionDataTask, NSError *error))failure;

-(void)getImage:(NSString*)url
          param:(NSDictionary*)params
    contentType:(id)contentType
responseSerializer:(id)responseSerializer
        success:(void (^)(NSURLSessionDataTask *sessionDataTask, id responseObject))success
        failure:(void (^)(NSURLSessionDataTask *sessionDataTask, NSError *error))failure;

@end
