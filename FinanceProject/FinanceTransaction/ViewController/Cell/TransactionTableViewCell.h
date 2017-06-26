//
//  TransactionTableViewCell.h
//  FinanceProject
//
//  Created by Вадим Чистяков on 24.06.17.
//  Copyright © 2017 Вадим Чистяков. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TransactionDB;

@interface TransactionTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *summ;

- (void) setCellWithTransaction:(TransactionDB *) transaction;

@end
