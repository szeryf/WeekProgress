//
//  WeekProgress.h
//  WeekProgress
//
//  Created by szeryf on 11-03-19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WeekProgress : NSObject {
	@private
	double progress;
}

-(WeekProgress*) initWithDate:(NSDate*) date;
-(void) update;
-(void) updateWithDate:(NSDate*) date;

-(double)    progress;
-(NSString*) summary;

@end

extern NSString* weekDayNames[];

