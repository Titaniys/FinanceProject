//
//  MapperUserVKModel.m
//  FinanceProject
//
//  Created by Вадим Чистяков on 26.06.17.
//  Copyright © 2017 Вадим Чистяков. All rights reserved.
//

#import "MapperUserVKModel.h"
#import "UserVKModel.h"

@implementation MapperUserVKModel

- (UserVKModel*)modelFromJson:(NSDictionary *)json {
    UserVKModel *user = [UserVKModel new];
    
    user.firstName   = json[@"first_name"];
    user.lastName    = json[@"last_name"];
    user.urlPhoto50  = json[@"photo_50"];
    
    return user;
}

@end
