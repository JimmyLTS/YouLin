//
//  MyTabBarController.m
//  YouLin
//
//  Created by Jimmy on 15/12/8.
//  Copyright © 2015年 Jimmy. All rights reserved.
//

#import "MyTabBarController.h"
#import "TabBarButton.h"

@interface MyTabBarController ()

@end

@implementation MyTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //1、创建子控制器
    [self _creatSubViewController];
    //2、自定义 TabBar
    [self _customTabBar];
}

#pragma mark - 添加子控制器
//为 TabBar 添加子控制器
- (void)_creatSubViewController {
    
    NSArray *nameArray = @[@"YouLin",@"Discover",@"Neighbour",@"Me"];
    NSMutableArray *navArray = [[NSMutableArray alloc]init];
    for (NSString *name in nameArray) {
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:name bundle:nil];
        UINavigationController *nav = [storyboard instantiateInitialViewController];
        [navArray addObject:nav];
    }
    
    self.viewControllers = navArray;
}

#pragma mark - 自定义 TabBar
- (void)_customTabBar {
    
    //1、移除tabBarButton
    for (UIView *view in self.tabBar.subviews) {
        Class class = NSClassFromString(@"UITabBarButton");
        if ([view isKindOfClass:class]) {
            [view removeFromSuperview];
        }
    }
    
    //2、创建 TabBarButton
    //normal状态的图片名称
    NSArray *normalImagesArray = @[
                                   @"Resource.bundle/ico_tab1_normal",
                                   @"Resource.bundle/ico_tab3_normal",
                                   @"Resource.bundle/ico_post_feed_plus",
                                   @"Resource.bundle/ico_tab2_normal",
                                   @"Resource.bundle/ico_tab4_normal"
                                   ];
    //select状态的图片名称
    NSArray *selectImagesArray = @[
                                   @"Resource.bundle/ico_tab1_pressed",
                                   @"Resource.bundle/ico_tab3_pressed",
                                   @"Resource.bundle/ico_post_feed_plus_pressed",
                                   @"Resource.bundle/ico_tab2_pressed",
                                   @"Resource.bundle/ico_tab4_pressed"
                                   ];
    //title
    NSArray *textArray = @[@"有邻",@"发现",@"",@"邻居",@"我"];
    
    CGFloat imageWidth = kScreenWidth/normalImagesArray.count;
    
    //通过for循环创建 TabBarButton按钮
    for (int i = 0; i < normalImagesArray.count; i++) {
        
        CGRect tabBarButtonRect = CGRectMake(imageWidth * i, 0, imageWidth, 49) ;
        
        if (i != 2) {
            TabBarButton *tabBarButton = [[TabBarButton alloc] initWithFrame:tabBarButtonRect normalImageName:normalImagesArray[i] normalTitle:textArray[i] selectImageName:selectImagesArray[i] ];
            
            tabBarButton.tag = i;
            tabBarButton.backgroundColor = [UIColor whiteColor];
            
            [tabBarButton addTarget:self action:@selector(tabBarButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.tabBar addSubview:tabBarButton];
            
            //将起始页面 TabBarButton 设为选中状态
            if (i == 0) {
                [tabBarButton setHighlighted:YES];
            }
        }
        else {
            //发布话题按钮
            
            [self _creatAddTopicButtonWithWidth:imageWidth frame:tabBarButtonRect imageName:normalImagesArray[i]];
        }
    }
    
}

- (void)_creatAddTopicButtonWithWidth:(CGFloat)imageWidth frame:(CGRect)tabBarButtonRect imageName:(NSString *)imageName {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = tabBarButtonRect;
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(13, 5, imageWidth - 26, 39)];
    imageView.image = [UIImage imageNamed:imageName];
    [button addSubview:imageView];
    
    button.backgroundColor = [UIColor whiteColor];
    
    
    [self.tabBar addSubview:button];
    

}

// TabBarButton 点击事件
- (void)tabBarButtonAction:(TabBarButton *)button {
    
    //页面切换
    if (button.tag < 2) {
        self.selectedIndex = button.tag;
    }
    else if (button.tag > 2) {
        
        self.selectedIndex = button.tag - 1;
    }
    
     //改变状态栏按钮的显示效果
    for (UIButton *tabButton in self.tabBar.subviews) {
        
        if ([tabButton isKindOfClass:[TabBarButton class]] ) {
            
            if (tabButton.tag != button.tag) {
                [(TabBarButton *)tabButton  setNormalState];
            }
        }
    }
    
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
