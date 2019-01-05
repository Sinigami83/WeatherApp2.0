//
//  Created by Nodir Latipov on 1/4/19.
//  Copyright © 2019 Home. All rights reserved.
//

#import "ViewController.h"
#import "LoadingDataFromServer.h"
#import "WeatherForecastModel.h"
#import "RowsForWeatherByHours.h"
#import "RowsForWeatherByDays.h"
#import "RowsForWeatherDetail.h"
#import "WeatherByHours.h"
#import "WeatherByDays.h"
#import "WeatherDetailByToday.h"


#define NUMBER_OF_HOURS_FOR_PRINT 8

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *temperatureInCityLable;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLable;
@property (weak, nonatomic) IBOutlet UILabel *cityNameLable;
@property (nonatomic, strong) NSNumber *cityID;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (nonatomic, strong) NSArray<WeatherForecastModel *> *weatherForCity;
@property (nonatomic, strong) NSArray<RowsForWeatherByHours *> *weatherForOneDay;
@property (nonatomic, strong) NSArray<RowsForWeatherByDays *> *weatherForWeak;
@property (nonatomic, strong) NSArray<RowsForWeatherDetail *> *weatherDetail;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.cityID = @524901;
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateFormat:@"EEEE"];
    //self.dateFormatter.dateFormat = @"dd-MM-yyyy";
    [self getWeatherFromServer];
}

- (void)getWeatherFromServer
{
    [[LoadingDataFromServer sharedManager]
     getWeatherWithCity:self.cityID
     onSuccess:^(NSArray *weathers) {
         self.weatherForCity = weathers;
         self.temperatureInCityLable.text = [NSString stringWithFormat:@"%.0f", self.weatherForCity[0].temerature];
         self.descriptionLable.text = self.weatherForCity[0].weatherDescription;
         [self reloadData];
     } onFailure:^(NSError *error) {
         NSLog(@"Error %@", [error localizedDescription]);
     }];
}

- (void)reloadData
{
    self.weatherForOneDay = [self makeTableViewCellWeatherByHour];
    self.weatherForWeak = [self makeTableViewCellWeatherByDay];
    self.weatherDetail = [self makeTableViewCellWeatherDetail];

    [self.tableView reloadData];
}

- (NSArray *)makeTableViewCellWeatherByHour
{
    NSMutableArray *rows = [NSMutableArray array];

    for (int i = 0; i < NUMBER_OF_HOURS_FOR_PRINT; ++i) {
        WeatherForecastModel *w = self.weatherForCity[i];

        RowsForWeatherByHours *row = [[RowsForWeatherByHours alloc] init];
        row.temperature = w.temerature;
        row.hour = w.hour;
        row.image = w.image;
        [rows addObject:row];
    }
    return rows;
}

- (NSArray *)makeTableViewCellWeatherByDay
{
    NSMutableArray *rows = [NSMutableArray array];

    double temperatureMax = self.weatherForCity[0].temerature;
    double temperatureMin = self.weatherForCity[0].temerature;
    NSString *image = self.weatherForCity[0].image;

    NSDate *weatherDate = self.weatherForCity[0].date;

    for (WeatherForecastModel *w in self.weatherForCities) {
        NSComparisonResult result = [self compareTwoDate:weatherDate secondDate:w.date];

        if (result != NSOrderedSame) {
            RowsForWeatherByDays *row = [[RowsForWeatherByDays alloc] init];
            row.temperatureMax = temperatureMax;
            row.temperatureMin = temperatureMin;
            row.image = image;
            row.dayName = [self.dateFormatter stringFromDate:w.date];
            [rows addObject:row];
        } else {
            if (temperatureMax < w.temerature) {
                temperatureMax = w.temerature;
                image = w.image;
            }
            if (temperatureMin > w.temerature) {
                temperatureMin = w.temerature;
            }
        }
        weatherDate = w.date;
    }
    return rows;
}

- (NSArray *)makeTableViewCellWeatherDetail
{
    WeatherForecastModel *w = self.weatherForCity[0];

    NSMutableArray *rows = [NSMutableArray array];

    [rows addObject: [[RowsForWeatherDetail alloc] initWithWeatherDescription:@"Cloudiness, %"
                                                                weatherDetail:w.clouds]];
    [rows addObject: [[RowsForWeatherDetail alloc] initWithWeatherDescription:@"Wind speed. Unit Default: meter/sec"
                                                                weatherDetail:w.windSpeed]];
    [rows addObject: [[RowsForWeatherDetail alloc] initWithWeatherDescription:@"Wind direction, degrees (meteorological)"
                                                                weatherDetail:w.windDeg]];
    [rows addObject: [[RowsForWeatherDetail alloc] initWithWeatherDescription:@"Snow volume for last 3 hours"
                                                                weatherDetail:w.snow3h]];
    [rows addObject: [[RowsForWeatherDetail alloc] initWithWeatherDescription:@"Atmospheric pressure on the ground level, hPa"
                                                                weatherDetail:w.grndLevel]];
    [rows addObject: [[RowsForWeatherDetail alloc] initWithWeatherDescription:@"Humidity, %"
                                                                weatherDetail:w.humidity]];
    [rows addObject: [[RowsForWeatherDetail alloc] initWithWeatherDescription:@"Atmospheric pressure on the sea level by default, hPa"
                                                                weatherDetail:w.pressure]];
    [rows addObject: [[RowsForWeatherDetail alloc] initWithWeatherDescription:@"Atmospheric pressure on the sea level, hPa"
                                                                weatherDetail:w.seaLevel]];
    [rows addObject: [[RowsForWeatherDetail alloc] initWithWeatherDescription:@"Atmospheric pressure on the sea level, hPa"
                                                                weatherDetail:[NSNumber numberWithDouble:w.temerature]]];

    return rows;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        WeatherByHours *cell = [tableView dequeueReusableCellWithIdentifier:@"CellWeatherByHours"];
        cell.weatherForOneDay = self.weatherForOneDay;
        [cell.collectionView reloadData];
        return cell;
    } else if (indexPath.section == 1) {
        WeatherByDays* cell = [tableView dequeueReusableCellWithIdentifier:@"WeatherByDays"];
        cell.weatherForWeek = self.weatherForWeak;
        [cell.weatherByDayCellTableView reloadData];
        return cell;
    } else {
        WeatherDetailByToday* cell = [tableView dequeueReusableCellWithIdentifier:@"WeatherDetailByToday"];
        cell.weatherDetailByToday = self.weatherDetail;
        [cell.tableView reloadData];
        return cell;
    }
}

#pragma mark - get

- (NSArray *)weatherForCities
{
    if (!_weatherForCity) {
        _weatherForCity = [[NSArray alloc] init];
    }
    return _weatherForCity;
}

#pragma mark - for compare

- (NSDateComponents *)dayComponents:(NSDate *)date
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSCalendarUnit flags = NSCalendarUnitDay;
    NSDateComponents *daysComponents = [calendar components:flags fromDate:date];
    return daysComponents;
}

- (NSComparisonResult)compareTwoDate:(NSDate *)firstDate
                          secondDate:(NSDate *)secondDate
{
    NSDateComponents *firstDateComponents   = [self dayComponents: firstDate];
    NSDateComponents *secondDateComponents  = [self dayComponents: secondDate];

    NSUInteger firstDay     = [firstDateComponents day];
    NSUInteger secondDay    = [secondDateComponents day];

    if (firstDay == secondDay) {
        return NSOrderedSame;
    } else if (firstDay < secondDay) {
        return NSOrderedAscending;
    }
    return NSOrderedDescending;
}

@end
