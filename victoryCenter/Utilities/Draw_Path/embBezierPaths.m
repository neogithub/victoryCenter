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
		UIBezierPath *reversePath;

		UIColor *pathRed = [UIColor colorWithRed:235.0f/255.0f
										   green:199.0f/255.0f
											blue:113.0f/255.0f
										   alpha:1.0];
		
		
		
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
        [woodall_Rodgers_1Path addCurveToPoint: CGPointMake(964, 183) controlPoint1: CGPointMake(866, 1) controlPoint2: CGPointMake(973.5, 170.5)];
        [woodall_Rodgers_1Path addCurveToPoint: CGPointMake(747, 307) controlPoint1: CGPointMake(954.5, 195.5) controlPoint2: CGPointMake(750, 302)];
        [woodall_Rodgers_1Path addCurveToPoint: CGPointMake(721, 454) controlPoint1: CGPointMake(744, 312) controlPoint2: CGPointMake(735, 395)];
        [woodall_Rodgers_1Path addCurveToPoint: CGPointMake(712, 584) controlPoint1: CGPointMake(706.08, 516.89) controlPoint2: CGPointMake(712, 584)];
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

	}
	
	return self;
}

@end
