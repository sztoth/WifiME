//
//  WifiMEAppDelegate.h
//  WifiME
//
//  Created by Szabolcs Tóth on 7/4/11.
//  Copyright 2011 Bme. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

@interface WifiMEAppDelegate : NSObject <UIApplicationDelegate> {
    RootViewController *rootController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) RootViewController *rootController;

@end
