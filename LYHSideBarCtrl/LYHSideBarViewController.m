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
//#import "MainViewController.h"
@interface LYHSideBarViewController ()
{
    UIViewController * currentMainViewController;
    CGFloat currentTranslate;
    UIPanGestureRecognizer * panGestureRecognizer;
    UITapGestureRecognizer * tapGestureRecognizer;
   // MainViewController * mainViewController;
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
 -(void)rightSideBarSelectWithController:(UIViewController *)controller
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
