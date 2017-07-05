//
//  PieChartYearCollectionViewCell.m
//  FinanceProject
//
//  Created by Вадим Чистяков on 30.06.17.
//  Copyright © 2017 Вадим Чистяков. All rights reserved.
//

#import "PieChartYearCollectionViewCell.h"

@implementation PieChartYearCollectionViewCell


- (void)setCellForArray:(NSMutableArray*)dataArray
            andMonth:(NSMutableArray *)dateArray {
    
    [self.pieChartView renderInLayer:self.pieChartView dataArray:dataArray];
    
    [self.pieChartView drawLegends:self.pieChartView dataArray:dateArray];
    
}

@end
