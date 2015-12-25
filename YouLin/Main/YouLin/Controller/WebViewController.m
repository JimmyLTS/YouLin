//
//  WebViewController.m
//  QRCode
//
//  Created by Mac_Mini on 15/9/15.
//  Copyright (c) 2015年 Chenxuhun. All rights reserved.
//

#import "WebViewController.h"
#import "MBProgressHUD+MJ.h"
@interface WebViewController () <UIWebViewDelegate>

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"浏览网址";
    
    UIWebView *wv = [[UIWebView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:wv];
    wv.delegate = self;
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.path]];
    NSLog(@"===%@",self.path);
    [wv loadRequest:request];
    
}


@end
