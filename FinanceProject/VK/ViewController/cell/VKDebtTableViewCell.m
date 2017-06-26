//
//  VKDebtTableViewCell.m
//  FinanceProject
//
//  Created by Вадим Чистяков on 22.06.17.
//  Copyright © 2017 Вадим Чистяков. All rights reserved.
//

#import "VKDebtTableViewCell.h"
#import "FriendVK+CoreDataClass.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation VKDebtTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void) setCellforVK:(FriendVK*)friend {
    
    self.imageView.image = [UIImage imageNamed:@"1.png"];
    self.imageView.layer.backgroundColor=[[UIColor clearColor] CGColor];
    self.imageView.layer.cornerRadius=25;
    self.imageView.layer.borderWidth=2.0;
    self.imageView.layer.masksToBounds = YES;
    
    
    self.name.text = [NSString stringWithFormat:@"%@ %@", friend.firstName, friend.lastName];
    if (!friend.isDebt) {
        self.summ.text = [NSString stringWithFormat:@"+%@", friend.summ];
        self.summ.textColor = [UIColor greenColor];
        self.imageView.layer.borderColor=[[UIColor greenColor] CGColor];
    } else {
        self.summ.text = [NSString stringWithFormat:@"-%@", friend.summ];
        self.summ.textColor = [UIColor redColor];
        self.imageView.layer.borderColor=[[UIColor redColor] CGColor];
    }
    
    NSURL *url = [NSURL URLWithString:friend.urlImage];
    
    [self.imageView sd_setImageWithURL:url placeholderImage: [UIImage imageNamed:@"1.png"]];
    
}

@end
