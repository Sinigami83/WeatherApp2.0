//
//  Created by Nodir Latipov on 1/4/19.
//  Copyright © 2019 Home. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WeatherByDay : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *dayNameOfWeekLable;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *maxWeatherLable;
@property (weak, nonatomic) IBOutlet UILabel *minWeatherLable;

@end

NS_ASSUME_NONNULL_END
