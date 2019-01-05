//
//  Created by Nodir Latipov on 1/5/19.
//  Copyright © 2019 Home. All rights reserved.
//

#import "RowsForWeatherDetail.h"

@implementation RowsForWeatherDetail

- (instancetype)initWithWeatherDescription:(NSString *)weatherDescription
                             weatherDetail:(NSNumber *)weatherDetail
{
    self = [super init];
    if (self) {
        _weatherDescription = weatherDescription;
        _weatherDetail = weatherDetail;
    }
    return self;
}

@end
