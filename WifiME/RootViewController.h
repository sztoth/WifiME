//
//  RootViewController.h
//  WifiME
//
//  Created by Szabolcs Tóth on 7/4/11.
//  Copyright 2011 Bme. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <dlfcn.h>

@interface RootViewController : UIViewController {
    NSMutableDictionary *networks;
    
    UITextView *textView;
    
    void *libHandle;
    void *airportHandle;
    
    int (*open)(void *);
    int (*bind)(void *, NSString *);
    int (*close)(void *);
    int (*scan)(void *, NSArray **, void *);
}

@property (nonatomic, retain) UITextView *textView;
@property (nonatomic, retain) NSMutableDictionary *networks;

-(void)scanNetworks;

@end
