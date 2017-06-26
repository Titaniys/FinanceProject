//
//  ManagerServer.h
//  FinanceProject
//
//  Created by Вадим Чистяков on 22.06.17.
//  Copyright © 2017 Вадим Чистяков. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@class UserVKModel;

typedef void (^UserListCompletionBlock)(NSError *error, NSArray *friends);
typedef void (^UserDetailsCompletionBlock)(NSError *error, id users);

@interface ManagerServer : NSObject

@property (strong, nonatomic, readonly) UserVKModel *currentUser;


- (void)authorizeUserWirhQuery:(NSString *) query
                      andBlock:(void (^)(NSArray *))completion;

+ (ManagerServer *) sharedManager;

//- (NSURLSessionDataTask*)searchFrendsFromVKWithRequest:(NSString*)request
//                               offset:(NSInteger)offset
//                                count:(NSInteger)count
//                            onSuccess:(UserListCompletionBlock) success
//                               onFail:(void(^)(NSError *error, NSInteger statusCode)) failure;


- (NSURLSessionDataTask*)searchVKWithRequest:(NSString*)query
                     userID:(NSInteger)userID
                  onSuccess:(UserListCompletionBlock) success
                     onFail:(void(^)(NSError *error, NSInteger statusCode)) failure;


@end
