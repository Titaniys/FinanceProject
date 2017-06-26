//
//  LoginViewController.h
//  FinanceProject
//
//  Created by Вадим Чистяков on 23.06.17.
//  Copyright © 2017 Вадим Чистяков. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AccessToken;

typedef void(^LoginComplitionBlock)(AccessToken *token);

@interface LoginViewController : UIViewController

- (id)initWithCompletionBlock:(LoginComplitionBlock) completionBlock;


@end
