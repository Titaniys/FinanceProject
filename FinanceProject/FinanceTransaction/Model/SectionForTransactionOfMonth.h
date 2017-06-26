//
//  SectionForTransactionOfMonth.h
//  FinanceProject
//
//  Created by Вадим Чистяков on 20.06.17.
//  Copyright © 2017 Вадим Чистяков. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SectionForTransactionOfMonth : NSObject

@property (strong, nonatomic) NSMutableArray * sectionWithMonth;
@property (copy, nonatomic) NSString *nameMonth;
@property (strong, nonatomic) NSNumber *summMonth;

@end
