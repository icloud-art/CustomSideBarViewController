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
@interface LYHSideBarViewController ()
{
    UIViewController * currentMainViewController;
    CGFloat currentTranslate;
}
//声明左右视图控制器属性
@property (strong,nonatomic) UIViewController * leftViewController;
@property (strong,nonatomic) UIViewController * rightViewController;
@end

@implementation LYHSideBarViewController
@synthesize contentView,navBackView,sideBarShowing,leftViewController,rightViewController;
static LYHSideBarViewController * rootController;
const int ContentOffset = 230;
const int ContentMinOffset = 60;
const float MoveAnimationDuration = 0.3;
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
- (void)moveAnimationWithDirection:(SideBarShowDirection)direction duration:(float)duration
{
    void (^animations)(void) = ^{
		switch (direction) {
            case SideBarShowDirectionNone:
            {
                self.contentView.transform  = CGAffineTransformMakeTranslation(0, 0);
            }
                break;
            case SideBarShowDirectionLeft:
            {
                self.contentView.transform  = CGAffineTransformMakeTranslation(ContentOffset, 0);
            }
                break;
            case SideBarShowDirectionRight:
            {
                self.contentView.transform  = CGAffineTransformMakeTranslation(-ContentOffset, 0);
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
            
//            if (tapGestureRecognizer) {
//                [self.contentView removeGestureRecognizer:tapGestureRecognizer];
//                tapGestureRecognizer = nil;
//            }
            sideBarShowing = NO;
        }
        else
        {
//            [self contentViewAddTapGestures];
            sideBarShowing = YES;
        }
        currentTranslate = self.contentView.transform.tx;
        NSLog(@"currentTanslate is %f",currentTranslate);
	};
    self.contentView.userInteractionEnabled = NO;
    self.navBackView.userInteractionEnabled = NO;
    [UIView animateWithDuration:duration animations:animations completion:complete];
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
