//
//  SelectDaysController.h
//  WeekProgress
//
//  Created by szeryf on 11-04-05.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlipsideViewControllerDelegate.h"


@interface SelectDaysController : UIViewController {
	id <FlipsideViewControllerDelegate> delegate;
}

@property (nonatomic, assign) id <FlipsideViewControllerDelegate> delegate;

- (IBAction) done: (id)sender;
- (IBAction) dayChanged: (id)sender;

@end
