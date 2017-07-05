//
//  ManagerServer.h
//  FinanceProject
//
//  Created by Вадим Чистяков on 22.06.17.
//  Copyright © 2017 Вадим Чистяков. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "PDKeychainBindings.h"
@class UserVKModel;

typedef void (^PDKeychainCompletionBlock)(NSError *error, PDKeychainBindings *binding);
typedef void (^UserListCompletionBlock)(NSError *error, NSArray *friends);
typedef void (^UserDetailsCompletionBlock)(NSError *error, id users);

@interface ManagerServer : NSObject

@property (strong, nonatomic, readonly) UserVKModel *currentUser;


- (void)authorizeUserWirhQuery:(PDKeychainCompletionBlock) completion;

+ (ManagerServer *) sharedManager;


- (void)searchVKWithRequest:(NSString*)query
                accessToken:(NSString*)access_token
                     userID:(NSString*)userID
                  onSuccess:(UserListCompletionBlock) success
                     onFail:(void(^)(NSError *error, NSInteger statusCode)) failure;

@end
