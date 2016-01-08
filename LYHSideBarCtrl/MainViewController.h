//
//  MainViewController.h
//  LYHSideBarCtrl
//
//  Created by Charles Leo on 14-8-4.
//  Copyright (c) 2014年 Charles Leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController <UIScrollViewDelegate,UIGestureRecognizerDelegate>
@property (copy,nonatomic) NSString * titleText;
@property (strong,nonatomic)  UIScrollView * mScrollView;
@end
