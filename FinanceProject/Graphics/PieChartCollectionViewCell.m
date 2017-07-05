//
//  PieChartCollectionViewCell.m
//  FinanceProject
//
//  Created by Вадим Чистяков on 30.06.17.
//  Copyright © 2017 Вадим Чистяков. All rights reserved.
//

#import "PieChartCollectionViewCell.h"

@implementation PieChartCollectionViewCell


- (void)setCellForArray:(NSMutableArray*)summArray
            andCategory:(NSMutableArray*)categoryArray
{

[self.pieChartViewCategory renderInLayer:self.pieChartViewCategory dataArray:summArray];
    
[self.pieChartViewCategory drawLegends:self.pieChartViewCategory dataArray:categoryArray];

}
@end
