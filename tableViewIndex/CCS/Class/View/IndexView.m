//
//  IndexView.m
//  test
//
//  Created by wangliang on 16/12/9.
//  Copyright © 2016年 wangliang. All rights reserved.
//

#import "IndexView.h"

@interface IndexView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *myTab;
/** item的高 */
@property(nonatomic,assign)CGFloat itemH;
/** 头部和底部的高 */
@property(nonatomic,assign)CGFloat headerFooterH;
/** 中部显示的label */
@property(nonatomic,strong)UILabel *centerLabel;
/** 数据数组 */
@property(nonatomic,strong)NSArray *listArray;

@property (nonatomic, strong) UILabel *pastLabel;
@end

@implementation IndexView

- (instancetype)initWithFrame:(CGRect)frame headerFooterViewHeight:(CGFloat)headerFooterH andListArray:(NSArray*)listArray
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = ColorWith(@"dcdcdc");
        self.layer.cornerRadius = self.frame.size.width / 2;
        self.layer.masksToBounds = YES;
        self.itemH = (frame.size.height - 2*headerFooterH)/listArray.count;
        self.headerFooterH = headerFooterH;
        self.listArray = listArray;
        [self setUpUI];
    }

    return self;
}

- (void)setUpUI{

    CGFloat width = self.frame.size.width;
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,width, _headerFooterH)];
    headerView.backgroundColor = self.backgroundColor;
    [self addSubview:headerView];

    self.myTab = [[UITableView alloc]initWithFrame:CGRectMake(0, _headerFooterH,width, self.frame.size.height - 2*_headerFooterH) style:UITableViewStylePlain];
    self.myTab.userInteractionEnabled = NO;
    self.myTab.delegate = self;
    self.myTab.separatorStyle = UITableViewScrollPositionNone;
    self.myTab.dataSource = self;
    self.myTab.showsVerticalScrollIndicator = NO;
    self.myTab.showsHorizontalScrollIndicator = NO;
    [self addSubview:_myTab];
    [_myTab registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];

    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_myTab.frame),width, _headerFooterH)];
    [self addSubview:footerView];
    footerView.backgroundColor = self.backgroundColor;

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _listArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];

    UILabel *label = [[UILabel alloc]initWithFrame:cell.contentView.bounds];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:16];
    label.textColor = COLOR(102, 102, 102, 102);
    if (indexPath.row == 0) {
        label.textColor = MAIN_COLOR;
        _pastLabel = label;
    }
    label.tag = 3333;
    [cell.contentView addSubview:label];
    label.text = _listArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentView.backgroundColor = ColorWith(@"dcdcdc");

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return _itemH;
}


- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:_myTab];
    if(point.y >= _myTab.frame.size.height) return;
    if(point.y <= 0) return;
    int pointIndex = point.y / _myTab.frame.size.height *_listArray.count;
    self.currentItem = _listArray[pointIndex];
    if(_callBack) _callBack(_currentItem,pointIndex);
    if ([self.delegate respondsToSelector:@selector(completeWithIndex:itemStr:indexView:)]) {
        [self.delegate completeWithIndex:pointIndex itemStr:_currentItem indexView:self];
    }
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:_myTab];
    if(point.y >= _myTab.frame.size.height) return;
    if(point.y <= 0) return;
    int pointIndex = point.y / _myTab.frame.size.height *_listArray.count;
    self.currentItem = _listArray[pointIndex];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:pointIndex inSection:0];
    UITableViewCell *cell = [_myTab cellForRowAtIndexPath:indexPath];
    UILabel *label = [cell viewWithTag:3333];
    label.textColor = MAIN_COLOR;
    _pastLabel.textColor = COLOR(102, 102, 102, 102);
    _pastLabel = label;
    
    if(_callBack) _callBack(_currentItem,pointIndex);
    if ([self.delegate respondsToSelector:@selector(completeWithIndex:itemStr:indexView:)]) {
        [self.delegate completeWithIndex:pointIndex itemStr:_currentItem indexView:self];
    }
}


- (void)setItemHightlightWithIndexPathRow:(NSInteger)row
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    UITableViewCell *cell = [_myTab cellForRowAtIndexPath:indexPath];
    UILabel *label = [cell viewWithTag:3333];
    
    if ([label isEqual:_pastLabel]) {
        return;
    }
    
    label.textColor = MAIN_COLOR;
    _pastLabel.textColor = COLOR(102, 102, 102, 102);
    _pastLabel = label;
}


@end
