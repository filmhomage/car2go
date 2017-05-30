//
//  NSMutableArray+Sort.h
//  car2go_sample
//
//  Created by Jonghyun Kim on 2017/05/29.
//  Copyright © 2017 kokaru. All rights reserved.
//

@interface NSMutableArray (Sort)

+(NSMutableArray*)sortArrayList:(NSMutableArray*)arrDeviceList filterKeyName:(NSString*)sortKeyName ascending:(BOOL)isAscending;
    
@end
