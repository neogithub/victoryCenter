//
//  embBezierPathItems.m
//  embAnimatedPath
//
//  Created by Evan Buxton on 2/19/14.
//  Copyright (c) 2014 neoscape. All rights reserved.
//

#import "embDirections.h"
@implementation embDirections

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
		
        //// FromI30 Drawing
        UIBezierPath* fromI30Path = UIBezierPath.bezierPath;
        [fromI30Path moveToPoint: CGPointMake(-0.5, 596.5)];
        [fromI30Path addCurveToPoint: CGPointMake(72.5, 603.5) controlPoint1: CGPointMake(-0.5, 596.5) controlPoint2: CGPointMake(36.87, 593.04)];
        [fromI30Path addCurveToPoint: CGPointMake(189.5, 634.5) controlPoint1: CGPointMake(108.13, 613.96) controlPoint2: CGPointMake(156.69, 635.95)];
        [fromI30Path addCurveToPoint: CGPointMake(289, 596.5) controlPoint1: CGPointMake(222.31, 633.05) controlPoint2: CGPointMake(230.9, 606.12)];
        [fromI30Path addCurveToPoint: CGPointMake(439.5, 567.5) controlPoint1: CGPointMake(347.1, 586.88) controlPoint2: CGPointMake(383.75, 580.28)];
        [fromI30Path addCurveToPoint: CGPointMake(484.29, 548.73) controlPoint1: CGPointMake(462.35, 562.26) controlPoint2: CGPointMake(476.07, 555.65)];
        [fromI30Path addCurveToPoint: CGPointMake(496.5, 520) controlPoint1: CGPointMake(496.13, 538.76) controlPoint2: CGPointMake(496.59, 528.14)];
        [fromI30Path addCurveToPoint: CGPointMake(494, 464) controlPoint1: CGPointMake(496.46, 516.44) controlPoint2: CGPointMake(495.27, 491.95)];
        [fromI30Path addCurveToPoint: CGPointMake(491, 406) controlPoint1: CGPointMake(493.09, 443.9) controlPoint2: CGPointMake(492.91, 423.12)];
        [fromI30Path addCurveToPoint: CGPointMake(485, 377) controlPoint1: CGPointMake(490.03, 397.32) controlPoint2: CGPointMake(486.75, 383.29)];
		
		
		//// FromWoodallRogers1 Drawing
		UIBezierPath* fromWoodallRogers1Path = [UIBezierPath bezierPath];
		[fromWoodallRogers1Path moveToPoint: CGPointMake(729.5, -2.5)];
		[fromWoodallRogers1Path addLineToPoint: CGPointMake(674, 125.5)];
		[fromWoodallRogers1Path addCurveToPoint: CGPointMake(659.5, 182.5) controlPoint1: CGPointMake(674, 125.5) controlPoint2: CGPointMake(661.5, 146)];
		[fromWoodallRogers1Path addCurveToPoint: CGPointMake(661, 240.5) controlPoint1: CGPointMake(658.18, 206.65) controlPoint2: CGPointMake(659.37, 223.68)];
		[fromWoodallRogers1Path addCurveToPoint: CGPointMake(661, 286) controlPoint1: CGPointMake(661.83, 249.1) controlPoint2: CGPointMake(664.3, 279)];
		[fromWoodallRogers1Path addCurveToPoint: CGPointMake(587.34, 355.86) controlPoint1: CGPointMake(654.13, 300.57) controlPoint2: CGPointMake(587.34, 355.86)];
		[fromWoodallRogers1Path addLineToPoint: CGPointMake(566.5, 337)];
		[fromWoodallRogers1Path addCurveToPoint: CGPointMake(553, 337) controlPoint1: CGPointMake(566.5, 337) controlPoint2: CGPointMake(558.6, 332.53)];
		[fromWoodallRogers1Path addCurveToPoint: CGPointMake(518, 368) controlPoint1: CGPointMake(547.41, 341.46) controlPoint2: CGPointMake(518, 368)];
		
		
		//// FromWoodallRogers2 Drawing
		UIBezierPath* fromWoodallRogers2Path = [UIBezierPath bezierPath];
		[fromWoodallRogers2Path moveToPoint: CGPointMake(729.5, -2.5)];
		[fromWoodallRogers2Path addLineToPoint: CGPointMake(674, 125.5)];
		[fromWoodallRogers2Path addCurveToPoint: CGPointMake(659.5, 182.5) controlPoint1: CGPointMake(674, 125.5) controlPoint2: CGPointMake(661.5, 146)];
		[fromWoodallRogers2Path addCurveToPoint: CGPointMake(661, 240.5) controlPoint1: CGPointMake(658.18, 206.65) controlPoint2: CGPointMake(659.37, 223.68)];
		[fromWoodallRogers2Path addCurveToPoint: CGPointMake(661, 286) controlPoint1: CGPointMake(661.83, 249.1) controlPoint2: CGPointMake(664.3, 279)];
		[fromWoodallRogers2Path addCurveToPoint: CGPointMake(587.34, 355.86) controlPoint1: CGPointMake(654.13, 300.57) controlPoint2: CGPointMake(587.34, 355.86)];
		[fromWoodallRogers2Path addLineToPoint: CGPointMake(551.5, 394)];
		[fromWoodallRogers2Path addLineToPoint: CGPointMake(530, 354.5)];
		
		
        //// FromWoodallRogers3 Drawing
        UIBezierPath* fromWoodallRogers3Path = UIBezierPath.bezierPath;
        [fromWoodallRogers3Path moveToPoint: CGPointMake(729.5, -2.5)];
        [fromWoodallRogers3Path addLineToPoint: CGPointMake(674, 125.5)];
        [fromWoodallRogers3Path addCurveToPoint: CGPointMake(659.5, 182.5) controlPoint1: CGPointMake(674, 125.5) controlPoint2: CGPointMake(661.5, 146)];
        [fromWoodallRogers3Path addCurveToPoint: CGPointMake(661, 240.5) controlPoint1: CGPointMake(658.18, 206.65) controlPoint2: CGPointMake(659.37, 223.68)];
        [fromWoodallRogers3Path addCurveToPoint: CGPointMake(661, 286) controlPoint1: CGPointMake(661.83, 249.1) controlPoint2: CGPointMake(664.3, 279)];
        [fromWoodallRogers3Path addCurveToPoint: CGPointMake(657, 295) controlPoint1: CGPointMake(660.01, 288.09) controlPoint2: CGPointMake(660.02, 291.44)];
        [fromWoodallRogers3Path addCurveToPoint: CGPointMake(589, 358) controlPoint1: CGPointMake(638.97, 316.25) controlPoint2: CGPointMake(589, 358)];
        [fromWoodallRogers3Path addLineToPoint: CGPointMake(570, 376)];
        [fromWoodallRogers3Path addLineToPoint: CGPointMake(551.5, 394)];
        [fromWoodallRogers3Path addCurveToPoint: CGPointMake(538, 409) controlPoint1: CGPointMake(551.5, 394) controlPoint2: CGPointMake(545.97, 401.03)];
        [fromWoodallRogers3Path addLineToPoint: CGPointMake(524.47, 424.59)];
        [fromWoodallRogers3Path addCurveToPoint: CGPointMake(521, 367) controlPoint1: CGPointMake(524.47, 424.59) controlPoint2: CGPointMake(520.48, 367.47)];
        [fromWoodallRogers3Path addCurveToPoint: CGPointMake(524.47, 424.59) controlPoint1: CGPointMake(521.45, 366.59) controlPoint2: CGPointMake(524.47, 424.59)];
		
		
        //// FromKatyTrail Drawing
        UIBezierPath* fromKatyTrailPath = UIBezierPath.bezierPath;
        [fromKatyTrailPath moveToPoint: CGPointMake(683.5, -1)];
        [fromKatyTrailPath addCurveToPoint: CGPointMake(629, 93) controlPoint1: CGPointMake(665.65, 30.92) controlPoint2: CGPointMake(644.95, 66.37)];
        [fromKatyTrailPath addCurveToPoint: CGPointMake(586.5, 161.5) controlPoint1: CGPointMake(621.06, 106.26) controlPoint2: CGPointMake(594.39, 145.46)];
        [fromKatyTrailPath addCurveToPoint: CGPointMake(563, 216) controlPoint1: CGPointMake(578.54, 177.68) controlPoint2: CGPointMake(569.99, 210.44)];
        [fromKatyTrailPath addCurveToPoint: CGPointMake(515.89, 245.7) controlPoint1: CGPointMake(556.33, 221.3) controlPoint2: CGPointMake(535.72, 234.63)];
        [fromKatyTrailPath addCurveToPoint: CGPointMake(485.14, 269.09) controlPoint1: CGPointMake(501.81, 253.56) controlPoint2: CGPointMake(493.14, 260.3)];
        [fromKatyTrailPath addCurveToPoint: CGPointMake(475, 286) controlPoint1: CGPointMake(480.9, 273.75) controlPoint2: CGPointMake(473.29, 280.84)];
        [fromKatyTrailPath addCurveToPoint: CGPointMake(520, 364) controlPoint1: CGPointMake(481.06, 304.29) controlPoint2: CGPointMake(513.13, 346.28)];

		
		
        //// FromDallasNorthTollWay Drawing
        UIBezierPath* fromDallasNorthTollWayPath = UIBezierPath.bezierPath;
        [fromDallasNorthTollWayPath moveToPoint: CGPointMake(450.5, -0.5)];
        [fromDallasNorthTollWayPath addLineToPoint: CGPointMake(445.5, 66.5)];
        [fromDallasNorthTollWayPath addCurveToPoint: CGPointMake(437, 136) controlPoint1: CGPointMake(445.5, 66.5) controlPoint2: CGPointMake(437.07, 109.93)];
        [fromDallasNorthTollWayPath addCurveToPoint: CGPointMake(451, 232) controlPoint1: CGPointMake(436.93, 162.07) controlPoint2: CGPointMake(451, 232)];
        [fromDallasNorthTollWayPath addCurveToPoint: CGPointMake(451, 232) controlPoint1: CGPointMake(451, 232) controlPoint2: CGPointMake(451, 229)];
        [fromDallasNorthTollWayPath addCurveToPoint: CGPointMake(469, 291) controlPoint1: CGPointMake(451, 235) controlPoint2: CGPointMake(469, 291)];
        [fromDallasNorthTollWayPath addLineToPoint: CGPointMake(474.49, 333.99)];
        [fromDallasNorthTollWayPath addLineToPoint: CGPointMake(485, 377)];
		
		
        //// FromI35 Drawing
        UIBezierPath* fromI35Path = UIBezierPath.bezierPath;
        [fromI35Path moveToPoint: CGPointMake(-4, 74)];
        [fromI35Path addCurveToPoint: CGPointMake(82, 123) controlPoint1: CGPointMake(-4, 74) controlPoint2: CGPointMake(7.29, 114.74)];
        [fromI35Path addCurveToPoint: CGPointMake(149, 129) controlPoint1: CGPointMake(110.81, 126.18) controlPoint2: CGPointMake(123.21, 119.83)];
        [fromI35Path addCurveToPoint: CGPointMake(253.5, 190.5) controlPoint1: CGPointMake(190.08, 143.61) controlPoint2: CGPointMake(236.66, 177.02)];
        [fromI35Path addCurveToPoint: CGPointMake(378, 235) controlPoint1: CGPointMake(280.91, 212.45) controlPoint2: CGPointMake(340.77, 225.42)];
        [fromI35Path addCurveToPoint: CGPointMake(410.12, 250.91) controlPoint1: CGPointMake(391.2, 238.4) controlPoint2: CGPointMake(401.76, 246.08)];
        [fromI35Path addCurveToPoint: CGPointMake(450, 279) controlPoint1: CGPointMake(425.33, 259.71) controlPoint2: CGPointMake(446.8, 275.98)];
        [fromI35Path addCurveToPoint: CGPointMake(465, 298) controlPoint1: CGPointMake(453.36, 282.17) controlPoint2: CGPointMake(460.49, 291.36)];
        [fromI35Path addCurveToPoint: CGPointMake(470, 311) controlPoint1: CGPointMake(467.15, 301.16) controlPoint2: CGPointMake(470, 311)];
        [fromI35Path addLineToPoint: CGPointMake(485, 377)];

	
//		//// FromTheWest Drawing
//		UIBezierPath* fromTheWestPath = [UIBezierPath bezierPath];
//		[fromTheWestPath moveToPoint: CGPointMake(-0.5, 596.5)];
//		[fromTheWestPath addCurveToPoint: CGPointMake(72.5, 603.5) controlPoint1: CGPointMake(-0.5, 596.5) controlPoint2: CGPointMake(36.87, 593.04)];
//		[fromTheWestPath addCurveToPoint: CGPointMake(189.5, 634.5) controlPoint1: CGPointMake(108.13, 613.96) controlPoint2: CGPointMake(156.69, 635.95)];
//		[fromTheWestPath addCurveToPoint: CGPointMake(289, 596.5) controlPoint1: CGPointMake(222.31, 633.05) controlPoint2: CGPointMake(230.9, 606.12)];
//		[fromTheWestPath addCurveToPoint: CGPointMake(439.5, 567.5) controlPoint1: CGPointMake(347.1, 586.88) controlPoint2: CGPointMake(383.75, 580.28)];
//		[fromTheWestPath addCurveToPoint: CGPointMake(496.5, 520) controlPoint1: CGPointMake(495.25, 554.72) controlPoint2: CGPointMake(496.64, 533.79)];
//		[fromTheWestPath addCurveToPoint: CGPointMake(492.5, 421.5) controlPoint1: CGPointMake(496.36, 506.21) controlPoint2: CGPointMake(493.31, 440.63)];
//		[fromTheWestPath addCurveToPoint: CGPointMake(476, 333) controlPoint1: CGPointMake(491.69, 402.37) controlPoint2: CGPointMake(476, 333)];
//		[fromTheWestPath addCurveToPoint: CGPointMake(496.5, 344.5) controlPoint1: CGPointMake(476, 333) controlPoint2: CGPointMake(491.79, 324.59)];
//		
//		
//		//// FromTheSouth Drawing
//		UIBezierPath* fromTheSouthPath = [UIBezierPath bezierPath];
//		[fromTheSouthPath moveToPoint: CGPointMake(514.5, 768.5)];
//		[fromTheSouthPath addCurveToPoint: CGPointMake(514.5, 686.5) controlPoint1: CGPointMake(513.11, 729.7) controlPoint2: CGPointMake(500.05, 717.82)];
//		[fromTheSouthPath addCurveToPoint: CGPointMake(558, 602.5) controlPoint1: CGPointMake(521.7, 670.91) controlPoint2: CGPointMake(555.61, 625.16)];
//		[fromTheSouthPath addCurveToPoint: CGPointMake(523.5, 559) controlPoint1: CGPointMake(560.41, 579.64) controlPoint2: CGPointMake(530.49, 564.56)];
//		[fromTheSouthPath addCurveToPoint: CGPointMake(497.5, 516) controlPoint1: CGPointMake(509.59, 547.93) controlPoint2: CGPointMake(499.81, 528.27)];
//		[fromTheSouthPath addCurveToPoint: CGPointMake(492.5, 421.5) controlPoint1: CGPointMake(495.19, 503.73) controlPoint2: CGPointMake(493.31, 440.63)];
//		[fromTheSouthPath addCurveToPoint: CGPointMake(476, 333) controlPoint1: CGPointMake(491.69, 402.37) controlPoint2: CGPointMake(476, 333)];
//		[fromTheSouthPath addCurveToPoint: CGPointMake(496.5, 344.5) controlPoint1: CGPointMake(476, 333) controlPoint2: CGPointMake(491.79, 324.59)];
//		
//		
//		//// FromTheNorth Drawing
//		UIBezierPath* fromTheNorthPath = [UIBezierPath bezierPath];
//		[fromTheNorthPath moveToPoint: CGPointMake(450.5, -0.5)];
//		[fromTheNorthPath addLineToPoint: CGPointMake(445.5, 66.5)];
//		[fromTheNorthPath addCurveToPoint: CGPointMake(437, 136) controlPoint1: CGPointMake(445.5, 66.5) controlPoint2: CGPointMake(437.07, 109.93)];
//		[fromTheNorthPath addCurveToPoint: CGPointMake(450.5, 227) controlPoint1: CGPointMake(436.93, 162.07) controlPoint2: CGPointMake(450.5, 227)];
//		[fromTheNorthPath addLineToPoint: CGPointMake(433.5, 266.5)];
//		[fromTheNorthPath addCurveToPoint: CGPointMake(470, 311) controlPoint1: CGPointMake(433.5, 266.5) controlPoint2: CGPointMake(468.32, 291.87)];
//		[fromTheNorthPath addCurveToPoint: CGPointMake(489.5, 327.5) controlPoint1: CGPointMake(471.68, 330.13) controlPoint2: CGPointMake(485.44, 323.33)];
//		[fromTheNorthPath addCurveToPoint: CGPointMake(498.5, 349.5) controlPoint1: CGPointMake(493.56, 331.67) controlPoint2: CGPointMake(498.5, 349.5)];
//		
//		
//		//// FromTheNorthWest Drawing
//		UIBezierPath* fromTheNorthWestPath = [UIBezierPath bezierPath];
//		[fromTheNorthWestPath moveToPoint: CGPointMake(-4, 74)];
//		[fromTheNorthWestPath addCurveToPoint: CGPointMake(82, 123) controlPoint1: CGPointMake(-4, 74) controlPoint2: CGPointMake(7.29, 114.74)];
//		[fromTheNorthWestPath addCurveToPoint: CGPointMake(149, 129) controlPoint1: CGPointMake(110.81, 126.18) controlPoint2: CGPointMake(123.21, 119.83)];
//		[fromTheNorthWestPath addCurveToPoint: CGPointMake(253.5, 190.5) controlPoint1: CGPointMake(190.08, 143.61) controlPoint2: CGPointMake(236.66, 177.02)];
//		[fromTheNorthWestPath addCurveToPoint: CGPointMake(378, 235) controlPoint1: CGPointMake(280.91, 212.45) controlPoint2: CGPointMake(340.77, 225.42)];
//		[fromTheNorthWestPath addCurveToPoint: CGPointMake(410.12, 250.91) controlPoint1: CGPointMake(391.2, 238.4) controlPoint2: CGPointMake(401.76, 246.08)];
//		[fromTheNorthWestPath addCurveToPoint: CGPointMake(450, 279) controlPoint1: CGPointMake(425.33, 259.71) controlPoint2: CGPointMake(446.8, 275.98)];
//		[fromTheNorthWestPath addCurveToPoint: CGPointMake(469, 311) controlPoint1: CGPointMake(454.96, 283.68) controlPoint2: CGPointMake(467.97, 298.67)];
//		[fromTheNorthWestPath addCurveToPoint: CGPointMake(489.5, 327.5) controlPoint1: CGPointMake(470.03, 323.33) controlPoint2: CGPointMake(485.44, 323.33)];
//		[fromTheNorthWestPath addCurveToPoint: CGPointMake(498.5, 349.5) controlPoint1: CGPointMake(493.56, 331.67) controlPoint2: CGPointMake(498.5, 349.5)];
//		
//		
//		//// FromTheNorthEast Drawing
//		UIBezierPath* fromTheNorthEastPath = [UIBezierPath bezierPath];
//		[fromTheNorthEastPath moveToPoint: CGPointMake(729.5, -2.5)];
//		[fromTheNorthEastPath addLineToPoint: CGPointMake(674, 125.5)];
//		[fromTheNorthEastPath addCurveToPoint: CGPointMake(659.5, 182.5) controlPoint1: CGPointMake(674, 125.5) controlPoint2: CGPointMake(661.5, 146)];
//		[fromTheNorthEastPath addCurveToPoint: CGPointMake(661, 240.5) controlPoint1: CGPointMake(658.18, 206.65) controlPoint2: CGPointMake(659.37, 223.68)];
//		[fromTheNorthEastPath addCurveToPoint: CGPointMake(661, 279) controlPoint1: CGPointMake(661.83, 249.1) controlPoint2: CGPointMake(664.3, 272)];
//		[fromTheNorthEastPath addCurveToPoint: CGPointMake(570, 371.5) controlPoint1: CGPointMake(651.25, 299.68) controlPoint2: CGPointMake(570, 371.5)];
//		[fromTheNorthEastPath addCurveToPoint: CGPointMake(554, 360) controlPoint1: CGPointMake(570, 371.5) controlPoint2: CGPointMake(560.22, 366.76)];
//		[fromTheNorthEastPath addCurveToPoint: CGPointMake(544.5, 344.5) controlPoint1: CGPointMake(547.79, 353.25) controlPoint2: CGPointMake(545.13, 344.47)];
//		[fromTheNorthEastPath addCurveToPoint: CGPointMake(518, 368) controlPoint1: CGPointMake(543.25, 344.55) controlPoint2: CGPointMake(518, 368)];

		
		// END COPY FROM PAINT CODE

		
		
		// copy new paths from paint code above into array
		
		pathItem = [[embBezierPathItem alloc] init];
		pathItem.pathDelay = 1.0;
		pathItem.pathColor = pathRed;
		pathItem.pathSpeed = pathSpeed;
		pathItem.pathWidth = pathWidth;
		pathItem.embPath = fromI35Path;
		[_bezierPaths addObject:pathItem];

		pathItem = [[embBezierPathItem alloc] init];
		pathItem.pathDelay = 1.0;
		pathItem.pathColor = pathBlue;
		pathItem.pathSpeed = pathSpeed;
		pathItem.pathWidth = pathWidth;
		pathItem.embPath = fromDallasNorthTollWayPath;
		[_bezierPaths addObject:pathItem];
		
		pathItem = [[embBezierPathItem alloc] init];
		pathItem.pathDelay = 1.0;
		pathItem.pathColor = pathRed;
		pathItem.pathSpeed = pathSpeed;
		pathItem.pathWidth = pathWidth;
		pathItem.embPath = fromKatyTrailPath;
		[_bezierPaths addObject:pathItem];
		

		

		
		
		pathItem = [[embBezierPathItem alloc] init];
		pathItem.pathDelay = 1.0;
		pathItem.pathColor = pathRed;
		pathItem.pathSpeed = pathSpeed;
		pathItem.pathWidth = pathWidth;
		pathItem.embPath = fromWoodallRogers1Path;
		[_bezierPaths addObject:pathItem];
		
		pathItem = [[embBezierPathItem alloc] init];
		pathItem.pathDelay = 1.0;
		pathItem.pathColor = pathRed;
		pathItem.pathSpeed = pathSpeed;
		pathItem.pathWidth = pathWidth;
		pathItem.embPath = fromWoodallRogers2Path;
		[_bezierPaths addObject:pathItem];
		
		pathItem = [[embBezierPathItem alloc] init];
		pathItem.pathDelay = 1.0;
		pathItem.pathColor = pathRed;
		pathItem.pathSpeed = pathSpeed;
		pathItem.pathWidth = pathWidth;
		pathItem.embPath = fromWoodallRogers3Path;
		[_bezierPaths addObject:pathItem];
		
		
		
		pathItem = [[embBezierPathItem alloc] init];
		pathItem.pathDelay = 1.0;
		pathItem.pathColor = pathBlue;
		pathItem.pathSpeed = pathSpeed;
		pathItem.pathWidth = pathWidth;
		pathItem.embPath = fromI30Path;
		[_bezierPaths addObject:pathItem];


	
	}
	
	return self;
}

@end
