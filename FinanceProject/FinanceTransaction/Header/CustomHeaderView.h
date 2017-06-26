//
//  CustomHeaderView.h
//  FinanceProject
//
//  Created by Вадим Чистяков on 21.06.17.
//  Copyright © 2017 Вадим Чистяков. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomHeaderView : UITableViewHeaderFooterView
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *summLabel;

+ (UINib*) nib;

@end
