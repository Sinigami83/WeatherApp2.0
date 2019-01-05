//
//  Created by Nodir Latipov on 1/4/19.
//  Copyright © 2019 Home. All rights reserved.
//

#import "ViewController.h"
#import "LoadingDataFromServer.h"
#import "WeatherForecastModel.h"
#import "RowsForWeatherByHours.h"
#import "RowsForWeatherByDays.h"
#import "WeatherByHours.h"
#import "WeatherByDays.h"


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
         [self reloadData];
     } onFailure:^(NSError *error) {
         NSLog(@"Error %@", [error localizedDescription]);
     }];
}

- (void)reloadData
{
    self.weatherForOneDay = [self makeTableViewCellWeatherByHour];
    self.weatherForWeak = [self makeTableViewCellWeatherByDay];

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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
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
    } else {//if (indexPath.row == 1 ) {
        WeatherByDays* cell = [tableView dequeueReusableCellWithIdentifier:@"WeatherByDays"];
        cell.weatherForWeek = self.weatherForWeak;
        [cell.weatherByDayCellTableView reloadData];
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
