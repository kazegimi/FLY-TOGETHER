//
//  DownloadManager.m
//  FLY TOGETHER
//
//  Created by Eiichi Hayashi on 2017/08/21.
//  Copyright © 2017年 Eiichi Hayashi. All rights reserved.
//

#import "DownloadManager.h"

@implementation DownloadManager
{
    Downloader *downloader;
}

- (id)init
{
    downloader = [[Downloader alloc] init];
    downloader.delegate = self;
    
    return self;
}

- (void)downloadLogs
{
    [downloader startDownloadLogs];
}

- (void)downloadCrewWithEmployeeNumber:(NSString *)employeeNumber
{
    [downloader startDownloadLogsWithEmloyeeNumber:employeeNumber];
}

- (void)didFinishConnectionWithData:(NSData *)data
{
    //NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    
    NSArray *newArray = [NSJSONSerialization JSONObjectWithData:data
                                                        options:kNilOptions
                                                          error:nil];
    
    //NSLog(@"%@", newArray);

    if (newArray.count != 0)
    {
        NSArray *oldArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"logsArray"];
        NSArray *logsArray = [newArray arrayByAddingObjectsFromArray:oldArray];
        [[NSUserDefaults standardUserDefaults] setObject:logsArray forKey:@"logsArray"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else
    {
        NSLog(@"新しいLogはありません。");
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didFinishDownload" object:self userInfo:nil];
    [self.delegate didFinishConnection];
}

- (void)didFailConnection
{
    [self.delegate didFinishConnection];
}

@end
