//
//  embBezierPathItems.m
//  embAnimatedPath
//
//  Created by Evan Buxton on 2/19/14.
//  Copyright (c) 2014 neoscape. All rights reserved.
//

#import "embDirections.h"
#import "UIColor+Extensions.h"
@implementation embDirections

- (id) init
{
    if (self = [super init]) {
		
		// setup
		_bezierPaths = [[NSMutableArray alloc] init];
		
        UIColor *inPathColor = [UIColor vcPathColor];
		
		UIColor *outPathColor = [UIColor vcOutPathColor];
		
		CGFloat pathWidth = 7.0;
		CGFloat pathSpeed = 3.0;
        CGFloat inDelay = 0.0;
        CGFloat outDelay = 0.0;

		// Bezier paths created in paintcode
		// COPY FROM PAINTCODE
		
        ////////////////////////////////CITY////////////////////////////////
        
        //// FromDallasNorthTollWay1 Drawing
        //0
        UIBezierPath* fromDallasNorthTollWay1Path = UIBezierPath.bezierPath;
        [fromDallasNorthTollWay1Path moveToPoint: CGPointMake(450.5, -0.5)];
        [fromDallasNorthTollWay1Path addLineToPoint: CGPointMake(445.5, 66.5)];
        [fromDallasNorthTollWay1Path addCurveToPoint: CGPointMake(437, 136) controlPoint1: CGPointMake(445.5, 66.5) controlPoint2: CGPointMake(437.07, 109.93)];
        [fromDallasNorthTollWay1Path addCurveToPoint: CGPointMake(451, 224) controlPoint1: CGPointMake(436.96, 149.23) controlPoint2: CGPointMake(444.11, 187.22)];
        [fromDallasNorthTollWay1Path addCurveToPoint: CGPointMake(461, 264) controlPoint1: CGPointMake(457.69, 259.7) controlPoint2: CGPointMake(461, 264)];
        [fromDallasNorthTollWay1Path addCurveToPoint: CGPointMake(485, 269) controlPoint1: CGPointMake(461.96, 266.17) controlPoint2: CGPointMake(475.93, 266.54)];
        [fromDallasNorthTollWay1Path addCurveToPoint: CGPointMake(503, 277) controlPoint1: CGPointMake(496.28, 272.06) controlPoint2: CGPointMake(503, 277)];
        [fromDallasNorthTollWay1Path addCurveToPoint: CGPointMake(555, 333) controlPoint1: CGPointMake(503, 277) controlPoint2: CGPointMake(555, 327)];
        [fromDallasNorthTollWay1Path addCurveToPoint: CGPointMake(514, 368) controlPoint1: CGPointMake(555, 337.51) controlPoint2: CGPointMake(528.74, 357.46)];
        [fromDallasNorthTollWay1Path addCurveToPoint: CGPointMake(503, 373) controlPoint1: CGPointMake(509.13, 371.48) controlPoint2: CGPointMake(503.25, 371.76)];
        [fromDallasNorthTollWay1Path addCurveToPoint: CGPointMake(508, 400) controlPoint1: CGPointMake(502, 378) controlPoint2: CGPointMake(509, 400)];
        [fromDallasNorthTollWay1Path addCurveToPoint: CGPointMake(503, 400) controlPoint1: CGPointMake(507, 400) controlPoint2: CGPointMake(503, 400)];
        fromDallasNorthTollWay1Path.lineCapStyle = kCGLineCapRound;
        
        //// FromDallasNorthTollWay2 Drawing
        //1
        UIBezierPath* fromDallasNorthTollWay2Path = UIBezierPath.bezierPath;
        [fromDallasNorthTollWay2Path moveToPoint: CGPointMake(450.5, -0.5)];
        [fromDallasNorthTollWay2Path addLineToPoint: CGPointMake(445.5, 66.5)];
        [fromDallasNorthTollWay2Path addCurveToPoint: CGPointMake(437, 136) controlPoint1: CGPointMake(445.5, 66.5) controlPoint2: CGPointMake(437.07, 109.93)];
        [fromDallasNorthTollWay2Path addCurveToPoint: CGPointMake(451, 224) controlPoint1: CGPointMake(436.96, 149.23) controlPoint2: CGPointMake(444.11, 187.22)];
        [fromDallasNorthTollWay2Path addCurveToPoint: CGPointMake(470, 298) controlPoint1: CGPointMake(457.69, 259.7) controlPoint2: CGPointMake(470, 292)];
        [fromDallasNorthTollWay2Path addCurveToPoint: CGPointMake(470, 313) controlPoint1: CGPointMake(470, 304) controlPoint2: CGPointMake(468, 309)];
        [fromDallasNorthTollWay2Path addCurveToPoint: CGPointMake(492, 337) controlPoint1: CGPointMake(472, 317) controlPoint2: CGPointMake(489, 332)];
        [fromDallasNorthTollWay2Path addCurveToPoint: CGPointMake(506, 399) controlPoint1: CGPointMake(495, 342) controlPoint2: CGPointMake(507, 397)];
        [fromDallasNorthTollWay2Path addCurveToPoint: CGPointMake(498, 399) controlPoint1: CGPointMake(505, 401) controlPoint2: CGPointMake(498, 399)];
        fromDallasNorthTollWay2Path.lineCapStyle = kCGLineCapRound;
        
        
        //// FromDallasNorthTollWay3 Drawing
        //2
        UIBezierPath* fromDallasNorthTollWay3Path = UIBezierPath.bezierPath;
        [fromDallasNorthTollWay3Path moveToPoint: CGPointMake(579, -0)];
        [fromDallasNorthTollWay3Path addCurveToPoint: CGPointMake(579, 95) controlPoint1: CGPointMake(579, -0) controlPoint2: CGPointMake(583, 85)];
        [fromDallasNorthTollWay3Path addCurveToPoint: CGPointMake(457, 216) controlPoint1: CGPointMake(575, 105) controlPoint2: CGPointMake(461, 210)];
        [fromDallasNorthTollWay3Path addCurveToPoint: CGPointMake(430, 270) controlPoint1: CGPointMake(453, 222) controlPoint2: CGPointMake(427, 263)];
        [fromDallasNorthTollWay3Path addCurveToPoint: CGPointMake(457, 296) controlPoint1: CGPointMake(433, 277) controlPoint2: CGPointMake(454, 289)];
        [fromDallasNorthTollWay3Path addCurveToPoint: CGPointMake(482, 385) controlPoint1: CGPointMake(460, 303) controlPoint2: CGPointMake(479, 375)];
        [fromDallasNorthTollWay3Path addCurveToPoint: CGPointMake(487, 419) controlPoint1: CGPointMake(485, 395) controlPoint2: CGPointMake(485, 415)];
        [fromDallasNorthTollWay3Path addCurveToPoint: CGPointMake(521, 415) controlPoint1: CGPointMake(489, 423) controlPoint2: CGPointMake(520, 418)];
        [fromDallasNorthTollWay3Path addCurveToPoint: CGPointMake(521, 398) controlPoint1: CGPointMake(522, 412) controlPoint2: CGPointMake(523, 401)];
        [fromDallasNorthTollWay3Path addCurveToPoint: CGPointMake(502, 398) controlPoint1: CGPointMake(519, 395) controlPoint2: CGPointMake(502, 398)];
        
        //// OutDallasNorthTollWay1 Drawing
        //3
        UIBezierPath* outDallasNorthTollWay1Path = UIBezierPath.bezierPath;
        [outDallasNorthTollWay1Path moveToPoint: CGPointMake(495, 399)];
        [outDallasNorthTollWay1Path addCurveToPoint: CGPointMake(506, 401) controlPoint1: CGPointMake(495, 399) controlPoint2: CGPointMake(504, 398)];
        [outDallasNorthTollWay1Path addCurveToPoint: CGPointMake(508, 416) controlPoint1: CGPointMake(508, 404) controlPoint2: CGPointMake(506, 414)];
        [outDallasNorthTollWay1Path addCurveToPoint: CGPointMake(527, 418) controlPoint1: CGPointMake(510, 418) controlPoint2: CGPointMake(522, 415)];
        [outDallasNorthTollWay1Path addCurveToPoint: CGPointMake(512, 434) controlPoint1: CGPointMake(529.64, 419.59) controlPoint2: CGPointMake(521.1, 428.97)];
        [outDallasNorthTollWay1Path addCurveToPoint: CGPointMake(493, 437) controlPoint1: CGPointMake(503.87, 438.49) controlPoint2: CGPointMake(495.36, 438.89)];
        [outDallasNorthTollWay1Path addCurveToPoint: CGPointMake(489, 396) controlPoint1: CGPointMake(491.33, 435.67) controlPoint2: CGPointMake(492.5, 410.01)];
        [outDallasNorthTollWay1Path addCurveToPoint: CGPointMake(465, 285) controlPoint1: CGPointMake(482, 368) controlPoint2: CGPointMake(466, 291)];
        [outDallasNorthTollWay1Path addCurveToPoint: CGPointMake(456, 247) controlPoint1: CGPointMake(463.5, 276) controlPoint2: CGPointMake(459, 254)];
        [outDallasNorthTollWay1Path addCurveToPoint: CGPointMake(437, 157) controlPoint1: CGPointMake(453, 240) controlPoint2: CGPointMake(437, 161)];
        [outDallasNorthTollWay1Path addCurveToPoint: CGPointMake(437, 125) controlPoint1: CGPointMake(437, 153) controlPoint2: CGPointMake(437, 133)];
        [outDallasNorthTollWay1Path addCurveToPoint: CGPointMake(444, 72) controlPoint1: CGPointMake(437, 121.59) controlPoint2: CGPointMake(441.08, 97.75)];
        [outDallasNorthTollWay1Path addCurveToPoint: CGPointMake(451, -1) controlPoint1: CGPointMake(447.93, 37.39) controlPoint2: CGPointMake(451, -1)];
        
        //// OutDallasNorthTollWay2 Drawing
        //4
        UIBezierPath* outDallasNorthTollWay2Path = UIBezierPath.bezierPath;
        [outDallasNorthTollWay2Path moveToPoint: CGPointMake(502, 398)];
        [outDallasNorthTollWay2Path addCurveToPoint: CGPointMake(523, 401) controlPoint1: CGPointMake(502, 398) controlPoint2: CGPointMake(522, 404)];
        [outDallasNorthTollWay2Path addCurveToPoint: CGPointMake(523, 369) controlPoint1: CGPointMake(524, 398) controlPoint2: CGPointMake(522, 377)];
        [outDallasNorthTollWay2Path addCurveToPoint: CGPointMake(555, 333) controlPoint1: CGPointMake(524, 361) controlPoint2: CGPointMake(553, 337)];
        [outDallasNorthTollWay2Path addCurveToPoint: CGPointMake(502, 273) controlPoint1: CGPointMake(557, 329) controlPoint2: CGPointMake(508, 276)];
        [outDallasNorthTollWay2Path addCurveToPoint: CGPointMake(461, 264) controlPoint1: CGPointMake(496, 270) controlPoint2: CGPointMake(464, 269)];
        
        //// FromWoodallRogers1 Drawing
        //5
        UIBezierPath* fromWoodallRogers1Path = UIBezierPath.bezierPath;
        [fromWoodallRogers1Path moveToPoint: CGPointMake(729.5, -2.5)];
        [fromWoodallRogers1Path addCurveToPoint: CGPointMake(659, 165) controlPoint1: CGPointMake(729.5, -2.5) controlPoint2: CGPointMake(661, 153)];
        [fromWoodallRogers1Path addCurveToPoint: CGPointMake(664, 288) controlPoint1: CGPointMake(657.68, 172.94) controlPoint2: CGPointMake(666, 282)];
        [fromWoodallRogers1Path addCurveToPoint: CGPointMake(562, 385) controlPoint1: CGPointMake(662.72, 291.84) controlPoint2: CGPointMake(602.73, 345.99)];
        [fromWoodallRogers1Path addCurveToPoint: CGPointMake(531, 416) controlPoint1: CGPointMake(539.11, 406.93) controlPoint2: CGPointMake(536, 413)];
        [fromWoodallRogers1Path addCurveToPoint: CGPointMake(521, 415) controlPoint1: CGPointMake(526, 419) controlPoint2: CGPointMake(522, 418)];
        [fromWoodallRogers1Path addCurveToPoint: CGPointMake(523, 401) controlPoint1: CGPointMake(520, 412) controlPoint2: CGPointMake(524, 403)];
        [fromWoodallRogers1Path addCurveToPoint: CGPointMake(506, 399) controlPoint1: CGPointMake(522, 399) controlPoint2: CGPointMake(506, 399)];
        fromWoodallRogers1Path.lineCapStyle = kCGLineCapRound;
        
        //// FromWoodallRogers2 Drawing
        //6
        UIBezierPath* fromWoodallRogers2Path = UIBezierPath.bezierPath;
        [fromWoodallRogers2Path moveToPoint: CGPointMake(729.5, -2.5)];
        [fromWoodallRogers2Path addCurveToPoint: CGPointMake(659, 165) controlPoint1: CGPointMake(729.5, -2.5) controlPoint2: CGPointMake(661, 153)];
        [fromWoodallRogers2Path addCurveToPoint: CGPointMake(664, 288) controlPoint1: CGPointMake(657.68, 172.94) controlPoint2: CGPointMake(666, 282)];
        [fromWoodallRogers2Path addCurveToPoint: CGPointMake(551, 394) controlPoint1: CGPointMake(662.72, 291.84) controlPoint2: CGPointMake(556, 393)];
        [fromWoodallRogers2Path addCurveToPoint: CGPointMake(532, 356) controlPoint1: CGPointMake(546, 395) controlPoint2: CGPointMake(537, 357)];
        [fromWoodallRogers2Path addCurveToPoint: CGPointMake(507, 373) controlPoint1: CGPointMake(527, 355) controlPoint2: CGPointMake(509, 368)];
        [fromWoodallRogers2Path addCurveToPoint: CGPointMake(510, 399) controlPoint1: CGPointMake(505, 378) controlPoint2: CGPointMake(515, 396)];
        [fromWoodallRogers2Path addCurveToPoint: CGPointMake(504, 399) controlPoint1: CGPointMake(505, 402) controlPoint2: CGPointMake(504, 399)];
        fromWoodallRogers2Path.lineCapStyle = kCGLineCapRound;
        
        //// OutWoodallRogers1 Drawing
        //7
        UIBezierPath* outWoodallRogers1Path = UIBezierPath.bezierPath;
        [outWoodallRogers1Path moveToPoint: CGPointMake(507, 404)];
        [outWoodallRogers1Path addCurveToPoint: CGPointMake(517, 405) controlPoint1: CGPointMake(507, 404) controlPoint2: CGPointMake(516, 403)];
        [outWoodallRogers1Path addCurveToPoint: CGPointMake(516, 419) controlPoint1: CGPointMake(518, 407) controlPoint2: CGPointMake(515, 416)];
        [outWoodallRogers1Path addCurveToPoint: CGPointMake(533, 414) controlPoint1: CGPointMake(517, 422) controlPoint2: CGPointMake(528, 417)];
        [outWoodallRogers1Path addCurveToPoint: CGPointMake(565, 382) controlPoint1: CGPointMake(538, 411) controlPoint2: CGPointMake(542.11, 403.93)];
        [outWoodallRogers1Path addCurveToPoint: CGPointMake(663, 292) controlPoint1: CGPointMake(605.73, 342.99) controlPoint2: CGPointMake(661.72, 295.84)];
        [outWoodallRogers1Path addCurveToPoint: CGPointMake(659, 165) controlPoint1: CGPointMake(665, 286) controlPoint2: CGPointMake(657.68, 172.94)];
        [outWoodallRogers1Path addCurveToPoint: CGPointMake(730, -3) controlPoint1: CGPointMake(661, 153) controlPoint2: CGPointMake(730, -3)];
        outWoodallRogers1Path.lineCapStyle = kCGLineCapRound;
        
        //// OutWoodallRogers2 Drawing
        //8
        UIBezierPath* outWoodallRogers2Path = UIBezierPath.bezierPath;
        [outWoodallRogers2Path moveToPoint: CGPointMake(504, 396)];
        [outWoodallRogers2Path addCurveToPoint: CGPointMake(520, 396) controlPoint1: CGPointMake(504, 396) controlPoint2: CGPointMake(518, 398)];
        [outWoodallRogers2Path addCurveToPoint: CGPointMake(520, 365) controlPoint1: CGPointMake(522, 394) controlPoint2: CGPointMake(518, 368)];
        [outWoodallRogers2Path addCurveToPoint: CGPointMake(535, 357) controlPoint1: CGPointMake(522, 362) controlPoint2: CGPointMake(531, 353)];
        [outWoodallRogers2Path addCurveToPoint: CGPointMake(553, 392) controlPoint1: CGPointMake(539, 361) controlPoint2: CGPointMake(550, 391)];
        outWoodallRogers2Path.lineCapStyle = kCGLineCapRound;
        
        //// FromKatyTrail Drawing
        //9
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
        
        //// OutKatyTrail Drawing
        //10
        UIBezierPath* outKatyTrailPath = UIBezierPath.bezierPath;
        [outKatyTrailPath moveToPoint: CGPointMake(504, 405)];
        [outKatyTrailPath addCurveToPoint: CGPointMake(526, 399) controlPoint1: CGPointMake(504, 405) controlPoint2: CGPointMake(526, 405)];
        [outKatyTrailPath addCurveToPoint: CGPointMake(520, 365) controlPoint1: CGPointMake(526, 393) controlPoint2: CGPointMake(521.5, 370)];
        [outKatyTrailPath addCurveToPoint: CGPointMake(478, 291) controlPoint1: CGPointMake(514, 345) controlPoint2: CGPointMake(484.06, 309.29)];
        [outKatyTrailPath addCurveToPoint: CGPointMake(485, 269) controlPoint1: CGPointMake(476.29, 285.84) controlPoint2: CGPointMake(478, 277)];
        [outKatyTrailPath addCurveToPoint: CGPointMake(571, 213) controlPoint1: CGPointMake(498.2, 253.92) controlPoint2: CGPointMake(566.23, 218.73)];
        [outKatyTrailPath addCurveToPoint: CGPointMake(598, 133) controlPoint1: CGPointMake(576, 207) controlPoint2: CGPointMake(584.88, 151.16)];
        [outKatyTrailPath addCurveToPoint: CGPointMake(631, 87) controlPoint1: CGPointMake(611, 115) controlPoint2: CGPointMake(626, 101)];
        [outKatyTrailPath addCurveToPoint: CGPointMake(675, -4) controlPoint1: CGPointMake(641.04, 58.88) controlPoint2: CGPointMake(657, 28)];
        outKatyTrailPath.lineCapStyle = kCGLineCapRound;
        
        //// FromI35_1 Drawing
        //11
        UIBezierPath* fromI35_1Path = UIBezierPath.bezierPath;
        [fromI35_1Path moveToPoint: CGPointMake(-3, 78)];
        [fromI35_1Path addCurveToPoint: CGPointMake(48, 118) controlPoint1: CGPointMake(-3, 78) controlPoint2: CGPointMake(15, 113)];
        [fromI35_1Path addCurveToPoint: CGPointMake(132, 125) controlPoint1: CGPointMake(75.81, 122.21) controlPoint2: CGPointMake(97.47, 122.99)];
        [fromI35_1Path addCurveToPoint: CGPointMake(262, 195) controlPoint1: CGPointMake(174.27, 127.46) controlPoint2: CGPointMake(224.07, 174.41)];
        [fromI35_1Path addCurveToPoint: CGPointMake(382, 236) controlPoint1: CGPointMake(316.5, 224.59) controlPoint2: CGPointMake(372.11, 232.7)];
        [fromI35_1Path addCurveToPoint: CGPointMake(452, 282) controlPoint1: CGPointMake(394.19, 240.06) controlPoint2: CGPointMake(439.29, 267.94)];
        [fromI35_1Path addCurveToPoint: CGPointMake(507, 336) controlPoint1: CGPointMake(455.26, 285.61) controlPoint2: CGPointMake(488.66, 309.47)];
        [fromI35_1Path addCurveToPoint: CGPointMake(517, 365) controlPoint1: CGPointMake(522.73, 358.76) controlPoint2: CGPointMake(519, 363)];
        [fromI35_1Path addCurveToPoint: CGPointMake(503, 373) controlPoint1: CGPointMake(516.13, 365.87) controlPoint2: CGPointMake(504, 368)];
        [fromI35_1Path addCurveToPoint: CGPointMake(507, 397) controlPoint1: CGPointMake(502, 378) controlPoint2: CGPointMake(508, 393)];
        [fromI35_1Path addCurveToPoint: CGPointMake(502, 398) controlPoint1: CGPointMake(506, 401) controlPoint2: CGPointMake(502, 398)];
        fromI35_1Path.lineCapStyle = kCGLineCapRound;
        
        //// FromI35_2 Drawing
        //12
        UIBezierPath* fromI35_2Path = UIBezierPath.bezierPath;
        [fromI35_2Path moveToPoint: CGPointMake(461, 290)];
        [fromI35_2Path addCurveToPoint: CGPointMake(490, 399) controlPoint1: CGPointMake(466, 292) controlPoint2: CGPointMake(482.26, 358.67)];
        [fromI35_2Path addCurveToPoint: CGPointMake(493, 432) controlPoint1: CGPointMake(493.58, 417.67) controlPoint2: CGPointMake(491, 427)];
        [fromI35_2Path addCurveToPoint: CGPointMake(520, 423) controlPoint1: CGPointMake(495, 437) controlPoint2: CGPointMake(513.25, 425.5)];
        [fromI35_2Path addCurveToPoint: CGPointMake(522, 404) controlPoint1: CGPointMake(522.87, 421.94) controlPoint2: CGPointMake(521, 413)];
        [fromI35_2Path addCurveToPoint: CGPointMake(517, 399) controlPoint1: CGPointMake(522.6, 398.58) controlPoint2: CGPointMake(520.8, 399.09)];
        [fromI35_2Path addCurveToPoint: CGPointMake(506, 399) controlPoint1: CGPointMake(512.28, 398.89) controlPoint2: CGPointMake(506, 399)];
        fromI35_2Path.lineCapStyle = kCGLineCapRound;
        
        //// FromI35_3 Drawing
        //13
        UIBezierPath* fromI35_3Path = UIBezierPath.bezierPath;
        [fromI35_3Path moveToPoint: CGPointMake(493, 420)];
        [fromI35_3Path addCurveToPoint: CGPointMake(521, 415) controlPoint1: CGPointMake(496, 415) controlPoint2: CGPointMake(518, 419)];
        [fromI35_3Path addCurveToPoint: CGPointMake(521, 398) controlPoint1: CGPointMake(524, 411) controlPoint2: CGPointMake(523, 400)];
        [fromI35_3Path addCurveToPoint: CGPointMake(501, 398) controlPoint1: CGPointMake(519, 396) controlPoint2: CGPointMake(501, 398)];
        
        //// FromI35_4 Drawing
        //14
        UIBezierPath* fromI35_4Path = UIBezierPath.bezierPath;
        [fromI35_4Path moveToPoint: CGPointMake(515, 768)];
        [fromI35_4Path addCurveToPoint: CGPointMake(509, 696) controlPoint1: CGPointMake(515, 768) controlPoint2: CGPointMake(508, 708)];
        [fromI35_4Path addCurveToPoint: CGPointMake(559, 600) controlPoint1: CGPointMake(510, 684) controlPoint2: CGPointMake(560, 624)];
        [fromI35_4Path addCurveToPoint: CGPointMake(515, 551) controlPoint1: CGPointMake(558, 576) controlPoint2: CGPointMake(523, 560)];
        [fromI35_4Path addCurveToPoint: CGPointMake(496, 511) controlPoint1: CGPointMake(507, 542) controlPoint2: CGPointMake(499, 528)];
        [fromI35_4Path addCurveToPoint: CGPointMake(492, 408) controlPoint1: CGPointMake(493, 494) controlPoint2: CGPointMake(494, 431)];
        [fromI35_4Path addCurveToPoint: CGPointMake(470, 313) controlPoint1: CGPointMake(490, 385) controlPoint2: CGPointMake(468, 321)];
        [fromI35_4Path addCurveToPoint: CGPointMake(489, 332) controlPoint1: CGPointMake(472, 305) controlPoint2: CGPointMake(479.75, 311)];
        [fromI35_4Path addCurveToPoint: CGPointMake(507, 397) controlPoint1: CGPointMake(498.25, 353) controlPoint2: CGPointMake(509, 394)];
        [fromI35_4Path addCurveToPoint: CGPointMake(498, 399) controlPoint1: CGPointMake(505, 400) controlPoint2: CGPointMake(498, 399)];
        
        //// OutI35_1 Drawing
        //15
        UIBezierPath* outI35_1Path = UIBezierPath.bezierPath;
        [outI35_1Path moveToPoint: CGPointMake(500, 394)];
        [outI35_1Path addCurveToPoint: CGPointMake(509, 394) controlPoint1: CGPointMake(500, 394) controlPoint2: CGPointMake(503.35, 394.58)];
        [outI35_1Path addCurveToPoint: CGPointMake(521, 391) controlPoint1: CGPointMake(514.1, 393.48) controlPoint2: CGPointMake(520.53, 392.9)];
        [outI35_1Path addCurveToPoint: CGPointMake(509, 339) controlPoint1: CGPointMake(522, 387) controlPoint2: CGPointMake(526, 361)];
        [outI35_1Path addCurveToPoint: CGPointMake(473, 297) controlPoint1: CGPointMake(498.86, 325.88) controlPoint2: CGPointMake(486.83, 309.75)];
        [outI35_1Path addCurveToPoint: CGPointMake(443, 274) controlPoint1: CGPointMake(459.8, 284.82) controlPoint2: CGPointMake(453, 281)];
        [outI35_1Path addCurveToPoint: CGPointMake(375, 233) controlPoint1: CGPointMake(403, 246) controlPoint2: CGPointMake(387.19, 237.06)];
        [outI35_1Path addCurveToPoint: CGPointMake(262, 195) controlPoint1: CGPointMake(365.11, 229.7) controlPoint2: CGPointMake(316.5, 224.59)];
        [outI35_1Path addCurveToPoint: CGPointMake(132, 125) controlPoint1: CGPointMake(224.07, 174.41) controlPoint2: CGPointMake(174.27, 127.46)];
        [outI35_1Path addCurveToPoint: CGPointMake(48, 118) controlPoint1: CGPointMake(97.47, 122.99) controlPoint2: CGPointMake(75.81, 122.21)];
        [outI35_1Path addCurveToPoint: CGPointMake(-3, 78) controlPoint1: CGPointMake(15, 113) controlPoint2: CGPointMake(-3, 78)];
        outI35_1Path.lineCapStyle = kCGLineCapRound;
        
        //// OutI35_2 Drawing
        //16
        UIBezierPath* outI35_2Path = UIBezierPath.bezierPath;
        [outI35_2Path moveToPoint: CGPointMake(500, 394)];
        [outI35_2Path addCurveToPoint: CGPointMake(517, 394) controlPoint1: CGPointMake(500, 394) controlPoint2: CGPointMake(512.28, 393.89)];
        [outI35_2Path addCurveToPoint: CGPointMake(525, 405) controlPoint1: CGPointMake(520.8, 394.09) controlPoint2: CGPointMake(525.6, 399.58)];
        [outI35_2Path addCurveToPoint: CGPointMake(523, 427) controlPoint1: CGPointMake(524, 414) controlPoint2: CGPointMake(525.87, 425.94)];
        [outI35_2Path addCurveToPoint: CGPointMake(493, 437) controlPoint1: CGPointMake(516.25, 429.5) controlPoint2: CGPointMake(495, 442)];
        [outI35_2Path addCurveToPoint: CGPointMake(489, 396) controlPoint1: CGPointMake(491, 432) controlPoint2: CGPointMake(492.58, 414.67)];
        [outI35_2Path addCurveToPoint: CGPointMake(462, 288) controlPoint1: CGPointMake(481.26, 355.67) controlPoint2: CGPointMake(465.42, 292.1)];
        outI35_2Path.lineCapStyle = kCGLineCapRound;
        
        //// OutI35_3 Drawing
        //17
        UIBezierPath* outI35_3Path = UIBezierPath.bezierPath;
        [outI35_3Path moveToPoint: CGPointMake(497, 394.5)];
        [outI35_3Path addCurveToPoint: CGPointMake(521, 396) controlPoint1: CGPointMake(497, 394.5) controlPoint2: CGPointMake(515, 390.5)];
        [outI35_3Path addCurveToPoint: CGPointMake(525, 423) controlPoint1: CGPointMake(527, 401.5) controlPoint2: CGPointMake(524, 415)];
        [outI35_3Path addCurveToPoint: CGPointMake(493, 439) controlPoint1: CGPointMake(526, 430.97) controlPoint2: CGPointMake(493.5, 438)];
        [outI35_3Path addCurveToPoint: CGPointMake(495, 492) controlPoint1: CGPointMake(492, 441) controlPoint2: CGPointMake(495, 492)];
        [outI35_3Path addCurveToPoint: CGPointMake(497, 520) controlPoint1: CGPointMake(495, 492) controlPoint2: CGPointMake(495, 513)];
        [outI35_3Path addCurveToPoint: CGPointMake(515, 551) controlPoint1: CGPointMake(499, 527) controlPoint2: CGPointMake(504.25, 538.25)];
        [outI35_3Path addCurveToPoint: CGPointMake(556, 588) controlPoint1: CGPointMake(525.75, 563.75) controlPoint2: CGPointMake(552, 577)];
        [outI35_3Path addCurveToPoint: CGPointMake(552, 623) controlPoint1: CGPointMake(560, 599) controlPoint2: CGPointMake(555, 615)];
        [outI35_3Path addCurveToPoint: CGPointMake(518, 675) controlPoint1: CGPointMake(549, 631) controlPoint2: CGPointMake(518, 675)];
        [outI35_3Path addCurveToPoint: CGPointMake(509, 704) controlPoint1: CGPointMake(518, 675) controlPoint2: CGPointMake(510, 688)];
        [outI35_3Path addCurveToPoint: CGPointMake(515, 768) controlPoint1: CGPointMake(508, 720) controlPoint2: CGPointMake(515, 768)];
        
        //// FromI30_1 Drawing
        //18
        UIBezierPath* fromI30_1Path = UIBezierPath.bezierPath;
        [fromI30_1Path moveToPoint: CGPointMake(-0.5, 596.5)];
        [fromI30_1Path addCurveToPoint: CGPointMake(76, 603) controlPoint1: CGPointMake(-0.5, 596.5) controlPoint2: CGPointMake(41, 594)];
        [fromI30_1Path addCurveToPoint: CGPointMake(194, 633) controlPoint1: CGPointMake(111, 612) controlPoint2: CGPointMake(148, 640)];
        [fromI30_1Path addCurveToPoint: CGPointMake(289, 596.5) controlPoint1: CGPointMake(240, 626) controlPoint2: CGPointMake(230.9, 606.12)];
        [fromI30_1Path addCurveToPoint: CGPointMake(439.5, 567.5) controlPoint1: CGPointMake(347.1, 586.88) controlPoint2: CGPointMake(383.75, 580.28)];
        [fromI30_1Path addCurveToPoint: CGPointMake(484.29, 548.73) controlPoint1: CGPointMake(462.35, 562.26) controlPoint2: CGPointMake(476.07, 555.65)];
        [fromI30_1Path addCurveToPoint: CGPointMake(496.5, 520) controlPoint1: CGPointMake(496.13, 538.76) controlPoint2: CGPointMake(496.59, 528.14)];
        [fromI30_1Path addCurveToPoint: CGPointMake(493, 460) controlPoint1: CGPointMake(496.49, 518.59) controlPoint2: CGPointMake(494.88, 484.86)];
        [fromI30_1Path addCurveToPoint: CGPointMake(497, 431) controlPoint1: CGPointMake(491.86, 444.97) controlPoint2: CGPointMake(490.59, 429.87)];
        [fromI30_1Path addCurveToPoint: CGPointMake(521, 420) controlPoint1: CGPointMake(514, 434) controlPoint2: CGPointMake(521, 420)];
        [fromI30_1Path addCurveToPoint: CGPointMake(523, 401) controlPoint1: CGPointMake(521, 420) controlPoint2: CGPointMake(524, 406)];
        [fromI30_1Path addCurveToPoint: CGPointMake(506, 399) controlPoint1: CGPointMake(522, 396) controlPoint2: CGPointMake(506, 399)];
        fromI30_1Path.lineCapStyle = kCGLineCapRound;
        
        //// FromI30_2 Drawing
        //19
        UIBezierPath* fromI30_2Path = UIBezierPath.bezierPath;
        [fromI30_2Path moveToPoint: CGPointMake(1024, 343)];
        [fromI30_2Path addCurveToPoint: CGPointMake(941, 353) controlPoint1: CGPointMake(1023.5, 343) controlPoint2: CGPointMake(956, 348)];
        [fromI30_2Path addCurveToPoint: CGPointMake(882, 407) controlPoint1: CGPointMake(926, 358) controlPoint2: CGPointMake(889, 398)];
        [fromI30_2Path addCurveToPoint: CGPointMake(864, 444) controlPoint1: CGPointMake(875, 416) controlPoint2: CGPointMake(872, 432)];
        [fromI30_2Path addCurveToPoint: CGPointMake(832, 457) controlPoint1: CGPointMake(860.75, 448.87) controlPoint2: CGPointMake(847.24, 454.3)];
        [fromI30_2Path addCurveToPoint: CGPointMake(778, 463) controlPoint1: CGPointMake(809.69, 460.95) controlPoint2: CGPointMake(791, 460)];
        [fromI30_2Path addCurveToPoint: CGPointMake(747, 487) controlPoint1: CGPointMake(765, 466) controlPoint2: CGPointMake(747, 487)];
        [fromI30_2Path addCurveToPoint: CGPointMake(729, 506) controlPoint1: CGPointMake(747, 487) controlPoint2: CGPointMake(734, 500)];
        [fromI30_2Path addCurveToPoint: CGPointMake(623, 538) controlPoint1: CGPointMake(724, 512) controlPoint2: CGPointMake(638, 531)];
        [fromI30_2Path addCurveToPoint: CGPointMake(594, 563) controlPoint1: CGPointMake(608, 545) controlPoint2: CGPointMake(594, 563)];
        [fromI30_2Path addCurveToPoint: CGPointMake(574, 576) controlPoint1: CGPointMake(594, 563) controlPoint2: CGPointMake(588, 571)];
        [fromI30_2Path addCurveToPoint: CGPointMake(523, 560) controlPoint1: CGPointMake(560, 581) controlPoint2: CGPointMake(531, 568)];
        [fromI30_2Path addCurveToPoint: CGPointMake(499, 523) controlPoint1: CGPointMake(515, 552) controlPoint2: CGPointMake(501, 531)];
        [fromI30_2Path addCurveToPoint: CGPointMake(490, 390) controlPoint1: CGPointMake(497, 515) controlPoint2: CGPointMake(492, 394)];
        [fromI30_2Path addCurveToPoint: CGPointMake(470, 313) controlPoint1: CGPointMake(488, 386) controlPoint2: CGPointMake(470, 321)];
        [fromI30_2Path addCurveToPoint: CGPointMake(490, 331) controlPoint1: CGPointMake(470, 305) controlPoint2: CGPointMake(483, 321)];
        [fromI30_2Path addCurveToPoint: CGPointMake(506, 399) controlPoint1: CGPointMake(497, 341) controlPoint2: CGPointMake(509, 397)];
        [fromI30_2Path addCurveToPoint: CGPointMake(499, 399) controlPoint1: CGPointMake(503, 401) controlPoint2: CGPointMake(499, 399)];
        
        //// ToI30_1 Drawing
        //20
        UIBezierPath* toI30_1Path = UIBezierPath.bezierPath;
        [toI30_1Path moveToPoint: CGPointMake(506, 394)];
        [toI30_1Path addCurveToPoint: CGPointMake(515, 397) controlPoint1: CGPointMake(506, 394) controlPoint2: CGPointMake(514, 392)];
        [toI30_1Path addCurveToPoint: CGPointMake(515, 415) controlPoint1: CGPointMake(515.5, 399.51) controlPoint2: CGPointMake(512.98, 413.99)];
        [toI30_1Path addCurveToPoint: CGPointMake(531, 416) controlPoint1: CGPointMake(517, 416) controlPoint2: CGPointMake(534.75, 410.5)];
        [toI30_1Path addCurveToPoint: CGPointMake(515, 433) controlPoint1: CGPointMake(529.11, 418.77) controlPoint2: CGPointMake(524.08, 427.92)];
        [toI30_1Path addCurveToPoint: CGPointMake(493, 439) controlPoint1: CGPointMake(506.03, 438.02) controlPoint2: CGPointMake(495, 434)];
        [toI30_1Path addCurveToPoint: CGPointMake(497, 520) controlPoint1: CGPointMake(491, 444) controlPoint2: CGPointMake(496.99, 518.59)];
        [toI30_1Path addCurveToPoint: CGPointMake(488, 544) controlPoint1: CGPointMake(497.09, 528.14) controlPoint2: CGPointMake(499, 528)];
        [toI30_1Path addCurveToPoint: CGPointMake(436, 570) controlPoint1: CGPointMake(480.36, 555.11) controlPoint2: CGPointMake(458.54, 565.9)];
        [toI30_1Path addCurveToPoint: CGPointMake(289, 596) controlPoint1: CGPointMake(381, 580) controlPoint2: CGPointMake(347.1, 586.38)];
        [toI30_1Path addCurveToPoint: CGPointMake(194, 633) controlPoint1: CGPointMake(230.9, 605.62) controlPoint2: CGPointMake(227, 629)];
        [toI30_1Path addCurveToPoint: CGPointMake(76, 603) controlPoint1: CGPointMake(161, 637) controlPoint2: CGPointMake(130, 623)];
        [toI30_1Path addCurveToPoint: CGPointMake(31, 598) controlPoint1: CGPointMake(57.34, 596.09) controlPoint2: CGPointMake(42.43, 598.93)];
        [toI30_1Path addCurveToPoint: CGPointMake(0, 596) controlPoint1: CGPointMake(9.35, 596.24) controlPoint2: CGPointMake(0, 596)];
        toI30_1Path.lineCapStyle = kCGLineCapRound;
        
        //// ToI30_2 Drawing
        //21
        UIBezierPath* toI30_2Path = UIBezierPath.bezierPath;
        [toI30_2Path moveToPoint: CGPointMake(506, 394)];
        [toI30_2Path addCurveToPoint: CGPointMake(515, 397) controlPoint1: CGPointMake(506, 394) controlPoint2: CGPointMake(514, 392)];
        [toI30_2Path addCurveToPoint: CGPointMake(515, 415) controlPoint1: CGPointMake(515.5, 399.5) controlPoint2: CGPointMake(512.98, 413.99)];
        [toI30_2Path addCurveToPoint: CGPointMake(530, 418) controlPoint1: CGPointMake(517, 416) controlPoint2: CGPointMake(533.75, 412.5)];
        [toI30_2Path addCurveToPoint: CGPointMake(498, 437) controlPoint1: CGPointMake(526.25, 423.5) controlPoint2: CGPointMake(514, 435)];
        [toI30_2Path addCurveToPoint: CGPointMake(493, 464) controlPoint1: CGPointMake(491.97, 437.75) controlPoint2: CGPointMake(491.86, 448.97)];
        [toI30_2Path addCurveToPoint: CGPointMake(498, 521) controlPoint1: CGPointMake(494.88, 488.86) controlPoint2: CGPointMake(496.79, 517.99)];
        [toI30_2Path addCurveToPoint: CGPointMake(530, 564) controlPoint1: CGPointMake(500, 526) controlPoint2: CGPointMake(514.01, 554.4)];
        [toI30_2Path addCurveToPoint: CGPointMake(574, 576) controlPoint1: CGPointMake(540, 570) controlPoint2: CGPointMake(559.08, 580.3)];
        [toI30_2Path addCurveToPoint: CGPointMake(616, 541) controlPoint1: CGPointMake(592.74, 570.6) controlPoint2: CGPointMake(605, 547)];
        [toI30_2Path addCurveToPoint: CGPointMake(721, 509) controlPoint1: CGPointMake(627, 535) controlPoint2: CGPointMake(696, 519)];
        [toI30_2Path addCurveToPoint: CGPointMake(764, 469) controlPoint1: CGPointMake(746, 499) controlPoint2: CGPointMake(745, 480)];
        [toI30_2Path addCurveToPoint: CGPointMake(825, 458) controlPoint1: CGPointMake(783, 458) controlPoint2: CGPointMake(807.25, 461)];
        [toI30_2Path addCurveToPoint: CGPointMake(864, 444) controlPoint1: CGPointMake(842.75, 455) controlPoint2: CGPointMake(857, 449)];
        [toI30_2Path addCurveToPoint: CGPointMake(885, 402) controlPoint1: CGPointMake(871, 439) controlPoint2: CGPointMake(879, 409)];
        [toI30_2Path addCurveToPoint: CGPointMake(936, 354) controlPoint1: CGPointMake(891, 395) controlPoint2: CGPointMake(925, 363)];
        [toI30_2Path addCurveToPoint: CGPointMake(1024, 343) controlPoint1: CGPointMake(947, 345) controlPoint2: CGPointMake(1024, 343)];
        toI30_2Path.lineCapStyle = kCGLineCapRound;
        
        ////////To Airport //////////
        //// City_To_AirPort Drawing
        //22
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
        
        //// City_To_LoveField Drawing
        //23
        UIBezierPath* city_To_LoveFieldPath = UIBezierPath.bezierPath;
        [city_To_LoveFieldPath moveToPoint: CGPointMake(506, 399)];
        [city_To_LoveFieldPath addCurveToPoint: CGPointMake(523, 395) controlPoint1: CGPointMake(506, 399) controlPoint2: CGPointMake(523.62, 402.13)];
        [city_To_LoveFieldPath addCurveToPoint: CGPointMake(501, 330) controlPoint1: CGPointMake(521.5, 377.75) controlPoint2: CGPointMake(505.48, 336.5)];
        [city_To_LoveFieldPath addCurveToPoint: CGPointMake(465, 273) controlPoint1: CGPointMake(495.74, 322.37) controlPoint2: CGPointMake(467.16, 277.86)];
        [city_To_LoveFieldPath addCurveToPoint: CGPointMake(451, 224) controlPoint1: CGPointMake(461, 264) controlPoint2: CGPointMake(457.69, 259.7)];
        [city_To_LoveFieldPath addCurveToPoint: CGPointMake(437, 136) controlPoint1: CGPointMake(444.11, 187.22) controlPoint2: CGPointMake(436.96, 149.23)];
        [city_To_LoveFieldPath addCurveToPoint: CGPointMake(445.5, 66.5) controlPoint1: CGPointMake(437.07, 109.93) controlPoint2: CGPointMake(445.5, 66.5)];
        [city_To_LoveFieldPath addLineToPoint: CGPointMake(450.5, -0.5)];
        city_To_LoveFieldPath.lineCapStyle = kCGLineCapRound;
        
		// END COPY FROM PAINT CODE

		
		
		// copy new paths from paint code above into array
		//CITY LEVEL
        //0
		pathItem = [[embBezierPathItem alloc] init];
		pathItem.pathDelay = inDelay;
		pathItem.pathColor = inPathColor;
		pathItem.pathSpeed = pathSpeed;
		pathItem.pathWidth = pathWidth;
		pathItem.embPath = fromDallasNorthTollWay1Path;
		[_bezierPaths addObject:pathItem];
        
        //1
        pathItem = [[embBezierPathItem alloc] init];
        pathItem.pathDelay = inDelay;
        pathItem.pathColor = inPathColor;
        pathItem.pathSpeed = pathSpeed;
        pathItem.pathWidth = pathWidth;
        pathItem.embPath = fromDallasNorthTollWay2Path;
        [_bezierPaths addObject:pathItem];

        //2
		pathItem = [[embBezierPathItem alloc] init];
		pathItem.pathDelay = inDelay;
		pathItem.pathColor = inPathColor;
		pathItem.pathSpeed = pathSpeed;
		pathItem.pathWidth = pathWidth;
		pathItem.embPath = fromDallasNorthTollWay3Path;
		[_bezierPaths addObject:pathItem];
        
        //3
        pathItem = [[embBezierPathItem alloc] init];
        pathItem.pathDelay = outDelay;
        pathItem.pathColor = outPathColor;
        pathItem.pathSpeed = pathSpeed;
        pathItem.pathWidth = pathWidth;
        pathItem.embPath = outDallasNorthTollWay1Path;
        [_bezierPaths addObject:pathItem];
        
        //4
		pathItem = [[embBezierPathItem alloc] init];
		pathItem.pathDelay = outDelay;
		pathItem.pathColor = outPathColor;
        pathItem.pathSpeed = 2.0;//pathSpeed;
		pathItem.pathWidth = pathWidth;
		pathItem.embPath = outDallasNorthTollWay2Path;
		[_bezierPaths addObject:pathItem];
        
        //5
        pathItem = [[embBezierPathItem alloc] init];
        pathItem.pathDelay = inDelay;
        pathItem.pathColor = inPathColor;
        pathItem.pathSpeed = pathSpeed;
        pathItem.pathWidth = pathWidth;
        pathItem.embPath = fromWoodallRogers1Path;
        [_bezierPaths addObject:pathItem];
		
		//6
		pathItem = [[embBezierPathItem alloc] init];
		pathItem.pathDelay = inDelay;
		pathItem.pathColor = inPathColor;
		pathItem.pathSpeed = pathSpeed;
		pathItem.pathWidth = pathWidth;
		pathItem.embPath = fromWoodallRogers2Path;
		[_bezierPaths addObject:pathItem];
        
        //7
        pathItem = [[embBezierPathItem alloc] init];
        pathItem.pathDelay = outDelay;
        pathItem.pathColor = outPathColor;
        pathItem.pathSpeed = pathSpeed;
        pathItem.pathWidth = pathWidth;
        pathItem.embPath = outWoodallRogers1Path;
        [_bezierPaths addObject:pathItem];
        
        //8
        pathItem = [[embBezierPathItem alloc] init];
		pathItem.pathDelay = outDelay;
		pathItem.pathColor = outPathColor;
        pathItem.pathSpeed = 1.0;//pathSpeed;
		pathItem.pathWidth = pathWidth;
		pathItem.embPath = outWoodallRogers2Path;
		[_bezierPaths addObject:pathItem];
        
        //9
        pathItem = [[embBezierPathItem alloc] init];
        pathItem.pathDelay = inDelay;
        pathItem.pathColor = inPathColor;
        pathItem.pathSpeed = pathSpeed;
        pathItem.pathWidth = pathWidth;
        pathItem.embPath = fromKatyTrailPath;
        [_bezierPaths addObject:pathItem];
        
		//10
		pathItem = [[embBezierPathItem alloc] init];
		pathItem.pathDelay = outDelay;
		pathItem.pathColor = outPathColor;
		pathItem.pathSpeed = pathSpeed;
		pathItem.pathWidth = pathWidth;
		pathItem.embPath = outKatyTrailPath;
		[_bezierPaths addObject:pathItem];
        
        //11
        pathItem = [[embBezierPathItem alloc] init];
        pathItem.pathDelay = inDelay;
        pathItem.pathColor = inPathColor;
        pathItem.pathSpeed = pathSpeed;
        pathItem.pathWidth = pathWidth;
        pathItem.embPath = fromI35_1Path;
        [_bezierPaths addObject:pathItem];
        
        //Neighiborhood Level
        
        //12
        pathItem = [[embBezierPathItem alloc] init];
        pathItem.pathDelay = 2.3;//inDelay;
		pathItem.pathColor = inPathColor;
        pathItem.pathSpeed = 1.0;//pathSpeed;
		pathItem.pathWidth = pathWidth;
		pathItem.embPath = fromI35_2Path;
		[_bezierPaths addObject:pathItem];
        
        //13
        pathItem = [[embBezierPathItem alloc] init];
        pathItem.pathDelay = 2.0;//inDelay;
        pathItem.pathColor = inPathColor;
        pathItem.pathSpeed = 1.0;//pathSpeed;
        pathItem.pathWidth = pathWidth;
        pathItem.embPath = fromI35_3Path;
        [_bezierPaths addObject:pathItem];
        
        //14
        pathItem = [[embBezierPathItem alloc] init];
		pathItem.pathDelay = inDelay;
		pathItem.pathColor = inPathColor;
		pathItem.pathSpeed = pathSpeed;
		pathItem.pathWidth = pathWidth;
		pathItem.embPath = fromI35_4Path;
		[_bezierPaths addObject:pathItem];
        
        //15
        pathItem = [[embBezierPathItem alloc] init];
        pathItem.pathDelay = outDelay;
        pathItem.pathColor = outPathColor;
        pathItem.pathSpeed = pathSpeed;
        pathItem.pathWidth = pathWidth;
        pathItem.embPath = outI35_1Path;
        [_bezierPaths addObject:pathItem];
        
        //16
        pathItem = [[embBezierPathItem alloc] init];
		pathItem.pathDelay = outDelay;
		pathItem.pathColor = outPathColor;
        pathItem.pathSpeed = 1.0;//pathSpeed;
		pathItem.pathWidth = pathWidth;
		pathItem.embPath = outI35_2Path;
		[_bezierPaths addObject:pathItem];
        
        //17
        pathItem = [[embBezierPathItem alloc] init];
        pathItem.pathDelay = outDelay;
        pathItem.pathColor = outPathColor;
        pathItem.pathSpeed = pathSpeed;
        pathItem.pathWidth = pathWidth;
        pathItem.embPath = outI35_3Path;
        [_bezierPaths addObject:pathItem];
        
        //18
        pathItem = [[embBezierPathItem alloc] init];
		pathItem.pathDelay = inDelay;
		pathItem.pathColor = inPathColor;
		pathItem.pathSpeed = pathSpeed;
		pathItem.pathWidth = pathWidth;
		pathItem.embPath = fromI30_1Path;
		[_bezierPaths addObject:pathItem];
        
        //19
        pathItem = [[embBezierPathItem alloc] init];
        pathItem.pathDelay = inDelay;
        pathItem.pathColor = inPathColor;
        pathItem.pathSpeed = pathSpeed;
        pathItem.pathWidth = pathWidth;
        pathItem.embPath = fromI30_2Path;
        [_bezierPaths addObject:pathItem];
        
        //20
        pathItem = [[embBezierPathItem alloc] init];
		pathItem.pathDelay = outDelay;
		pathItem.pathColor = outPathColor;
		pathItem.pathSpeed = pathSpeed;
		pathItem.pathWidth = pathWidth;
		pathItem.embPath = toI30_1Path;
		[_bezierPaths addObject:pathItem];
        
        //21
        pathItem = [[embBezierPathItem alloc] init];
        pathItem.pathDelay = outDelay;
        pathItem.pathColor = outPathColor;
        pathItem.pathSpeed = pathSpeed;
        pathItem.pathWidth = pathWidth;
        pathItem.embPath = toI30_2Path;
        [_bezierPaths addObject:pathItem];
        
        //22
        pathItem = [[embBezierPathItem alloc] init];
		pathItem.pathDelay = inDelay;
		pathItem.pathColor = outPathColor;
		pathItem.pathSpeed = pathSpeed;
		pathItem.pathWidth = pathWidth;
		pathItem.embPath = city_To_AirPortPath;
		[_bezierPaths addObject:pathItem];
        
        //23
        pathItem = [[embBezierPathItem alloc] init];
        pathItem.pathDelay = inDelay;
        pathItem.pathColor = outPathColor;
        pathItem.pathSpeed = pathSpeed;
        pathItem.pathWidth = pathWidth;
        pathItem.embPath = city_To_LoveFieldPath;
        [_bezierPaths addObject:pathItem];
	}
	
	return self;
}

@end
