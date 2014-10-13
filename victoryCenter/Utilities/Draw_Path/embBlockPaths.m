//
//  embBezierPathItems.m
//  embAnimatedPath
//
//  Created by Evan Buxton on 2/19/14.
//  Copyright (c) 2014 neoscape. All rights reserved.
//

#import "embBlockPaths.h"
@implementation embBlockPaths

- (id) init
{
    if (self = [super init]) {
		
		// setup
		_bezierPaths = [[NSMutableArray alloc] init];
		
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
		//// Bezier Drawing
		//// Color Declarations
		
		//// Bezier Drawing
		UIBezierPath* bezierPath = [UIBezierPath bezierPath];
		[bezierPath moveToPoint: CGPointMake(132.5, 328.5)];
		[bezierPath addCurveToPoint: CGPointMake(112.5, 277.5) controlPoint1: CGPointMake(132.5, 328.5) controlPoint2: CGPointMake(116.51, 288.77)];
		[bezierPath addCurveToPoint: CGPointMake(140.5, 263.5) controlPoint1: CGPointMake(108.49, 266.23) controlPoint2: CGPointMake(140.5, 263.5)];
		[bezierPath addLineToPoint: CGPointMake(206.5, 264.5)];
		[bezierPath addCurveToPoint: CGPointMake(227.5, 274.5) controlPoint1: CGPointMake(206.5, 264.5) controlPoint2: CGPointMake(222.52, 263.84)];
		[bezierPath addCurveToPoint: CGPointMake(232.5, 288.5) controlPoint1: CGPointMake(232.48, 285.16) controlPoint2: CGPointMake(232.5, 288.5)];
		[bezierPath addLineToPoint: CGPointMake(132.5, 328.5)];
		[bezierPath closePath];

		//// Bezier 3 Drawing
		UIBezierPath* bezier3Path = [UIBezierPath bezierPath];
		[bezier3Path moveToPoint: CGPointMake(155.5, 390.5)];
		[bezier3Path addLineToPoint: CGPointMake(272.5, 344.5)];
		[bezier3Path addLineToPoint: CGPointMake(263.5, 401.5)];
		[bezier3Path addCurveToPoint: CGPointMake(244.5, 421.5) controlPoint1: CGPointMake(263.5, 401.5) controlPoint2: CGPointMake(263.66, 414.44)];
		[bezier3Path addCurveToPoint: CGPointMake(192.5, 441.5) controlPoint1: CGPointMake(225.34, 428.56) controlPoint2: CGPointMake(192.5, 441.5)];
		[bezier3Path addCurveToPoint: CGPointMake(175.5, 438.5) controlPoint1: CGPointMake(192.5, 441.5) controlPoint2: CGPointMake(179.67, 449.12)];
		[bezier3Path addCurveToPoint: CGPointMake(155.5, 390.5) controlPoint1: CGPointMake(171.33, 427.88) controlPoint2: CGPointMake(155.5, 390.5)];
		[bezier3Path closePath];
		
		//// Bezier 6 Drawing
		UIBezierPath* bezier6Path = [UIBezierPath bezierPath];
		[bezier6Path moveToPoint: CGPointMake(619, 568)];
		[bezier6Path addLineToPoint: CGPointMake(619, 561)];
		[bezier6Path addLineToPoint: CGPointMake(625, 556)];
		[bezier6Path addLineToPoint: CGPointMake(659, 556)];
		[bezier6Path addLineToPoint: CGPointMake(659, 543)];
		[bezier6Path addLineToPoint: CGPointMake(618, 543)];
		[bezier6Path addLineToPoint: CGPointMake(618, 492)];
		[bezier6Path addLineToPoint: CGPointMake(596, 491)];
		[bezier6Path addLineToPoint: CGPointMake(603, 436)];
		[bezier6Path addLineToPoint: CGPointMake(735, 478)];
		[bezier6Path addLineToPoint: CGPointMake(723, 567)];
		[bezier6Path addLineToPoint: CGPointMake(619, 568)];
		[bezier6Path closePath];
		
		//// Bezier 8 Drawing
		UIBezierPath* bezier8Path = [UIBezierPath bezierPath];
		[bezier8Path moveToPoint: CGPointMake(775.5, 452.5)];
		[bezier8Path addLineToPoint: CGPointMake(784.5, 427.5)];
		[bezier8Path addLineToPoint: CGPointMake(781.5, 425.5)];
		[bezier8Path addLineToPoint: CGPointMake(791.5, 404.5)];
		[bezier8Path addLineToPoint: CGPointMake(795.5, 405.5)];
		[bezier8Path addLineToPoint: CGPointMake(797.5, 400.5)];
		[bezier8Path addLineToPoint: CGPointMake(828.5, 414.5)];
		[bezier8Path addLineToPoint: CGPointMake(826.5, 419.5)];
		[bezier8Path addLineToPoint: CGPointMake(877.5, 442.5)];
		[bezier8Path addLineToPoint: CGPointMake(880.5, 434.5)];
		[bezier8Path addLineToPoint: CGPointMake(920.5, 453.5)];
		[bezier8Path addLineToPoint: CGPointMake(895.5, 508.5)];
		[bezier8Path addLineToPoint: CGPointMake(775.5, 452.5)];
		[bezier8Path closePath];

		//// Bezier 9 Drawing
		UIBezierPath* bezier9Path = [UIBezierPath bezierPath];
		[bezier9Path moveToPoint: CGPointMake(617.5, 401.5)];
		[bezier9Path addLineToPoint: CGPointMake(623.5, 382.5)];
		[bezier9Path addLineToPoint: CGPointMake(628.5, 384.5)];
		[bezier9Path addLineToPoint: CGPointMake(635.5, 359.5)];
		[bezier9Path addLineToPoint: CGPointMake(640.5, 359.5)];
		[bezier9Path addLineToPoint: CGPointMake(643.5, 347.5)];
		[bezier9Path addLineToPoint: CGPointMake(647.5, 348.5)];
		[bezier9Path addLineToPoint: CGPointMake(648.5, 341.5)];
		[bezier9Path addLineToPoint: CGPointMake(665.5, 346.5)];
		[bezier9Path addLineToPoint: CGPointMake(663.5, 354.5)];
		[bezier9Path addLineToPoint: CGPointMake(712.5, 369.5)];
		[bezier9Path addLineToPoint: CGPointMake(715.5, 359.5)];
		[bezier9Path addLineToPoint: CGPointMake(743.5, 372.5)];
		[bezier9Path addLineToPoint: CGPointMake(742.5, 375.5)];
		[bezier9Path addLineToPoint: CGPointMake(761.5, 381.5)];
		[bezier9Path addLineToPoint: CGPointMake(745.5, 434.5)];
		[bezier9Path addCurveToPoint: CGPointMake(733.5, 438.5) controlPoint1: CGPointMake(745.5, 434.5) controlPoint2: CGPointMake(746.37, 442.56)];
		[bezier9Path addCurveToPoint: CGPointMake(617.5, 401.5) controlPoint1: CGPointMake(720.63, 434.44) controlPoint2: CGPointMake(617.5, 401.5)];
		[bezier9Path closePath];
		
		//// Bezier 10 Drawing
		UIBezierPath* bezier10Path = [UIBezierPath bezierPath];
		[bezier10Path moveToPoint: CGPointMake(373.5, 355.5)];
		[bezier10Path addLineToPoint: CGPointMake(376.5, 334.5)];
		[bezier10Path addLineToPoint: CGPointMake(326.5, 325.5)];
		[bezier10Path addLineToPoint: CGPointMake(331.5, 297.5)];
		[bezier10Path addLineToPoint: CGPointMake(343.63, 295.04)];
		[bezier10Path addLineToPoint: CGPointMake(356.5, 294.5)];
		[bezier10Path addLineToPoint: CGPointMake(356.5, 297.5)];
		[bezier10Path addLineToPoint: CGPointMake(382.5, 301.5)];
		[bezier10Path addLineToPoint: CGPointMake(383.5, 294.5)];
		[bezier10Path addLineToPoint: CGPointMake(503.5, 314.5)];
		[bezier10Path addLineToPoint: CGPointMake(502.5, 322.5)];
		[bezier10Path addLineToPoint: CGPointMake(507.5, 323.5)];
		[bezier10Path addLineToPoint: CGPointMake(506.5, 330.5)];
		[bezier10Path addLineToPoint: CGPointMake(578.5, 342.5)];
		[bezier10Path addLineToPoint: CGPointMake(580.5, 327.5)];
		[bezier10Path addLineToPoint: CGPointMake(589.5, 329.5)];
		[bezier10Path addLineToPoint: CGPointMake(592.5, 337.5)];
		[bezier10Path addLineToPoint: CGPointMake(567.5, 388.5)];
		[bezier10Path addLineToPoint: CGPointMake(373.5, 355.5)];
		[bezier10Path closePath];

		//// Bezier 11 Drawing
		UIBezierPath* bezier11Path = [UIBezierPath bezierPath];
		[bezier11Path moveToPoint: CGPointMake(526, 549)];
		[bezier11Path addLineToPoint: CGPointMake(493, 543)];
		[bezier11Path addLineToPoint: CGPointMake(493, 555)];
		[bezier11Path addLineToPoint: CGPointMake(421, 542)];
		[bezier11Path addLineToPoint: CGPointMake(419, 565)];
		[bezier11Path addLineToPoint: CGPointMake(299, 566)];
		[bezier11Path addLineToPoint: CGPointMake(287, 556)];
		[bezier11Path addLineToPoint: CGPointMake(316, 386)];
		[bezier11Path addLineToPoint: CGPointMake(457.5, 408.5)];
		[bezier11Path addLineToPoint: CGPointMake(461.5, 413.5)];
		[bezier11Path addLineToPoint: CGPointMake(459.5, 430.5)];
		[bezier11Path addLineToPoint: CGPointMake(464.5, 431.5)];
		[bezier11Path addLineToPoint: CGPointMake(466.5, 415.5)];
		[bezier11Path addLineToPoint: CGPointMake(482.5, 417.5)];
		[bezier11Path addLineToPoint: CGPointMake(482.5, 412.5)];
		[bezier11Path addLineToPoint: CGPointMake(555.5, 425.5)];
		[bezier11Path addLineToPoint: CGPointMake(537.51, 532.95)];
		[bezier11Path addLineToPoint: CGPointMake(528, 532)];
		[bezier11Path addLineToPoint: CGPointMake(526, 549)];
		[bezier11Path closePath];
		
		// END COPY FROM PAINT CODE

		
		
		// copy new paths from paint code above into array
		pathItem = [[embBezierPathItem alloc] init];
		pathItem.pathDelay = 1.0;
		pathItem.pathColor = pathBlue;
		pathItem.pathSpeed = pathSpeed;
		pathItem.pathWidth = pathWidth;
		pathItem.embPath = bezierPath;
		[_bezierPaths addObject:pathItem];
		
		pathItem = [[embBezierPathItem alloc] init];
		pathItem.pathDelay = 1.0;
		pathItem.pathColor = pathRed;
		pathItem.pathSpeed = pathSpeed;
		pathItem.pathWidth = pathWidth;
		pathItem.embPath = bezier3Path;
		[_bezierPaths addObject:pathItem];
		
		pathItem = [[embBezierPathItem alloc] init];
		pathItem.pathDelay = 1.0;
		pathItem.pathColor = pathRed;
		pathItem.pathSpeed = pathSpeed;
		pathItem.pathWidth = pathWidth;
		pathItem.embPath = bezier10Path;
		[_bezierPaths addObject:pathItem];
		
		pathItem = [[embBezierPathItem alloc] init];
		pathItem.pathDelay = 1.0;
		pathItem.pathColor = pathRed;
		pathItem.pathSpeed = pathSpeed;
		pathItem.pathWidth = pathWidth;
		pathItem.embPath = bezier11Path;
		[_bezierPaths addObject:pathItem];

		pathItem = [[embBezierPathItem alloc] init];
		pathItem.pathDelay = 1.0;
		pathItem.pathColor = pathRed;
		pathItem.pathSpeed = pathSpeed;
		pathItem.pathWidth = pathWidth;
		pathItem.embPath = bezier9Path;
		[_bezierPaths addObject:pathItem];
		
		pathItem = [[embBezierPathItem alloc] init];
		pathItem.pathDelay = 1.0;
		pathItem.pathColor = pathBlue;
		pathItem.pathSpeed = pathSpeed;
		pathItem.pathWidth = pathWidth;
		pathItem.embPath = bezier6Path;
		[_bezierPaths addObject:pathItem];
		
		pathItem = [[embBezierPathItem alloc] init];
		pathItem.pathDelay = 1.0;
		pathItem.pathColor = pathBlue;
		pathItem.pathSpeed = pathSpeed;
		pathItem.pathWidth = pathWidth;
		pathItem.embPath = bezier8Path;
		[_bezierPaths addObject:pathItem];
	}
	
	return self;
}

@end
