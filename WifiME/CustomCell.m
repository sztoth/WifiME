//
//  CustomCell.m
//  WifiME
//
//  Created by Szabolcs Tóth on 7/7/11.
//  Copyright 2011 Bme. All rights reserved.
//

#import "CustomCell.h"


@implementation CustomCell

@synthesize name, mac, signal;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.name = [[UILabel alloc] init];
        self.mac = [[UILabel alloc] init];
        self.signal = [[UILabel alloc] init];
        
        [self.contentView addSubview:name];
        [self.contentView addSubview:mac];
        [self.contentView addSubview:signal];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    CGRect contentRect = [self.contentView bounds];
    
    self.name.frame = CGRectMake(contentRect.origin.x + 10, 10, 100, 40);
    self.signal.frame = CGRectMake(contentRect.origin.x + 60, 10, 100, 40);
    self.mac.frame = CGRectMake(contentRect.origin.x + 10, 50, 100, 40);

}

- (void)dealloc
{
    [name release];
    [signal release];
    [mac release];
    [super dealloc];
}

@end
