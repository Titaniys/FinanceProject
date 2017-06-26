//
//  MapperUserVKModel.h
//  FinanceProject
//
//  Created by Вадим Чистяков on 26.06.17.
//  Copyright © 2017 Вадим Чистяков. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserVKModel;

@interface MapperUserVKModel : NSObject

- (UserVKModel*)modelFromJson:(NSDictionary*)json;

@end
