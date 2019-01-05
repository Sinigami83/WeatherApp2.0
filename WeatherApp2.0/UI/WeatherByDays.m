//
//  Created by Nodir Latipov on 1/4/19.
//  Copyright © 2019 Home. All rights reserved.
//

#import "WeatherByDays.h"
#import "WeatherByDay.h"
#import "RowsForWeatherByDays.h"

@interface WeatherByDays () <UITableViewDelegate, UITableViewDataSource>
@end

@implementation WeatherByDays

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.weatherForWeek count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeatherByDay *cell = [tableView dequeueReusableCellWithIdentifier:@"WeatherByDay"];
    RowsForWeatherByDays *row = self.weatherForWeek[indexPath.row];
    cell.dayNameOfWeekLable.text = row.dayName;
    cell.iconImageView.image = [UIImage imageNamed:row.image];;
    cell.maxWeatherLable.text = [NSString stringWithFormat:@"%.0f", row.temperatureMax];
    cell.minWeatherLable.text = [NSString stringWithFormat:@"%.0f", row.temperatureMin];;
    return cell;
}

@end
