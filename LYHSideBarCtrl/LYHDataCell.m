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
        self.icon = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 20, 20)];
        self.icon.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.icon];
        self.mTitle = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.icon.frame) + 10, 10, 200, 40)];
        self.mTitle.textColor = [UIColor whiteColor];
        [self.contentView addSubview:self.mTitle];
    }
    return self;
}
- (void)configureForData:( SideItem*)item
{
    self.mTitle.text = item.title;
    self.icon.image= [UIImage imageNamed:item.iconName];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
