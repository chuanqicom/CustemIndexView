//
//  ProvincesChooseViewController.m
//  GFB
//
//  Created by xiebin on 16/9/23.
//  Copyright © 2016年 Vision Credit  Financial Technology Cpmpany Limited. All rights reserved.
//

#import "ProvincesChooseViewController.h"
#import "IndexView.h"

#define itemHeight RATIO_H(18)
#define itemWidth RATIO_W(22)
#define itemHeaderFooterH RATIO_H(5)

@interface ProvincesChooseViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTab;
@property (nonatomic, weak) IndexView *indexView;
@property (nonatomic, strong) UILabel *showLabel;

@end

@implementation ProvincesChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createTableView];
    [self creatIndexView];
}

- (void)createTableView
{
    self.myTab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStylePlain];
    self.myTab.delegate = self;
    self.myTab.dataSource = self;
    [self.view addSubview:_myTab];
    [_myTab registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
}

- (void)creatIndexView{

    if (self.sectionTitles.count != 0) {
        
        CGFloat indexViewH = self.sectionTitles.count*itemHeight + itemHeaderFooterH *2;
        CGFloat indexViewY = (self.view.frame.size.height - indexViewH - 64) *0.5;
        
        IndexView *indexView = [[IndexView alloc]initWithFrame:CGRectMake(self.view.frame.size.width - (itemWidth + 20), indexViewY, itemWidth, indexViewH) headerFooterViewHeight:itemHeaderFooterH andListArray:self.sectionTitles];
        [self.view addSubview:indexView];
        self.indexView = indexView;
        
        //中部显示的label
        self.showLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
        self.showLabel.center = self.view.center;
        self.showLabel.alpha = 0;
        self.showLabel.textColor = ColorWith(@"ffc601");
        self.showLabel.font = [UIFont systemFontOfSize:50];
        self.showLabel.shadowColor = [UIColor lightGrayColor];
        self.showLabel.shadowOffset = CGSizeMake(3, 3);
        [self.view addSubview:self.showLabel];
        
        //block
        __weak typeof(self)blockSelf = self;
        _indexView.callBack = ^(NSString *str,int index){
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:index];
            [blockSelf.myTab scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
            blockSelf.showLabel.text = str;
            
            [UIView animateWithDuration:0.35 animations:^{
                
                blockSelf.showLabel.alpha = 1;
                [UIView animateWithDuration:0.35 animations:^{
                    blockSelf.showLabel.alpha = 0;
                }];
            }];
        };
    }
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSIndexPath *indexpath = [_myTab indexPathForRowAtPoint:scrollView.contentOffset];
    [_indexView setItemHightlightWithIndexPathRow:indexpath.section];
}

//结束拖拽的方法 decelerate 是否有速度
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{

    if (!decelerate) {
        NSIndexPath *indexpath = [_myTab indexPathForRowAtPoint:scrollView.contentOffset];
        [_indexView setItemHightlightWithIndexPathRow:indexpath.section];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sectionTitles.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSString *T = self.sectionTitles[indexPath.section];
    // tableView 文字
    cell.textLabel.text = [NSString stringWithFormat:@"%@->%zd",T,indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:17];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *headLabel = [[UILabel alloc] init];
    headLabel.frame = CGRectMake(15, 0, 100, 40);
    headLabel.font = [UIFont systemFontOfSize:17];
    NSString *T = self.sectionTitles[section];
    headLabel.text = [NSString stringWithFormat:@"%@", T];
    UIView *headerView = [[UIView alloc]init];
    headerView.backgroundColor = COLOR(238, 238, 238, 1);
    [headerView addSubview:headLabel];
    
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *T = self.sectionTitles[indexPath.section];
    NSLog(@"%@",T);
}


@end
