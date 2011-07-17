//
//  ChangeHoursController.h
//  WeekProgress
//
//  Created by szeryf on 11-04-05.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlipsideViewControllerDelegate.h"


@interface ChangeHoursController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
	id <FlipsideViewControllerDelegate> delegate;
	IBOutlet UIPickerView *pickerView;
	NSMutableArray *days;
	NSMutableArray *hours;
}

- (IBAction) done: (id)sender;
- (IBAction) resetHours: (id)sender;

@property (nonatomic, assign) id <FlipsideViewControllerDelegate> delegate;

@end