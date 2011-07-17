//
//  WeekProgressTest.m
//  WeekProgress
//
//  Created by szeryf on 11-03-20.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WeekProgressTestCase.h"
#import "WeekProgress.h"
#import "Config.h"

static const bool stdWorkingDays[] = {YES, YES, YES, YES, YES, NO, NO};
static const bool noWorkingDays[] = {NO, NO, NO, NO, NO, NO, NO};
static const bool allWorkingDays[] = {YES, YES, YES, YES, YES, YES, YES};
static const bool* workingDays;

@implementation Config
-(bool) isWorkingDay:(int)day {
	return workingDays[day];
}

static Config *instance = nil;
static const int defaultStartHours[8] = { 9,  9,  9,  9,  9,  9,  9,  9}; // first is -1 for all
static const int defaultEndHours[8]   = {17, 17, 17, 17, 17, 17, 17, 17}; // first is -1 for all

int* startHours;
int* endHours;

- (Config*) init {
	startHours = malloc(sizeof(int) * 8);
	memcpy(startHours, defaultStartHours, sizeof(int) * 8);
	endHours = malloc(sizeof(int) * 8);
	memcpy(endHours, defaultEndHours, sizeof(int) * 8);
	return self;
}

+ (Config*) instance {
	if (nil == instance) {
		instance = [[super allocWithZone:NULL] init];
	}
	return instance;
}

- (void) setWorking: (bool)val forDay: (int)day {}

- (int) startHourForDay: (int)day { return startHours[day + 1]; } // allow -1
- (int) endHourForDay:   (int)day { return endHours[day + 1]; } // allow -1

- (void) setStartHour: (int)hour forDay: (int)day { startHours[day + 1] = hour; } // allow -1
- (void) setEndHour:   (int)hour forDay: (int)day { endHours[day + 1]   = hour; } // allow -1

- (void) resetHours {}

@end

@implementation WeekProgressTestCase

- (void) setUp {
	[[Config instance] init]; // cleanup for other tests
}

NSDate* dateFromString(NSString* str) {
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"yyyyMMdd HH:mm"];
	NSDate* date = [dateFormatter dateFromString:str];
	[dateFormatter release];
	return date;
}

-(void) assertProgress:(double) expected of:(WeekProgress*) wp withDate:(NSString*) date {
	double actual = [wp progress];
	STAssertEqualsWithAccuracy(expected, actual, 1e-6, @"progress for date %@ expected %.7f was %.7f", date, expected, actual);
}

#define F(x) [NSNumber numberWithFloat: x]

NSDictionary *getFixtures() {
	return [NSDictionary dictionaryWithObjectsAndKeys:
			F(1.0),      /* Sun */ @"20110320 13:00",
			F(1.0),      /* Sat */ @"20110319 13:00",
			F(0.0),      /* Mon */ @"20110321 08:00",
			F(0.0),      /* Mon */ @"20110321 09:00",
			F(0.000417), /* Mon */ @"20110321 09:01",
			F(0.000833), /* Mon */ @"20110321 09:02",
			F(0.002083), /* Mon */ @"20110321 09:05",
			F(0.004167), /* Mon */ @"20110321 09:10",
			F(0.008333), /* Mon */ @"20110321 09:20",
			F(0.016667), /* Mon */ @"20110321 09:40",
			F(0.025),    /* Mon */ @"20110321 10:00",
			F(0.025417), /* Mon */ @"20110321 10:01",
			F(0.1),      /* Mon */ @"20110321 13:00",
			F(0.100417), /* Mon */ @"20110321 13:01",
			F(0.100833), /* Mon */ @"20110321 13:02",
			F(0.102083), /* Mon */ @"20110321 13:05",
			F(0.104167), /* Mon */ @"20110321 13:10",
			F(0.108333), /* Mon */ @"20110321 13:20",
			F(0.116667), /* Mon */ @"20110321 13:40",
			F(0.191667), /* Mon */ @"20110321 16:40",
			F(0.195833), /* Mon */ @"20110321 16:50",
			F(0.197917), /* Mon */ @"20110321 16:55",
			F(0.199583), /* Mon */ @"20110321 16:59",
			F(0.2),      /* Mon */ @"20110321 17:00",
			F(0.2),      /* Mon */ @"20110321 18:00",
			F(0.2),      /* Tue */ @"20110322 08:00",
			F(0.2),      /* Tue */ @"20110322 09:00",
			F(0.200417), /* Tue */ @"20110322 09:01",
			F(0.200833), /* Tue */ @"20110322 09:02",
			F(0.202083), /* Tue */ @"20110322 09:05",
			F(0.204167), /* Tue */ @"20110322 09:10",
			F(0.208333), /* Tue */ @"20110322 09:20",
			F(0.216667), /* Tue */ @"20110322 09:40",
			F(0.225),    /* Tue */ @"20110322 10:00",
			F(0.225417), /* Tue */ @"20110322 10:01",
			F(0.3),      /* Tue */ @"20110322 13:00",
			F(0.300417), /* Tue */ @"20110322 13:01",
			F(0.300833), /* Tue */ @"20110322 13:02",
			F(0.302083), /* Tue */ @"20110322 13:05",
			F(0.304167), /* Tue */ @"20110322 13:10",
			F(0.308333), /* Tue */ @"20110322 13:20",
			F(0.316667), /* Tue */ @"20110322 13:40",
			F(0.391667), /* Tue */ @"20110322 16:40",
			F(0.395833), /* Tue */ @"20110322 16:50",
			F(0.397917), /* Tue */ @"20110322 16:55",
			F(0.399583), /* Tue */ @"20110322 16:59",
			F(0.4),      /* Tue */ @"20110322 17:00",
			F(0.4),      /* Tue */ @"20110322 18:00",
			F(0.4),      /* Wed */ @"20110323 08:00",
			F(0.4),      /* Wed */ @"20110323 09:00",
			F(0.400417), /* Wed */ @"20110323 09:01",
			F(0.400833), /* Wed */ @"20110323 09:02",
			F(0.402083), /* Wed */ @"20110323 09:05",
			F(0.404167), /* Wed */ @"20110323 09:10",
			F(0.408333), /* Wed */ @"20110323 09:20",
			F(0.416667), /* Wed */ @"20110323 09:40",
			F(0.425),    /* Wed */ @"20110323 10:00",
			F(0.425417), /* Wed */ @"20110323 10:01",
			F(0.5),      /* Wed */ @"20110323 13:00",
			F(0.500417), /* Wed */ @"20110323 13:01",
			F(0.500833), /* Wed */ @"20110323 13:02",
			F(0.502083), /* Wed */ @"20110323 13:05",
			F(0.504167), /* Wed */ @"20110323 13:10",
			F(0.508333), /* Wed */ @"20110323 13:20",
			F(0.516667), /* Wed */ @"20110323 13:40",
			F(0.591667), /* Wed */ @"20110323 16:40",
			F(0.595833), /* Wed */ @"20110323 16:50",
			F(0.597917), /* Wed */ @"20110323 16:55",
			F(0.599583), /* Wed */ @"20110323 16:59",
			F(0.6),      /* Wed */ @"20110323 17:00",
			F(0.6),      /* Wed */ @"20110323 18:00",
			F(0.6),      /* Thu */ @"20110324 08:00",
			F(0.6),      /* Thu */ @"20110324 09:00",
			F(0.600417), /* Thu */ @"20110324 09:01",
			F(0.600833), /* Thu */ @"20110324 09:02",
			F(0.602083), /* Thu */ @"20110324 09:05",
			F(0.604167), /* Thu */ @"20110324 09:10",
			F(0.608333), /* Thu */ @"20110324 09:20",
			F(0.616667), /* Thu */ @"20110324 09:40",
			F(0.625),    /* Thu */ @"20110324 10:00",
			F(0.625417), /* Thu */ @"20110324 10:01",
			F(0.7),      /* Thu */ @"20110324 13:00",
			F(0.700417), /* Thu */ @"20110324 13:01",
			F(0.700833), /* Thu */ @"20110324 13:02",
			F(0.702083), /* Thu */ @"20110324 13:05",
			F(0.704167), /* Thu */ @"20110324 13:10",
			F(0.708333), /* Thu */ @"20110324 13:20",
			F(0.716667), /* Thu */ @"20110324 13:40",
			F(0.791667), /* Thu */ @"20110324 16:40",
			F(0.795833), /* Thu */ @"20110324 16:50",
			F(0.797917), /* Thu */ @"20110324 16:55",
			F(0.799583), /* Thu */ @"20110324 16:59",
			F(0.8),      /* Thu */ @"20110324 17:00",
			F(0.8),      /* Thu */ @"20110324 18:00",
			F(0.8),      /* Fri */ @"20110325 08:00",
			F(0.8),      /* Fri */ @"20110325 09:00",
			F(0.800417), /* Fri */ @"20110325 09:01",
			F(0.800833), /* Fri */ @"20110325 09:02",
			F(0.802083), /* Fri */ @"20110325 09:05",
			F(0.804167), /* Fri */ @"20110325 09:10",
			F(0.808333), /* Fri */ @"20110325 09:20",
			F(0.816667), /* Fri */ @"20110325 09:40",
			F(0.825),    /* Fri */ @"20110325 10:00",
			F(0.825417), /* Fri */ @"20110325 10:01",
			F(0.9),      /* Fri */ @"20110325 13:00",
			F(0.900417), /* Fri */ @"20110325 13:01",
			F(0.900833), /* Fri */ @"20110325 13:02",
			F(0.902083), /* Fri */ @"20110325 13:05",
			F(0.904167), /* Fri */ @"20110325 13:10",
			F(0.908333), /* Fri */ @"20110325 13:20",
			F(0.916667), /* Fri */ @"20110325 13:40",
			F(0.991667), /* Fri */ @"20110325 16:40",
			F(0.995833), /* Fri */ @"20110325 16:50",
			F(0.997917), /* Fri */ @"20110325 16:55",
			F(0.999583), /* Fri */ @"20110325 16:59",
			F(1.0),      /* Fri */ @"20110325 17:00",
			F(1.0),      /* Fri */ @"20110325 18:00",
			nil];

}

-(void) testInitWithDate {
	workingDays = stdWorkingDays;
	NSDictionary *fixtures = getFixtures();
	for (NSString* date in fixtures) {
		NSNumber* expected = [fixtures objectForKey:date];
		WeekProgress *wp = [[WeekProgress alloc] initWithDate:dateFromString(date)];
		[self assertProgress:[expected doubleValue] of:wp withDate:date];
		[wp release];
	}
}

-(void) testUpdateWithDate {
	workingDays = stdWorkingDays;
	NSDictionary *fixtures = getFixtures();
	WeekProgress *wp = [[WeekProgress alloc] init];
	for (NSString* date in fixtures) {
		NSNumber* expected = [fixtures objectForKey:date];
		[wp updateWithDate:dateFromString(date)];
		[self assertProgress:[expected doubleValue] of:wp withDate:date];
	}
	[wp release];
}

-(void) testInitWithDateAndNoDays {
	workingDays = noWorkingDays;
	NSDictionary *fixtures = getFixtures();
	for (NSString* date in fixtures) {
		WeekProgress *wp = [[WeekProgress alloc] initWithDate:dateFromString(date)];
		[self assertProgress:0.0 of:wp withDate:date];
		[wp release];
	}
}

-(void) testInitWithDateAndAllDays {
	workingDays = allWorkingDays;
	NSDictionary *fixtures = getFixtures();
	for (NSString* date in fixtures) {
		NSNumber* expected = [fixtures objectForKey:date];
		WeekProgress *wp = [[WeekProgress alloc] initWithDate:dateFromString(date)];
		double exp = [expected doubleValue] * 5.0 / 7.0;
		if (@"20110320 13:00" == date) {
			exp = 0.9285714;
		}
		if (@"20110319 13:00" == date) {
			exp = 0.7857143;
		}
		[self assertProgress:exp of:wp withDate:date];
		[wp release];
	}
}

#define testSummary(var, expected)                    \
	-(void) testSummary_##var {                        \
		workingDays = var##WorkingDays;                 \
		WeekProgress *wp = [[WeekProgress alloc] init];  \
		STAssertEqualObjects(expected, [wp summary], nil);\
		[wp release]; 	                                   \
	}

testSummary(std, @"I work from Monday to Friday from 9:00 to 17:00");
testSummary(all, @"I work from Monday to Sunday from 9:00 to 17:00");
testSummary(no,  @"I don't work at all");

static const bool twoRangesWorkingDays[] = {YES, YES, YES, NO, YES, YES, NO};
testSummary(twoRanges, @"I work from Monday to Wednesday and from Friday to Saturday from 9:00 to 17:00");

static const bool threeRangesWorkingDays[] = {YES, YES, NO, YES, YES, NO, YES};
testSummary(threeRanges, @"I work from Monday to Tuesday, from Thursday to Friday, and on Sunday from 9:00 to 17:00");

static const bool singleWorkingDays[] = {YES, NO, YES, NO, YES, NO, YES};
testSummary(single, @"I work on Monday, Wednesday, Friday, and Sunday from 9:00 to 17:00");

static const bool rangeAndSingleWorkingDays[] = {YES, NO, YES, YES, YES, NO, YES};
testSummary(rangeAndSingle, @"I work on Monday, from Wednesday to Friday, and on Sunday from 9:00 to 17:00");

static const bool twoWorkingDays[] = {NO, YES, NO, NO, YES, NO, NO};
testSummary(two, @"I work on Tuesday and Friday from 9:00 to 17:00");

-(void) testSummary_withVaryingHours {
	workingDays = allWorkingDays;
	[[Config instance] setStartHour:8 forDay: 1];
	WeekProgress *wp = [[WeekProgress alloc] init];
	STAssertEqualObjects(@"I work from Monday to Sunday on varying hours", [wp summary], nil);
	[wp release];
}

static const bool oneWorkingDay[] = {YES, NO, NO, NO, NO, NO, NO};
-(void) testSummary_withOneWorkingDay {
	workingDays = oneWorkingDay;
	[[Config instance] setStartHour:8 forDay: 0];
	[[Config instance] setStartHour:8 forDay: -1];
	WeekProgress *wp = [[WeekProgress alloc] init];
	STAssertEqualObjects(@"I work on Monday from 8:00 to 17:00", [wp summary], nil);
	[wp release];
}

#define assertProgressWithDate(exp, date) \
	[wp updateWithDate:dateFromString(date)]; \
	[self assertProgress:exp of:wp withDate:date];

- (void)testProgress_withOneDay8to16 {
	workingDays = oneWorkingDay;
	[[Config instance] setStartHour:8 forDay: 0];
	[[Config instance] setEndHour:16 forDay: 0];
	WeekProgress *wp = [[WeekProgress alloc] init];
	assertProgressWithDate(0.0,       @"20110321 08:00");
	assertProgressWithDate(0.125,     @"20110321 09:00");
	assertProgressWithDate(0.3125,    @"20110321 10:30");
	assertProgressWithDate(0.3145833, @"20110321 10:31");
	assertProgressWithDate(0.875,     @"20110321 15:00");
	assertProgressWithDate(1.0,       @"20110321 16:00");
	[wp release];
}

- (void)testProgress_withOneDay0to23 {
	workingDays = oneWorkingDay;
	[[Config instance] setStartHour:0 forDay: 0];
	[[Config instance] setEndHour:23 forDay: 0];
	WeekProgress *wp = [[WeekProgress alloc] init];
	assertProgressWithDate( 8.0/23.0, @"20110321 08:00");
	assertProgressWithDate( 9.0/23.0, @"20110321 09:00");
	assertProgressWithDate(10.5/23.0, @"20110321 10:30");
	assertProgressWithDate(15.0/23.0, @"20110321 15:00");
	assertProgressWithDate(16.0/23.0, @"20110321 16:00");

	assertProgressWithDate(0.0,       @"20110321 00:00");
	assertProgressWithDate(0.0007246, @"20110321 00:01");
	assertProgressWithDate(0.4572464, @"20110321 10:31");
	assertProgressWithDate(0.9992754, @"20110321 22:59");
	assertProgressWithDate(1.0,       @"20110321 23:00");
	[wp release];
}

- (void)testProgress_withTwoDaysVariousHours {
	workingDays = twoWorkingDays;
	[[Config instance] setStartHour:6 forDay: 1];
	[[Config instance] setEndHour:14 forDay: 1];
	[[Config instance] setStartHour:10 forDay: 4];
	[[Config instance] setEndHour:20 forDay: 4];
	WeekProgress *wp = [[WeekProgress alloc] init];
	assertProgressWithDate(2.0/18.0,  @"20110322 08:00");
	assertProgressWithDate(3.0/18.0,  @"20110322 09:00");
	assertProgressWithDate(4.5/18.0,  @"20110322 10:30");
	assertProgressWithDate(0.2509259, @"20110322 10:31");
	assertProgressWithDate(8.0/18.0,  @"20110322 15:00");
	assertProgressWithDate(9.0/18.0,  @"20110325 11:00");
	assertProgressWithDate(1.0 - 1/18.0/60.0, @"20110325 19:59");
	assertProgressWithDate(1.0,       @"20110325 20:00");
	[wp release];
}


@end
