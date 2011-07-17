//
//  FlipsideViewControllerDelegate.h
//  WeekProgress
//
//  Created by szeryf on 11-04-05.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeekProgress.h"

@protocol FlipsideViewControllerDelegate

- (void) flipsideViewControllerDidFinish: (UIViewController*) controller;
- (WeekProgress*) weekProgress;

@end

