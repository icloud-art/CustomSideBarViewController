//
//  LYHDataCell.h
//  LighterTableViewController
//
//  Created by Charles Leo on 14-7-25.
//  Copyright (c) 2014年 Charles Leo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SideItem.h"

@interface LYHDataCell : UITableViewCell
@property (retain,nonatomic) UILabel * mTitle;
@property (strong,nonatomic) UIImageView * icon;
- (void)configureForData:(SideItem *)item;
@end
