//
//  ChangeHoursController.m
//  WeekProgress
//
//  Created by szeryf on 11-04-05.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ChangeHoursController.h"
#import "WeekProgress.h"
#import "Config.h"
#import "macros.h"

@implementation ChangeHoursController

@synthesize delegate;

- (void) setHoursForDay:(int) day {
	Config* cfg = [Config instance];
	[pickerView selectRow:[cfg startHourForDay:day] inComponent:1 animated:YES];
	[pickerView selectRow:[cfg endHourForDay:day]   inComponent:2 animated:YES];
}

static NSMutableArray *daysInRows;

- (void)viewDidLoad {
    [super viewDidLoad];
	Config* cfg = [Config instance];
	days = [[NSMutableArray alloc] init];
	daysInRows = [[NSMutableArray alloc] init];
	[days addObject:@"default hours"];
	[daysInRows addObject:[NSNumber numberWithInt:DEFAULT_DAY]];
	forAllDays {
		if ([cfg isWorkingDay:day]) {
			[days addObject:fmt(@"on %@s", weekDayNames[day])];
			[daysInRows addObject:[NSNumber numberWithInt:day]];
		}
	}
	hours = [[NSMutableArray alloc] init];
	for (int h = 0; h < 24; ++h) {
		[hours addObject:fmt(@"%d:00", h)];
	}
    [self setHoursForDay:DEFAULT_DAY];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
	[days dealloc];
	[hours dealloc];
}

- (void)dealloc {
    [super dealloc];
}

- (IBAction) done: (id)sender {
    [self.delegate flipsideViewControllerDidFinish:self];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

#define IS_DAY_SELECTED (component == 0)

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	NSInteger num = IS_DAY_SELECTED ? [days count] : [hours count];
    return num;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	NSString *str = IS_DAY_SELECTED ? [days objectAtIndex:row] : [hours objectAtIndex:row];
	return str;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
	return IS_DAY_SELECTED ? 240 : 90;
}

- (int)selectedDay {
	int selDay = [pickerView selectedRowInComponent:0];
	selDay = [[daysInRows objectAtIndex:selDay] intValue];
	return selDay;
}

- (void)pickerView:(UIPickerView *)pv didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	//NSLog(@"selected %d %d", row, component);
	if (IS_DAY_SELECTED) {
		[self setHoursForDay:[[daysInRows objectAtIndex:row] intValue]];
	}
	else {
		Config* cfg = [Config instance];
		int selDay = [self selectedDay];
		if (1 == component)
			[cfg setStartHour:row forDay:selDay];
		else
			[cfg setEndHour:row forDay:selDay];
		[self setHoursForDay:selDay]; // changing start hour may change end hour and vice versa
	}
}

- (IBAction) resetHours: (id)sender {
	[[Config instance] resetHours];
	[self setHoursForDay:[self selectedDay]];
}


@end
