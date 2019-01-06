//
//  Created by Nodir Latipov on 1/4/19.
//  Copyright © 2019 Home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RowsForWeatherByHours.h"

NS_ASSUME_NONNULL_BEGIN

@interface WeatherByHours : UITableViewCell

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray<RowsForWeatherByHours *> *weatherForOneDay;

- (void)setCollectionView:(UICollectionView *)collectionView;
@end

NS_ASSUME_NONNULL_END
