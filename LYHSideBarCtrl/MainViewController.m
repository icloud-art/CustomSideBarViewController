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
        
        UIBarButtonItem *flexSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem: UIBarButtonSystemItemFixedSpace target:self action:nil];
        flexSpacer.width = -10;
        
        
        UIButton * btnLeft = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btnLeft.frame = CGRectMake(0, 0, 35, 35);
        btnLeft.clipsToBounds = YES;
        btnLeft.layer.cornerRadius = 35.0/2;
        [btnLeft setBackgroundImage:[UIImage imageNamed:@"headimage.jpg"] forState:UIControlStateNormal];
        
        [btnLeft addTarget:self action:@selector(btnLeft) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem * barLeft = [[UIBarButtonItem alloc]initWithCustomView:btnLeft];
        
        self.navigationItem.leftBarButtonItems = @[flexSpacer,barLeft];
        
        UIButton * btnRight = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btnRight.frame = CGRectMake(0, 0, 30, 30);
        [btnRight setBackgroundImage:[UIImage imageNamed:@"header_icon_list"] forState:UIControlStateNormal];
        [btnRight addTarget:self action:@selector(btnRight) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem * barRight = [[UIBarButtonItem alloc]initWithCustomView:btnRight];
        self.navigationItem.rightBarButtonItems = @[flexSpacer,barRight];
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
	self.view.backgroundColor = [UIColor whiteColor];
    UIImageView * tipImageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 75)];
    tipImageView.backgroundColor = [UIColor clearColor];
    tipImageView.center = self.view.center;
    tipImageView.image = [UIImage imageNamed:@"group_verify_blank"];
    [self.view addSubview:tipImageView];
    
    
    UILabel * descriptionLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(tipImageView.frame) + 10, SCREENWIDTH, 20)];
    descriptionLabel.font = [UIFont systemFontOfSize:15.0f];
    descriptionLabel.textAlignment = NSTextAlignmentCenter;
    descriptionLabel.textColor = [UIColor lightGrayColor];
    descriptionLabel.text = @"暂时没有新消息";
    [self.view addSubview:descriptionLabel];

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
