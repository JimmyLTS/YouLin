//
//  CustomViewController.h
//  QRCode
//
//  Created by Mac_Mini on 15/9/15.
//  Copyright (c) 2015年 Chenxuhun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

typedef void(^QRUrlBlock)(NSString *url);
@interface QRCodeViewController : BaseViewController

@property (nonatomic, copy) QRUrlBlock qrUrlBlock;

@end
