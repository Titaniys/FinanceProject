//
//  TransactionTableViewCell.m
//  FinanceProject
//
//  Created by Вадим Чистяков on 24.06.17.
//  Copyright © 2017 Вадим Чистяков. All rights reserved.
//

#import "TransactionTableViewCell.h"
#import "TransactionDB+CoreDataClass.h"

@implementation TransactionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setCellWithTransaction:(TransactionDB *) transaction {
    //Доделать формат даты 24/FRI/12:45
    NSDate *firstDate = transaction.datePicker;
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"dd EEEE"];
    NSString *strDate = [dateFormatter stringFromDate:firstDate];
    
    self.name.text = transaction.name;
    self.date.text = strDate;
    self.summ.text = [NSString stringWithFormat:@"%.02f",[transaction.summ doubleValue]];
    
}


@end
