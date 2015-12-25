//
//  YouLinViewController.h
//  YouLin
//
//  Created by Jimmy on 15/12/8.
//  Copyright © 2015年 Jimmy. All rights reserved.
//

#import "BaseViewController.h"
#import "MainCollectionView.h"
#import "ChooseTopicButton.h"

@interface YouLinViewController : BaseViewController<UIScrollViewDelegate> {
    UIView *_navBottomLineView; //导航栏底部边线遮盖视图
    NSArray *_titleArray;  //存储主题title
    MainCollectionView *_mainCollectionView;
}

@property (nonatomic, strong)UIScrollView *topicScrollView;
@property (nonatomic, strong)UIView *selectView;  //主题选中标识视图

@property (nonatomic, strong)UIImageView *messageMarkImageView;

@property (nonatomic, copy)NSMutableArray *topicButtonArray;

@property (nonatomic, assign)BOOL isScroll;

- (void)selectTopicTypeAction:(ChooseTopicButton *)button;

@end
