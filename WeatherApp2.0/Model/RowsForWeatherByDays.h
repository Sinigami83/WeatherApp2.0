//
//  Created by Nodir Latipov on 1/5/19.
//  Copyright © 2019 Home. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RowsForWeatherByDays : NSObject

@property (nonatomic, strong) NSString *dayName;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, assign) double temperatureMax;
@property (nonatomic, assign) double temperatureMin;

@end

NS_ASSUME_NONNULL_END
