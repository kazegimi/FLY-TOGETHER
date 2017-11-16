//
//  DownloadManager.h
//  FLY TOGETHER
//
//  Created by Eiichi Hayashi on 2017/08/21.
//  Copyright © 2017年 Eiichi Hayashi. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Downloader.h"

@protocol DownloadManagerDelegate

@optional

- (void)didFinishConnection;

@end

@interface DownloadManager : NSObject <DownloaderDelegate>

@property (strong, nonatomic) id<DownloadManagerDelegate> delegate;

- (void)downloadLogs;
- (void)downloadCrewWithEmployeeNumber:(NSString *)employeeNumber;

@end
