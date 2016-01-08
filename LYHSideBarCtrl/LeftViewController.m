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
#import "SideItem.h"
#import "LYHMyFileViewController.h"
#import "LYHSideBarViewController.h"
@interface LeftViewController ()
{
    LYHArrayDataSource * _dataSource;
    LYHTableDelegate * _delegate;
    NSInteger selectIndex;
    UIImageView * headImage;
    UIImageView * rCodeImage;
    UIImageView * bgImage;
    UILabel * nameLabel;
    UILabel * descriptionLabel;

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
    
    headImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 60, 55, 55)];
    headImage.clipsToBounds = YES;
    headImage.layer.borderWidth = 1.0f;
    headImage.backgroundColor = [UIColor lightGrayColor];
    headImage.userInteractionEnabled = YES;
    headImage.layer.cornerRadius = 55.0/2;
    headImage.layer.borderColor = [UIColor whiteColor].CGColor;
    headImage.layer.borderWidth = 1.0f;
    headImage.image = [UIImage imageNamed:@"headimage.jpg"];
    [self.view addSubview:headImage];
    
    nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headImage.frame) + 10, headImage.frame.origin.y + 6, 100, 20)];
    nameLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.text = @"潭清";
    [self.view addSubview:nameLabel];
    
    rCodeImage = [[UIImageView alloc]initWithFrame:CGRectMake(ContentOffset - 45, nameLabel.frame.origin.y, 25, 25)];
    rCodeImage.backgroundColor =[UIColor clearColor];
    rCodeImage.image = [UIImage imageNamed:@"sidebar_ QRcode_normal"];
    [self.view addSubview:rCodeImage];
    
    NSArray * levelImageArray = @[@"usersummary_icon_lv_crown",@"usersummary_icon_lv_sun",@"usersummary_icon_lv_sun",@"usersummary_icon_lv_moon",@"usersummary_icon_lv_star"];
    for (int i = 0; i<levelImageArray.count; i++) {
        UIImageView * levelImage = [[UIImageView alloc]initWithFrame:CGRectMake(nameLabel.frame.origin.x + 14 * i, CGRectGetMaxY(nameLabel.frame) + 12, 12, 12)];
        levelImage.backgroundColor = [UIColor clearColor];
        levelImage.image = [UIImage imageNamed:levelImageArray[i]];
        [self.view addSubview:levelImage];
    }
    
    descriptionLabel = [[UILabel alloc]initWithFrame:CGRectMake(headImage.frame.origin.x, CGRectGetMaxY(headImage.frame) + 6, 100, 20)];
    descriptionLabel.font = [UIFont systemFontOfSize:15.0f];
    descriptionLabel.textAlignment = NSTextAlignmentLeft;
    descriptionLabel.textColor = [UIColor lightGrayColor];
    descriptionLabel.text = @"“  上善若水";
    [self.view addSubview:descriptionLabel];
    
    bgImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(headImage.frame),ContentOffset, 160)];
    bgImage.image = [UIImage imageNamed:@"sidebar_bg.jpg"];
    [self.view addSubview:bgImage];
    [self.view bringSubviewToFront:descriptionLabel];

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
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(bgImage.frame) - 40, SCREENWIDTH, self.view.bounds.size.height - 200) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    TableViewCellConfigureBlock configureBlock = ^(LYHDataCell *cell,SideItem * item){
        [cell configureForData:item];
    };
    NSArray * titleArray = @[@"开通会员",@"QQ钱包",@"个性装扮",@"我的收藏",@"我的相册",@"我的文件"];
    NSArray * iconArray = @[@"sidebar_favorite",@"sidebar_purse",@"sidebar_decoration",@"sidebar_favorit",@"sidebar_album",@"sidebar_file",];
    NSMutableArray * array = [[NSMutableArray alloc]initWithCapacity:0];
    for (int i = 0; i< titleArray.count; i++) {
        SideItem *item = [[SideItem alloc]init];
        item.title = titleArray[i];
        item.iconName = iconArray[i];
        [array addObject:item];
    }
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
    [self.view addSubview:tableView];
    
}
- (UINavigationController *)subControllerWithIndex:(NSInteger)index
{
    MainViewController * mainView =[[MainViewController alloc]init];
    UINavigationController * navCtrl = [[UINavigationController alloc]initWithRootViewController:mainView];
    return navCtrl;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
