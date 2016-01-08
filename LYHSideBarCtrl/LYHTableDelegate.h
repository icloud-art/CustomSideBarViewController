//
//  LYHTableDelegate.h
//  LighterTableViewController
//
//  Created by Charles Leo on 14-7-27.
//  Copyright (c) 2014年 Charles Leo. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^TableViewDelegateConfigureBlock)(id cell,NSIndexPath *indexpath);
@interface LYHTableDelegate : NSObject<UITableViewDelegate>
- (id)initWithCount:(NSInteger)count andHeight:(CGFloat)height andConfigureBlock:(TableViewDelegateConfigureBlock)block;
@end
