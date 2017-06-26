//
//  TransactionDB+CoreDataProperties.h
//  
//
//  Created by Вадим Чистяков on 23.06.17.
//
//  This file was automatically generated and should not be edited.
//

#import "TransactionDB+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface TransactionDB (CoreDataProperties)

+ (NSFetchRequest<TransactionDB *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *category;
@property (nullable, nonatomic, copy) NSDate *datePicker;
@property (nonatomic) BOOL isSpending;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *note;
@property (nullable, nonatomic, copy) NSString *summ;

@end

NS_ASSUME_NONNULL_END
