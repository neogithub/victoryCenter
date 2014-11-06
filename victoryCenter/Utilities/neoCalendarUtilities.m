//
//  neoCalendarUtilities.m
//  quadrangle
//
//  Created by Evan Buxton on 4/1/13.
//  Copyright (c) 2013 neoscape. All rights reserved.
//

#import "neoCalendarUtilities.h"

@implementation NSString (time)

+(NSString*)currentHour
{
	//NSLog(@"neoCalendarUtilities");
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *components = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:[NSDate date]];
	NSInteger hour = [components hour];
	//NSLog(@"hour %i",hour);
	//NSInteger minute = [components minute];
	//NSLog(@"minute %i",minute);
	NSString *neoHour = [NSString stringWithFormat:@"%i",hour];
	return neoHour;
}

/*
Midnight (12:00 AM) -- 0000 hrs
1:00 AM -- 0100 hrs
2:00 AM -- 0200 hrs
3:00 AM -- 0300 hrs
4:00 AM -- 0400 hrs
5:00 AM -- 0500 hrs
6:00 AM -- 0600 hrs
7:00 AM -- 0700 hrs
8:00 AM -- 0800 hrs
9:00 AM -- 0900 hrs
10:00 AM -- 1000 hrs
11:00 AM -- 1100 hrs
12:00 PM -- 1200 hrs
1:00 PM -- 1300 hrs
2:00 PM -- 1400 hrs
3:00 PM -- 1500 hrs
4:00 PM -- 1600 hrs
5:00 PM -- 1700 hrs
6:00 PM -- 1800 hrs
7:00 PM -- 1900 hrs
8:00 PM -- 2000 hrs
9:00 PM -- 2100 hrs
10:00 PM -- 2200 hrs
11:00 PM -- 2300 hrs
*/

@end
