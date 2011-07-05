//
//  RootViewController.m
//  WifiME
//
//  Created by Szabolcs Tóth on 7/4/11.
//  Copyright 2011 Bme. All rights reserved.
//

#import "RootViewController.h"

@implementation RootViewController

@synthesize textView, networks;

- (id)init
{
    //self = [super init];
    if (self = [super init]) {
        self.networks = [[NSMutableDictionary alloc] init];
        
        libHandle = dlopen("/System/Library/SystemConfiguration/WiFiManager.bundle/WiFiManager", RTLD_LAZY);
        
        char *error;
        if (libHandle == NULL && (error = dlerror()) != NULL) {
            //exit(1);
            NSLog(@"hahaha");
        }
        
        open = dlsym(libHandle, "Apple80211Open");
        bind = dlsym(libHandle, "Apple80211BindToInterface");
        close = dlsym(libHandle, "Apple80211Close");
        scan = dlsym(libHandle, "Apple80211Scan");
        
        open(&airportHandle);
        bind(airportHandle, @"en0");
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    close(airportHandle);
    [textView release];
    [networks release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 480.0)];
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(0.0, 20.0, 320.0, 460.0)];
    [self.view addSubview:textView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self scanNetworks];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Own Stuff

- (void)scanNetworks
{
    NSDictionary *parameters = [[NSDictionary alloc] init];
    NSArray *scan_networks;
    
    scan(airportHandle, &scan_networks, parameters);
    
    for (int i = 0; i < [scan_networks count]; i++){
        [networks setObject:[scan_networks objectAtIndex:i] forKey:[[scan_networks objectAtIndex:i] objectForKey:@"BSSID"]];
    }

    NSMutableString *result = [[NSMutableString alloc] initWithString:@"Networks:"];
    
    for (id key in networks) {
        [result appendString:[NSString stringWithFormat:@"\n%@ (MAC: %@), RSSI: %@, Channel: %@ \n", 
                              [[networks objectForKey:key] objectForKey:@"SSID_STR"],
                              key,
                              [[networks objectForKey:key] objectForKey:@"RSSI"],
                              [[networks objectForKey:key] objectForKey:@"CHANNEL"]
                              ]];
    }
    
    self.textView.text = result;
}

@end