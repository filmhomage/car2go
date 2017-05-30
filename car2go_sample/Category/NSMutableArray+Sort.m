//
//  NSMutableArray+Sort.m
//  car2go_sample
//
//  Created by Jonghyun Kim on 2017/05/29.
//  Copyright © 2017 kokaru. All rights reserved.
//

#import "NSMutableArray+Sort.h"

@implementation NSMutableArray (Sort)

+(NSMutableArray*)sortArrayList:(NSMutableArray*)arrDeviceList filterKeyName:(NSString*)sortKeyName ascending:(BOOL)isAscending {
    
    NSSortDescriptor *sorter = [[NSSortDescriptor alloc] initWithKey:sortKeyName ascending:isAscending];
    [arrDeviceList sortUsingDescriptors:[NSArray arrayWithObject:sorter]];
    return arrDeviceList;
}

@end
