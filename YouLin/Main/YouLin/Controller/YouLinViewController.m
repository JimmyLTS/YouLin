//
//  YouLinViewController.m
//  YouLin
//
//  Created by Jimmy on 15/12/8.
//  Copyright © 2015年 Jimmy. All rights reserved.
//

#import "YouLinViewController.h"
#import "MessageCenterViewController.h"
#import "UIViewExt.h"
#import "QRCodeViewController.h"

#define kButtonHeight 40
#define kSelectViewHeight 3
#define kLineViewHeight 0.5

@interface YouLinViewController () 
    

@end

@implementation YouLinViewController

- (void)viewWillAppear:(BOOL)animated {
    //遮盖导航栏下边线
    _navBottomLineView = [[UIView alloc]initWithFrame:CGRectMake(0, 43, kScreenWidth, 2)];
    _navBottomLineView.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar addSubview:_navBottomLineView];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    [self _creatBarButtonItem];
    
    [self creatScrollView];
    
    [self _creatTopicCollectionView];
    
    NSLog(@"%@", NSHomeDirectory());
    
}



#pragma mark - creatScrollView
- (void)creatScrollView {
    
    _titleArray = @[@"推荐",@"本小区",@"求助",@"拼车",@"闲置",@"活动",@"租房",@"随便说说",@"小匠动态"];
    
    _topicScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, -10, kScreenWidth, kButtonHeight + 10)];

    _topicScrollView.showsHorizontalScrollIndicator = NO;
    _topicScrollView.showsVerticalScrollIndicator = NO;
    _topicScrollView.scrollEnabled = YES;
    
    [self.view addSubview:_topicScrollView];
    
    [self creatTopicTypeButton];
  
}

#pragma mark - 添加话题按钮
- (void)creatTopicTypeButton {
    static CGFloat buttonLeft = 0;
    _topicButtonArray = [[NSMutableArray alloc]initWithCapacity:_titleArray.count];
    
    for (int i = 0; i < _titleArray.count; i++) {
        
        ChooseTopicButton *button = [[ChooseTopicButton alloc]initWithFrame:CGRectMake(buttonLeft, 10, 0, kButtonHeight) title:_titleArray[i]];
        button.tag = i + 10;
        buttonLeft += button.width;
        
        [_topicScrollView addSubview:button];
        
        [button addTarget:self action:@selector(selectTopicTypeAction:) forControlEvents:UIControlEventTouchDown];
        
        if (i == 0) {
            [button setHighlighted:YES];
            _selectView = [[UIView alloc]initWithFrame:CGRectMake(button.left + 13, _topicScrollView.height - kSelectViewHeight, button.width - 26, kSelectViewHeight)];
            _selectView.backgroundColor = kAddTopicColor;
            
            [_topicScrollView addSubview:_selectView];
        }
        
        [_topicButtonArray addObject:button];
    }

    //设置有效视图尺寸
    _topicScrollView.contentSize = CGSizeMake(buttonLeft, 0);
    
    //
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, _topicScrollView.height - kLineViewHeight, buttonLeft, kLineViewHeight)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [_topicScrollView addSubview:lineView];
    
    [_topicScrollView bringSubviewToFront:_selectView];
    
}

//
- (void)_creatTopicCollectionView {
    
    _mainCollectionView = [[MainCollectionView alloc]initWithFrame:CGRectMake(0, kButtonHeight, kScreenWidth,self.view.height - kButtonHeight)];
    _mainCollectionView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_mainCollectionView];

    _mainCollectionView.contentSize = CGSizeMake(kScreenWidth * _titleArray.count, self.view.height - kButtonHeight);
    _mainCollectionView.youlinVc = self;
    [_mainCollectionView reloadData];
    
}

#pragma mark - 选择主题按钮

- (void)selectTopicTypeAction:(ChooseTopicButton *)button {
    _isScroll = NO;
    
    //改变MainCollectionView的偏移量
    [_mainCollectionView setContentOffset:CGPointMake(kScreenWidth * (button.tag - 10), 0) animated:YES];
    
    //改变选择视图的状态
    [UIView animateWithDuration:0.3 animations:^{
        _selectView.frame = CGRectMake(button.left + 13, _topicScrollView.height - kSelectViewHeight, button.width - 26, kSelectViewHeight);
    }];
    
    //改变状态栏按钮的显示效果
    for (UIButton *otherButton in _topicScrollView.subviews) {
        
        if ([otherButton isKindOfClass:[UIButton class]] ) {
            
            if (otherButton.tag != button.tag) {
                [(ChooseTopicButton *)otherButton  setNormalState];
            }
        }
    }
    
    if (button.tag < 13) {
        [_topicScrollView setContentOffset:CGPointZero animated:YES];
    }else if (button.tag > 15) {
        [_topicScrollView setContentOffset:CGPointMake(_topicScrollView.contentSize.width - kScreenWidth,0) animated:YES];
    }else {
        CGFloat left = button.left + button.width/2 - kScreenWidth/2;
        [_topicScrollView setContentOffset:CGPointMake(left, 0) animated:YES];
    }
    

}

#pragma mark - 自定义 BarButtonItem
- (void)_creatBarButtonItem {
    
    //leftBarItemButton
    UIImage *messageItemImage = [UIImage imageNamed:@"Resource.bundle/ico_topbar_notification_pressed@2x"];
    UIButton *messageItemButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [messageItemButton setImage:messageItemImage forState:UIControlStateNormal];
    [messageItemButton setImage:messageItemImage forState:UIControlStateHighlighted];
    [messageItemButton addTarget:self action:@selector(messageItemAction) forControlEvents:UIControlEventTouchUpInside];
    
    //newMessageMarkImageView
    _messageMarkImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
    _messageMarkImageView.center = CGPointMake(35, 15);
    _messageMarkImageView.image = [UIImage imageNamed:@"Resource.bundle/bg_poflie_sent_"];
    [messageItemButton addSubview:_messageMarkImageView];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:messageItemButton];
    
    //rightBarButtonItem
    UIImage *QRCodeItemImage = [UIImage imageNamed:@"Resource.bundle/icon_list_scan_normal@2x"];
    UIImage *QRCodeItemImagePress = [UIImage imageNamed:@"Resource.bundle/icon_list_scan_press@2x"];
    
    UIButton *QRCodeItemButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    
    [QRCodeItemButton setImage:QRCodeItemImage forState:UIControlStateNormal];
    [QRCodeItemButton setImage:QRCodeItemImagePress forState:UIControlStateHighlighted];
    
    [QRCodeItemButton addTarget:self action:@selector(QRCodeItemAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:QRCodeItemButton];
    
}

#pragma mark - 导航栏Items点击事件
- (void)messageItemAction {
    MessageCenterViewController *messageCenter = [[MessageCenterViewController alloc]init];
    
    [self.navigationController pushViewController:messageCenter animated:YES];
    
    [_navBottomLineView removeFromSuperview];
    _navBottomLineView = nil;
}

#pragma mark - 扫一扫
- (void)QRCodeItemAction:(UIButton *)QRCodeButton {
    
    if ([self validateCamera]) {
        
        [self showQRViewController];
        
    } else {
        
        UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"提示" message:@"没有摄像头或摄像头不可用" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *alertAction1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        
        [alertVc addAction:alertAction1];
        [self presentViewController:alertVc animated:YES completion:nil];
        
    }
    
}

- (BOOL)validateCamera {
    
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] &&
    [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

- (void)showQRViewController {
    
    QRCodeViewController *qrVC = [[QRCodeViewController alloc] init];
    qrVC.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:qrVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    //     Dispose of any resources that can be recreated.
}


@end
