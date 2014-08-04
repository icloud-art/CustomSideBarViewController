//
//  LeftViewController.m
//  LYHSideBarCtrl
//
//  Created by Charles Leo on 14-8-4.
//  Copyright (c) 2014年 Charles Leo. All rights reserved.
//

#import "LeftViewController.h"
#import "MainViewController.h"
#import "LYHTableDelegate.h"
#import "LYHArrayDataSource.h"
#import "LYHDataCell.h"
@interface LeftViewController ()
{
    LYHArrayDataSource * _dataSource;
    LYHTableDelegate * _delegate;
}
@end

@implementation LeftViewController
@synthesize delegate;
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
    self.view.backgroundColor = [UIColor brownColor];
    if ([self.delegate respondsToSelector:@selector(leftSideBarSelectWithController:)]) {
        [self.delegate leftSideBarSelectWithController: [self subControllerWithIndex:0]];
    }
    UITableView * tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    TableViewCellConfigureBlock configureBlock = ^(LYHDataCell *cell,NSString * title){
        [cell configureForData:title];
    };
    NSArray * array = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10"];
    _dataSource = [[LYHArrayDataSource alloc]initWithItems:array cellItentifier:@"ID" configureCellBlock:configureBlock];
    tableView.dataSource = _dataSource;
    
    TableViewDelegateConfigureBlock delegateBlock = ^(LYHDataCell *cell,NSIndexPath * indexPath){
        
    };
    _delegate = [[LYHTableDelegate alloc]initWithCount:array.count andHeight:60 andConfigureBlock:delegateBlock];
    tableView.delegate = _delegate;
    [self.view addSubview:tableView];
}
- (UINavigationController *)subControllerWithIndex:(NSInteger)index
{
    MainViewController * mainView =[[MainViewController alloc]init];
    mainView.title = @"自定义SideBar";
    UINavigationController * navCtrl = [[UINavigationController alloc]initWithRootViewController:mainView];
    return navCtrl;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
