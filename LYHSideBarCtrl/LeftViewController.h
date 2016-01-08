//
//  LeftViewController.h
//  LYHSideBarCtrl
//
//  Created by Charles Leo on 14-8-4.
//  Copyright (c) 2014年 Charles Leo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYHSideBarDelegate.h"
@interface LeftViewController : UIViewController
@property (assign,nonatomic) id<LYHSideBarDelegate> delegate;
@end
