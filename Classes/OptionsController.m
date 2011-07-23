//
//  OptionsController.m
//  WeekProgress
//
//  Created by szeryf on 11-03-29.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OptionsController.h"


@implementation OptionsController

@synthesize delegate;

-(void) updateSummary {
	summary.text = [[self weekProgress] summary];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[self updateSummary];
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return interfaceOrientation == UIInterfaceOrientationLandscapeRight || interfaceOrientation == UIInterfaceOrientationLandscapeLeft;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

- (IBAction) done: (id)sender {
    [self.delegate flipsideViewControllerDidFinish:self];
}

- (IBAction) showSelectDays: (id)sender {
	SelectDaysController *controller = [[SelectDaysController alloc] initWithNibName:@"SelectDaysController" bundle:nil];
    controller.delegate = self;
    
    controller.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentModalViewController:controller animated:YES];
    
    [controller release];
}

- (IBAction) showChangeHours: (id)sender {
	ChangeHoursController *controller = [[ChangeHoursController alloc] initWithNibName:@"ChangeHoursController" bundle:nil];
    controller.delegate = self;
    
    controller.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentModalViewController:controller animated:YES];
    
    [controller release];
}

- (void) flipsideViewControllerDidFinish:(UIViewController *)controller {
    [self dismissModalViewControllerAnimated:YES];
	[self updateSummary];
}

- (WeekProgress*) weekProgress {
	return [self.delegate weekProgress];
}

@end

