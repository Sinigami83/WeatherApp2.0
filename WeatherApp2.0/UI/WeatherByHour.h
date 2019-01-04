//
//  Created by Nodir Latipov on 1/4/19.
//  Copyright © 2019 Home. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WeatherByHour : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *hourLable;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *tempertatureLable;

@end

NS_ASSUME_NONNULL_END
