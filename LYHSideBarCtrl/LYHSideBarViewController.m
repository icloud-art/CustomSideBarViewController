//
//  LYHSideBarViewController.m
//  LYHSideBarCtrl
//
//  Created by Charles Leo on 14-8-4.
//  Copyright (c) 2014年 Charles Leo. All rights reserved.
//

#import "LYHSideBarViewController.h"
#import "LeftViewController.h"
#import "RightViewController.h"
#import "MessageViewController.h"
#import "ContactListViewController.h"
#import "DynamicViewController.h"
@interface LYHSideBarViewController ()
{
    UIViewController * currentMainViewController;
    CGFloat currentTranslate;
    UIPanGestureRecognizer * panGestureRecognizer;
    UITapGestureRecognizer * tapGestureRecognizer;
    UITabBarController * tabbar;
}
//声明左右视图控制器属性
@property (strong,nonatomic) UIViewController * leftViewController;
@property (strong,nonatomic) UIViewController * rightViewController;
@end

@implementation LYHSideBarViewController
@synthesize contentView,navBackView,sideBarShowing,leftViewController,rightViewController;
static LYHSideBarViewController * rootController;
const int ContentMinOffset = 60;
const float MoveAnimationDuration = 0.8;
+(id)share
{
    return rootController;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //初始化根控制器
    if (rootController) {
        rootController = nil;
    }
    rootController = self;
    //起初,没有任何偏移
    currentTranslate = 0;
    sideBarShowing = NO;
    //设置内容视图的边界阴影
    self.contentView.layer.shadowOffset = CGSizeMake(0, 0);
    self.contentView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.contentView.layer.shadowOpacity = 1;
    //初始化内容视图和背景视图
    self.navBackView = [[UIView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.navBackView];
    self.contentView = [[UIView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.contentView];
    //添加子视图控制器
    LeftViewController * leftView = [[LeftViewController alloc]init];
    leftView.delegate = self;
    self.leftViewController = leftView;
	[self addChildViewController:self.leftViewController];
    RightViewController * rightView = [[RightViewController alloc]init];
    self.rightViewController = rightView;
    [self addChildViewController:self.rightViewController];
    
    self.leftViewController.view.frame = self.navBackView.bounds;
    self.rightViewController.view.frame = self.navBackView.bounds;
    
    [self.navBackView addSubview:self.leftViewController.view];
    [self.navBackView addSubview:self.rightViewController.view];
    
    panGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panInContentView:)];
    [self.contentView addGestureRecognizer:panGestureRecognizer];
    
    [self makeToolBarView];
}
- (void)makeToolBarView{
    
    tabbar = [[UITabBarController alloc]init];
    [self addChildViewController:tabbar];
    [self.contentView addSubview:tabbar.view];
    
    
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
- (void)buttonClick:(UIButton *)sender{
    NSLog(@"%zi",sender.tag);
}
/**
 平移手势处理事件
 */
- (void)panInContentView:(UIPanGestureRecognizer *)panRecognizer
{
    if (panRecognizer.state == UIGestureRecognizerStateChanged) {
        CGFloat translation = [panRecognizer translationInView:self.contentView].x;
        self.contentView.transform = CGAffineTransformMakeTranslation(translation+currentTranslate, 0);
        UIView * view;
        if (translation+currentTranslate>0) {
            view = self.leftViewController.view;
        }
        else
        {
            view = self.rightViewController.view;
        }
        [self.navBackView bringSubviewToFront:view];
        [self statusBarView].transform = panRecognizer.view.transform;
    }
    else if(panRecognizer.state == UIGestureRecognizerStateEnded)
    {
        currentTranslate = self.contentView.transform.tx;
        //不显示SideBar的情况
        if (!sideBarShowing)
        {
            //当前偏移量小于最小偏移量不显示SideBar
            if (fabs(currentTranslate)<ContentMinOffset) {
                [self moveAnimationWithDirection:SideBarShowDirectionNone duration:MoveAnimationDuration];
            }
            //当前偏移量大于最小偏移量,显示左边SideBar
            else if(currentTranslate > ContentMinOffset)
            {
                [self moveAnimationWithDirection:SideBarShowDirectionLeft duration:MoveAnimationDuration];
            }
            //其他情况均显示右侧SideBar
            else
            {
                [self moveAnimationWithDirection:SideBarShowDirectionRight duration:MoveAnimationDuration];
            }
        }
        //SideBar已经显示的时候
        else
        {
            //如果当前偏移量的绝对值小于最大偏移量和最小偏移量的差,那么不显示SideBar
            if (fabs(currentTranslate)<ContentOffset - ContentMinOffset) {
                [self moveAnimationWithDirection:SideBarShowDirectionNone duration:MoveAnimationDuration];
            }
            //如果当前偏移量大于最大偏移量和最小偏移量的差,则显示左边SideBar(此时本来显示的是左边,即没有变化)
            else if (currentTranslate > ContentOffset - ContentMinOffset)
            {
                [self moveAnimationWithDirection:SideBarShowDirectionLeft duration:MoveAnimationDuration];
            }
            //如果当前偏移量小于最大偏移量和最小偏移量的差则显示右边SideBar(此时本来就显示的是右边,即没有变化)
            else
            {
                [self moveAnimationWithDirection:SideBarShowDirectionRight duration:MoveAnimationDuration];
            }
        }
    }
}
#pragma LYHSideBarDelegate的委托方法
- (void)leftSideBarSelectWithController:(UIViewController *)controller
{

    if ([controller isKindOfClass:[UINavigationController class]])
    {
        [(UINavigationController *)controller setDelegate:self];
    }
    if (currentMainViewController == nil) {
        controller.view.frame = self.contentView.bounds;
        currentMainViewController = controller;
        [self addChildViewController:currentMainViewController];
        [self.contentView addSubview:currentMainViewController.view];
        [currentMainViewController didMoveToParentViewController:self];
        [self.navBackView bringSubviewToFront:tabbar.view];
    }
    else if (controller!=nil && currentMainViewController !=controller) {
        controller.view.frame = self.contentView.bounds;
        [currentMainViewController willMoveToParentViewController:nil];
        [self addChildViewController:controller];
        self.view.userInteractionEnabled = NO;
        [self transitionFromViewController:currentMainViewController toViewController:controller duration:0 options:UIViewAnimationOptionTransitionNone animations:nil completion:^(BOOL finished) {
            self.view.userInteractionEnabled = YES;
           [currentMainViewController removeFromParentViewController];
            [controller didMoveToParentViewController:self];
            currentMainViewController = controller;
        }];
        [self.navBackView bringSubviewToFront:tabbar.view];

    }
    [self showSideBarControllerWithDirection:SideBarShowDirectionNone];
}
/**
 显示SideBar的方法
 */
- (void) showSideBarControllerWithDirection:(SideBarShowDirection)direction
{
    if (direction!=SideBarShowDirectionNone)
    {
        UIView *view;
        if (direction == SideBarShowDirectionLeft) {
            view = self.leftViewController.view;
        }
        else
        {
            view = self.rightViewController.view;
        }
        [self.navBackView bringSubviewToFront:view];
    }
    [self moveAnimationWithDirection:direction duration:MoveAnimationDuration];
}
/**
 移动视图的方法
 */
- (void)moveAnimationWithDirection:(SideBarShowDirection)direction duration:(float)duration
{
    void (^animations)(void) = ^{
		switch (direction) {
            case SideBarShowDirectionNone:
            {
                [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:1 initialSpringVelocity:1.0 options:UIViewAnimationOptionTransitionNone animations:^{
                    self.contentView.transform = CGAffineTransformMakeTranslation(0, 0);
                    [self statusBarView].transform = self.contentView.transform;
                    
                } completion:nil];
            }
                break;
            case SideBarShowDirectionLeft:
            {
                
               [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
                   self.contentView.transform  = CGAffineTransformMakeTranslation(ContentOffset, 0);
                   /*
                    CGAffineTransform trans  = CGAffineTransformMakeTranslation(ContentOffset, 0);
                    CGAffineTransform scale = CGAffineTransformMakeScale(0.8, 0.8);
                    CGAffineTransform newTransform = CGAffineTransformConcat(trans, scale);
                    self.contentView.transform = newTransform;
                   */
                   [self statusBarView].transform = self.contentView.transform;
               } completion:nil];
            }
                break;
            case SideBarShowDirectionRight:
            {
                [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
                    self.contentView.transform  = CGAffineTransformMakeTranslation(-ContentOffset, 0);
                    [self statusBarView].transform = self.contentView.transform;
                } completion:nil];
            }
                break;
            default:
                break;
        }
	};
    void (^complete)(BOOL) = ^(BOOL finished) {
        self.contentView.userInteractionEnabled = YES;
        self.navBackView.userInteractionEnabled = YES;
        if (direction == SideBarShowDirectionNone)
        {
            
            if (tapGestureRecognizer) {
                [self.contentView removeGestureRecognizer:tapGestureRecognizer];
                tapGestureRecognizer = nil;
            }
            sideBarShowing = NO;
        }
        else
        {
            [self contentViewAddTapGestures];
            sideBarShowing = YES;
        }
        currentTranslate = self.contentView.transform.tx;
        NSLog(@"currentTanslate is %f",currentTranslate);
	};
    self.contentView.userInteractionEnabled = NO;
    self.navBackView.userInteractionEnabled = NO;
    [UIView animateWithDuration:duration animations:animations completion:complete];
}
/**
 获取当前状态栏的方法
 */
- (UIView*)statusBarView;
{
    UIView *statusBar = nil;
    NSData *data = [NSData dataWithBytes:(unsigned char []){0x73, 0x74, 0x61, 0x74, 0x75, 0x73, 0x42, 0x61, 0x72} length:9];
    NSString *key = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    id object = [UIApplication sharedApplication];
    if ([object respondsToSelector:NSSelectorFromString(key)]) statusBar = [object valueForKey:key];
    return statusBar;
}
/**
 添加单击手势
 */
- (void)contentViewAddTapGestures
{
    if (tapGestureRecognizer) {
        [self.contentView removeGestureRecognizer:tapGestureRecognizer];
        tapGestureRecognizer = nil;
    }
    tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapOnContentView:)];
    [self.contentView addGestureRecognizer:tapGestureRecognizer];
}
/**
 单机手势的处理事件
 */
- (void)tapOnContentView:(UITapGestureRecognizer *)tapGesture
{
    [self moveAnimationWithDirection:SideBarShowDirectionNone duration:MoveAnimationDuration];
}
- (void)rightSideBarSelectWithController:(UIViewController *)controller
{
    
}
#pragma UINavigationController的委托方法

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
}
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
