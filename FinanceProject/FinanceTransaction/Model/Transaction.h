//
//  Transaction.h
//  FinanceProject
//
//  Created by Вадим Чистяков on 16.06.17.
//  Copyright © 2017 Вадим Чистяков. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Transaction : NSObject

@property (nonatomic, copy) NSString *nameTransaction;
@property (nonatomic, strong) NSNumber *sum;
@property (nonatomic, strong) NSString *note;
@property (nonatomic, strong) NSString *category;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, assign) BOOL isSpending;


@end
