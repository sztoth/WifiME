//
//  WifiManager.m
//  WifiME
//
//  Created by Szabolcs Tóth on 7/6/11.
//  Copyright 2011 Bme. All rights reserved.
//

#import "WifiManager.h"


@implementation WifiManager

@synthesize delegate, periodic, timeInSec, networks, workThread;

- (id)init
{
    if (self = [super init]) {
        self.networks = [[NSMutableArray alloc] init];
        self.workThread = [[NSThread alloc] init];
        
//#if !(TARGET_IPHONE_SIMULATOR)
        
        libHandle = dlopen("/System/Library/SystemConfiguration/WiFiManager.bundle/WiFiManager", RTLD_LAZY);
        
        char *error;
        if (libHandle == NULL && (error = dlerror()) != NULL) {
            NSLog(@"%c | %s",error, error);
            //exit(-1);
        }
        
        open = dlsym(libHandle, "Apple80211Open");
        bind = dlsym(libHandle, "Apple80211BindToInterface");
        close = dlsym(libHandle, "Apple80211Close");
        scan = dlsym(libHandle, "Apple80211Scan");
        
        open(&airportHandle);
        bind(airportHandle, @"en0");
        
//#endif
    }
    return self;
}

- (void)dealloc
{
    close(airportHandle);
    [workThread release];
    [timer release];
    [networks release];
    [super dealloc];
}

#pragma mark - WIFI stuffs

- (void)startScan
{
    if (periodic) {
        if (timer == nil) {
            timer = [NSTimer scheduledTimerWithTimeInterval:timeInSec 
                                                     target:self 
                                                   selector:@selector(scanNetworks) 
                                                   userInfo:nil 
                                                    repeats:YES];
            [timer fire];
        }
    } else {
        [self scanNetworks];
    }
}

- (void)stopScan
{
    if (periodic) {
        [timer invalidate];
        timer = nil;
    }
}

- (void)doItOnThread
{
    [NSThread detachNewThreadSelector:@selector(scanNetworks) toTarget:self withObject:nil];
}

- (void)scanNetworks
{
//    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    NSDictionary *parameters = [[NSDictionary alloc] init];
    //NSArray *scan_networks;
    
//#if !(TARGET_IPHONE_SIMULATOR)
    
    scan(airportHandle, &networks, parameters);
    
    //self.networks = [NSMutableArray arrayWithArray:scan_networks];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(scanUpdated)]) {
        [self.delegate scanUpdated];
    }
    
    //[parameters release];
    
//#endif
    
//    [pool release];
}

- (NSUInteger)numberOfNetworks
{
    return [networks count];
    //return 5;
}

- (NSArray *)networks
{
    return networks;
}

- (NSDictionary *)network:(int)index
{
    //return [networks objectAtIndex:index];
    return [networks objectAtIndex:index];
}

- (NSString *)description
{
    NSMutableString *result = [[NSMutableString alloc] initWithString:@"Networks:\n"];
    
    for (id key in networks) {
        [result appendString:[NSString stringWithFormat:@"%@ %@ %@\n", 
                              [key objectForKey:@"BSSID"],
                              [key objectForKey:@"RSSI"],
                              [key objectForKey:@"SSID_STR"]
                              ]];
    }
    return [NSString stringWithString:result];
}

@end
