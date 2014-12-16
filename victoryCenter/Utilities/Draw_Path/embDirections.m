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
        [fromDallasNorthTollWayPath addCurveToPoint: CGPointMake(523, 395) controlPoint1: CGPointMake(505.48, 336.5) controlPoint2: CGPointMake(521.5, 377.75)];
        [fromDallasNorthTollWayPath addCurveToPoint: CGPointMake(506, 399) controlPoint1: CGPointMake(523.62, 402.13) controlPoint2: CGPointMake(506, 399)];
        fromDallasNorthTollWayPath.lineCapStyle = kCGLineCapRound;
        
        //// FromWoodallRogers Drawing
        UIBezierPath* fromWoodallRogersPath = UIBezierPath.bezierPath;
        [fromWoodallRogersPath moveToPoint: CGPointMake(729.5, -2.5)];
        [fromWoodallRogersPath addCurveToPoint: CGPointMake(659, 165) controlPoint1: CGPointMake(729.5, -2.5) controlPoint2: CGPointMake(661, 153)];
        [fromWoodallRogersPath addCurveToPoint: CGPointMake(664, 288) controlPoint1: CGPointMake(657.68, 172.94) controlPoint2: CGPointMake(666, 282)];
        [fromWoodallRogersPath addCurveToPoint: CGPointMake(562, 385) controlPoint1: CGPointMake(662.72, 291.84) controlPoint2: CGPointMake(602.73, 345.99)];
        [fromWoodallRogersPath addCurveToPoint: CGPointMake(524.47, 424.59) controlPoint1: CGPointMake(539.11, 406.93) controlPoint2: CGPointMake(530.94, 416.18)];
        [fromWoodallRogersPath addCurveToPoint: CGPointMake(523, 401) controlPoint1: CGPointMake(518, 433) controlPoint2: CGPointMake(523, 409)];
        [fromWoodallRogersPath addCurveToPoint: CGPointMake(514, 398) controlPoint1: CGPointMake(523, 397.84) controlPoint2: CGPointMake(517.21, 397.27)];
        [fromWoodallRogersPath addCurveToPoint: CGPointMake(506, 399) controlPoint1: CGPointMake(509.08, 399.12) controlPoint2: CGPointMake(506, 399)];
        fromWoodallRogersPath.lineCapStyle = kCGLineCapRound;
        
        //// FromKatyTrail Drawing
        UIBezierPath* fromKatyTrailPath = UIBezierPath.bezierPath;
        [fromKatyTrailPath moveToPoint: CGPointMake(675, -4)];
        [fromKatyTrailPath addCurveToPoint: CGPointMake(629, 91) controlPoint1: CGPointMake(657, 28) controlPoint2: CGPointMake(644.95, 64.37)];
        [fromKatyTrailPath addCurveToPoint: CGPointMake(598, 133) controlPoint1: CGPointMake(621.06, 104.26) controlPoint2: CGPointMake(611, 115)];
        [fromKatyTrailPath addCurveToPoint: CGPointMake(567, 212) controlPoint1: CGPointMake(584.88, 151.16) controlPoint2: CGPointMake(573.99, 206.44)];
        [fromKatyTrailPath addCurveToPoint: CGPointMake(485.14, 269.09) controlPoint1: CGPointMake(560.33, 217.3) controlPoint2: CGPointMake(493.14, 260.3)];
        [fromKatyTrailPath addCurveToPoint: CGPointMake(475, 286) controlPoint1: CGPointMake(480.9, 273.75) controlPoint2: CGPointMake(473.29, 280.84)];
        [fromKatyTrailPath addCurveToPoint: CGPointMake(519, 364) controlPoint1: CGPointMake(481.06, 304.29) controlPoint2: CGPointMake(511, 344)];
        [fromKatyTrailPath addCurveToPoint: CGPointMake(523, 395) controlPoint1: CGPointMake(521, 369) controlPoint2: CGPointMake(523, 387)];
        [fromKatyTrailPath addCurveToPoint: CGPointMake(504, 399) controlPoint1: CGPointMake(523, 403) controlPoint2: CGPointMake(504, 399)];
        fromKatyTrailPath.lineCapStyle = kCGLineCapRound;
        
        //// FromI35_1 Drawing
        UIBezierPath* fromI35_1Path = UIBezierPath.bezierPath;
        [fromI35_1Path moveToPoint: CGPointMake(-3, 78)];
        [fromI35_1Path addCurveToPoint: CGPointMake(48, 118) controlPoint1: CGPointMake(-3, 78) controlPoint2: CGPointMake(15, 113)];
        [fromI35_1Path addCurveToPoint: CGPointMake(132, 125) controlPoint1: CGPointMake(75.81, 122.21) controlPoint2: CGPointMake(97.47, 122.99)];
        [fromI35_1Path addCurveToPoint: CGPointMake(262, 195) controlPoint1: CGPointMake(174.27, 127.46) controlPoint2: CGPointMake(224.07, 174.41)];
        [fromI35_1Path addCurveToPoint: CGPointMake(382, 236) controlPoint1: CGPointMake(316.5, 224.59) controlPoint2: CGPointMake(372.11, 232.7)];
        [fromI35_1Path addCurveToPoint: CGPointMake(452, 282) controlPoint1: CGPointMake(394.19, 240.06) controlPoint2: CGPointMake(439.29, 267.94)];
        [fromI35_1Path addCurveToPoint: CGPointMake(507, 336) controlPoint1: CGPointMake(455.26, 285.61) controlPoint2: CGPointMake(488.66, 309.47)];
        [fromI35_1Path addCurveToPoint: CGPointMake(523, 395) controlPoint1: CGPointMake(522.73, 358.76) controlPoint2: CGPointMake(521.75, 379.75)];
        [fromI35_1Path addCurveToPoint: CGPointMake(504, 399) controlPoint1: CGPointMake(523.54, 401.63) controlPoint2: CGPointMake(504, 399)];
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
        [fromI35_2Path addCurveToPoint: CGPointMake(493, 432) controlPoint1: CGPointMake(493.58, 417.67) controlPoint2: CGPointMake(491, 427)];
        [fromI35_2Path addCurveToPoint: CGPointMake(520, 423) controlPoint1: CGPointMake(495, 437) controlPoint2: CGPointMake(513.25, 425.5)];
        [fromI35_2Path addCurveToPoint: CGPointMake(522, 404) controlPoint1: CGPointMake(522.87, 421.94) controlPoint2: CGPointMake(521, 413)];
        [fromI35_2Path addCurveToPoint: CGPointMake(517, 399) controlPoint1: CGPointMake(522.6, 398.58) controlPoint2: CGPointMake(520.8, 399.09)];
        [fromI35_2Path addCurveToPoint: CGPointMake(506, 399) controlPoint1: CGPointMake(512.28, 398.89) controlPoint2: CGPointMake(506, 399)];
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
        [fromI30Path addCurveToPoint: CGPointMake(523, 401) controlPoint1: CGPointMake(521, 420) controlPoint2: CGPointMake(524, 406)];
        [fromI30Path addCurveToPoint: CGPointMake(506, 399) controlPoint1: CGPointMake(522, 396) controlPoint2: CGPointMake(506, 399)];
        fromI30Path.lineCapStyle = kCGLineCapRound;
        
        ////////////////////////////////NEIGHIBORHOOD////////////////////////////////
        
        //// Neighborhood_tollway Drawing
        UIBezierPath* neighborhood_tollwayPath = UIBezierPath.bezierPath;
        [neighborhood_tollwayPath moveToPoint: CGPointMake(368.5, 0.5)];
        [neighborhood_tollwayPath addCurveToPoint: CGPointMake(388, 83) controlPoint1: CGPointMake(370.37, 9.84) controlPoint2: CGPointMake(377.02, 46.99)];
        [neighborhood_tollwayPath addCurveToPoint: CGPointMake(414, 171) controlPoint1: CGPointMake(400.53, 124.1) controlPoint2: CGPointMake(402, 147)];
        [neighborhood_tollwayPath addCurveToPoint: CGPointMake(468, 243) controlPoint1: CGPointMake(426, 195) controlPoint2: CGPointMake(456.01, 228.61)];
        [neighborhood_tollwayPath addCurveToPoint: CGPointMake(533, 344) controlPoint1: CGPointMake(488, 267) controlPoint2: CGPointMake(529.25, 337.12)];
        [neighborhood_tollwayPath addCurveToPoint: CGPointMake(547, 443) controlPoint1: CGPointMake(539, 355) controlPoint2: CGPointMake(553, 435)];
        [neighborhood_tollwayPath addCurveToPoint: CGPointMake(497.5, 447) controlPoint1: CGPointMake(541, 451) controlPoint2: CGPointMake(497.5, 447)];
        neighborhood_tollwayPath.lineCapStyle = kCGLineCapRound;
        
        //// Neighborhood_Wooddall Drawing
        UIBezierPath* neighborhood_WooddallPath = UIBezierPath.bezierPath;
        [neighborhood_WooddallPath moveToPoint: CGPointMake(874, 1)];
        [neighborhood_WooddallPath addCurveToPoint: CGPointMake(882, 185) controlPoint1: CGPointMake(878, 61) controlPoint2: CGPointMake(884, 167)];
        [neighborhood_WooddallPath addCurveToPoint: CGPointMake(790, 272) controlPoint1: CGPointMake(881.11, 193.01) controlPoint2: CGPointMake(836.42, 229.54)];
        [neighborhood_WooddallPath addCurveToPoint: CGPointMake(578, 473) controlPoint1: CGPointMake(732.08, 324.98) controlPoint2: CGPointMake(601, 449)];
        [neighborhood_WooddallPath addCurveToPoint: CGPointMake(544, 511) controlPoint1: CGPointMake(555, 497) controlPoint2: CGPointMake(546.75, 518)];
        [neighborhood_WooddallPath addCurveToPoint: CGPointMake(547, 457) controlPoint1: CGPointMake(541.25, 504) controlPoint2: CGPointMake(546, 479)];
        [neighborhood_WooddallPath addCurveToPoint: CGPointMake(498, 447) controlPoint1: CGPointMake(548, 435) controlPoint2: CGPointMake(498, 447)];
        neighborhood_WooddallPath.lineCapStyle = kCGLineCapRound;

        //// Neighborhood_KatyRail Drawing
        UIBezierPath* neighborhood_KatyRailPath = UIBezierPath.bezierPath;
        [neighborhood_KatyRailPath moveToPoint: CGPointMake(644, -2)];
        [neighborhood_KatyRailPath addCurveToPoint: CGPointMake(616, 28) controlPoint1: CGPointMake(641.94, 0.22) controlPoint2: CGPointMake(637, 14)];
        [neighborhood_KatyRailPath addCurveToPoint: CGPointMake(457, 126) controlPoint1: CGPointMake(574.52, 55.66) controlPoint2: CGPointMake(494.91, 94.42)];
        [neighborhood_KatyRailPath addCurveToPoint: CGPointMake(436, 186) controlPoint1: CGPointMake(447.39, 134.01) controlPoint2: CGPointMake(436, 164.78)];
        [neighborhood_KatyRailPath addCurveToPoint: CGPointMake(536, 357) controlPoint1: CGPointMake(436, 204.37) controlPoint2: CGPointMake(521, 308)];
        [neighborhood_KatyRailPath addCurveToPoint: CGPointMake(546, 445) controlPoint1: CGPointMake(541.41, 374.69) controlPoint2: CGPointMake(554, 438)];
        [neighborhood_KatyRailPath addCurveToPoint: CGPointMake(527, 445) controlPoint1: CGPointMake(542.92, 447.69) controlPoint2: CGPointMake(535.45, 444.89)];
        [neighborhood_KatyRailPath addCurveToPoint: CGPointMake(498, 447) controlPoint1: CGPointMake(513.48, 445.18) controlPoint2: CGPointMake(498, 447)];
        neighborhood_KatyRailPath.lineCapStyle = kCGLineCapRound;
        
        //// Neighborhood_I35_1 Drawing
        UIBezierPath* neighborhood_I35_1Path = UIBezierPath.bezierPath;
        [neighborhood_I35_1Path moveToPoint: CGPointMake(0, 1)];
        [neighborhood_I35_1Path addCurveToPoint: CGPointMake(105, 32) controlPoint1: CGPointMake(22.02, 7.94) controlPoint2: CGPointMake(59.39, 21.26)];
        [neighborhood_I35_1Path addCurveToPoint: CGPointMake(214, 60) controlPoint1: CGPointMake(134.99, 39.06) controlPoint2: CGPointMake(178.3, 44.93)];
        [neighborhood_I35_1Path addCurveToPoint: CGPointMake(396, 185) controlPoint1: CGPointMake(304, 98) controlPoint2: CGPointMake(381, 163)];
        [neighborhood_I35_1Path addCurveToPoint: CGPointMake(427, 268) controlPoint1: CGPointMake(402.18, 194.06) controlPoint2: CGPointMake(416.59, 229.29)];
        [neighborhood_I35_1Path addCurveToPoint: CGPointMake(457, 393) controlPoint1: CGPointMake(441.86, 323.24) controlPoint2: CGPointMake(452.88, 385.94)];
        [neighborhood_I35_1Path addCurveToPoint: CGPointMake(537, 369) controlPoint1: CGPointMake(464, 405) controlPoint2: CGPointMake(530, 368)];
        [neighborhood_I35_1Path addCurveToPoint: CGPointMake(547, 443) controlPoint1: CGPointMake(544, 370) controlPoint2: CGPointMake(548, 435)];
        [neighborhood_I35_1Path addCurveToPoint: CGPointMake(524, 445) controlPoint1: CGPointMake(546.53, 446.74) controlPoint2: CGPointMake(535.31, 444.87)];
        [neighborhood_I35_1Path addCurveToPoint: CGPointMake(498, 447) controlPoint1: CGPointMake(511.13, 445.15) controlPoint2: CGPointMake(498, 447)];
        neighborhood_I35_1Path.lineCapStyle = kCGLineCapRound;
        
        //// Neighborhood_I35_2 Drawing
        UIBezierPath* neighborhood_I35_2Path = UIBezierPath.bezierPath;
        [neighborhood_I35_2Path moveToPoint: CGPointMake(0, 1)];
        [neighborhood_I35_2Path addCurveToPoint: CGPointMake(105, 32) controlPoint1: CGPointMake(22.02, 7.94) controlPoint2: CGPointMake(59.39, 21.26)];
        [neighborhood_I35_2Path addCurveToPoint: CGPointMake(214, 60) controlPoint1: CGPointMake(134.99, 39.06) controlPoint2: CGPointMake(178.3, 44.93)];
        [neighborhood_I35_2Path addCurveToPoint: CGPointMake(396, 185) controlPoint1: CGPointMake(304, 98) controlPoint2: CGPointMake(381, 163)];
        [neighborhood_I35_2Path addCurveToPoint: CGPointMake(427, 268) controlPoint1: CGPointMake(402.18, 194.06) controlPoint2: CGPointMake(416.59, 229.29)];
        [neighborhood_I35_2Path addCurveToPoint: CGPointMake(469, 434) controlPoint1: CGPointMake(435.6, 299.97) controlPoint2: CGPointMake(451.14, 374.92)];
        [neighborhood_I35_2Path addCurveToPoint: CGPointMake(477, 491) controlPoint1: CGPointMake(482, 477) controlPoint2: CGPointMake(468, 491)];
        [neighborhood_I35_2Path addCurveToPoint: CGPointMake(544, 482) controlPoint1: CGPointMake(513, 491) controlPoint2: CGPointMake(539, 483)];
        [neighborhood_I35_2Path addCurveToPoint: CGPointMake(544, 450) controlPoint1: CGPointMake(549, 481) controlPoint2: CGPointMake(546, 458)];
        [neighborhood_I35_2Path addCurveToPoint: CGPointMake(498, 447) controlPoint1: CGPointMake(542, 442) controlPoint2: CGPointMake(498, 447)];
        neighborhood_I35_2Path.lineCapStyle = kCGLineCapRound;
        
        //// Neighhorhood_I30 Drawing
        UIBezierPath* neighhorhood_I30Path = UIBezierPath.bezierPath;
        [neighhorhood_I30Path moveToPoint: CGPointMake(476, 769)];
        [neighhorhood_I30Path addCurveToPoint: CGPointMake(479.45, 759.37) controlPoint1: CGPointMake(477.41, 765.2) controlPoint2: CGPointMake(478.81, 761.97)];
        [neighhorhood_I30Path addCurveToPoint: CGPointMake(485, 732) controlPoint1: CGPointMake(480.76, 754.05) controlPoint2: CGPointMake(481.45, 751.53)];
        [neighhorhood_I30Path addCurveToPoint: CGPointMake(482, 685) controlPoint1: CGPointMake(487, 721) controlPoint2: CGPointMake(483.96, 707.94)];
        [neighhorhood_I30Path addCurveToPoint: CGPointMake(476, 527) controlPoint1: CGPointMake(481.03, 673.61) controlPoint2: CGPointMake(474, 525)];
        [neighhorhood_I30Path addCurveToPoint: CGPointMake(509, 522) controlPoint1: CGPointMake(476.97, 527.97) controlPoint2: CGPointMake(492.77, 526.1)];
        [neighhorhood_I30Path addCurveToPoint: CGPointMake(544, 499) controlPoint1: CGPointMake(526.27, 517.64) controlPoint2: CGPointMake(539, 506)];
        [neighhorhood_I30Path addCurveToPoint: CGPointMake(546, 449) controlPoint1: CGPointMake(549, 492) controlPoint2: CGPointMake(548, 457)];
        [neighhorhood_I30Path addCurveToPoint: CGPointMake(498, 447) controlPoint1: CGPointMake(544, 441) controlPoint2: CGPointMake(498, 447)];
        neighhorhood_I30Path.lineCapStyle = kCGLineCapRound;
        
        
        
        
        ////////To Airport //////////
        //// City_To_AirPort Drawing
        UIBezierPath* city_To_AirPortPath = UIBezierPath.bezierPath;
        [city_To_AirPortPath moveToPoint: CGPointMake(506, 399)];
        [city_To_AirPortPath addCurveToPoint: CGPointMake(517, 399) controlPoint1: CGPointMake(506, 399) controlPoint2: CGPointMake(512.28, 398.89)];
        [city_To_AirPortPath addCurveToPoint: CGPointMake(522, 404) controlPoint1: CGPointMake(520.8, 399.09) controlPoint2: CGPointMake(522.6, 398.58)];
        [city_To_AirPortPath addCurveToPoint: CGPointMake(520, 423) controlPoint1: CGPointMake(521, 413) controlPoint2: CGPointMake(522.87, 421.94)];
        [city_To_AirPortPath addCurveToPoint: CGPointMake(493, 432) controlPoint1: CGPointMake(513.25, 425.5) controlPoint2: CGPointMake(495, 437)];
        [city_To_AirPortPath addCurveToPoint: CGPointMake(490, 399) controlPoint1: CGPointMake(491, 427) controlPoint2: CGPointMake(493.58, 417.67)];
        [city_To_AirPortPath addCurveToPoint: CGPointMake(463, 293) controlPoint1: CGPointMake(482.26, 358.67) controlPoint2: CGPointMake(466.42, 297.1)];
        [city_To_AirPortPath addCurveToPoint: CGPointMake(382, 236) controlPoint1: CGPointMake(443.53, 269.64) controlPoint2: CGPointMake(394.19, 240.06)];
        [city_To_AirPortPath addCurveToPoint: CGPointMake(262, 195) controlPoint1: CGPointMake(372.11, 232.7) controlPoint2: CGPointMake(316.5, 224.59)];
        [city_To_AirPortPath addCurveToPoint: CGPointMake(132, 125) controlPoint1: CGPointMake(224.07, 174.41) controlPoint2: CGPointMake(174.27, 127.46)];
        [city_To_AirPortPath addCurveToPoint: CGPointMake(48, 118) controlPoint1: CGPointMake(97.47, 122.99) controlPoint2: CGPointMake(75.81, 122.21)];
        [city_To_AirPortPath addCurveToPoint: CGPointMake(-3, 78) controlPoint1: CGPointMake(15, 113) controlPoint2: CGPointMake(-3, 78)];
        city_To_AirPortPath.lineCapStyle = kCGLineCapRound;

        
        //// Neighborhood_To_airport Drawing
        UIBezierPath* neighborhood_To_airportPath = UIBezierPath.bezierPath;
        [neighborhood_To_airportPath moveToPoint: CGPointMake(498, 447)];
        [neighborhood_To_airportPath addCurveToPoint: CGPointMake(544, 450) controlPoint1: CGPointMake(498, 447) controlPoint2: CGPointMake(542, 442)];
        [neighborhood_To_airportPath addCurveToPoint: CGPointMake(544, 482) controlPoint1: CGPointMake(546, 458) controlPoint2: CGPointMake(549, 481)];
        [neighborhood_To_airportPath addCurveToPoint: CGPointMake(477, 491) controlPoint1: CGPointMake(539, 483) controlPoint2: CGPointMake(513, 491)];
        [neighborhood_To_airportPath addCurveToPoint: CGPointMake(469, 434) controlPoint1: CGPointMake(468, 491) controlPoint2: CGPointMake(482, 477)];
        [neighborhood_To_airportPath addCurveToPoint: CGPointMake(427, 268) controlPoint1: CGPointMake(451.14, 374.92) controlPoint2: CGPointMake(435.6, 299.97)];
        [neighborhood_To_airportPath addCurveToPoint: CGPointMake(396, 185) controlPoint1: CGPointMake(416.59, 229.29) controlPoint2: CGPointMake(402.18, 194.06)];
        [neighborhood_To_airportPath addCurveToPoint: CGPointMake(214, 60) controlPoint1: CGPointMake(381, 163) controlPoint2: CGPointMake(304, 98)];
        [neighborhood_To_airportPath addCurveToPoint: CGPointMake(105, 32) controlPoint1: CGPointMake(178.3, 44.93) controlPoint2: CGPointMake(134.99, 39.06)];
        [neighborhood_To_airportPath addCurveToPoint: CGPointMake(0, 1) controlPoint1: CGPointMake(59.39, 21.26) controlPoint2: CGPointMake(22.02, 7.94)];
        neighborhood_To_airportPath.lineCapStyle = kCGLineCapRound;

        
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
		pathItem.embPath = neighborhood_I35_1Path;
		[_bezierPaths addObject:pathItem];
        
        pathItem = [[embBezierPathItem alloc] init];
		pathItem.pathDelay = 1.0;
		pathItem.pathColor = pathBlue;
		pathItem.pathSpeed = pathSpeed;
		pathItem.pathWidth = pathWidth;
		pathItem.embPath = neighborhood_I35_2Path;
		[_bezierPaths addObject:pathItem];
        
        pathItem = [[embBezierPathItem alloc] init];
		pathItem.pathDelay = 1.0;
		pathItem.pathColor = pathBlue;
		pathItem.pathSpeed = pathSpeed;
		pathItem.pathWidth = pathWidth;
		pathItem.embPath = neighhorhood_I30Path;
		[_bezierPaths addObject:pathItem];
        
        pathItem = [[embBezierPathItem alloc] init];
        pathItem.pathDelay = 1.0;
        pathItem.pathColor = pathBlue;
        pathItem.pathSpeed = pathSpeed;
        pathItem.pathWidth = pathWidth;
        pathItem.embPath = city_To_AirPortPath;
        [_bezierPaths addObject:pathItem];

        pathItem = [[embBezierPathItem alloc] init];
        pathItem.pathDelay = 1.0;
        pathItem.pathColor = pathBlue;
        pathItem.pathSpeed = pathSpeed;
        pathItem.pathWidth = pathWidth;
        pathItem.embPath = neighborhood_To_airportPath;
        [_bezierPaths addObject:pathItem];
        //NEIGHBORHOOD LEVEL
	
	}
	
	return self;
}

@end
