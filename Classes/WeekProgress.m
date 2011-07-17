//
//  WeekProgress.m
//  WeekProgress
//
//  Created by szeryf on 11-03-19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "macros.h"
#import "WeekProgress.h"
#import "Config.h"

#define MINUTE_FRAC (1.0 / 60.0)

NSDateComponents *getDateComponents(NSDate *date) {
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *comps = [gregorian components:(NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:date];
	[gregorian release];
	return comps;
}

/**
 * converts from: 1 - Sunday, 2 - Monday, ... 7 - Saturday
 *            to: Monday -> 0, ... Sat -> 5, Sun -> 6
 **/
int convertWeekDay(int weekday) {
	return (weekday + 5) % 7;
}

@implementation WeekProgress

-(void) updateWithDate:(NSDate*) date {
	NSDateComponents *comps = getDateComponents(date);
	int weekday = convertWeekDay([comps weekday]);
	Config* cfg = [Config instance];
	double workingTime = 0, passedTime = 0.0;
	forAllDays {
		if ([cfg isWorkingDay:day]) {
			int endHour = [cfg endHourForDay:day];
			int startHour = [cfg startHourForDay:day];
			int workDayHours = endHour - startHour;
			workingTime += workDayHours;
			if (day < weekday) {
				passedTime += workDayHours;
			}
			else if (day == weekday) {
				int hour = [comps hour];
				if (hour >= endHour) {
					passedTime += workDayHours;
				}
				else if (hour >= startHour) {
					passedTime += (hour - startHour) + [comps minute] * MINUTE_FRAC;
				}
			}
		}
	}
	progress = workingTime > 0 ? passedTime / workingTime : 0;
}

-(void) update {
	[self updateWithDate:[NSDate date]];
}

-(WeekProgress*) initWithDate:(NSDate*) date_ {
	self = [super init];
    if (self) [self updateWithDate:date_];
	return self;
}

-(WeekProgress*) init {
	return [self initWithDate:[NSDate date]];
}

-(double) progress {
	return progress;
}

- (void)dealloc {
    [super dealloc];
}

NSString* weekDayNames[] = {@"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday", @"Saturday", @"Sunday"};

void appendSeparator(NSMutableString* ranges, int i, int max) {
	if (i > 0) {
		if (max > 2) appFmt(ranges, @",");
		if (i + 1 == max) appFmt(ranges, @" and");
		appFmt(ranges, @" ");
	}
}

NSMutableString* prepareDaysSummary(int rangeCount, int *mins, int *maxs) {
	NSMutableString* ranges = [NSMutableString stringWithFormat:@"I work "];
	bool hasOn = NO;
	for (int i = 0; i < rangeCount; ++i) {
		appendSeparator(ranges, i, rangeCount);
		if (mins[i] < maxs[i]) {
			appFmt(ranges, @"from %@ to %@", weekDayNames[mins[i]], weekDayNames[maxs[i]]);
			hasOn = NO;
		}
		else {
			appFmt(ranges, (hasOn ? @"%@" : @"on %@"), weekDayNames[mins[i]]);
			hasOn = YES;
		}
	}
	return ranges;
}

NSMutableString* appendHoursSummary(NSMutableString* summary) {
	Config* cfg = [Config instance];
	int s = [cfg startHourForDay:-1];
	int e = [cfg endHourForDay:-1];
	bool equal = YES;
	forAllDays
		if ([cfg isWorkingDay:day] && (s != [cfg startHourForDay:day] || e != [cfg endHourForDay:day])) {
			equal = NO;
			break;
		}
	appFmt(summary, equal ? @" from %d:00 to %d:00" : @" on varying hours", s, e);
	return summary;
}

- (NSString*) summary {
	int mins[7], maxs[7], rangeCount = 0;
	bool inRange = NO;
	Config* cfg = [Config instance];
	forAllDays {
		if ([cfg isWorkingDay:day]) {
			if (!inRange) {
				mins[rangeCount] = day;
				inRange = YES;
			}
			maxs[rangeCount] = day;
		}
		else if (inRange) {
			++rangeCount;
			inRange = NO;
		}
	}
	if (rangeCount += inRange)
		return appendHoursSummary(prepareDaysSummary(rangeCount, mins, maxs));
	else
		return @"I don't work at all";
}

@end

