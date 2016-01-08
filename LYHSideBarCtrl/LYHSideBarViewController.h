//
//  LYHSideBarViewController.h
//  LYHSideBarCtrl
//
//  Created by Charles Leo on 14-8-4.
//  Copyright (c) 2014年 Charles Leo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYHSideBarDelegate.h"
@interface LYHSideBarViewController : UIViewController<LYHSideBarDelegate,UINavigationControllerDelegate>

@property (strong,nonatomic) UIView * contentView;
@property (strong,nonatomic) UIView * navBackView;
@property (assign,nonatomic) BOOL sideBarShowing;
+(id)share;
@end
