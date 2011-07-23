//
//  SelectDaysController.m
//  WeekProgress
//
//  Created by szeryf on 11-04-05.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SelectDaysController.h"
#import "Config.h"

@implementation SelectDaysController

@synthesize delegate;

#define TAG_FOR_DAY_SWITCHES 70

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	Config* cfg = [Config instance];
	for (int tag = 0; tag < 7; ++tag) {
		UISwitch* s = (UISwitch *) [[self view] viewWithTag:tag + TAG_FOR_DAY_SWITCHES];
		s.on = [cfg isWorkingDay:tag];
	}
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return interfaceOrientation == UIInterfaceOrientationLandscapeRight || interfaceOrientation == UIInterfaceOrientationLandscapeLeft;
}

- (void)dealloc {
    [super dealloc];
}

- (IBAction) done: (id)sender {
    [self.delegate flipsideViewControllerDidFinish:self];
}

- (IBAction) dayChanged: (id)sender {
	UISwitch *s = (UISwitch *) sender;
	[[Config instance] setWorking:s.on forDay:s.tag - TAG_FOR_DAY_SWITCHES];
	
}


@end
