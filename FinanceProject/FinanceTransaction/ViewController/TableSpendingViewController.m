//
//  TableSpendingViewController.m
//  FinanceProject
//
//  Created by Вадим Чистяков on 17.06.17.
//  Copyright © 2017 Вадим Чистяков. All rights reserved.
//

#import "TableSpendingViewController.h"
#import "TransactionDB+CoreDataClass.h"
#import "AppDelegate.h"
#import "ComplexTransactionViewController.h"
#import "SectionForTransactionOfMonth.h"
#import "CustomHeaderView.h"
#import "TransactionTableViewCell.h"

@interface TableSpendingViewController ()



@property (weak, nonatomic) IBOutlet UISegmentedControl *segmenControl;

@property (strong, nonatomic) NSArray <TransactionDB*> *transactions;
@property (strong, nonatomic) NSMutableArray *transactOfMonth;
@property (strong, nonatomic) NSMutableArray *spandingArr;
@property (strong, nonatomic) NSMutableArray *incomeArr;
@property (assign, nonatomic) NSUInteger countReload;
@end

@implementation TableSpendingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.countReload ++;
    self.tableView.estimatedRowHeight = 40;
    self.tableView.sectionHeaderHeight = 35;
    
    [self.tableView registerNib:[CustomHeaderView nib] forHeaderFooterViewReuseIdentifier:@"Header"];
}

- (void) viewWillAppear:(BOOL)animated {
    [self changeArrayTransaction];
    [self.table reloadData];
}


- (void) changeArrayTransaction {
    
    NSFetchRequest <TransactionDB*> *fetchRequest = [TransactionDB fetchRequest];
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    self.transactions = [appDelegate.persistentContainer.viewContext
                         executeFetchRequest:fetchRequest
                         error:nil];
    
    [self sortArrayTransactionByDate];
    
    ///
    self.spandingArr = [NSMutableArray new];
    self.incomeArr = [NSMutableArray new];
    
    for (TransactionDB *transact in self.transactions){
        if (transact.isSpending == 0){
            [self.spandingArr addObject:transact];
        } else {
            [self.incomeArr addObject:transact];
        }
    }
    if (self.countReload == 1) {
        [self selectedArray:self.spandingArr];
    }


} 

- (void) selectedArray:(NSMutableArray*) array {
    ///
    self.transactOfMonth = [NSMutableArray new];
    NSString *dateMonth = nil;
    for (TransactionDB *transact in array){
        NSDate *firstDate = transact.datePicker;
        NSDateFormatter *dateFormatter = [NSDateFormatter new];
        [dateFormatter setDateFormat:@"MMM yyyy"];
        NSString *strDate = [dateFormatter stringFromDate:firstDate];
        //NSLog(@"%@", strDate);
        SectionForTransactionOfMonth *section = nil;
        if (![dateMonth isEqualToString:strDate]) {
            section = [[SectionForTransactionOfMonth alloc] init];
            section.nameMonth = strDate;
            section.sectionWithMonth = [NSMutableArray array];
            dateMonth = strDate;
            [self.transactOfMonth addObject:section];
        } else{
            section = [self.transactOfMonth lastObject];
        }
        [section.sectionWithMonth addObject:transact];
        
    }
}

- (IBAction)didSelectSegment:(id)sender {

    if (!self.segmenControl.selectedSegmentIndex) {
        [self selectedArray:self.spandingArr];
    } else {
        [self selectedArray:self.incomeArr];
    }
    NSLog(@"%ld",self.segmenControl.selectedSegmentIndex);
    [self.table reloadData];
}
#pragma mark - Sort an arrayTransaction by date

- (void) sortArrayTransactionByDate {
    self.transactOfMonth = [[NSMutableArray alloc] initWithArray:self.transactions];
    NSSortDescriptor *UN = [NSSortDescriptor sortDescriptorWithKey:@"datePicker" ascending:YES];
    [self.transactOfMonth sortUsingDescriptors:[NSArray arrayWithObjects:UN, nil]];
    self.transactions = self.transactOfMonth;
}



#pragma mark - UITableViewDataSource UITableViewDelegate

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        SectionForTransactionOfMonth *section = [self.transactOfMonth objectAtIndex:indexPath.section];
       
        [context deleteObject:[section.sectionWithMonth objectAtIndex:indexPath.row]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }
        
        [section.sectionWithMonth removeObjectAtIndex:indexPath.row];
        [self.table deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    [self changeArrayTransaction];
    [self.table reloadData];

}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [self.transactOfMonth count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    SectionForTransactionOfMonth *sec = [self.transactOfMonth objectAtIndex:section];

    return [sec.sectionWithMonth count];
}

-(nullable UIView*) tableView:(UITableView *)tableView
       viewForHeaderInSection:(NSInteger)section{
    
    SectionForTransactionOfMonth *sec = [self.transactOfMonth objectAtIndex:section];
    double summ = 0;
    
    for (TransactionDB *trans in sec.sectionWithMonth) {
        summ = summ + [trans.summ doubleValue];
    }

    NSString *title = [[self.transactOfMonth objectAtIndex:section] nameMonth];
    CustomHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"Header"];
    headerView.dateLabel.text = title;
    headerView.summLabel.text = [NSString stringWithFormat:@"%.0f$", summ];
    headerView.contentView.backgroundColor = [UIColor lightGrayColor];
    
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    TransactionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellTransaction"];
    
    if (cell == nil) {
        cell = [[TransactionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellTransaction"];
    }

    SectionForTransactionOfMonth *section = [self.transactOfMonth objectAtIndex:indexPath.section];
    
    TransactionDB *transaction = [section.sectionWithMonth objectAtIndex:indexPath.row];
    
    [cell setCellWithTransaction:transaction];
    
    return cell;
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"showComplexTransaction"]){
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        SectionForTransactionOfMonth *section = [self.transactOfMonth objectAtIndex:indexPath.section];
        
        TransactionDB *transaction = [section.sectionWithMonth objectAtIndex:indexPath.row];
        
        ComplexTransactionViewController *destViewController = [segue destinationViewController];
        destViewController.transaction = transaction;
       }
}


@end
