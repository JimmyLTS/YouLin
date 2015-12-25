//
//  CustomViewController.m
//  QRCode
//
//  Created by Mac_Mini on 15/9/15.
//  Copyright (c) 2015年 Chenxuhun. All rights reserved.
//

#import "QRCodeViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "QRView.h"
#import "WebViewController.h"
@interface QRCodeViewController () <AVCaptureMetadataOutputObjectsDelegate,QRViewDelegate>

@property (strong, nonatomic) AVCaptureDevice * device;
@property (strong, nonatomic) AVCaptureDeviceInput * input;
@property (strong, nonatomic) AVCaptureMetadataOutput * output;
@property (strong, nonatomic) AVCaptureSession * session;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer * preview;

@end

@implementation QRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"扫描二维码";
    [self creatLeftBarButtonItem];
    
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    // Output
    _output = [[AVCaptureMetadataOutput alloc]init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // Session
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }
    
    // 条码类型 AVMetadataObjectTypeQRCode
    _output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode];
    
    //增加条形码扫描
    //    _output.metadataObjectTypes = @[AVMetadataObjectTypeEAN13Code,
    //                                    AVMetadataObjectTypeEAN8Code,
    //                                    AVMetadataObjectTypeCode128Code,
    //                                    AVMetadataObjectTypeQRCode];
    
    // Preview
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:_session];
    _preview.videoGravity =AVLayerVideoGravityResize;
    _preview.frame =self.view.layer.bounds;
    [self.view.layer insertSublayer:_preview atIndex:0];
    
    [_session startRunning];
    
    
    
    QRView *qrRectView = [[QRView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    qrRectView.transparentArea = CGSizeMake(200, 200);
    qrRectView.backgroundColor = [UIColor clearColor];
    qrRectView.center = CGPointMake(kScreenWidth/2, kScreenHeight / 2 - 49 );
    qrRectView.delegate = self;
    [self.view addSubview:qrRectView];
    
    UIButton *openBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    openBtn.frame = CGRectMake(260, 0, 50, 50);
    [openBtn setTitle:@"开灯" forState:UIControlStateNormal];
    [openBtn addTarget:self action:@selector(openFlashlight:) forControlEvents:UIControlEventTouchUpInside];
    [openBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    
    UIBarButtonItem *openItem = [[UIBarButtonItem alloc] initWithCustomView:openBtn];
    
    self.navigationItem.rightBarButtonItem = openItem;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2 - 75, 65, 150, 60)];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 2;
    label.font = [UIFont systemFontOfSize:18];
    label.text = @"将二维码放入框中即可自动识别";
    label.textColor = [UIColor whiteColor];
    [self.view addSubview:label];
    
    //修正扫描区域
    CGRect cropRect = CGRectMake((kScreenWidth - qrRectView.transparentArea.width) / 2,
                                 (kScreenHeight - qrRectView.transparentArea.height) / 2,
                                 qrRectView.transparentArea.width,
                                 qrRectView.transparentArea.height);
    
    [_output setRectOfInterest:CGRectMake(cropRect.origin.y / kScreenHeight,
                                          cropRect.origin.x / kScreenWidth,
                                          cropRect.size.height / kScreenHeight,
                                          cropRect.size.width / kScreenWidth)];
    

    
}

-(void)openFlashlight:(UIButton *)sender
{
    sender.selected = !sender.selected;
    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
    if (captureDeviceClass != nil) {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        if ([device hasTorch] && [device hasFlash]){
            
            [device lockForConfiguration:nil];
            if (sender.selected) {
                
                [sender setTitle:@"关灯" forState:UIControlStateNormal];
                [device setTorchMode:AVCaptureTorchModeOn];
                [device setFlashMode:AVCaptureFlashModeOn];
                
            } else {
                
                [sender setTitle:@"开灯" forState:UIControlStateNormal];
                [device setTorchMode:AVCaptureTorchModeOff];
                [device setFlashMode:AVCaptureFlashModeOff];
                
            }
            [device unlockForConfiguration];
        }
    }
}

#pragma mark QRViewDelegate
-(void)scanTypeConfig:(QRItem *)item {
    
    if (item.type == QRItemTypeQRCode) {
        _output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode];
        
    } else if (item.type == QRItemTypeOther) {
        
        _output.metadataObjectTypes = @[AVMetadataObjectTypeEAN13Code,
                                        AVMetadataObjectTypeEAN8Code,
                                        AVMetadataObjectTypeCode128Code,
                                        AVMetadataObjectTypeQRCode];
    }
}
#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    NSString *stringValue;
    if ([metadataObjects count] >0)
    {
        //停止扫描
        [_session stopRunning];
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
    }
    
    NSLog(@" =============%@",stringValue);
    
    if (self.qrUrlBlock) {
        self.qrUrlBlock(stringValue);
    }
    
    WebViewController *scanVC = [[WebViewController alloc]init];
    scanVC.path = stringValue;
    [self.navigationController pushViewController:scanVC animated:YES];
    [_session startRunning];
}

@end
