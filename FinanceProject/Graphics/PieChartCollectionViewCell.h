//
//  PieChartCollectionViewCell.h
//  FinanceProject
//
//  Created by Вадим Чистяков on 30.06.17.
//  Copyright © 2017 Вадим Чистяков. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLPieChart.h"

@interface PieChartCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) IBOutlet DLPieChart *pieChartViewCategory;
@property (nonatomic, weak) IBOutlet UILabel *monthLabel;


- (void)setCellForArray:(NSMutableArray*) summArray
            andCategory:(NSMutableArray*)categoryArray;

@end
