//
//  RootViewController.h
//  WifiME
//
//  Created by Szabolcs Tóth on 7/6/11.
//  Copyright 2011 Bme. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WifiManagerProtocol.h"

@class WifiManager;

@interface RootViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, WifiManagerProtocol> {
    UITableView *tableView;
    WifiManager *wifiManager;
}

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) WifiManager *wifiManager;

@end
