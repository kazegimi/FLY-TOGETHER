//
//  ViewController.m
//  FLY TOGETHER
//
//  Created by Eiichi Hayashi on 2017/08/14.
//  Copyright © 2017年 Eiichi Hayashi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    QRViewController *qrViewController;
    MainViewController *mainViewController;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"45,321 Hours";
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"MENU"
                                                                   style:UIBarButtonItemStyleDone
                                                                  target:self
                                                                  action:@selector(menuButton)];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"QR"
                                                                    style:UIBarButtonItemStyleDone
                                                                   target:self
                                                                   action:@selector(qrButton)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"BACK"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:nil
                                                                            action:nil];
    
    //if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) self.edgesForExtendedLayout = UIRectEdgeNone;
    
    mainViewController = [[MainViewController alloc] init];
    [self.view addSubview:mainViewController.view];
}

- (void)menuButton
{
    [mainViewController menuButton];
}

- (void)qrButton
{
    if (!qrViewController)
    {
        qrViewController = [[QRViewController alloc] init];
    }
    
    [self.navigationController pushViewController:qrViewController animated:YES];
}

- (void)foundEmployeeNumber:(NSString *)employeeNumber
{
    
}

- (void)didFinishConnection
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
