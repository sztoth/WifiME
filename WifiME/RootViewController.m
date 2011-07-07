//
//  RootViewController.m
//  WifiME
//
//  Created by Szabolcs Tóth on 7/6/11.
//  Copyright 2011 Bme. All rights reserved.
//

#import "RootViewController.h"
#import "WifiManager.h"
//#import "CustomCell.h"

@implementation RootViewController

@synthesize tableView, wifiManager;

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
    [wifiManager release];
    [tableView release];
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
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 414.0)];
    
    self.wifiManager = [[WifiManager alloc] init];
    self.wifiManager.delegate = self;
    self.wifiManager.periodic = YES;
    self.wifiManager.timeInSec = 1.0;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 414.0) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:tableView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"WIFI";
    [wifiManager startScan];
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

#pragma mark - WifiManager protocol

- (void)scanUpdated
{
    [tableView reloadData];
    //NSArray *paths = [tableView indexPathsForVisibleRows];
    //[tableView reloadRowsAtIndexPaths:paths withRowAnimation:NO];
}

#pragma mark - TableView stuffs

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 100;
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [wifiManager numberOfNetworks];
}

- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *kCellIdentifier = @"TablaCella";
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier];
    }
    
    NSDictionary *dict = [wifiManager network:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ | %@",[dict objectForKey:@"SSID_STR"], [dict objectForKey:@"RSSI"]];
    //cell.name.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"SSID_STR"]];
    //cell.mac.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"BSSID"]];
    //cell.signal.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"RSSI"]];
    
    return cell;
}

- (void)tableView:(UITableView *)_tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"HAHA" 
                                                   message:@"EZ" 
                                                  delegate:nil 
                                         cancelButtonTitle:@"OK" 
                                         otherButtonTitles:nil];
    [alert show];
    [alert release];
    
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
