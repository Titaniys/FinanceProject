//
//  VKDebtTableViewCell.h
//  FinanceProject
//
//  Created by Вадим Чистяков on 22.06.17.
//  Copyright © 2017 Вадим Чистяков. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FriendVK;


@interface VKDebtTableViewCell : UITableViewCell

@property (weak, nonatomic)IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *summ;

- (void) setCellforVK:(FriendVK*) friend;

@end
