//
//  Created by Nodir Latipov on 1/5/19.
//  Copyright © 2019 Home. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RowsForWeatherDetail : NSObject

@property (nonatomic, strong) NSString *weatherDescription;
@property (nonatomic, strong) NSNumber *weatherDetail;

- (instancetype)initWithWeatherDescription:(NSString *)weatherDescription
                             weatherDetail:(NSNumber *)weatherDetail NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

/*
@property (nonatomic, strong) NSNumber *clouds;
@property (nonatomic, strong) NSNumber *windSpeed;
@property (nonatomic, strong) NSNumber *windDeg;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSNumber *snow3h;
@property (nonatomic, strong) NSNumber *grndLevel;
@property (nonatomic, strong) NSNumber *humidity;
@property (nonatomic, strong) NSNumber *pressure;
@property (nonatomic, strong) NSNumber *seaLevel;
@property (nonatomic, assign) double temerature;
@property (nonatomic, strong) NSString *weatherDescription;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *weatherType;
*/

@end

NS_ASSUME_NONNULL_END
