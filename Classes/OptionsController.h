//
//  OptionsController.h
//  WeekProgress
//
//  Created by szeryf on 11-03-29.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlipsideViewControllerDelegate.h"
#import "ChangeHoursController.h"
#import "SelectDaysController.h"

@interface OptionsController : UIViewController <FlipsideViewControllerDelegate> {
	id <FlipsideViewControllerDelegate> delegate;

	IBOutlet UILabel *summary;
}

- (IBAction) done: (id)sender;
- (IBAction) showSelectDays: (id)sender;
- (IBAction) showChangeHours: (id)sender;

@property (nonatomic, assign) id <FlipsideViewControllerDelegate> delegate;

@end


