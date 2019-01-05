//
//  Created by Nodir Latipov on 1/4/19.
//  Copyright © 2019 Home. All rights reserved.
//

#import "WeatherByHours.h"
#import "WeatherByHour.h"

@interface WeatherByHours () <UICollectionViewDelegate, UICollectionViewDataSource>
@end

@implementation WeatherByHours

- (void)setCollectionView:(UICollectionView *)collectionView
{
    _collectionView = collectionView;
    //collectionView.dataSource = self;
    //collectionView.delegate = self;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.weatherForOneDay.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WeatherByHour *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    SectionRow *row = self.weatherForOneDay[indexPath.row];
    NSString *hour = [NSString stringWithFormat:@"%lu", row.hour];
    cell.hourLable.text = hour;
    cell.iconImageView.image = [UIImage imageNamed:row.image]; ;
    cell.tempertatureLable.text = [NSString stringWithFormat:@"%.0f ℃", row.temperature];
    return cell;
}

@end
