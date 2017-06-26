//
//  TransactionDB+CoreDataProperties.m
//  
//
//  Created by Вадим Чистяков on 23.06.17.
//
//  This file was automatically generated and should not be edited.
//

#import "TransactionDB+CoreDataProperties.h"

@implementation TransactionDB (CoreDataProperties)

+ (NSFetchRequest<TransactionDB *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"TransactionDB"];
}

@dynamic category;
@dynamic datePicker;
@dynamic isSpending;
@dynamic name;
@dynamic note;
@dynamic summ;

@end
