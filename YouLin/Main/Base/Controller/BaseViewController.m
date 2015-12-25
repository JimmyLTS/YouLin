//
//  BaseViewController.m
//  YouLin
//
//  Created by Jimmy on 15/12/8.
//  Copyright © 2015年 Jimmy. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 自定义导航栏返回按钮
- (void)creatLeftBarButtonItem {
    
    UIImage *leftItemImage = [UIImage imageNamed:@"Resource.bundle/ico_general_back_normal@2x"];
    UIImage *leftItemImagePress = [UIImage imageNamed:@"Resource.bundle/ico_general_back_-pressed@2x"];
    
    UIButton *leftItemButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    
    [leftItemButton setImage:leftItemImage forState:UIControlStateNormal];
    [leftItemButton setImage:leftItemImagePress forState:UIControlStateHighlighted];
    
    [leftItemButton addTarget:self action:@selector(leftItemAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftItemButton];
}

- (void)leftItemAction {
    
    [self.navigationController popViewControllerAnimated:YES];
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
