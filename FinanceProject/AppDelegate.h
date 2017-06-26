//
//  AppDelegate.h
//  FinanceProject
//
//  Created by Вадим Чистяков on 16.06.17.
//  Copyright © 2017 Вадим Чистяков. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

