//
//  GraphicsViewController.m
//  FinanceProject
//
//  Created by Вадим Чистяков on 27.06.17.
//  Copyright © 2017 Вадим Чистяков. All rights reserved.
//

#import "GraphicsViewController.h"
#import "AppDelegate.h"
#import "Transaction.h"
#import "TransactionDB+CoreDataClass.h"
#import "SectionForTransactionOfMonth.h"
#import "PieChartCollectionViewCell.h"
#import "PieChartYearCollectionViewCell.h"


@interface GraphicsViewController ()

@property (nonatomic, strong) NSArray *transactions;
@property (nonatomic, strong) NSMutableArray *transactOfMonth;
@property (nonatomic, strong) NSMutableArray *countYear;
@property (nonatomic, strong) NSMutableArray *summOfCategory;
@property (nonatomic, strong) NSMutableArray *categoryArray;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *dateArray;

@end

@implementation GraphicsViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [self.collectionViewCategory reloadData];
    [self.CollectionViewYear reloadData];
    [self configure];


    }
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.collectionViewCategory.dataSource = self;
    self.CollectionViewYear.dataSource = self;

}


#pragma mark - Configure pieChart for year
- (void)configure {
    
    NSFetchRequest <TransactionDB*> *fetchRequest = [TransactionDB fetchRequest];
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    self.transactions = [appDelegate.persistentContainer.viewContext
                         executeFetchRequest:fetchRequest
                         error:nil];
    
    
    [self sortArrayTransactionByMonth];
    
    self.transactOfMonth = [self selectedArray:self.transactOfMonth];
    
    [self countYearInTransactionOfMonth];
}
- (void)pieChartForYear:(NSUInteger)numberYear {
    
    self.dataArray = [NSMutableArray new];
    self.dateArray = [NSMutableArray new];
    
    for(int i = 0; i < [self.transactOfMonth count]; i++)
    {

        SectionForTransactionOfMonth *sec = [self.transactOfMonth objectAtIndex:i];
        
        if ([self.countYear[numberYear] isEqualToString:[sec.nameMonth substringFromIndex:4]]) {
            
            double summ = 0;
            
            for (TransactionDB *trans in sec.sectionWithMonth) {
                summ = summ + [trans.summ doubleValue];
            }
            
            [self.dateArray addObject:sec.nameMonth];
            NSNumber *one = [NSNumber numberWithDouble:summ];
            [self.dataArray addObject:one];
        }
        
    }

}

- (void)pieChartForCategory:(NSUInteger)numberMonth {
    
    SectionForTransactionOfMonth *sec = [self.transactOfMonth objectAtIndex:numberMonth];

    NSMutableDictionary *category = [NSMutableDictionary new];
    
    for (TransactionDB *trans in sec.sectionWithMonth) {
        
        NSMutableDictionary *cat = [NSMutableDictionary dictionaryWithObjectsAndKeys:trans.summ, trans.category, nil];
        
        if (category[trans.category] == nil) {
            [category addEntriesFromDictionary:cat];
        } else {
            double znagenie = [category[trans.category] doubleValue] + [trans.summ doubleValue];
            cat = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%.f",znagenie], trans.category, nil];
            [category addEntriesFromDictionary:cat];
        }
    }
    
    self.categoryArray = [NSMutableArray new];
    self.summOfCategory = [NSMutableArray new];
    
    for (NSDictionary *tempCategory in category) {
        
        NSString *str =[NSString stringWithFormat:@"%@",tempCategory];

        [self.categoryArray addObject:str];
        NSNumber *one = [NSNumber numberWithDouble:[category[str] doubleValue]];
        [self.summOfCategory addObject:one];
        
    }
}

#pragma mark - Sort an arrayTransaction by date

- (void) sortArrayTransactionByMonth {
    self.transactOfMonth = [[NSMutableArray alloc] initWithArray:self.transactions];
    NSSortDescriptor *UN = [NSSortDescriptor sortDescriptorWithKey:@"datePicker" ascending:YES];
    [self.transactOfMonth sortUsingDescriptors:[NSArray arrayWithObjects:UN, nil]];
    self.transactions = self.transactOfMonth;
}

- (NSMutableArray *) selectedArray:(NSMutableArray*) array {
    
    NSMutableArray *returnArray = [NSMutableArray new];
    
    //self.transactOfMonth = [NSMutableArray new];
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
            [returnArray addObject:section];
        } else{
            section = [returnArray lastObject];
        }
        [section.sectionWithMonth addObject:transact];
        
    }
    return returnArray;
}

- (void) countYearInTransactionOfMonth {
    
    self.countYear = [NSMutableArray new];
    NSString *nameYear = nil;
    
    for (int i = 0; i < [self.transactOfMonth count]; i++) {
        
        SectionForTransactionOfMonth *sec = self.transactOfMonth[i];
        
        if (![nameYear isEqualToString:[sec.nameMonth substringFromIndex:4]]) {
            
            nameYear = [sec.nameMonth substringFromIndex:4];
            [self.countYear addObject:nameYear];
        }
 
    }
  
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (collectionView == self.collectionViewCategory) {
        return [self.transactOfMonth count];
    } else {
        return [self.countYear count];
    }

}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (collectionView == self.CollectionViewYear) {
        
        PieChartYearCollectionViewCell *cellYear = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellYear" forIndexPath:indexPath];
        [self pieChartForYear:indexPath.row];
        
        cellYear.labelYear.text = self.countYear[indexPath.row];
        
        [cellYear setCellForArray:self.dataArray andMonth:self.dateArray];
        
        return cellYear;
        
    
    } else {
            
        PieChartCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        
        [self pieChartForCategory:indexPath.row];
        
        SectionForTransactionOfMonth *sec = self.transactOfMonth[indexPath.row];
                                                                 
        cell.monthLabel.text = sec.nameMonth;
        
        [cell setCellForArray:self.summOfCategory andCategory:self.categoryArray];
        
        return cell;
        
    }

}


@end
