//
//  BaseNavigationController.m
//  YouLin
//
//  Created by Jimmy on 15/12/8.
//  Copyright © 2015年 Jimmy. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置导航栏title
    self.navigationBar.titleTextAttributes = @{
                                               NSFontAttributeName:[UIFont systemFontOfSize:18 weight:-100]
                                               };
    
    self.navigationBar.backgroundColor = [UIColor whiteColor];
    
    self.navigationBar.translucent = NO;
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
