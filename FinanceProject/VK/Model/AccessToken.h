//
//  AssessToken.h
//  FinanceProject
//
//  Created by Вадим Чистяков on 23.06.17.
//  Copyright © 2017 Вадим Чистяков. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccessToken : NSObject

@property (copy, nonatomic) NSString *token;
@property (copy, nonatomic) NSDate *expirationDate;
@property (copy, nonatomic) NSString *userID;

@end
