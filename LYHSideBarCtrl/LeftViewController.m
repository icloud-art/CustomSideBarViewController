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
    NSInteger selectIndex;
    UIImageView * headImage;
    UIImageView * rCodeImage;
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
- (void)makeView{
    
    headImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 60, 60, 60)];
    headImage.clipsToBounds = YES;
    headImage.layer.borderWidth = 1.0f;
    headImage.backgroundColor = [UIColor lightGrayColor];
    headImage.userInteractionEnabled = YES;
    headImage.layer.cornerRadius = 30.0f;
    headImage.layer.borderColor = [UIColor whiteColor].CGColor;
    headImage.layer.borderWidth = 1.0f;
    [self.view addSubview:headImage];
    
    UIImageView * bgImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(headImage.frame),ContentOffset, 160)];
    bgImage.image = [UIImage imageNamed:@"sidebar_bg.jpg"];
    [self.view addSubview:bgImage];
    
    UIView * containerView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(bgImage.frame), ContentOffset, SCREENHEIGHT - CGRectGetHeight(headImage.frame) - CGRectGetHeight(bgImage.frame))];
    containerView.backgroundColor = customerBlue;
    [self.view addSubview:containerView];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = customerBgColor;
    [self makeView];

    if ([self.delegate respondsToSelector:@selector(leftSideBarSelectWithController:)]) {
        [self.delegate leftSideBarSelectWithController: [self subControllerWithIndex:0]];
        selectIndex = 0;
    }
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, self.view.bounds.size.height - 200) style:UITableViewStylePlain];
    
    TableViewCellConfigureBlock configureBlock = ^(LYHDataCell *cell,NSString * title){
        [cell configureForData:title];
    };
    NSArray * array = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10"];
    _dataSource = [[LYHArrayDataSource alloc]initWithItems:array cellItentifier:@"ID" configureCellBlock:configureBlock];
    tableView.dataSource = _dataSource;
    
    TableViewDelegateConfigureBlock delegateBlock = ^(LYHDataCell *cell,NSIndexPath * indexPath){
        if ([delegate respondsToSelector:@selector(leftSideBarSelectWithController:)]) {
            if (indexPath.row == selectIndex) {
                [delegate leftSideBarSelectWithController:nil];
            }
            else
            {
                [delegate leftSideBarSelectWithController:[self subControllerWithIndex:indexPath.row]];
            }
        }
        selectIndex = indexPath.row;
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    };
    _delegate = [[LYHTableDelegate alloc]initWithCount:array.count andHeight:60 andConfigureBlock:delegateBlock];
    tableView.delegate = _delegate;
//    [self.view addSubview:tableView];
    
}
- (UINavigationController *)subControllerWithIndex:(NSInteger)index
{
    MainViewController * mainView =[[MainViewController alloc]init];
    mainView.title = @"自定义SideBar";
    mainView.titleText = [NSString stringWithFormat:@"第%ld行",index + 1];
    UINavigationController * navCtrl = [[UINavigationController alloc]initWithRootViewController:mainView];
    return navCtrl;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
