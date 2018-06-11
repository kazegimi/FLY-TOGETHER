//
//  LogTableViewController.m
//  FLY TOGETHER
//
//  Created by Eiichi Hayashi on 2017/08/15.
//  Copyright © 2017年 Eiichi Hayashi. All rights reserved.
//

#import "LogTableViewController.h"

@interface LogTableViewController ()

@end

@implementation LogTableViewController

@synthesize crewsArray;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"JL1234";
    self.tableView.rowHeight = 256.0f;
    self.tableView.allowsSelection = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return crewsArray.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = [NSString stringWithFormat:@"cell%ld", indexPath.row];// Reuseさせない
    LogTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[LogTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if (indexPath.row == 0)
    {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.tableView.rowHeight);
        imageView.image = [UIImage imageNamed:@"flightinfo.PNG"];
        [cell addSubview:imageView];
    } else
    {
        cell.titleLabel.text = crewsArray[indexPath.row - 1][@"title"];
        cell.imageView.image = [self decodeBase64ToImage:crewsArray[indexPath.row - 1][@"image"]];
        cell.nameLabel.text = crewsArray[indexPath.row - 1][@"name"];
        cell.mottoLabel.text = crewsArray[indexPath.row - 1][@"motto"];
        cell.paTextView.text = crewsArray[indexPath.row - 1][@"pa"];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(LogTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // TextViewのTopを表示するための処理
    [cell.paTextView setContentOffset:CGPointZero animated:NO];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UIImage *)decodeBase64ToImage:(NSString *)strEncodeData
{
    NSData *data = [[NSData alloc]initWithBase64EncodedString:strEncodeData options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [UIImage imageWithData:data];
}

@end
