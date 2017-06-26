//
//  LoginViewController.m
//  FinanceProject
//
//  Created by Вадим Чистяков on 23.06.17.
//  Copyright © 2017 Вадим Чистяков. All rights reserved.
//

#import "LoginViewController.h"
#import "AccessToken.h"


@interface LoginViewController () <UIWebViewDelegate>

@property (copy,nonatomic) LoginComplitionBlock complitionBlock;
@property (weak, nonatomic) UIWebView *webView;
@property (strong, nonatomic) AccessToken *token;

@end

@implementation LoginViewController 


- (void)viewDidLoad {
    [super viewDidLoad];

    CGRect rect = self.view.bounds;
    rect.origin = CGPointZero;
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:rect];

    webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.view addSubview:webView];
    
    self.webView = webView;
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]
        initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                             target:self
                             action:@selector(actionCancel:)];

    [self.navigationItem setRightBarButtonItem:item animated:YES];
    self.navigationItem.title = @"Login";
    
    
    NSString *urlString = @"https://oauth.vk.com/authorize?"
                           "client_id=5990337&"
                           "scope=friends,photos&"
                           "redirect_uri=com.vadim&"
                           "display=page&"
                           "response_type=token";
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    webView.delegate = self;
    [webView loadRequest:request];

}

- (void)dealloc {
    self.webView.delegate = nil;
}
#pragma mark - Actions

- (void)actionCancel:(UIBarButtonItem*) item {
    
    if (self.complitionBlock) {
        self.complitionBlock(nil);
    }
    [self dismissViewControllerAnimated:YES
                             completion:^{
                                 
                             }];
}
- (id)initWithCompletionBlock:(LoginComplitionBlock)completionBlock {
    
    self = [super init];
    if (self) {
        self.complitionBlock = completionBlock;
    }
    return self;
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
//http://com.vadim/#access_token=a436406efd545548a0427e6eefe52b29518547b716c3ee90c222f67d475e5e84b80068fd2bd5d0eeef290&expires_in=86400&user_id=13897921

    if ([[[request URL] host] isEqual:@"com.vadim"]) {
        
        AccessToken *token = [AccessToken new];
        NSString *query = [[request URL] description];
        NSArray *array = [query componentsSeparatedByString:@"#"];
        
        if ([array count] > 1) {
            query = [array lastObject];
        }
        NSArray *pairs = [query componentsSeparatedByString:@"&"];
        for (NSString *pair in pairs) {
            NSArray *values = [pair componentsSeparatedByString:@"="];
            
            if ([values count] == 2) {
                NSString *key = [values firstObject];
                
                if ([key isEqualToString:@"access_token"]) {
                    token.token = [values lastObject];
                } else if ([key isEqualToString:@"expires_in"]) {
                    NSTimeInterval interval = [[values lastObject] doubleValue];
                    token.expirationDate = [NSDate dateWithTimeIntervalSinceNow:interval];
                } else if ([key isEqualToString:@"user_id"]) {
                    token.userID = [values lastObject];
                }
            }
        }
        
        self.webView.delegate = nil;
        
        if (self.complitionBlock) {
            self.complitionBlock(token);
        }
        
        NSLog(@"%@", [request URL]);
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
        return NO;

    }
    
    return YES;
}

@end





