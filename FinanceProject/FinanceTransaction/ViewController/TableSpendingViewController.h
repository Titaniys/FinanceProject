//
//  TableSpendingViewController.h
//  FinanceProject
//
//  Created by Вадим Чистяков on 17.06.17.
//  Copyright © 2017 Вадим Чистяков. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableSpendingViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

- (void) changeArrayTransaction;

-(IBAction)didSelectSegment:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *table;

@end
