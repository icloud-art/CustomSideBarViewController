//
//  MainViewController.m
//  LYHSideBarCtrl
//
//  Created by Charles Leo on 14-8-4.
//  Copyright (c) 2014年 Charles Leo. All rights reserved.
//

#import "MainViewController.h"
#import "LYHSideBarViewController.h"
#import "MessageViewController.h"
#import "ContactListViewController.h"
#import "DynamicViewController.h"
@interface MainViewController ()
{
    UITabBarController * tabbar;
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
- (void)makeToolBarView{
    
    tabbar = [[UITabBarController alloc]init];
    [self addChildViewController:tabbar];
    [self.view addSubview:tabbar.view];
    
    
    //    toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0,SCREENHEIGHT - 44, SCREENWIDTH, 44)];
    //    toolBar.backgroundColor = [UIColor whiteColor];
    //    NSArray * titleArray = @[@"消息",@"联系人",@"动态"];
    //    NSArray * imgArray = @[@"sidebar_album",@"sidebar_album",@"sidebar_album"];
    //    NSArray * highImgArray = @[@"sidebar_album",@"sidebar_album",@"sidebar_album"];
    //    for (int i=0 ;i <3 ; i++) {
    //
    //        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    //        button.frame = CGRectMake(SCREENWIDTH/3*i, 0,SCREENWIDTH/3, 30);
    //        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    //        [button setImage:[UIImage imageNamed:imgArray[i]] forState:UIControlStateNormal];
    //        button.tag = 100+i;
    //        [button setImage:[UIImage imageNamed:imgArray[i]] forState:UIControlStateHighlighted];
    //        [toolBar addSubview:button];
    //        UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(button.frame.origin.x, CGRectGetMaxY(button.frame), SCREENWIDTH/3, 14)];
    //        titleLabel.text  = titleArray[i];
    //        titleLabel.textAlignment = NSTextAlignmentCenter;
    //        titleLabel.font = [UIFont systemFontOfSize:13.0f];
    //        titleLabel.textColor = [UIColor grayColor];
    //        titleLabel.alpha = 0.8;
    //        [toolBar addSubview:titleLabel];
    //    }
    //    [self.contentView addSubview:toolBar];
    //
    //    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    //
    //    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithCustomView:<#(nonnull UIView *)#> target:self action:@selector(toobarAction:)];
    //    UIBarButtonItem *item2 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(toobarAction:)];
    //    UIBarButtonItem *item3 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(toobarAction:)];
    //
    //    NSArray *items = [NSArray arrayWithObjects:spaceItem,item1,spaceItem,item2,spaceItem,item3,nil];
    //    toolBar.items = items;
    
    
    NSMutableArray * array = [[NSMutableArray alloc] initWithCapacity:0];
    
    MessageViewController *messageVC = [[MessageViewController alloc] init];
    
    UINavigationController * nav1 = [[UINavigationController alloc]initWithRootViewController:messageVC];
    UITabBarItem *item1 = [[UITabBarItem alloc]initWithTitle:@"消息" image:[[UIImage imageNamed:@"tab_recent_nor"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tab_recent_press"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    nav1.tabBarItem=item1;
    
    ContactListViewController * contactVC = [[ContactListViewController alloc]init];
    UINavigationController * nav2 = [[UINavigationController alloc]initWithRootViewController:contactVC];
    UITabBarItem *item2 = [[UITabBarItem alloc]initWithTitle:@"联系人" image:[[UIImage imageNamed:@"tab_buddy_nor"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tab_buddy_press"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    nav2.tabBarItem=item2;
    [array addObject:nav2];

    DynamicViewController * dynamicVC = [[DynamicViewController alloc]init];
    UINavigationController * nav3 = [[UINavigationController alloc]initWithRootViewController:dynamicVC];
    UITabBarItem *item3 = [[UITabBarItem alloc]initWithTitle:@"动态" image:[[UIImage imageNamed:@"tab_qworld_nor"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tab_qworld_press"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    nav3.tabBarItem=item3;
    [array addObject:nav3];
    
    tabbar.viewControllers = @[nav1,nav2,nav3];
    tabbar.selectedIndex = 0;
    tabbar.tabBar.selectedImageTintColor = customerBlue;
    
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
