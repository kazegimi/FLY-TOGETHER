//
//  MainViewController.m
//  FLY TOGETHER
//
//  Created by Eiichi Hayashi on 2017/08/21.
//  Copyright © 2017年 Eiichi Hayashi. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController
{
    MenuTableViewController *menuTableViewController;
    float menuViewWidth;
    BOOL isOpen;
    
    LogsTableViewController *logsTableViewController;
    UINavigationController *logsNavigationContoller;
    
    UIView *shadeView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    menuTableViewController = [[MenuTableViewController alloc] init];
    menuViewWidth = self.view.frame.size.width / 3.0f * 2.0f;
    menuTableViewController.view.frame = CGRectMake(-menuViewWidth, 0, menuViewWidth, self.view.frame.size.height);
    [self.view addSubview:menuTableViewController.view];
    
    isOpen = NO;
    
    logsTableViewController = [[LogsTableViewController alloc] init];
    logsNavigationContoller = [[UINavigationController alloc] initWithRootViewController:logsTableViewController];
    [self.view addSubview:logsNavigationContoller.view];
    
    shadeView = [[UIView alloc] init];
    shadeView.frame = logsNavigationContoller.view.frame;
    shadeView.backgroundColor = [UIColor blackColor];
    shadeView.alpha = 0.0f;
    [self.view addSubview:shadeView];
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapped:)];
    [shadeView addGestureRecognizer:recognizer];
    
    [self.view bringSubviewToFront:menuTableViewController.view];
}

- (void)menuButton
{
    if (isOpen)
    {
        [UIView animateWithDuration:0.25f
                         animations:^{
                             menuTableViewController.view.frame = CGRectMake(-menuViewWidth, 0, menuViewWidth, self.view.frame.size.height);
                             shadeView.alpha = 0.0f;
                         }];
    } else
    {
        [UIView animateWithDuration:0.25f
                         animations:^{
                             menuTableViewController.view.frame = CGRectMake(0, 0, menuViewWidth, self.view.frame.size.height);
                             shadeView.alpha = 0.3f;
                         }];
    }
    isOpen = !isOpen;
}

- (void)onTapped:(UITapGestureRecognizer *)recognizer
{
    [self menuButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
