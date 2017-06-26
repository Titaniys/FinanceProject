//
//  VKDebtTableViewController.m
//  FinanceProject
//
//  Created by Вадим Чистяков on 22.06.17.
//  Copyright © 2017 Вадим Чистяков. All rights reserved.
//

#import "VKDebtTableViewController.h"
#import "VKDebtTableViewCell.h"
#import "ManagerServer.h"
#import "UserVKModel.h"
#import "FriendVK+CoreDataClass.h"
#import "AppDelegate.h"


@interface VKDebtTableViewController ()

@property (strong, nonatomic) NSArray<FriendVK*> *friends;

@end

@implementation VKDebtTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSFetchRequest <FriendVK*> *fetchRequest = [FriendVK fetchRequest];
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    self.friends = [appDelegate.persistentContainer.viewContext
                         executeFetchRequest:fetchRequest
                         error:nil];
    
    FriendVK *friend = [FriendVK new];
    friend = self.friends[0];
    NSLog(@"%@",friend.firstName);

    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.friends.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    VKDebtTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellVK"];

    FriendVK *friend = self.friends[indexPath.row];
    
    [cell setCellforVK:friend];
    
    return cell;
    
}



@end
