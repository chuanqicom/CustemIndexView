//
//  RootViewController.m
//  CCS
//
//  Created by 维信金科 on 16/12/14.
//  Copyright © 2016年 OrangeCat. All rights reserved.
//

#import "RootViewController.h"
#import "ProvincesChooseViewController.h"

@interface RootViewController ()

@property (nonatomic, strong) UIButton *queryBtn;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"自定义tableView索引";
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.center = self.view.center;
    [button setTitle:@"查看" forState:UIControlStateNormal];
    [button sizeToFit];
    [button addTarget:self action:@selector(jumpToQueryVc) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    self.queryBtn = button;
}

#pragma mark - 跳转公积金

- (void)jumpToQueryVc{
    ProvincesChooseViewController *resultVc = [[ProvincesChooseViewController alloc] init];
    resultVc.sectionTitles = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M"];
    [self.navigationController pushViewController:resultVc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
