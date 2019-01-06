//
//  Created by Nodir Latipov on 1/4/19.
//  Copyright © 2019 Home. All rights reserved.
//

#import "WeatherDetailByToday.h"
#import "RowsForWeatherDetail.h"

@interface WeatherDetailByToday () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation WeatherDetailByToday
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.weatherDetailByToday count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WeatherDetail"];
    RowsForWeatherDetail *row = self.weatherDetailByToday[indexPath.row];
    cell.textLabel.text = row.weatherDescription;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", row.weatherDetail];
    return cell;
}

@end
