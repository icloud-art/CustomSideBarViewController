//
//  LYHDataCell.h
//  LighterTableViewController
//
//  Created by Charles Leo on 14-7-25.
//  Copyright (c) 2014年 Charles Leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYHDataCell : UITableViewCell
@property (retain,nonatomic) UILabel * mTitle;

- (void)configureForData:(NSString *)data;
@end
