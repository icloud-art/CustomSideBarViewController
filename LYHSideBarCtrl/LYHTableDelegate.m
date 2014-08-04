//
//  LYHTableDelegate.m
//  LighterTableViewController
//
//  Created by Charles Leo on 14-7-27.
//  Copyright (c) 2014年 Charles Leo. All rights reserved.
//

#import "LYHTableDelegate.h"
#import "LYHDataCell.h"
@interface LYHTableDelegate()

@property (assign,nonatomic) NSInteger mCount;
@property (assign,nonatomic) CGFloat  mHeight;
@property (copy,nonatomic) TableViewDelegateConfigureBlock configureBlock;
@end
@implementation LYHTableDelegate
- (id)initWithCount:(NSInteger)count andHeight:(CGFloat)height andConfigureBlock:(TableViewDelegateConfigureBlock)block
{
    if (self = [super init]) {
        self.mCount = count;
        self.mHeight = height;
        self.configureBlock = [block copy];
    }
    return self;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.mHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYHDataCell * cell = (LYHDataCell *)[tableView cellForRowAtIndexPath:indexPath];
    self.configureBlock(cell,indexPath);
}
@end
