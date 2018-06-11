//
//  QRViewController.m
//  FLY TOGETHER
//
//  Created by Eiichi Hayashi on 2017/08/20.
//  Copyright © 2017年 Eiichi Hayashi. All rights reserved.
//

#import "QRViewController.h"

@interface QRViewController ()

@end

@implementation QRViewController
{
    AVCaptureVideoPreviewLayer *preview;
    DownloadManager *downloadManager;
    
    UIAlertController *alertController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"QR";
    
    // QR読み取りのための準備
    // Device
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    // session
    self.session = [[AVCaptureSession alloc] init];
    
    // Input
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    if (input) {
        [self.session addInput:input];
    } else {
        NSLog(@"error");
    }
    
    // Output
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    [self.session addOutput:output];
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    [output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code]];
    
    // Preview
    preview = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    preview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view.layer insertSublayer:preview atIndex:100];
    
    downloadManager = [[DownloadManager alloc] init];
    downloadManager.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [self.session startRunning];
}

// QRコード認識時のDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects
       fromConnection:(AVCaptureConnection *)connection {
    // 複数のmetadataが来るので順に調べる
    for (AVMetadataObject *data in metadataObjects)
    {
        if (![data isKindOfClass:[AVMetadataMachineReadableCodeObject class]]) continue;
        // QR code data
        NSString *strValue = [(AVMetadataMachineReadableCodeObject *)data stringValue];
        // type ?
        if ([data.type isEqualToString:AVMetadataObjectTypeQRCode])
        {
            // QRコードの場合
            [self.session stopRunning];
            [downloadManager downloadCrewWithEmployeeNumber:strValue];
            
            alertController = [UIAlertController alertControllerWithTitle:@"通信中" message:@"乗員を探しています..." preferredStyle:UIAlertControllerStyleAlert];
            
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }
}

- (void)didFinishConnection {
    [self dismissViewControllerAnimated:YES completion:nil];
    
    //[preview removeFromSuperlayer];
    [self.navigationController popViewControllerAnimated:YES];
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
