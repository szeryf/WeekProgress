//
//  Config.h
//  WeekProgress
//
//  Created by szeryf on 11-04-12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define UNSET -1
#define UNSET_S @"-1"
#define DEFAULT_DAY -1

@interface Config : NSObject {

}

+ (Config*) instance;

- (bool) isWorkingDay:    (int)day;
- (void) setWorking:      (bool)val forDay: (int)day;
- (int)  startHourForDay: (int)day;
- (void) setStartHour:    (int)hour forDay: (int)day;
- (int)  endHourForDay:   (int)day;
- (void) setEndHour:      (int)hour forDay: (int)day;

- (void) resetHours;

@end
