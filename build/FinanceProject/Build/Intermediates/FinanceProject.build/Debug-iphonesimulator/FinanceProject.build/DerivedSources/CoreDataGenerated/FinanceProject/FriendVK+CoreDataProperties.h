//
//  FriendVK+CoreDataProperties.h
//  
//
//  Created by Вадим Чистяков on 23.06.17.
//
//  This file was automatically generated and should not be edited.
//

#import "FriendVK+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface FriendVK (CoreDataProperties)

+ (NSFetchRequest<FriendVK *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *firstName;
@property (nonatomic) BOOL isDebt;
@property (nullable, nonatomic, copy) NSString *lastName;
@property (nullable, nonatomic, copy) NSString *summ;
@property (nullable, nonatomic, copy) NSString *urlImage;

@end

NS_ASSUME_NONNULL_END
