//
//  WeekProgressAppDelegate.h
//  WeekProgress
//
//  Created by szeryf on 11-03-19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WeekProgressViewController;

@interface WeekProgressAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    WeekProgressViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet WeekProgressViewController *viewController;

@end

