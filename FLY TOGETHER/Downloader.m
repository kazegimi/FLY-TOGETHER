//
//  Downloader.m
//  FLY TOGETHER
//
//  Created by Eiichi Hayashi on 2017/08/21.
//  Copyright © 2017年 Eiichi Hayashi. All rights reserved.
//

#import "Downloader.h"

@implementation Downloader
{
    NSMutableData *mutableData;
}

- (void)startDownloadLogs
{
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration
                                                          delegate:self
                                                     delegateQueue:[NSOperationQueue mainQueue]];
    
    NSString *urlString = [NSString stringWithFormat:@"http://flytogether.skyelements.jp/logs_downloader.php"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    NSMutableString *postString = [[NSMutableString alloc] init];
    [postString appendString:@"member_id=1&"];
    NSArray *logsArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"logsArray"];
    for(NSDictionary *dictionary in logsArray)
    {
        [postString appendString:@"idsArray[]="];
        [postString appendString:dictionary[@"id"]];
        [postString appendString:@"&"];
    }
    NSData *postData = [postString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:postData];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request];
    
    mutableData = [[NSMutableData alloc] init];
    
    [task resume];
}

- (void)startDownloadLogsWithEmloyeeNumber:(NSString *)employeeNumber
{
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration
                                                          delegate:self
                                                     delegateQueue:[NSOperationQueue mainQueue]];
    
    NSString *urlString = [NSString stringWithFormat:@"http://flytogether.skyelements.jp/crew_downloader.php"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    NSMutableString *postString = [[NSMutableString alloc] init];
    NSString *string = [NSString stringWithFormat:@"employee_number=%@&", employeeNumber];
    [postString appendString:string];
    /*
    NSArray *logsArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"logsArray"];
    for(NSDictionary *dictionary in logsArray)
    {
        [postString appendString:@"idsArray[]="];
        [postString appendString:dictionary[@"id"]];
        [postString appendString:@"&"];
    }
    */
    NSData *postData = [postString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:postData];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request];
    
    mutableData = [[NSMutableData alloc] init];
    
    [task resume];
}

// レスポンス受信時の処理
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler
{
    completionHandler(NSURLSessionResponseAllow);// どのレスポンスが来ても通信を継続
}

// データを受信時の処理
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    [mutableData appendData:data];
}

// 通信完了、または失敗時の処理
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    if (!error)
    {
        // 成功時の処理
        [self.delegate didFinishConnectionWithData:mutableData];
    } else
    {
        // 失敗時の処理
    }
    [session invalidateAndCancel];
}

@end
