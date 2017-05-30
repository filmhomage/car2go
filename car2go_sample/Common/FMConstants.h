//
//  FMConstants
//  car2go_sample
//
//  Created by Jonghyun Kim on 2017/05/29.
//  Copyright © 2017 kokaru. All rights reserved.
//

#ifndef FMConstants_h
#define FMConstants_h

// "https://www.car2go.com/api/v2.1/operationareas?oauth_consumer_key=consumer_key&loc=Berlin&format=json"
// "https://www.car2go.com/api/v2.1/locations?oauth_consumer_key=consumer_key&format=json"
// "https://www.car2go.com/api/v2.1/parkingspots?loc=Berlin&oauth_consumer_key=consumer_key&format=json"
// "https://www.car2go.com/api/v2.1/gasstations?loc=Berlin&oauth_consumer_key=consumer_key&format=json"
// "https://www.car2go.com/api/v2.1/vehicles?loc=Berlin&oauth_consumer_key=consumer_key&format=json"

static NSString* const BASE_URL     = @"https://www.car2go.com/api/v2.1/";
static NSString* const API_VEHICLES = @"vehicles";

static NSString* const COREDATA_FILENAME            = @"FMModel.sqlite";
static NSString* const kEmptyString                 = @"";
static NSString* const FirstLaunch_Key              = @"FirstLaunch";
static NSString* const ALERT_BUTTON_OK              = @"OK";
static NSString* const ALERT_BUTTON_YES             = @"YES";
static NSString* const ALERT_BUTTON_NO              = @"NO";
static NSString* const ALERT_TITLE_ERROR_OCCURRED   = @"ERROR";
static NSString* const ALERT_BUTTON_TITLE_SETTING   = @"Setting";
static NSString* const ALERT_BUTTON_TITLE_CANCEL    = @"cancel";

static NSString* const ALERT_TITLE_LOCATION_AuthorizationDenied        = @"AuthorizationDenied";
static NSString* const ALERT_MESSAGE_LOCATION_AuthorizationDenied      = @"AuthorizationDenied \n[Setting] > [Privacy] > [Location]";
static NSString* const ALERT_TITLE_LOCATION_AuthorizationRestricted    = @"AuthorizationRestricted";
static NSString* const ALERT_MESSAGE_LOCATION_AuthorizationRestricted  = @"AuthorizationRestricted\n[Setting] > [General] > [Restricte] > [Location]";

#define FMThemeColor        [UIColor colorWithRed: 31.0f/255.0f green:179.0f/255.0f blue:248.0f/255.0f alpha:1.0f]
#define FMThemeColorAlpha   [UIColor colorWithRed: 31.0f/255.0f green:179.0f/255.0f blue:248.0f/255.0f alpha:0.5f]
#define FMMapLineColor      [UIColor colorWithRed:255.0f/255.0f green: 38.0f/255.0f blue:  0.0f/255.0f alpha:1.0f]

typedef enum : NSUInteger {
    FMAPIResponseState_OK = 1,
    FMAPIResponseState_Fail = 2,
    FMAPIResponseState_Fail_Auth = 3,
} FMAPIResponseState;

typedef void (^complection)();
typedef void (^complectionRoute)(MKRoute* route);
typedef void (^complectionList)(NSArray* arrayList);
typedef void (^complectionOK)(BOOL success);
typedef void (^complectionBlock)(id result, NSError *error);

#endif /* FMConstants_h */
