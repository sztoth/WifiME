//
//  WifiManager.h
//  WifiME
//
//  Created by Szabolcs Tóth on 7/6/11.
//  Copyright 2011 Bme. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WifiManagerProtocol.h"
#include <dlfcn.h>

@interface WifiManager : NSObject {
    NSMutableArray *networks;
    
    id<WifiManagerProtocol> delegate;
    bool periodic;
    NSTimeInterval timeInSec;
    NSTimer *timer;
    NSThread *workThread;
        
    void *libHandle;
    void *airportHandle;
    
    int (*open)(void *);
    int (*bind)(void *, NSString *);
    int (*close)(void *);
    int (*scan)(void *, NSArray **, void *);
}

@property (nonatomic, retain) id<WifiManagerProtocol> delegate;
@property (assign) bool periodic;
@property (assign) NSTimeInterval timeInSec;
@property (nonatomic, retain) NSMutableArray *networks;
@property (nonatomic, retain) NSThread *workThread;

-(void)startScan;
-(void)stopScan;
-(void)doItOnThread;
-(void)scanNetworks;
-(NSUInteger)numberOfNetworks;
-(NSArray *)networks;
-(NSDictionary *)network:(int)index;
-(NSString *)description;

@end
