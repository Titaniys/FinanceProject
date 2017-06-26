//
//  FriendVK+CoreDataProperties.m
//  
//
//  Created by Вадим Чистяков on 23.06.17.
//
//  This file was automatically generated and should not be edited.
//

#import "FriendVK+CoreDataProperties.h"

@implementation FriendVK (CoreDataProperties)

+ (NSFetchRequest<FriendVK *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"FriendVK"];
}

@dynamic firstName;
@dynamic isDebt;
@dynamic lastName;
@dynamic summ;
@dynamic urlImage;

@end
