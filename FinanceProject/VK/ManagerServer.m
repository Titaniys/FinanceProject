//
//  ManagerServer.m
//  FinanceProject
//
//  Created by Вадим Чистяков on 22.06.17.
//  Copyright © 2017 Вадим Чистяков. All rights reserved.
//

#import "ManagerServer.h"
#import "LoginViewController.h"
#import "AFNetworking.h"
#import "UserVKModel.h"
#import "AccessToken.h"
#import "MapperUserVKModel.h"
#import "PDKeychainBindings.h"


@interface ManagerServer ()

@property (strong, nonatomic) AFHTTPSessionManager *sessionManager;
@property (strong, nonatomic) AccessToken *accessToken;
// @property  для единственного запуска авторизации

@end

@implementation ManagerServer


+ (ManagerServer *) sharedManager {
    
    static ManagerServer * manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ManagerServer alloc] init];
        
    });
    return manager;
}


- (id)init
{
    self = [super init];
    if (self) {
        NSURL *url = [NSURL URLWithString:@"https://api.vk.com/method/"];
        self.sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    }
    return self;
}

- (void)authorizeUserWirhQuery:(PDKeychainCompletionBlock)completion {
    
    LoginViewController *vc = [[LoginViewController alloc] initWithCompletionBlock:^(AccessToken *token) {
        self.accessToken = token;
//        if (token) {
//         //NSURLSessionDataTask* dich =
//            [self searchVKWithRequest:query
//                    accessToken:self.accessToken.token
//                         userID:self.accessToken.userID
//                      onSuccess:^(NSError *error, NSArray *friends) {
//                          NSLog(@"%@",friends);
//                          completion(friends);
//                
//                       } onFail:^(NSError *error, NSInteger statusCode) {
//                                                         
//                       }];
//            
//        } else if (completion) {
//            completion(nil);
//        }
        PDKeychainBindings *bindings = [PDKeychainBindings sharedKeychainBindings];
        [bindings setObject:self.accessToken.userID forKey:@"userID"];
        [bindings setObject:self.accessToken.token forKey:@"token"];
        completion(nil, bindings);

    }];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    UIViewController *mainVC = [[[[UIApplication sharedApplication] windows] firstObject] rootViewController];
    
    [mainVC presentViewController:nav animated:YES completion:nil];
    
        
}
- (void)searchVKWithRequest:(NSString*)query
                accessToken:(NSString*)access_token
                     userID:(NSString*)userID
                  onSuccess:(UserListCompletionBlock) success
                    onFail:(void(^)(NSError *error, NSInteger statusCode)) failure {
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                access_token,@"access_token",
                                userID,@"user_id",
                                query,@"q",
                                @"photo_50",@"fields", nil];

   [self.sessionManager GET:@"friends.search"
                  parameters:dictionary
                          progress:^(NSProgress * _Nonnull downloadProgress) {
                              
                          }
                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

                         [ManagerServer handleSuccessResponse:responseObject withCompletion:success];
                         
                     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         
                         NSLog(@"Fail %@", error);
                     }];
    
}

#pragma mark - private

+ (void) handleSuccessResponse:(NSDictionary *)responceJson
                withCompletion:(UserDetailsCompletionBlock)
                completionBlock {
    
    dispatch_async(dispatch_get_global_queue (DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        MapperUserVKModel *mapper = [MapperUserVKModel new];
        NSMutableArray *friends = [@[] mutableCopy];
        NSArray *jsonArray = responceJson[@"response"];
        int i = 1;
        
        NSLog(@"jsonnew %@",jsonArray);
       
        for (NSDictionary *friendsJson in jsonArray) {
            if (i != 1){
                UserVKModel *user = [mapper modelFromJson:friendsJson];
                if (user) {
                    [friends addObject:user];
                }
            }
            i ++;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(nil,friends);
        });
    });
    
}

@end
