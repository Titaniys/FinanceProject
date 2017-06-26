//
//  ViewController.m
//  FinanceProject
//
//  Created by Вадим Чистяков on 16.06.17.
//  Copyright © 2017 Вадим Чистяков. All rights reserved.
//

#import "ComplexTransactionViewController.h"
#import "TransactionDB+CoreDataClass.h"

@interface ComplexTransactionViewController ()

@end

@implementation ComplexTransactionViewController

- (void)setVCWithTransaction:(TransactionDB *)transaction {
  
    self.nameLabel.text = transaction.name;
    self.summLabel.text = [NSString stringWithFormat:@"%.02f",[transaction.summ doubleValue]];
    self.isSpanding.text = [NSString stringWithFormat:@"%d", transaction.isSpending];
    self.category.text = transaction.category;
    
    NSDate *firstDate = transaction.datePicker;
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"yyyy-MM-dd 'at' HH:mm"];
    NSString *stringDate = [dateFormatter stringFromDate:firstDate];
    
    self.date.text = stringDate;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setVCWithTransaction:self.transaction];
}



@end
