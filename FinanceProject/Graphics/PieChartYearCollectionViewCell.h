//
//  PieChartYearCollectionViewCell.h
//  FinanceProject
//
//  Created by Вадим Чистяков on 30.06.17.
//  Copyright © 2017 Вадим Чистяков. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLPieChart.h"

@interface PieChartYearCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) IBOutlet DLPieChart *pieChartView;
@property (nonatomic, weak) IBOutlet UILabel *labelYear;


- (void)setCellForArray:(NSMutableArray*)dataArray
            andMonth:(NSMutableArray*)dateArray;

@end
