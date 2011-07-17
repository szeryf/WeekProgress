//
//  WeekProgressViewController.m
//  WeekProgress
//
//  Created by szeryf on 11-03-19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WeekProgressViewController.h"
#import "macros.h"

@implementation WeekProgressViewController

@synthesize window;


#define MAX_PROGRESS_WIDTH 316
-(void) updateView {
	[weekProgress update];
	float prog = [weekProgress progress];
	CGRect mFrame = middleImageView.frame;
	middleImageView.frame = CGRectMake(leftImageView.frame.origin.x + leftImageView.frame.size.width,
									   mFrame.origin.y,
									   MAX_PROGRESS_WIDTH * prog,
									   mFrame.size.height);
	CGRect rFrame = rightImageView.frame;
	rightImageView.frame = CGRectMake(middleImageView.frame.origin.x + middleImageView.frame.size.width,
									  rFrame.origin.y,
									  rFrame.size.width,
									  rFrame.size.height);
	percentLabel.text = fmt(@"%d%%", (int) (100 * prog));
	if (1.0 == prog) {
		commentLabel.text = @"Congratulations, you're through!";
	}
	else if (0.95 <= prog) {
		commentLabel.text = @"Almost there!";
	}
	else if (0.9 <= prog) {
		commentLabel.text = @"Hold on, you're almost done.";
	}
	else if (0.75 <= prog) {
		commentLabel.text = @"Just a little bit...";
	}
	else if (0.6 <= prog) {
		commentLabel.text = @"You'll make it. Probably.";
	}
	else if (0.45 <= prog) {
		commentLabel.text = @"Eventually, it will be over.";
	}
	else {
		commentLabel.text = @"Aww man, when will it end?";
	}
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

	weekProgress = [[WeekProgress alloc] init];
	[self updateView];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:60
													  target:self
													selector:@selector(updateView)
													userInfo:nil
													 repeats:YES];
    [timer fire];

}



// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[weekProgress dealloc];
    [super dealloc];
}

- (IBAction) showOptionsPane:(id)sender {
	OptionsController *controller = [[OptionsController alloc] initWithNibName:@"OptionsController" bundle:nil];
    controller.delegate = self;

    controller.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentModalViewController:controller animated:YES];

    [controller release];
}

- (void) flipsideViewControllerDidFinish:(UIViewController *)controller {
    [self dismissModalViewControllerAnimated:YES];
	[self updateView];
}

- (WeekProgress*) weekProgress {
	return weekProgress;
}

@end
