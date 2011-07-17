//
//  WeekProgressViewController.h
//  WeekProgress
//
//  Created by szeryf on 11-03-19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeekProgress.h"
#import "OptionsController.h"


@interface WeekProgressViewController : UIViewController <FlipsideViewControllerDelegate> {
	IBOutlet UIImageView *leftImageView;
	IBOutlet UIImageView *middleImageView;
	IBOutlet UIImageView *rightImageView;
	IBOutlet UILabel *percentLabel;
	IBOutlet UILabel *commentLabel;
	WeekProgress *weekProgress;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

- (IBAction) showOptionsPane: (id)sender;

@end

