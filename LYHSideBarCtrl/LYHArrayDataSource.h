//
//  LYHArrayDataSource.h
//  LighterTableViewController
//
//  Created by Charles Leo on 14-7-24.
//  Copyright (c) 2014年 Charles Leo. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^TableViewCellConfigureBlock) (id cell,id item);
@interface LYHArrayDataSource : NSObject<UITableViewDataSource>


-(id)initWithItems:(NSArray *)anItems cellItentifier:(NSString *)aCellIdentifier configureCellBlock:(TableViewCellConfigureBlock)aConofigureCellBlock;

- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

@end
