//
//  ViewController.h
//  FinanceProject
//
//  Created by Вадим Чистяков on 16.06.17.
//  Copyright © 2017 Вадим Чистяков. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TransactionDB;

@interface ComplexTransactionViewController : UIViewController

@property (strong, nonatomic) TransactionDB *transaction;
@property (weak, nonatomic) IBOutlet UIImageView *imageTransaction;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *summLabel;
@property (weak, nonatomic) IBOutlet UILabel *isSpanding;
@property (weak, nonatomic) IBOutlet UILabel *category;
@property (weak, nonatomic) IBOutlet UILabel *date;

- (void) setVCWithTransaction:(TransactionDB *) transaction;

@end

