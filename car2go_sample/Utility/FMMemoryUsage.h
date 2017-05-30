//
//  FMMemoryUsage.h
//  car2go_sample
//
//  Created by Jonghyun Kim on 2017/05/29.
//  Copyright © 2017 kokaru. All rights reserved.
//

@interface FMMemoryUsage : NSObject

+(instancetype)sharedInstance;
-(NSString*)printMemoryUsage;

@end
