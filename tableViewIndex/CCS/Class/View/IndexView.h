//
//  IndexView.h
//  test
//
//  Created by wangliang on 16/12/9.
//  Copyright © 2016年 wangliang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IndexView;
@protocol IndexViewDelegate <NSObject>

- (void)completeWithIndex:(int)index itemStr:(NSString *)itemStr indexView:(IndexView *)indexView;

@end

@interface IndexView : UIView

/**
 初始化方法

 @param frame 视图
 @param headerFooterH 顶部和底部预留出的高度，默认为5
 @param listArray 数据
 @return self
 */
- (instancetype)initWithFrame:(CGRect)frame headerFooterViewHeight:(CGFloat)headerFooterH andListArray:(NSArray*)listArray;

- (void)setItemHightlightWithIndexPathRow:(NSInteger)row;

/**
 *  当前的item
 */
@property(nonatomic,copy)NSString *currentItem;

/**
 *  block回调
 */
@property(nonatomic,copy)void(^callBack)(NSString*itemStr,int index);

/**
 *  delegate回调
 */
@property(nonatomic,assign)id delegate;


@end
