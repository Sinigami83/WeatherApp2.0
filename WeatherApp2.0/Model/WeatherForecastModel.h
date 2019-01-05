//
//  Created by Nodir Latipov on 12/25/18.
//  Copyright © 2018 Home. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WeatherForecastModel : NSObject

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, assign) double temerature;
@property (nonatomic, assign) NSUInteger hour;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSNumber *pressure; //main.pressure - Атмосферное давление на уровне моря по умолчанию, гПа
@property (nonatomic, strong) NSNumber *seaLevel; //main.sea_level - Атмосферное давление на уровне моря, гПа
@property (nonatomic, strong) NSNumber *grndLevel; //main.grnd_level - Атмосферное давление на уровне земли, гПа
@property (nonatomic, strong) NSNumber *humidity; //main.humidity - Влажность,%
@property (nonatomic, strong) NSString *weatherType; //weather.main - Группа параметров погоды (Дождь, Снег, Экстрим и т.д.
@property (nonatomic, strong) NSString *weatherDescription; //weather.description -  Погодные условия в группе
@property (nonatomic, strong) NSNumber *clouds; //clouds.all - Облачность,%
@property (nonatomic, strong) NSNumber *windSpeed; //wind.speedСкорость ветра. Единица измерения по умолчанию: метр / сек, метрика: метр / сек, империал: миль / час
@property (nonatomic, strong) NSNumber *windDeg; //wind.deg Направление ветра, градусы (метеорологические)
@property (nonatomic, strong) NSNumber *snow3h; //snow.3h Объем снега за последние 3 часа

- (instancetype)initWithServerResponse:(NSDictionary *)responseObject;

@end
