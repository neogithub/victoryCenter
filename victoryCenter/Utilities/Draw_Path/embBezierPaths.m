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
		
		
	//// From Uptown
		
		//// Bezier 2 Drawing
		UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
		[bezier2Path moveToPoint: CGPointMake(148.5, -2.5)];
		[bezier2Path addCurveToPoint: CGPointMake(180.5, 75.5) controlPoint1: CGPointMake(148.5, -2.5) controlPoint2: CGPointMake(175.88, 48.37)];
		[bezier2Path addCurveToPoint: CGPointMake(257.5, 218.5) controlPoint1: CGPointMake(185.12, 102.63) controlPoint2: CGPointMake(257.5, 218.5)];
		[bezier2Path addCurveToPoint: CGPointMake(284, 264.5) controlPoint1: CGPointMake(257.5, 218.5) controlPoint2: CGPointMake(273.56, 235.85)];
		[bezier2Path addCurveToPoint: CGPointMake(292, 354) controlPoint1: CGPointMake(294.44, 293.15) controlPoint2: CGPointMake(292, 354)];
		bezier2Path.lineJoinStyle = kCGLineJoinRound;
		
		
		//// Bezier 3 Drawing
		UIBezierPath* bezier3Path = [UIBezierPath bezierPath];
		[bezier3Path moveToPoint: CGPointMake(347, -0.5)];
		[bezier3Path addCurveToPoint: CGPointMake(213, 62.5) controlPoint1: CGPointMake(347, -0.5) controlPoint2: CGPointMake(227.82, 49.59)];
		[bezier3Path addCurveToPoint: CGPointMake(192, 100.5) controlPoint1: CGPointMake(198.18, 75.41) controlPoint2: CGPointMake(186.83, 89.08)];
		[bezier3Path addCurveToPoint: CGPointMake(277.63, 248.17) controlPoint1: CGPointMake(208.05, 135.92) controlPoint2: CGPointMake(268.42, 238.79)];
		[bezier3Path addCurveToPoint: CGPointMake(305.5, 263.5) controlPoint1: CGPointMake(282.47, 253.11) controlPoint2: CGPointMake(299.95, 261.99)];
		[bezier3Path addCurveToPoint: CGPointMake(371.5, 277) controlPoint1: CGPointMake(325.68, 269.01) controlPoint2: CGPointMake(371.5, 277)];
		bezier3Path.lineJoinStyle = kCGLineJoinRound;
		
		
		//// Bezier Drawing
		UIBezierPath* bezierPath = [UIBezierPath bezierPath];
		[bezierPath moveToPoint: CGPointMake(148.5, -2.5)];
		[bezierPath addCurveToPoint: CGPointMake(180.5, 75.5) controlPoint1: CGPointMake(148.5, -2.5) controlPoint2: CGPointMake(175.88, 48.37)];
		[bezierPath addCurveToPoint: CGPointMake(257.5, 218.5) controlPoint1: CGPointMake(185.12, 102.63) controlPoint2: CGPointMake(257.5, 218.5)];
		[bezierPath addCurveToPoint: CGPointMake(226, 245.5) controlPoint1: CGPointMake(257.5, 218.5) controlPoint2: CGPointMake(261.77, 250.55)];
		[bezierPath addCurveToPoint: CGPointMake(145.5, 238.5) controlPoint1: CGPointMake(190.23, 240.45) controlPoint2: CGPointMake(145.5, 238.5)];
		bezierPath.lineJoinStyle = kCGLineJoinRound;
			

		
		
	//// From the South or West
	
		UIBezierPath* bezier17Path = [UIBezierPath bezierPath];
		[bezier17Path moveToPoint: CGPointMake(655.5, 315.5)];
		[bezier17Path addCurveToPoint: CGPointMake(909.02, 424.65) controlPoint1: CGPointMake(720.36, 328.3) controlPoint2: CGPointMake(835.83, 395.55)];
		[bezier17Path addCurveToPoint: CGPointMake(1026, 462.18) controlPoint1: CGPointMake(982.21, 453.76) controlPoint2: CGPointMake(1026, 462.18)];
		bezier17Path.lineJoinStyle = kCGLineJoinRound;

		//// Bezier 16 Drawing
		UIBezierPath* bezier16Path = [UIBezierPath bezierPath];
		[bezier16Path moveToPoint: CGPointMake(571.63, 578.5)];
		[bezier16Path addLineToPoint: CGPointMake(1026, 579.18)];
		bezier16Path.lineJoinStyle = kCGLineJoinRound;
		
	
	
	
	
	//// From the North
	
		//// Bezier 15 Drawing
		UIBezierPath* bezier15Path = [UIBezierPath bezierPath];
		[bezier15Path moveToPoint: CGPointMake(0.63, 285.5)];
		[bezier15Path addCurveToPoint: CGPointMake(187, 252) controlPoint1: CGPointMake(0.63, 285.5) controlPoint2: CGPointMake(105.42, 251.9)];
		[bezier15Path addCurveToPoint: CGPointMake(326.95, 271.9) controlPoint1: CGPointMake(268.58, 252.1) controlPoint2: CGPointMake(296.54, 267.96)];
		[bezier15Path addCurveToPoint: CGPointMake(606, 318.18) controlPoint1: CGPointMake(357.36, 275.84) controlPoint2: CGPointMake(606, 318.18)];
		bezier15Path.lineJoinStyle = kCGLineJoinRound;
		
			
		//// Bezier 14 Drawing
		UIBezierPath* bezier14Path = [UIBezierPath bezierPath];
		[bezier14Path moveToPoint: CGPointMake(252.91, 587.81)];
		[bezier14Path addCurveToPoint: CGPointMake(268.5, 570) controlPoint1: CGPointMake(266.95, 587.21) controlPoint2: CGPointMake(268.5, 570)];
		[bezier14Path addLineToPoint: CGPointMake(292, 420.5)];
		bezier14Path.lineJoinStyle = kCGLineJoinRound;
		
		
		//// Bezier 11 Drawing
		UIBezierPath* bezier11Path = [UIBezierPath bezierPath];
		[bezier11Path moveToPoint: CGPointMake(0.63, 587.5)];
		[bezier11Path addLineToPoint: CGPointMake(537, 588.18)];
		bezier11Path.lineJoinStyle = kCGLineJoinRound;
	

	
	
	//// From Downtown
	
		//// Bezier 12 Drawing
		UIBezierPath* bezier12Path = [UIBezierPath bezierPath];
		[bezier12Path moveToPoint: CGPointMake(908, 569.5)];
		[bezier12Path addCurveToPoint: CGPointMake(880, 581.17) controlPoint1: CGPointMake(908, 569.5) controlPoint2: CGPointMake(897.39, 581.18)];
		[bezier12Path addCurveToPoint: CGPointMake(735.5, 581) controlPoint1: CGPointMake(869.59, 581.16) controlPoint2: CGPointMake(735.5, 581)];
		bezier12Path.lineJoinStyle = kCGLineJoinRound;
		
		
		//// Bezier 5 Drawing
		UIBezierPath* bezier5Path = [UIBezierPath bezierPath];
		[bezier5Path moveToPoint: CGPointMake(954.5, 440)];
		[bezier5Path addCurveToPoint: CGPointMake(912.5, 526) controlPoint1: CGPointMake(950.92, 443.37) controlPoint2: CGPointMake(917.14, 493.63)];
		[bezier5Path addCurveToPoint: CGPointMake(908.5, 693) controlPoint1: CGPointMake(902.03, 599.1) controlPoint2: CGPointMake(908.5, 693)];
		bezier5Path.lineJoinStyle = kCGLineJoinRound;
			
		
		//// Bezier 4 Drawing
		UIBezierPath* bezier4Path = [UIBezierPath bezierPath];
		[bezier4Path moveToPoint: CGPointMake(1025.5, 401.5)];
		[bezier4Path addCurveToPoint: CGPointMake(970.5, 433.5) controlPoint1: CGPointMake(1025.5, 401.5) controlPoint2: CGPointMake(984.25, 419.13)];
		[bezier4Path addCurveToPoint: CGPointMake(922.5, 429.5) controlPoint1: CGPointMake(956.75, 447.87) controlPoint2: CGPointMake(922.5, 429.5)];
		[bezier4Path addLineToPoint: CGPointMake(810.5, 380.5)];
		bezier4Path.lineJoinStyle = kCGLineJoinRound;
		
		// END COPY FROM PAINT CODE

		
		
		// copy new paths from paint code above into array
		// (reverse some of them as well)

		// INGRESS N & S
		//reversePath = [bezierPath bezierPathByReversingPath];
		pathItem = [[embBezierPathItem alloc] init];
		pathItem.pathDelay = 1.0;
		pathItem.pathColor = pathBlue;
		pathItem.pathSpeed = pathSpeed;
		pathItem.pathWidth = pathWidth;
		pathItem.embPath = bezierPath;
		[_bezierPaths addObject:pathItem];
		
		//reversePath = [bezier2Path bezierPathByReversingPath];
		pathItem = [[embBezierPathItem alloc] init];
		pathItem.pathDelay = 1.0;
		pathItem.pathColor = pathRed;
		pathItem.pathSpeed = pathSpeed;
		pathItem.pathWidth = pathWidth;
		pathItem.embPath = bezier2Path;
		[_bezierPaths addObject:pathItem];
		
		//reversePath = [bezier3Path bezierPathByReversingPath];
		pathItem = [[embBezierPathItem alloc] init];
		pathItem.pathDelay = 1.0;
		pathItem.pathColor = pathRed;
		pathItem.pathSpeed = pathSpeed;
		pathItem.pathWidth = pathWidth;
		pathItem.embPath = bezier3Path;
		[_bezierPaths addObject:pathItem];
		
		
		
		
		
		
		pathItem = [[embBezierPathItem alloc] init];
		pathItem.pathDelay = 0.0;
		pathItem.pathColor = pathRed;
		pathItem.pathSpeed = pathSpeed;
		pathItem.pathWidth = pathWidth;
		pathItem.embPath = bezier4Path;
		[_bezierPaths addObject:pathItem];
		
		pathItem = [[embBezierPathItem alloc] init];
		pathItem.pathDelay = 1.0;
		pathItem.pathColor = pathRed;
		pathItem.pathSpeed = pathSpeed;
		pathItem.pathWidth = pathWidth;
		pathItem.embPath = bezier5Path;
		[_bezierPaths addObject:pathItem];
		
		pathItem = [[embBezierPathItem alloc] init];
		pathItem.pathDelay = 1.5;
		pathItem.pathColor = pathRed;
		pathItem.pathSpeed = pathSpeed;
		pathItem.pathWidth = pathWidth;
		pathItem.embPath = bezier12Path;
		[_bezierPaths addObject:pathItem];

		
		
		
		
		
		
		// EGRESS N & S
		reversePath = [bezier17Path bezierPathByReversingPath];
		pathItem = [[embBezierPathItem alloc] init];
		pathItem.pathDelay = 1.0;
		pathItem.pathColor = pathBlue;
		pathItem.pathSpeed = pathSpeed;
		pathItem.pathWidth = pathWidth;
		pathItem.embPath = reversePath;
		[_bezierPaths addObject:pathItem];
		
		reversePath = [bezier16Path bezierPathByReversingPath];
		pathItem = [[embBezierPathItem alloc] init];
		pathItem.pathDelay = 1.0;
		pathItem.pathColor = pathRed;
		pathItem.pathSpeed = pathSpeed;
		pathItem.pathWidth = pathWidth;
		pathItem.embPath = reversePath;
		[_bezierPaths addObject:pathItem];
		
		
		
		
		
		

		pathItem = [[embBezierPathItem alloc] init];
		pathItem.pathDelay = 1.0;
		pathItem.pathColor = pathRed;
		pathItem.pathSpeed = pathSpeed;
		pathItem.pathWidth = pathWidth;
		pathItem.embPath = bezier15Path;
		[_bezierPaths addObject:pathItem];
		
		pathItem = [[embBezierPathItem alloc] init];
		pathItem.pathDelay = 1.5;
		pathItem.pathColor = pathRed;
		pathItem.pathSpeed = pathSpeed;
		pathItem.pathWidth = pathWidth;
		pathItem.embPath = bezier14Path;
		[_bezierPaths addObject:pathItem];
		
		pathItem = [[embBezierPathItem alloc] init];
		pathItem.pathDelay = 1.0;
		pathItem.pathColor = pathRed;
		pathItem.pathSpeed = pathSpeed;
		pathItem.pathWidth = pathWidth;
		pathItem.embPath = bezier11Path;
		[_bezierPaths addObject:pathItem];
		
		
		
		


	}
	
	return self;
}

@end
