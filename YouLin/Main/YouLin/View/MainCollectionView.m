//
//  MainCollectionView.m
//  YouLin
//
//  Created by Jimmy on 15/12/22.
//  Copyright © 2015年 Jimmy. All rights reserved.
//

#import "MainCollectionView.h"
#import "ChooseTopicButton.h"
#import "YouLinViewController.h"
#import "MainTableView.h"

@implementation MainCollectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.estimatedItemSize = CGSizeMake(kScreenWidth,kScreenHeight - 40);
    
    self = [super initWithFrame:frame collectionViewLayout:flowLayout];
    
    if (self) {
        
        self.dataSource = self;
        self.delegate = self;
        
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        
        self.decelerationRate = 0.1;
        self.pagingEnabled = YES;
        self.bounces = NO;
        
        [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kTopicCell];
    }
    return self;
}

#pragma mark - creatTableView
- (void)_creatMainTableView {
    
}

#pragma mark - MainCollectionView的delegate和datasource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _youlinVc.topicButtonArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kTopicCell forIndexPath:indexPath];
    
    if (indexPath.section%2 == 0) {
        cell.backgroundColor = [UIColor greenColor];
    
    }else {
        cell.backgroundColor = [UIColor redColor];
    }
    
    
    return cell;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView         {
    _youlinVc.isScroll = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //根据判定是否是拖动MainCollectionView，选择是否执行以下代码
    if (_youlinVc.isScroll) {
        CGFloat offsetX = scrollView.contentOffset.x;
        CGFloat rate = offsetX/kScreenWidth - (int)offsetX/(int)kScreenWidth;
        int index = offsetX/kScreenWidth;
        if (index == _youlinVc.topicButtonArray.count-1) {
            return;
        }
        
        ChooseTopicButton *previousButton = _youlinVc.topicButtonArray[index];
        ChooseTopicButton *nextButton = _youlinVc.topicButtonArray[index + 1];
        
        //改变selectView的位置
        CGFloat distance = nextButton.left - previousButton.left;
        _youlinVc.selectView.left = previousButton.left + 13 + distance*rate;
        
        //改变selectView长度
        CGFloat previousLength = previousButton.width - 26;
        CGFloat nextLength = nextButton.width - 26;
        _youlinVc.selectView.width = previousLength + (nextLength-previousLength)*rate;
        
        //改变按钮字体颜色
        previousButton.label.textColor = [UIColor colorWithRed:(194-194*rate)/255.0 green:(78-78*rate)/255.0 blue:(66-66*rate)/255.0 alpha:1];
        
        nextButton.label.textColor = [UIColor colorWithRed:(194*rate)/255.0 green:(78*rate)/255.0 blue:(66*rate)/255.0 alpha:1];
        
        //改变按钮字体大小
        previousButton.label.transform = CGAffineTransformMakeScale(1.2-0.2*rate, 1.2-0.2*rate);
        nextButton.label.transform = CGAffineTransformMakeScale(1+0.2*rate, 1+0.2*rate);
    }

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    int index = scrollView.contentOffset.x/kScreenWidth;
    
    ChooseTopicButton *button = _youlinVc.topicButtonArray[index];
    
    if (button.tag < 13) {
        [_youlinVc.topicScrollView setContentOffset:CGPointZero animated:YES];
    }else if (button.tag > 15) {
        [_youlinVc.topicScrollView setContentOffset:CGPointMake(_youlinVc.topicScrollView.contentSize.width - kScreenWidth,0) animated:YES];
    }else {
        CGFloat left = button.left + button.width/2 - kScreenWidth/2;
        [_youlinVc.topicScrollView setContentOffset:CGPointMake(left, 0) animated:YES];
    }
    
}

@end
