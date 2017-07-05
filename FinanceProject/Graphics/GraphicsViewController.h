//
//  GraphicsViewController.h
//  FinanceProject
//
//  Created by Вадим Чистяков on 27.06.17.
//  Copyright © 2017 Вадим Чистяков. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLPieChart.h"
#import "CorePlot-CocoaTouch.h"

@interface GraphicsViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionViewCategory;

@property (nonatomic, weak) IBOutlet UICollectionView *CollectionViewYear;


@end
