//
//  MainViewController.m
//  LYHSideBarCtrl
//
//  Created by Charles Leo on 14-8-4.
//  Copyright (c) 2014年 Charles Leo. All rights reserved.
//

#import "MainViewController.h"
#import "LYHSideBarViewController.h"
@interface MainViewController ()
{
   
}
@end

@implementation MainViewController
@synthesize titleText,mScrollView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIButton * btnLeft = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btnLeft.frame = CGRectMake(0, 0, 80, 30);
        [btnLeft setTitle:@"左边" forState:UIControlStateNormal];
        [btnLeft addTarget:self action:@selector(btnLeft) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem * barLeft = [[UIBarButtonItem alloc]initWithCustomView:btnLeft];
        self.navigationItem.leftBarButtonItem = barLeft;
        
        UIButton * btnRight = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btnRight.frame = CGRectMake(0, 0, 80, 30);
        [btnRight setTitle:@"右边" forState:UIControlStateNormal];
        [btnRight addTarget:self action:@selector(btnRight) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem * barRight = [[UIBarButtonItem alloc]initWithCustomView:btnRight];
        self.navigationItem.rightBarButtonItem = barRight;
    }
    return self;
}
- (void)btnLeft{
    LYHSideBarViewController * sideBar = [LYHSideBarViewController share];
    if (sideBar.sideBarShowing == YES) {
        [[LYHSideBarViewController share]showSideBarControllerWithDirection:SideBarShowDirectionNone];
    }
    else
    {
        [[LYHSideBarViewController share]showSideBarControllerWithDirection:SideBarShowDirectionLeft];
    }
}
- (void)btnRight{
    LYHSideBarViewController * sideBar = [LYHSideBarViewController share];
    if (sideBar.sideBarShowing == YES) {
        [[LYHSideBarViewController share] showSideBarControllerWithDirection:SideBarShowDirectionNone];
    }
    else
    {
        [[LYHSideBarViewController share]showSideBarControllerWithDirection:SideBarShowDirectionRight];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor greenColor];
    
//    self.mScrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
//    self.mScrollView.backgroundColor = [UIColor yellowColor];
//    self.mScrollView.contentSize = CGSizeMake(320 * 10, 568-64);
//    self.mScrollView.showsVerticalScrollIndicator = NO;
//    self.mScrollView.showsHorizontalScrollIndicator = NO;
//    self.mScrollView.bounces = NO;
//    self.mScrollView.delegate = self;
//    self.mScrollView.alwaysBounceVertical = NO;
//    self.mScrollView.alwaysBounceHorizontal = YES;
//    self.mScrollView.pagingEnabled = YES;
//    //[self.view addSubview:self.mScrollView];
//    for (int i = 0 ; i<10; i++) {
//        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(320 * i, 0, 320, 568-64)];
//        imageView.backgroundColor = [UIColor brownColor];
//        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 300, 320, 40)];
//        label.backgroundColor = [UIColor clearColor];
//        label.font = [UIFont systemFontOfSize:17.0f];
//        label.textAlignment = NSTextAlignmentCenter;
//        [imageView addSubview:label];
//        label.text = [NSString stringWithFormat:@"第%d页",i];
//        [self.mScrollView addSubview:imageView];
//    }
//    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 300, 320, 40)];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:17.0f];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    label.text = [NSString stringWithFormat:@"%@",self.titleText];
}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSLog(@"begin");
    CGPoint velocity = [scrollView.panGestureRecognizer velocityInView:scrollView.panGestureRecognizer.view];
    CGPoint translation = [scrollView.panGestureRecognizer  translationInView:scrollView.panGestureRecognizer.view];
     NSLog(@"translation.x is %f velocity.x is %f",translation.x,velocity.x);
    //如果scrollview的偏移为0并且手势方向为从左向右滑,则显示左边SideBar
    if (scrollView.contentOffset.x == 0 && translation.x > 0) {
       [[LYHSideBarViewController share]showSideBarControllerWithDirection:SideBarShowDirectionLeft];
        //scrollView.panGestureRecognizer.view.userInteractionEnabled = NO;
        //self.mScrollView.userInteractionEnabled = NO;
    }
    if (scrollView.contentOffset.x == 320 * 9) {
        [[LYHSideBarViewController share]showSideBarControllerWithDirection:SideBarShowDirectionRight];
        // self.mScrollView.userInteractionEnabled = NO;
    }
}
- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"mainView willappear");
}
- (void)viewDidDisappear:(BOOL)animated
{
    NSLog(@"mainview diddisappear");
}
- (void)viewDidAppear:(BOOL)animated
{
    NSLog(@"mainview didAppear");
}
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
//{
//    if ([touch.view isKindOfClass:[UIScrollView class]]) {
//        return NO;
//    }
//    return YES;
//}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSLog(@"scrollview.offSet is %f",scrollView.contentOffset.x);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
