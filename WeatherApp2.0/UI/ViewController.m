//
//  Created by Nodir Latipov on 1/4/19.
//  Copyright © 2019 Home. All rights reserved.
//

#import "ViewController.h"
#import "LoadingDataFromServer.h"
#import "WeatherForecastModel.h"
#import "Section.h"
#import "SectionRow.h"
#import "WeatherByHours.h"


@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *temperatureInCityLable;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLable;
@property (weak, nonatomic) IBOutlet UILabel *cityNameLable;
@property (nonatomic, strong) NSNumber *cityID;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (nonatomic, strong) NSArray<WeatherForecastModel *> *weatherForCity;
@property (nonatomic, strong) NSArray<Section *> *dataForPrint;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.cityID = @524901;

    self.dateFormatter = [[NSDateFormatter alloc] init];
    self.dateFormatter.dateFormat = @"dd-MM-yyyy";

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
    NSMutableArray *sections = [NSMutableArray array];
    NSMutableArray *rows = [NSMutableArray array];

    NSDate *weatherDate = self.weatherForCity[0].date;
    for (WeatherForecastModel *w in self.weatherForCity) {
        NSComparisonResult result = [self compareTwoDate:weatherDate
                                              secondDate:w.date];
        if (result != NSOrderedSame) {
            Section *s = [[Section alloc] init];
            s.title = [self.dateFormatter stringFromDate:weatherDate];
            s.rows = rows;
            [sections addObject:s];
            weatherDate = w.date;
            [rows removeAllObjects];
        }
        SectionRow *row = [[SectionRow alloc] init];
        row.temperature = w.temerature;
        row.hour = w.hour;
        row.image = w.image;
        [rows addObject:row];
    }
    self.dataForPrint = sections;
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1; //[self.dataForPrint count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeatherByHours* cell = [tableView dequeueReusableCellWithIdentifier:@"CellWeatherByHours"];
    cell.weatherForOneDay = self.dataForPrint[indexPath.section].rows;
    [cell.collectionView reloadData];
    return cell;
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
