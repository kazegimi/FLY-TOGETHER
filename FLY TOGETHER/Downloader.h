//
//  Downloader.h
//  FLY TOGETHER
//
//  Created by Eiichi Hayashi on 2017/08/21.
//  Copyright © 2017年 Eiichi Hayashi. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DownloaderDelegate

@optional

- (void)didFinishConnectionWithData:(NSData *)data;
- (void)didFailConnection;

@end

@interface Downloader : NSObject <NSURLSessionDelegate>

@property (strong, nonatomic) id<DownloaderDelegate> delegate;

- (void)startDownloadLogs;
- (void)startDownloadLogsWithEmloyeeNumber:(NSString *)employeeNumber;

@end
