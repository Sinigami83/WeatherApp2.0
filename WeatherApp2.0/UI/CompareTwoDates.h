//
//  Created by Nodir Latipov on 1/4/19.
//  Copyright © 2019 Home. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CompareTwoDates : NSObject

@property (nonatomic, strong) NSDate *firstDate;

- (NSComparisonResult)compareDate:(NSDate *)secondDate;

@end

NS_ASSUME_NONNULL_END
