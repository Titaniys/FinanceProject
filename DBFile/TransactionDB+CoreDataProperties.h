//
//  TransactionDB+CoreDataProperties.h
//  FinanceProject
//
//  Created by Вадим Чистяков on 20.06.17.
//  Copyright © 2017 Вадим Чистяков. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "TransactionDB+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface TransactionDB (CoreDataProperties)

+ (NSFetchRequest<TransactionDB *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *summ;
@property (nullable, nonatomic, copy) NSString *note;
@property (nullable, nonatomic, copy) NSString *category;
@property (nullable, nonatomic, copy) NSDate *datePicker;
@property (nonatomic) BOOL isSpending;

@end

NS_ASSUME_NONNULL_END
