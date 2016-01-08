//
//  ContactListViewController.m
//  QQ
//
//  Created by Charles on 16/1/8.
//  Copyright © 2016年 Charles Leo. All rights reserved.
//

#import "ContactListViewController.h"

@interface ContactListViewController ()
@property (strong,nonatomic) UITableView * mTableView;
@end

@implementation ContactListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = bgViewColor;
    self.title = @"联系人";
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
