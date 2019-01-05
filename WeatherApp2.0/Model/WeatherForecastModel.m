//
//  Created by Nodir Latipov on 12/25/18.
//  Copyright © 2018 Home. All rights reserved.
//

#import "WeatherForecastModel.h"


@interface WeatherForecastModel ()
@end

@implementation WeatherForecastModel

- (instancetype)initWithServerResponse:(NSDictionary *)responseObject
{
    self = [super init];
    if (self) {
        //JSON field
        //clouds
        NSNumber *clouds = [[responseObject objectForKey:@"clouds"] objectForKey:@"all"];
        //wind
        NSDictionary *wind  = [responseObject objectForKey:@"wind"];
        NSNumber *windSpeed = [wind objectForKey:@"speed"];
        NSNumber *windDeg   = [wind objectForKey:@"deg"];
        //dt
        NSNumber *dateInString = [responseObject objectForKey:@"dt"];
        //snow
        NSDictionary *snow  = [responseObject objectForKey:@"snow"];
        NSNumber *snow3h    = [snow objectForKey:@"3h"];
        //main
        NSDictionary *main  = [responseObject objectForKey:@"main"];
        NSNumber *grndLevel = [main objectForKey:@"grnd_level"];
        NSNumber *humidity  = [main objectForKey:@"humidity"];
        NSNumber *pressure  = [main objectForKey:@"pressure"];
        NSNumber *seaLevel  = [main objectForKey:@"sea_level"];
        NSNumber *tempertur = [main objectForKey:@"temp"];
        //weather
        NSArray *weather        = [responseObject objectForKey:@"weather"];
        NSString *description   = [weather[0] objectForKey:@"description"];
        NSString *icon          = [weather[0] objectForKey:@"icon"];
        NSString *type          = [weather[0] objectForKey:@"main"];

        //JSON field
        //clouds
        _clouds     = clouds;
        //wind
        _windSpeed  = windSpeed;
        _windDeg    = windDeg;
        //dt
        _date       = [self currentDateForWeather:dateInString];
        //snow
        _snow3h     = snow3h;
        //main
        _grndLevel  = grndLevel;
        _humidity   = humidity;
        _pressure   = pressure;
        _seaLevel   = seaLevel;
        _temerature = [self temeratureOfWeather:tempertur];
        //weather
        _weatherDescription = description;
        _image      = [NSString stringWithFormat:@"%@", icon];
        _weatherType = type;
        //other
        _hour       = [self hourComponent:self.date];
    }
    return self;
}

- (NSDate *)currentDateForWeather:(NSNumber *)date
{
    return [NSDate dateWithTimeIntervalSince1970:[date doubleValue]];
}

- (NSNumberFormatter *)numberFormatter
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setRoundingMode:NSNumberFormatterRoundUp];
    [numberFormatter setMaximumFractionDigits:0];
    return numberFormatter;
}

- (double)temeratureOfWeather:(NSNumber *)temperature
{
    NSNumberFormatter *numberFormatter = [self numberFormatter];
    NSString *stringFromNumber = [numberFormatter stringFromNumber:temperature];
    return stringFromNumber.doubleValue;
}

- (NSUInteger)hourComponent:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *hourComponent = [calendar components:NSCalendarUnitHour
                                                         fromDate:date];
    return [hourComponent hour];
}

@end
