//
//  LYHDataCell.m
//  LighterTableViewController
//
//  Created by Charles Leo on 14-7-25.
//  Copyright (c) 2014年 Charles Leo. All rights reserved.
//

#import "LYHDataCell.h"
@interface LYHDataCell()

@end
@implementation LYHDataCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.mTitle = [[UILabel alloc]initWithFrame:CGRectMake(30, 10, 200, 40)];
        [self.contentView addSubview:self.mTitle];
    }
    return self;
}
- (void)configureForData:(NSString *)data
{
    self.mTitle.text = data;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
