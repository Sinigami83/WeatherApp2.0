//
//  Created by Nodir Latipov on 1/4/19.
//  Copyright © 2019 Home. All rights reserved.
//

#import "WeatherByDays.h"

@interface WeatherByDays () <UITableViewDelegate, UITableViewDataSource>
@end

@implementation WeatherByDays

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WeatherByDay"];
    return cell;
}

@end
