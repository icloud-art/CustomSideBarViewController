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

@end

@implementation MainViewController
@synthesize titleText;
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
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 300, 320, 40)];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:17.0f];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    label.text = self.titleText;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
