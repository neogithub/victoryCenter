//
//  embBezierPathItems.m
//  embAnimatedPath
//
//  Created by Evan Buxton on 2/19/14.
//  Copyright (c) 2014 neoscape. All rights reserved.
//

#import "embBezierPaths.h"
@implementation embBezierPaths

- (id) init
{
    if (self = [super init]) {
		
		// setup
		_bezierPaths = [[NSMutableArray alloc] init];
//		UIBezierPath *reversePath;
//
//		UIColor *pathRed = [UIColor colorWithRed:235.0f/255.0f
//										   green:199.0f/255.0f
//											blue:113.0f/255.0f
//										   alpha:1.0];
//		
		
		
		UIColor *pathBlue = [UIColor colorWithRed:235/255.0f
											green:199.0f/255.0f
											 blue:113.0f/255.0f
											alpha:1.0];
		
		CGFloat pathWidth = 7.0;
		CGFloat pathSpeed = 3.5;
		

		// Bezier paths created in paintcode
		// COPY FROM PAINTCODE

		//// Color Declarations
		
        //// North_Toll_1 Drawing
        UIBezierPath* north_Toll_1Path = UIBezierPath.bezierPath;
        [north_Toll_1Path moveToPoint: CGPointMake(0, 0)];
        [north_Toll_1Path addCurveToPoint: CGPointMake(188, 49) controlPoint1: CGPointMake(13, 9) controlPoint2: CGPointMake(158, 27)];
        [north_Toll_1Path addCurveToPoint: CGPointMake(296, 245) controlPoint1: CGPointMake(218, 71) controlPoint2: CGPointMake(295, 215)];
        [north_Toll_1Path addCurveToPoint: CGPointMake(254, 533) controlPoint1: CGPointMake(297, 275) controlPoint2: CGPointMake(236, 531)];
        [north_Toll_1Path addCurveToPoint: CGPointMake(708, 533) controlPoint1: CGPointMake(272, 535) controlPoint2: CGPointMake(702, 527)];
        [north_Toll_1Path addCurveToPoint: CGPointMake(712, 581) controlPoint1: CGPointMake(714, 539) controlPoint2: CGPointMake(712, 581)];
        north_Toll_1Path.lineCapStyle = kCGLineCapRound;
        
        //// Woodall_Rodgers_1 Drawing
        UIBezierPath* woodall_Rodgers_1Path = UIBezierPath.bezierPath;
        [woodall_Rodgers_1Path moveToPoint: CGPointMake(866, 1)];
        [woodall_Rodgers_1Path addCurveToPoint: CGPointMake(975, 194) controlPoint1: CGPointMake(866, 1) controlPoint2: CGPointMake(984.5, 181.5)];
        [woodall_Rodgers_1Path addCurveToPoint: CGPointMake(756, 318) controlPoint1: CGPointMake(965.5, 206.5) controlPoint2: CGPointMake(759, 313)];
        [woodall_Rodgers_1Path addCurveToPoint: CGPointMake(720, 459) controlPoint1: CGPointMake(753, 323) controlPoint2: CGPointMake(732, 399)];
        [woodall_Rodgers_1Path addCurveToPoint: CGPointMake(712, 584) controlPoint1: CGPointMake(707.21, 522.96) controlPoint2: CGPointMake(712, 584)];
        woodall_Rodgers_1Path.lineCapStyle = kCGLineCapRound;
        
        //// I35_2 Drawing
        UIBezierPath* i35_2Path = UIBezierPath.bezierPath;
        [i35_2Path moveToPoint: CGPointMake(0, 534.5)];
        [i35_2Path addCurveToPoint: CGPointMake(705, 535) controlPoint1: CGPointMake(525, 535.5) controlPoint2: CGPointMake(699, 524)];
        [i35_2Path addCurveToPoint: CGPointMake(712, 584) controlPoint1: CGPointMake(711, 546) controlPoint2: CGPointMake(712, 584)];
        i35_2Path.lineCapStyle = kCGLineCapRound;
        
        //// I35_3 Drawing
        UIBezierPath* i35_3Path = UIBezierPath.bezierPath;
        [i35_3Path moveToPoint: CGPointMake(963, 768)];
        [i35_3Path addCurveToPoint: CGPointMake(881, 671) controlPoint1: CGPointMake(963, 768) controlPoint2: CGPointMake(887, 714)];
        [i35_3Path addCurveToPoint: CGPointMake(894, 396) controlPoint1: CGPointMake(857, 499) controlPoint2: CGPointMake(906, 409)];
        [i35_3Path addCurveToPoint: CGPointMake(750, 337) controlPoint1: CGPointMake(882, 383) controlPoint2: CGPointMake(760, 326)];
        [i35_3Path addCurveToPoint: CGPointMake(720, 459) controlPoint1: CGPointMake(745.1, 342.39) controlPoint2: CGPointMake(728.13, 400.51)];
        [i35_3Path addCurveToPoint: CGPointMake(712, 581) controlPoint1: CGPointMake(711.54, 519.83) controlPoint2: CGPointMake(712, 581)];
        i35_3Path.lineCapStyle = kCGLineCapRound;
		
        //// Site_to_airport Drawing
        UIBezierPath* site_to_airportPath = UIBezierPath.bezierPath;
        [site_to_airportPath moveToPoint: CGPointMake(712, 581)];
        [site_to_airportPath addCurveToPoint: CGPointMake(720, 459) controlPoint1: CGPointMake(712, 581) controlPoint2: CGPointMake(711.54, 519.83)];
        [site_to_airportPath addCurveToPoint: CGPointMake(750, 337) controlPoint1: CGPointMake(728.14, 400.51) controlPoint2: CGPointMake(745.1, 342.39)];
        [site_to_airportPath addCurveToPoint: CGPointMake(894, 396) controlPoint1: CGPointMake(760, 326) controlPoint2: CGPointMake(882, 383)];
        [site_to_airportPath addCurveToPoint: CGPointMake(881, 671) controlPoint1: CGPointMake(906, 409) controlPoint2: CGPointMake(857, 499)];
        [site_to_airportPath addCurveToPoint: CGPointMake(963, 768) controlPoint1: CGPointMake(887, 714) controlPoint2: CGPointMake(963, 768)];
        site_to_airportPath.lineCapStyle = kCGLineCapRound;
        
        
        //// Site_to_loveField Drawing
        UIBezierPath* site_to_loveFieldPath = UIBezierPath.bezierPath;
        [site_to_loveFieldPath moveToPoint: CGPointMake(712, 581)];
        [site_to_loveFieldPath addCurveToPoint: CGPointMake(720, 459) controlPoint1: CGPointMake(712, 581) controlPoint2: CGPointMake(711.54, 519.83)];
        [site_to_loveFieldPath addCurveToPoint: CGPointMake(750, 337) controlPoint1: CGPointMake(728.14, 400.51) controlPoint2: CGPointMake(745.1, 342.39)];
        [site_to_loveFieldPath addCurveToPoint: CGPointMake(558, 273) controlPoint1: CGPointMake(754.49, 332.06) controlPoint2: CGPointMake(661.92, 297.16)];
        [site_to_loveFieldPath addCurveToPoint: CGPointMake(278, 220) controlPoint1: CGPointMake(430.43, 243.35) controlPoint2: CGPointMake(366, 237)];
        [site_to_loveFieldPath addCurveToPoint: CGPointMake(106, 217) controlPoint1: CGPointMake(190, 203) controlPoint2: CGPointMake(106, 217)];
        [site_to_loveFieldPath addLineToPoint: CGPointMake(-4, 255)];
        site_to_loveFieldPath.lineCapStyle = kCGLineCapRound;
		// END COPY FROM PAINT CODE

		
		
		// copy new paths from paint code above into array
		// (reverse some of them as well)

		pathItem = [[embBezierPathItem alloc] init];
		pathItem.pathDelay = 1.0;
		pathItem.pathColor = pathBlue;
		pathItem.pathSpeed = pathSpeed;
		pathItem.pathWidth = pathWidth;
		pathItem.embPath = north_Toll_1Path;
		[_bezierPaths addObject:pathItem];
        
        pathItem = [[embBezierPathItem alloc] init];
		pathItem.pathDelay = 1.0;
		pathItem.pathColor = pathBlue;
		pathItem.pathSpeed = pathSpeed;
		pathItem.pathWidth = pathWidth;
		pathItem.embPath = woodall_Rodgers_1Path;
		[_bezierPaths addObject:pathItem];
        
        pathItem = [[embBezierPathItem alloc] init];
		pathItem.pathDelay = 1.0;
		pathItem.pathColor = pathBlue;
		pathItem.pathSpeed = pathSpeed;
		pathItem.pathWidth = pathWidth;
		pathItem.embPath = i35_2Path;
		[_bezierPaths addObject:pathItem];
        
        pathItem = [[embBezierPathItem alloc] init];
		pathItem.pathDelay = 1.0;
		pathItem.pathColor = pathBlue;
		pathItem.pathSpeed = pathSpeed;
		pathItem.pathWidth = pathWidth;
		pathItem.embPath = i35_3Path;
		[_bezierPaths addObject:pathItem];
        
        pathItem = [[embBezierPathItem alloc] init];
        pathItem.pathDelay = 1.0;
        pathItem.pathColor = pathBlue;
        pathItem.pathSpeed = pathSpeed;
        pathItem.pathWidth = pathWidth;
        pathItem.embPath = site_to_airportPath;
        [_bezierPaths addObject:pathItem];
        
        pathItem = [[embBezierPathItem alloc] init];
        pathItem.pathDelay = 1.0;
        pathItem.pathColor = pathBlue;
        pathItem.pathSpeed = pathSpeed;
        pathItem.pathWidth = pathWidth;
        pathItem.embPath = site_to_loveFieldPath;
        [_bezierPaths addObject:pathItem];
	}
	
	return self;
}

@end
