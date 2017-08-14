//
//  AppDelegate.h
//  FLY TOGETHER
//
//  Created by Eiichi Hayashi on 2017/08/14.
//  Copyright © 2017年 Eiichi Hayashi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

