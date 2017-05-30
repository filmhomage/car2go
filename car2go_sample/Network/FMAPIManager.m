//
//  FMAPIManager.m
//  car2go_sample
//
//  Created by Jonghyun Kim on 2017/05/29.
//  Copyright © 2017 kokaru. All rights reserved.
//

#import "FMAPIManager.h"

@implementation FMAPIManager

+(instancetype)sharedInstance {
    
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    return sharedInstance;
}

-(void)post:(NSString*)url
      param:(NSDictionary*)params
    success:(void (^)(NSURLSessionDataTask *sessionDataTask, id responseObject))success
    failure:(void (^)(NSURLSessionDataTask *sessionDataTask, NSError *error))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    [securityPolicy setValidatesDomainName:NO];
    manager.securityPolicy = securityPolicy;
    
    [manager POST:[NSString stringWithFormat:@"%@?%@", url, @""]
       parameters:params
         progress:nil
          success:^(NSURLSessionDataTask* sessionDataTask, id responseObject) {

          } failure:^(NSURLSessionDataTask* sessionDataTask, NSError* error) {
          }];
}

-(void)get:(NSString*)url
     param:(NSDictionary*)params
   success:(void (^)(NSURLSessionDataTask *sessionDataTask, id responseObject))success
   failure:(void (^)(NSURLSessionDataTask *sessionDataTask, NSError *error))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    [securityPolicy setValidatesDomainName:NO];
    manager.securityPolicy = securityPolicy;
    
    [manager GET:[NSString stringWithFormat:@"%@?%@", url, @""]
      parameters:params
        progress:nil
         success:^(NSURLSessionDataTask* sessionDataTask, id responseObject) {
             if(success) {
                 success(sessionDataTask, responseObject);
             }
         } failure:^(NSURLSessionDataTask* sessionDataTask, NSError* error) {
             if(failure) {
                 failure(sessionDataTask, error);
             }
         }];
}

-(void)getImage:(NSString*)url
          param:(NSDictionary*)params
        success:(void (^)(NSURLSessionDataTask *sessionDataTask, id responseObject))success
        failure:(void (^)(NSURLSessionDataTask *sessionDataTask, NSError *error))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.securityPolicy setAllowInvalidCertificates:YES];
    manager.responseSerializer = [AFImageResponseSerializer serializer];
    
    [manager.requestSerializer setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager GET:url
      parameters:params
        progress:nil
         success:^(NSURLSessionDataTask* sessionDataTask, id responseObject) {
             if(success) {
                 success(sessionDataTask, responseObject);
             }
         } failure:^(NSURLSessionDataTask* sessionDataTask, NSError*  error) {
             if(failure) {
                 failure(sessionDataTask, error);
             }
         }];
}

-(void)getImage:(NSString*)url
          param:(NSDictionary*)params
    contentType:(id)contentType
responseSerializer:(id)responseSerializer
        success:(void (^)(NSURLSessionDataTask *sessionDataTask, id responseObject))success
        failure:(void (^)(NSURLSessionDataTask *sessionDataTask, NSError *error))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.securityPolicy setAllowInvalidCertificates:YES];
    
    if(responseSerializer) {
        manager.responseSerializer = responseSerializer;
    } else {
        manager.responseSerializer = [AFImageResponseSerializer serializer];
    }
    
    if(contentType) {
        manager.responseSerializer.acceptableContentTypes = contentType;
    }
    [manager.requestSerializer setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager GET:url
      parameters:params
        progress:nil
         success:^(NSURLSessionDataTask* sessionDataTask, id responseObject) {
             if(success) {
                 success(sessionDataTask, responseObject);
             }
         } failure:^(NSURLSessionDataTask* sessionDataTask, NSError*  error) {
             NSLog(@"%@ / %@", (NSHTTPURLResponse *)sessionDataTask.response, error.localizedDescription);
             if(failure) {
                 failure(sessionDataTask, error);
             }
         }];
}

@end
