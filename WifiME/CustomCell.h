//
//  CustomCell.h
//  WifiME
//
//  Created by Szabolcs Tóth on 7/7/11.
//  Copyright 2011 Bme. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CustomCell : UITableViewCell {
    UILabel *name;
    UILabel *mac;
    UILabel *signal;
}

@property (nonatomic, retain) UILabel *name;
@property (nonatomic, retain) UILabel *mac;
@property (nonatomic, retain) UILabel *signal;

@end
