//
//  LogsTableViewController.m
//  FLY TOGETHER
//
//  Created by Eiichi Hayashi on 2017/08/14.
//  Copyright © 2017年 Eiichi Hayashi. All rights reserved.
//

#import "LogsTableViewController.h"

@interface LogsTableViewController ()

@end

@implementation LogsTableViewController
{
    DownloadManager *downloadManager;
    
    LogTableViewController *logTableViewController;
    
    NSArray *logsArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Flight Logs";
    self.tableView.rowHeight = 64.0f;
    
    // UIRefreshControlの初期化
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl = refreshControl;
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    // tableViewの中身が空の場合でもUIRefreshControlを使えるようにする
    self.tableView.alwaysBounceVertical = YES;
    
    downloadManager = [[DownloadManager alloc] init];
    downloadManager.delegate = self;
    
    logTableViewController = [[LogTableViewController alloc] init];
    
    // Notification受信登録
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:@"didFinishDownload" object:nil];
    
    [self reloadData];
}

- (void)startRefreshing
{
    [self.refreshControl beginRefreshing];
}

- (void)refresh:(id)sender
{
    [downloadManager downloadLogs];
}

- (void)didFinishConnection
{
    [self.refreshControl endRefreshing];
}

- (void)reloadData
{
    // Sort
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timestamp" ascending:NO];
    logsArray = [[[NSUserDefaults standardUserDefaults] objectForKey:@"logsArray"] sortedArrayUsingDescriptors:@[sortDescriptor]];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return logsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = logsArray[indexPath.row][@"flight_number"];
    cell.detailTextLabel.text = logsArray[indexPath.row][@"date"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    logTableViewController.crewsArray = logsArray[indexPath.row][@"crews"];
    [self.navigationController pushViewController:logTableViewController animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
