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
		
        ////////////////////////////////CITY////////////////////////////////
        
        //// FromDallasNorthTollWay Drawing
        UIBezierPath* fromDallasNorthTollWayPath = UIBezierPath.bezierPath;
        [fromDallasNorthTollWayPath moveToPoint: CGPointMake(450.5, -0.5)];
        [fromDallasNorthTollWayPath addLineToPoint: CGPointMake(445.5, 66.5)];
        [fromDallasNorthTollWayPath addCurveToPoint: CGPointMake(437, 136) controlPoint1: CGPointMake(445.5, 66.5) controlPoint2: CGPointMake(437.07, 109.93)];
        [fromDallasNorthTollWayPath addCurveToPoint: CGPointMake(451, 224) controlPoint1: CGPointMake(436.96, 149.23) controlPoint2: CGPointMake(444.11, 187.22)];
        [fromDallasNorthTollWayPath addCurveToPoint: CGPointMake(465, 273) controlPoint1: CGPointMake(457.69, 259.7) controlPoint2: CGPointMake(461, 264)];
        [fromDallasNorthTollWayPath addCurveToPoint: CGPointMake(501, 330) controlPoint1: CGPointMake(467.16, 277.86) controlPoint2: CGPointMake(495.74, 322.37)];
        [fromDallasNorthTollWayPath addCurveToPoint: CGPointMake(523, 380) controlPoint1: CGPointMake(505.48, 336.5) controlPoint2: CGPointMake(521.5, 362.75)];
        [fromDallasNorthTollWayPath addCurveToPoint: CGPointMake(507, 399) controlPoint1: CGPointMake(524.5, 397.25) controlPoint2: CGPointMake(507, 399)];
        fromDallasNorthTollWayPath.lineCapStyle = kCGLineCapRound;
        
        //// FromWoodallRogers Drawing
        UIBezierPath* fromWoodallRogersPath = UIBezierPath.bezierPath;
        [fromWoodallRogersPath moveToPoint: CGPointMake(729.5, -2.5)];
        [fromWoodallRogersPath addCurveToPoint: CGPointMake(659, 165) controlPoint1: CGPointMake(729.5, -2.5) controlPoint2: CGPointMake(661, 153)];
        [fromWoodallRogersPath addCurveToPoint: CGPointMake(664, 288) controlPoint1: CGPointMake(657.68, 172.94) controlPoint2: CGPointMake(666, 282)];
        [fromWoodallRogersPath addCurveToPoint: CGPointMake(562, 385) controlPoint1: CGPointMake(662.72, 291.84) controlPoint2: CGPointMake(602.73, 345.99)];
        [fromWoodallRogersPath addCurveToPoint: CGPointMake(524.47, 424.59) controlPoint1: CGPointMake(539.11, 406.93) controlPoint2: CGPointMake(530.94, 416.18)];
        [fromWoodallRogersPath addCurveToPoint: CGPointMake(524, 385) controlPoint1: CGPointMake(518, 433) controlPoint2: CGPointMake(524, 393)];
        [fromWoodallRogersPath addCurveToPoint: CGPointMake(507, 388) controlPoint1: CGPointMake(524, 377) controlPoint2: CGPointMake(507, 388)];
        fromWoodallRogersPath.lineCapStyle = kCGLineCapRound;
        
        //// FromKatyTrail Drawing
        UIBezierPath* fromKatyTrailPath = UIBezierPath.bezierPath;
        [fromKatyTrailPath moveToPoint: CGPointMake(675, -4)];
        [fromKatyTrailPath addCurveToPoint: CGPointMake(629, 91) controlPoint1: CGPointMake(657, 28) controlPoint2: CGPointMake(644.95, 64.37)];
        [fromKatyTrailPath addCurveToPoint: CGPointMake(598, 133) controlPoint1: CGPointMake(621.06, 104.26) controlPoint2: CGPointMake(611, 115)];
        [fromKatyTrailPath addCurveToPoint: CGPointMake(567, 212) controlPoint1: CGPointMake(584.88, 151.16) controlPoint2: CGPointMake(573.99, 206.44)];
        [fromKatyTrailPath addCurveToPoint: CGPointMake(485.14, 269.09) controlPoint1: CGPointMake(560.33, 217.3) controlPoint2: CGPointMake(493.14, 260.3)];
        [fromKatyTrailPath addCurveToPoint: CGPointMake(475, 286) controlPoint1: CGPointMake(480.9, 273.75) controlPoint2: CGPointMake(473.29, 280.84)];
        [fromKatyTrailPath addCurveToPoint: CGPointMake(520, 366) controlPoint1: CGPointMake(481.06, 304.29) controlPoint2: CGPointMake(512, 346)];
        [fromKatyTrailPath addCurveToPoint: CGPointMake(523, 393) controlPoint1: CGPointMake(522, 371) controlPoint2: CGPointMake(523, 385)];
        [fromKatyTrailPath addCurveToPoint: CGPointMake(507, 399) controlPoint1: CGPointMake(523, 401) controlPoint2: CGPointMake(507, 399)];
        fromKatyTrailPath.lineCapStyle = kCGLineCapRound;
        
        //// FromI35_1 Drawing
        UIBezierPath* fromI35_1Path = UIBezierPath.bezierPath;
        [fromI35_1Path moveToPoint: CGPointMake(-3, 78)];
        [fromI35_1Path addCurveToPoint: CGPointMake(48, 118) controlPoint1: CGPointMake(-3, 78) controlPoint2: CGPointMake(15, 113)];
        [fromI35_1Path addCurveToPoint: CGPointMake(132, 125) controlPoint1: CGPointMake(75.81, 122.21) controlPoint2: CGPointMake(97.47, 122.99)];
        [fromI35_1Path addCurveToPoint: CGPointMake(262, 195) controlPoint1: CGPointMake(174.27, 127.46) controlPoint2: CGPointMake(224.07, 174.41)];
        [fromI35_1Path addCurveToPoint: CGPointMake(382, 236) controlPoint1: CGPointMake(316.5, 224.59) controlPoint2: CGPointMake(372.11, 232.7)];
        [fromI35_1Path addCurveToPoint: CGPointMake(452, 282) controlPoint1: CGPointMake(394.19, 240.06) controlPoint2: CGPointMake(439.29, 267.94)];
        [fromI35_1Path addCurveToPoint: CGPointMake(502, 338) controlPoint1: CGPointMake(455.26, 285.61) controlPoint2: CGPointMake(483.66, 311.47)];
        [fromI35_1Path addCurveToPoint: CGPointMake(518, 386) controlPoint1: CGPointMake(517.73, 360.76) controlPoint2: CGPointMake(516.75, 370.75)];
        [fromI35_1Path addCurveToPoint: CGPointMake(507, 402) controlPoint1: CGPointMake(519.25, 401.25) controlPoint2: CGPointMake(507, 402)];
        fromI35_1Path.lineCapStyle = kCGLineCapRound;
        
        //// FromI35_2 Drawing
        UIBezierPath* fromI35_2Path = UIBezierPath.bezierPath;
        [fromI35_2Path moveToPoint: CGPointMake(-3, 78)];
        [fromI35_2Path addCurveToPoint: CGPointMake(48, 118) controlPoint1: CGPointMake(-3, 78) controlPoint2: CGPointMake(15, 113)];
        [fromI35_2Path addCurveToPoint: CGPointMake(132, 125) controlPoint1: CGPointMake(75.81, 122.21) controlPoint2: CGPointMake(97.47, 122.99)];
        [fromI35_2Path addCurveToPoint: CGPointMake(262, 195) controlPoint1: CGPointMake(174.27, 127.46) controlPoint2: CGPointMake(224.07, 174.41)];
        [fromI35_2Path addCurveToPoint: CGPointMake(382, 236) controlPoint1: CGPointMake(316.5, 224.59) controlPoint2: CGPointMake(372.11, 232.7)];
        [fromI35_2Path addCurveToPoint: CGPointMake(463, 293) controlPoint1: CGPointMake(394.19, 240.06) controlPoint2: CGPointMake(443.53, 269.64)];
        [fromI35_2Path addCurveToPoint: CGPointMake(490, 399) controlPoint1: CGPointMake(466.42, 297.1) controlPoint2: CGPointMake(482.26, 358.67)];
        [fromI35_2Path addCurveToPoint: CGPointMake(493, 429) controlPoint1: CGPointMake(493.58, 417.67) controlPoint2: CGPointMake(491, 424)];
        [fromI35_2Path addCurveToPoint: CGPointMake(510, 429) controlPoint1: CGPointMake(495, 434) controlPoint2: CGPointMake(503.25, 431.5)];
        [fromI35_2Path addCurveToPoint: CGPointMake(522, 410) controlPoint1: CGPointMake(512.87, 427.94) controlPoint2: CGPointMake(519.54, 418.99)];
        [fromI35_2Path addCurveToPoint: CGPointMake(522, 388) controlPoint1: CGPointMake(525.31, 397.87) controlPoint2: CGPointMake(525, 392.25)];
        [fromI35_2Path addCurveToPoint: CGPointMake(510, 393) controlPoint1: CGPointMake(519, 383.75) controlPoint2: CGPointMake(510, 393)];
        fromI35_2Path.lineCapStyle = kCGLineCapRound;
        
        //// FromI30 Drawing
        UIBezierPath* fromI30Path = UIBezierPath.bezierPath;
        [fromI30Path moveToPoint: CGPointMake(-0.5, 596.5)];
        [fromI30Path addCurveToPoint: CGPointMake(76, 603) controlPoint1: CGPointMake(-0.5, 596.5) controlPoint2: CGPointMake(41, 594)];
        [fromI30Path addCurveToPoint: CGPointMake(194, 633) controlPoint1: CGPointMake(111, 612) controlPoint2: CGPointMake(148, 640)];
        [fromI30Path addCurveToPoint: CGPointMake(289, 596.5) controlPoint1: CGPointMake(240, 626) controlPoint2: CGPointMake(230.9, 606.12)];
        [fromI30Path addCurveToPoint: CGPointMake(439.5, 567.5) controlPoint1: CGPointMake(347.1, 586.88) controlPoint2: CGPointMake(383.75, 580.28)];
        [fromI30Path addCurveToPoint: CGPointMake(484.29, 548.73) controlPoint1: CGPointMake(462.35, 562.26) controlPoint2: CGPointMake(476.07, 555.65)];
        [fromI30Path addCurveToPoint: CGPointMake(496.5, 520) controlPoint1: CGPointMake(496.13, 538.76) controlPoint2: CGPointMake(496.59, 528.14)];
        [fromI30Path addCurveToPoint: CGPointMake(493, 460) controlPoint1: CGPointMake(496.49, 518.59) controlPoint2: CGPointMake(494.88, 484.86)];
        [fromI30Path addCurveToPoint: CGPointMake(497, 431) controlPoint1: CGPointMake(491.86, 444.97) controlPoint2: CGPointMake(490.59, 429.87)];
        [fromI30Path addCurveToPoint: CGPointMake(521, 420) controlPoint1: CGPointMake(514, 434) controlPoint2: CGPointMake(521, 420)];
        [fromI30Path addCurveToPoint: CGPointMake(523, 380) controlPoint1: CGPointMake(521, 420) controlPoint2: CGPointMake(524, 385)];
        [fromI30Path addCurveToPoint: CGPointMake(507, 388) controlPoint1: CGPointMake(522, 375) controlPoint2: CGPointMake(507, 388)];
        fromI30Path.lineCapStyle = kCGLineCapRound;
        
        ////////////////////////////////NEIGHIBORHOOD////////////////////////////////
        
        //// Neighborhood_tollway Drawing
        UIBezierPath* neighborhood_tollwayPath = UIBezierPath.bezierPath;
        [neighborhood_tollwayPath moveToPoint: CGPointMake(368.5, 0.5)];
        [neighborhood_tollwayPath addCurveToPoint: CGPointMake(388, 83) controlPoint1: CGPointMake(370.37, 9.84) controlPoint2: CGPointMake(377.02, 46.99)];
        [neighborhood_tollwayPath addCurveToPoint: CGPointMake(411.5, 163.5) controlPoint1: CGPointMake(400.53, 124.1) controlPoint2: CGPointMake(411.5, 163.5)];
        [neighborhood_tollwayPath addCurveToPoint: CGPointMake(421.5, 208.5) controlPoint1: CGPointMake(411.5, 163.5) controlPoint2: CGPointMake(418, 190)];
        [neighborhood_tollwayPath addCurveToPoint: CGPointMake(425, 254) controlPoint1: CGPointMake(425, 227) controlPoint2: CGPointMake(421.5, 224.5)];
        [neighborhood_tollwayPath addCurveToPoint: CGPointMake(452, 372) controlPoint1: CGPointMake(427.02, 271.04) controlPoint2: CGPointMake(439.5, 326.55)];
        [neighborhood_tollwayPath addCurveToPoint: CGPointMake(470, 443) controlPoint1: CGPointMake(461.14, 405.22) controlPoint2: CGPointMake(463, 403)];
        [neighborhood_tollwayPath addCurveToPoint: CGPointMake(476, 525) controlPoint1: CGPointMake(477, 483) controlPoint2: CGPointMake(473, 510)];
        [neighborhood_tollwayPath addCurveToPoint: CGPointMake(518, 521) controlPoint1: CGPointMake(477.26, 531.28) controlPoint2: CGPointMake(501.26, 528.87)];
        [neighborhood_tollwayPath addCurveToPoint: CGPointMake(547, 474) controlPoint1: CGPointMake(541.22, 510.08) controlPoint2: CGPointMake(545, 499)];
        [neighborhood_tollwayPath addCurveToPoint: CGPointMake(547, 423) controlPoint1: CGPointMake(549, 449) controlPoint2: CGPointMake(547, 423)];
        
        //// Neighborhood_Wooddall Drawing
        UIBezierPath* neighborhood_WooddallPath = UIBezierPath.bezierPath;
        [neighborhood_WooddallPath moveToPoint: CGPointMake(874, 16)];
        [neighborhood_WooddallPath addCurveToPoint: CGPointMake(881, 208) controlPoint1: CGPointMake(878, 76) controlPoint2: CGPointMake(881, 208)];
        [neighborhood_WooddallPath addLineToPoint: CGPointMake(851, 233)];
        [neighborhood_WooddallPath addLineToPoint: CGPointMake(670, 400)];
        [neighborhood_WooddallPath addLineToPoint: CGPointMake(578, 488)];
        [neighborhood_WooddallPath addLineToPoint: CGPointMake(567, 500)];
        [neighborhood_WooddallPath addLineToPoint: CGPointMake(562, 506)];
        [neighborhood_WooddallPath addLineToPoint: CGPointMake(555, 516)];
        [neighborhood_WooddallPath addLineToPoint: CGPointMake(544, 526)];
        [neighborhood_WooddallPath addLineToPoint: CGPointMake(544, 488)];
        [neighborhood_WooddallPath addLineToPoint: CGPointMake(544, 466)];
        [neighborhood_WooddallPath addLineToPoint: CGPointMake(544, 426)];
        [neighborhood_WooddallPath addLineToPoint: CGPointMake(544, 400)];
        [neighborhood_WooddallPath addLineToPoint: CGPointMake(540, 385)];

        //// Neighborhood_KatyRail Drawing
        UIBezierPath* neighborhood_KatyRailPath = UIBezierPath.bezierPath;
        [neighborhood_KatyRailPath moveToPoint: CGPointMake(646, 16)];
        [neighborhood_KatyRailPath addCurveToPoint: CGPointMake(620, 42) controlPoint1: CGPointMake(637.63, 25.01) controlPoint2: CGPointMake(628.34, 35.33)];
        [neighborhood_KatyRailPath addCurveToPoint: CGPointMake(538, 89) controlPoint1: CGPointMake(602.42, 56.06) controlPoint2: CGPointMake(538, 89)];
        [neighborhood_KatyRailPath addLineToPoint: CGPointMake(509, 108)];
        [neighborhood_KatyRailPath addLineToPoint: CGPointMake(460, 142)];
        [neighborhood_KatyRailPath addLineToPoint: CGPointMake(447, 155)];
        [neighborhood_KatyRailPath addCurveToPoint: CGPointMake(440, 169) controlPoint1: CGPointMake(447, 155) controlPoint2: CGPointMake(440, 168)];
        [neighborhood_KatyRailPath addCurveToPoint: CGPointMake(437, 184) controlPoint1: CGPointMake(440, 170) controlPoint2: CGPointMake(437, 183)];
        [neighborhood_KatyRailPath addCurveToPoint: CGPointMake(437, 206) controlPoint1: CGPointMake(437, 185) controlPoint2: CGPointMake(437, 206)];
        [neighborhood_KatyRailPath addLineToPoint: CGPointMake(440, 215)];
        [neighborhood_KatyRailPath addLineToPoint: CGPointMake(447, 229)];
        [neighborhood_KatyRailPath addLineToPoint: CGPointMake(460, 248)];
        [neighborhood_KatyRailPath addLineToPoint: CGPointMake(485, 283)];
        [neighborhood_KatyRailPath addLineToPoint: CGPointMake(509, 318)];
        [neighborhood_KatyRailPath addLineToPoint: CGPointMake(533, 364)];
        [neighborhood_KatyRailPath addLineToPoint: CGPointMake(538, 379)];
        
        UIBezierPath* neighborhood_I35Path = UIBezierPath.bezierPath;
        [neighborhood_I35Path moveToPoint: CGPointMake(0, 16)];
        [neighborhood_I35Path addCurveToPoint: CGPointMake(49, 32) controlPoint1: CGPointMake(36.5, 27.5) controlPoint2: CGPointMake(49, 32)];
        [neighborhood_I35Path addLineToPoint: CGPointMake(124, 53)];
        [neighborhood_I35Path addLineToPoint: CGPointMake(176, 65)];
        [neighborhood_I35Path addLineToPoint: CGPointMake(197, 69)];
        [neighborhood_I35Path addLineToPoint: CGPointMake(205, 71)];
        [neighborhood_I35Path addLineToPoint: CGPointMake(213, 74)];
        [neighborhood_I35Path addLineToPoint: CGPointMake(248, 92)];
        [neighborhood_I35Path addLineToPoint: CGPointMake(275, 107)];
        [neighborhood_I35Path addLineToPoint: CGPointMake(367, 171)];
        [neighborhood_I35Path addLineToPoint: CGPointMake(382, 184)];
        [neighborhood_I35Path addLineToPoint: CGPointMake(395, 199)];
        [neighborhood_I35Path addLineToPoint: CGPointMake(409, 224)];
        [neighborhood_I35Path addLineToPoint: CGPointMake(421, 258)];
        [neighborhood_I35Path addLineToPoint: CGPointMake(435, 318)];
        [neighborhood_I35Path addLineToPoint: CGPointMake(457, 408)];
        
        UIBezierPath* neighhorhood_I30Path = UIBezierPath.bezierPath;
        [neighhorhood_I30Path moveToPoint: CGPointMake(476, 784)];
        [neighhorhood_I30Path addCurveToPoint: CGPointMake(479.45, 774.37) controlPoint1: CGPointMake(477.41, 780.2) controlPoint2: CGPointMake(478.81, 776.97)];
        [neighhorhood_I30Path addCurveToPoint: CGPointMake(485, 755) controlPoint1: CGPointMake(480.76, 769.05) controlPoint2: CGPointMake(483.66, 761.13)];
        [neighhorhood_I30Path addCurveToPoint: CGPointMake(482, 700) controlPoint1: CGPointMake(485.75, 751.55) controlPoint2: CGPointMake(483.96, 722.94)];
        [neighhorhood_I30Path addCurveToPoint: CGPointMake(479, 668) controlPoint1: CGPointMake(480.66, 684.23) controlPoint2: CGPointMake(479, 668)];
        [neighhorhood_I30Path addLineToPoint: CGPointMake(476, 561)];
        [neighhorhood_I30Path addLineToPoint: CGPointMake(474, 495)];
        [neighhorhood_I30Path addLineToPoint: CGPointMake(472, 468)];
        [neighhorhood_I30Path addLineToPoint: CGPointMake(469, 449)];
        [neighhorhood_I30Path addLineToPoint: CGPointMake(455, 397)];

		// END COPY FROM PAINT CODE

		
		
		// copy new paths from paint code above into array
		//CITY LEVEL
		pathItem = [[embBezierPathItem alloc] init];
		pathItem.pathDelay = 1.0;
		pathItem.pathColor = pathRed;
		pathItem.pathSpeed = pathSpeed;
		pathItem.pathWidth = pathWidth;
		pathItem.embPath = fromDallasNorthTollWayPath;
		[_bezierPaths addObject:pathItem];

		pathItem = [[embBezierPathItem alloc] init];
		pathItem.pathDelay = 1.0;
		pathItem.pathColor = pathBlue;
		pathItem.pathSpeed = pathSpeed;
		pathItem.pathWidth = pathWidth;
		pathItem.embPath = fromWoodallRogersPath;
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
		pathItem.embPath = fromI35_1Path;
		[_bezierPaths addObject:pathItem];
        
        pathItem = [[embBezierPathItem alloc] init];
		pathItem.pathDelay = 1.0;
		pathItem.pathColor = pathRed;
		pathItem.pathSpeed = pathSpeed;
		pathItem.pathWidth = pathWidth;
		pathItem.embPath = fromI35_2Path;
		[_bezierPaths addObject:pathItem];
		
		pathItem = [[embBezierPathItem alloc] init];
		pathItem.pathDelay = 1.0;
		pathItem.pathColor = pathBlue;
		pathItem.pathSpeed = pathSpeed;
		pathItem.pathWidth = pathWidth;
		pathItem.embPath = fromI30Path;
		[_bezierPaths addObject:pathItem];
        
        //Neighiborhood Level
        
        pathItem = [[embBezierPathItem alloc] init];
		pathItem.pathDelay = 1.0;
		pathItem.pathColor = pathBlue;
		pathItem.pathSpeed = pathSpeed;
		pathItem.pathWidth = pathWidth;
		pathItem.embPath = neighborhood_tollwayPath;
		[_bezierPaths addObject:pathItem];
        
        pathItem = [[embBezierPathItem alloc] init];
		pathItem.pathDelay = 1.0;
		pathItem.pathColor = pathBlue;
		pathItem.pathSpeed = pathSpeed;
		pathItem.pathWidth = pathWidth;
		pathItem.embPath = neighborhood_WooddallPath;
		[_bezierPaths addObject:pathItem];
        
        pathItem = [[embBezierPathItem alloc] init];
		pathItem.pathDelay = 1.0;
		pathItem.pathColor = pathBlue;
		pathItem.pathSpeed = pathSpeed;
		pathItem.pathWidth = pathWidth;
		pathItem.embPath = neighborhood_KatyRailPath;
		[_bezierPaths addObject:pathItem];
        
        pathItem = [[embBezierPathItem alloc] init];
		pathItem.pathDelay = 1.0;
		pathItem.pathColor = pathBlue;
		pathItem.pathSpeed = pathSpeed;
		pathItem.pathWidth = pathWidth;
		pathItem.embPath = neighborhood_I35Path;
		[_bezierPaths addObject:pathItem];
        
        pathItem = [[embBezierPathItem alloc] init];
		pathItem.pathDelay = 1.0;
		pathItem.pathColor = pathBlue;
		pathItem.pathSpeed = pathSpeed;
		pathItem.pathWidth = pathWidth;
		pathItem.embPath = neighhorhood_I30Path;
		[_bezierPaths addObject:pathItem];

        //NEIGHBORHOOD LEVEL
	
	}
	
	return self;
}

@end
