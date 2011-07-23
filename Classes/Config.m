//
//  Config.m
//  WeekProgress
//
//  Created by szeryf on 11-04-12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "macros.h"
#import "Config.h"

#define DEFS [NSUserDefaults standardUserDefaults]
#define dayKey(day)       [NSString stringWithFormat:@"workingDay%d", day]
#define startHourKey(day) [NSString stringWithFormat:@"startHour%d", day]
#define endHourKey(day)   [NSString stringWithFormat:@"endHour%d", day]

@implementation Config

- (bool) isWorkingDay: (int)day {
	return [DEFS boolForKey:dayKey(day)];
}

- (void) setWorking: (bool)val forDay: (int)day {
	[DEFS setBool:val forKey:dayKey(day)];
	[DEFS synchronize];
}

- (int) startHourForDay: (int)day {
	int h = [DEFS integerForKey:startHourKey(day)];
	if (UNSET == h && DEFAULT_DAY != day) {
		return [DEFS integerForKey:startHourKey(DEFAULT_DAY)];
	}
	return h;
}

- (void) setStartHour: (int)hour forDay: (int)day {
	[DEFS setInteger:hour forKey:startHourKey(day)];
	if (hour > [self endHourForDay:day]) {
		[DEFS setInteger:hour forKey:endHourKey(day)];
	}
	[DEFS synchronize];
}

- (int) endHourForDay: (int)day {
	int h = [DEFS integerForKey:endHourKey(day)];
	if (UNSET == h && DEFAULT_DAY != day) {
		return [DEFS integerForKey:endHourKey(DEFAULT_DAY)];
	}
	return h;
}

- (void) setEndHour: (int)hour forDay: (int)day {
	[DEFS setInteger:hour forKey:endHourKey(day)];
	if (hour < [self startHourForDay:day]) {
		[DEFS setInteger:hour forKey:startHourKey(day)];
	}
	[DEFS synchronize];
}

- (void) resetHours {
	forAllDays {
		[DEFS setInteger:UNSET forKey:startHourKey(day)];
		[DEFS setInteger:UNSET forKey:endHourKey(day)];
	}
	[DEFS synchronize];
}

#pragma mark Singleton stuff

+ (void)initialize{
    NSMutableDictionary *appDefaults = [NSMutableDictionary dictionaryWithObjectsAndKeys:
										@"YES", dayKey(0),
										@"YES", dayKey(1),
										@"YES", dayKey(2),
										@"YES", dayKey(3),
										@"YES", dayKey(4),
										@"NO",  dayKey(5),
										@"NO",  dayKey(6),
										nil];
	// -1 is for "all days"
	[appDefaults setObject: @"9" forKey:startHourKey(DEFAULT_DAY)];
	[appDefaults setObject:@"17" forKey:endHourKey(DEFAULT_DAY)];
	forAllDays {
		[appDefaults setObject:UNSET_S forKey:startHourKey(day)];
		[appDefaults setObject:UNSET_S forKey:endHourKey(day)];
	}
	//NSLog(@"%@", appDefaults);
    [DEFS registerDefaults:appDefaults];
}

static Config *instance = nil;

+ (Config*) instance {
	if (nil == instance) {
		instance = [[super allocWithZone:NULL] init];
	}
	return instance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [[self instance] retain];
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (id)retain
{
    return self;
}

- (NSUInteger)retainCount
{
    return NSUIntegerMax;  //denotes an object that cannot be released
}

- (void)release
{
    //do nothing
}

- (id)autorelease
{
    return self;
}

@end
