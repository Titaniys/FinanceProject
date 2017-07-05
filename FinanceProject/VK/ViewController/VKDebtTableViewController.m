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

@property (strong, nonatomic) NSMutableArray *friends;

@end

@implementation VKDebtTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void) viewWillAppear:(BOOL)animated {
    NSFetchRequest <FriendVK*> *fetchRequest = [FriendVK fetchRequest];
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSArray *arr = [NSArray new];
    arr = [appDelegate.persistentContainer.viewContext
                    executeFetchRequest:fetchRequest
                    error:nil];
    self.friends = [[NSMutableArray alloc] initWithArray:arr];
    
    [self.table reloadData];
}

#pragma mark - UITableViewDataSource

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{

        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
        if (editingStyle == UITableViewCellEditingStyleDelete) {
 
            [context deleteObject:[self.friends objectAtIndex:indexPath.row]];
            
            NSError *error = nil;
            if (![context save:&error]) {
                NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
                return;
            }

            [self.friends removeObjectAtIndex:indexPath.row];
            [self.table deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
}

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
