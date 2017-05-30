//
//  FMMemoryUsage.m
//  car2go_sample
//
//  Created by Jonghyun Kim on 2017/05/29.
//  Copyright © 2017 kokaru. All rights reserved.
//

#import <mach/mach.h>
#import <mach/mach_host.h>
#import "FMMemoryUsage.h"

@implementation FMMemoryUsage

+ (instancetype)sharedInstance {
    
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    return sharedInstance;
}

-(NSString*)printMemoryUsage {
    
    mach_port_t host_port;
    mach_msg_type_number_t host_size;
    vm_size_t pagesize;
    
    host_port = mach_host_self();
    host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    host_page_size(host_port, &pagesize);
    
    vm_statistics_data_t vm_stat;
    
    if (host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size) != KERN_SUCCESS) {
        NSLog(@"Failed to fetch vm statistics");
    }
    
    unsigned long mem_used = (vm_stat.active_count + vm_stat.inactive_count + (unsigned long)vm_stat.wire_count) * pagesize;
    unsigned long mem_free = (unsigned long)vm_stat.free_count * pagesize;
    unsigned long mem_total = mem_used + mem_free;
    
    int const byte = 1024*1024;
    
    NSString* memoryString = [NSString stringWithFormat:@"MEMORY [used: %ld MB] + [free: %ld MB] [total: %ld MB]", mem_used/byte, mem_free/byte, mem_total/byte];
    NSLog(@"%@", memoryString);
    memoryString = [NSString stringWithFormat:@"%ld", mem_used/byte];
    return memoryString;
}

@end
