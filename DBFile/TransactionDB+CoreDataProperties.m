//
//  TransactionDB+CoreDataProperties.m
//  FinanceProject
//
//  Created by Вадим Чистяков on 20.06.17.
//  Copyright © 2017 Вадим Чистяков. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "TransactionDB+CoreDataProperties.h"

@implementation TransactionDB (CoreDataProperties)

+ (NSFetchRequest<TransactionDB *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"TransactionDB"];
}

@dynamic name;
@dynamic summ;
@dynamic note;
@dynamic category;
@dynamic datePicker;
@dynamic isSpending;

@end
