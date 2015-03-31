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
        CGFloat inDelay = 1.0;
        CGFloat outDelay = 4.0;

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
        [outDallasNorthTollWay1Path addCurveToPoint: CGPointMake(488, 438) controlPoint1: CGPointMake(532, 421) controlPoint2: CGPointMake(493, 442)];
        [outDallasNorthTollWay1Path addCurveToPoint: CGPointMake(479, 399) controlPoint1: CGPointMake(486.33, 436.67) controlPoint2: CGPointMake(482.5, 413.01)];
        [outDallasNorthTollWay1Path addCurveToPoint: CGPointMake(461, 285) controlPoint1: CGPointMake(472, 371) controlPoint2: CGPointMake(462, 291)];
        [outDallasNorthTollWay1Path addCurveToPoint: CGPointMake(450, 254) controlPoint1: CGPointMake(459.5, 276) controlPoint2: CGPointMake(453, 261)];
        [outDallasNorthTollWay1Path addCurveToPoint: CGPointMake(431, 157) controlPoint1: CGPointMake(447, 247) controlPoint2: CGPointMake(431, 161)];
        [outDallasNorthTollWay1Path addCurveToPoint: CGPointMake(431, 125) controlPoint1: CGPointMake(431, 153) controlPoint2: CGPointMake(431, 133)];
        [outDallasNorthTollWay1Path addCurveToPoint: CGPointMake(444, 0) controlPoint1: CGPointMake(431, 117) controlPoint2: CGPointMake(444, 0)];
        
        //// OutDallasNorthTollWay2 Drawing
        //4
        UIBezierPath* outDallasNorthTollWay2Path = UIBezierPath.bezierPath;
        [outDallasNorthTollWay2Path moveToPoint: CGPointMake(502, 398)];
        [outDallasNorthTollWay2Path addCurveToPoint: CGPointMake(523, 401) controlPoint1: CGPointMake(502, 398) controlPoint2: CGPointMake(522, 404)];
        [outDallasNorthTollWay2Path addCurveToPoint: CGPointMake(523, 369) controlPoint1: CGPointMake(524, 398) controlPoint2: CGPointMake(522, 377)];
        [outDallasNorthTollWay2Path addCurveToPoint: CGPointMake(563, 333) controlPoint1: CGPointMake(524, 361) controlPoint2: CGPointMake(561, 337)];
        [outDallasNorthTollWay2Path addCurveToPoint: CGPointMake(502, 268) controlPoint1: CGPointMake(565, 329) controlPoint2: CGPointMake(508, 271)];
        [outDallasNorthTollWay2Path addCurveToPoint: CGPointMake(466, 259) controlPoint1: CGPointMake(496, 265) controlPoint2: CGPointMake(469, 264)];
        [outDallasNorthTollWay2Path addCurveToPoint: CGPointMake(455, 211) controlPoint1: CGPointMake(463, 254) controlPoint2: CGPointMake(459, 229)];
        [outDallasNorthTollWay2Path addCurveToPoint: CGPointMake(444, 127) controlPoint1: CGPointMake(451, 193) controlPoint2: CGPointMake(443, 145)];
        [outDallasNorthTollWay2Path addCurveToPoint: CGPointMake(457, -2) controlPoint1: CGPointMake(445, 109) controlPoint2: CGPointMake(457, -2)];
        
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
        [outWoodallRogers1Path addCurveToPoint: CGPointMake(535, 421) controlPoint1: CGPointMake(517, 422) controlPoint2: CGPointMake(530, 424)];
        [outWoodallRogers1Path addCurveToPoint: CGPointMake(569, 387) controlPoint1: CGPointMake(540, 418) controlPoint2: CGPointMake(546.11, 408.93)];
        [outWoodallRogers1Path addCurveToPoint: CGPointMake(671, 290) controlPoint1: CGPointMake(609.73, 347.99) controlPoint2: CGPointMake(669.72, 293.84)];
        [outWoodallRogers1Path addCurveToPoint: CGPointMake(666, 167) controlPoint1: CGPointMake(673, 284) controlPoint2: CGPointMake(664.68, 174.94)];
        [outWoodallRogers1Path addCurveToPoint: CGPointMake(736.5, -0.5) controlPoint1: CGPointMake(668, 155) controlPoint2: CGPointMake(736.5, -0.5)];
        outWoodallRogers1Path.lineCapStyle = kCGLineCapRound;
        
        //// OutWoodallRogers2 Drawing
        //8
        UIBezierPath* outWoodallRogers2Path = UIBezierPath.bezierPath;
        [outWoodallRogers2Path moveToPoint: CGPointMake(504, 396)];
        [outWoodallRogers2Path addCurveToPoint: CGPointMake(520, 396) controlPoint1: CGPointMake(504, 396) controlPoint2: CGPointMake(518, 398)];
        [outWoodallRogers2Path addCurveToPoint: CGPointMake(517, 357) controlPoint1: CGPointMake(522, 394) controlPoint2: CGPointMake(515, 360)];
        [outWoodallRogers2Path addCurveToPoint: CGPointMake(536, 351) controlPoint1: CGPointMake(519, 354) controlPoint2: CGPointMake(532, 347)];
        [outWoodallRogers2Path addCurveToPoint: CGPointMake(552, 386) controlPoint1: CGPointMake(540, 355) controlPoint2: CGPointMake(549, 385)];
        [outWoodallRogers2Path addCurveToPoint: CGPointMake(657, 287) controlPoint1: CGPointMake(555, 387) controlPoint2: CGPointMake(655.72, 290.84)];
        [outWoodallRogers2Path addCurveToPoint: CGPointMake(652, 164) controlPoint1: CGPointMake(659, 281) controlPoint2: CGPointMake(650.68, 171.94)];
        [outWoodallRogers2Path addCurveToPoint: CGPointMake(722.5, -3.5) controlPoint1: CGPointMake(654, 152) controlPoint2: CGPointMake(722.5, -3.5)];
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
        [outKatyTrailPath addCurveToPoint: CGPointMake(528, 399) controlPoint1: CGPointMake(504, 405) controlPoint2: CGPointMake(528, 405)];
        [outKatyTrailPath addCurveToPoint: CGPointMake(526, 365) controlPoint1: CGPointMake(528, 393) controlPoint2: CGPointMake(527.5, 370)];
        [outKatyTrailPath addCurveToPoint: CGPointMake(482, 287) controlPoint1: CGPointMake(520, 345) controlPoint2: CGPointMake(488.06, 305.29)];
        [outKatyTrailPath addCurveToPoint: CGPointMake(491, 273) controlPoint1: CGPointMake(480.29, 281.84) controlPoint2: CGPointMake(486.76, 277.66)];
        [outKatyTrailPath addCurveToPoint: CGPointMake(573, 216) controlPoint1: CGPointMake(499, 264.21) controlPoint2: CGPointMake(566.33, 221.3)];
        [outKatyTrailPath addCurveToPoint: CGPointMake(604, 137) controlPoint1: CGPointMake(579.99, 210.44) controlPoint2: CGPointMake(590.88, 155.16)];
        [outKatyTrailPath addCurveToPoint: CGPointMake(635, 95) controlPoint1: CGPointMake(617, 119) controlPoint2: CGPointMake(627.06, 108.26)];
        [outKatyTrailPath addCurveToPoint: CGPointMake(681, 0) controlPoint1: CGPointMake(650.95, 68.37) controlPoint2: CGPointMake(663, 32)];
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
        
        //// FromI35_3 Drawing
        //13
        UIBezierPath* fromI35_3Path = UIBezierPath.bezierPath;
        [fromI35_3Path moveToPoint: CGPointMake(515, 768)];
        [fromI35_3Path addCurveToPoint: CGPointMake(509, 696) controlPoint1: CGPointMake(515, 768) controlPoint2: CGPointMake(508, 708)];
        [fromI35_3Path addCurveToPoint: CGPointMake(559, 600) controlPoint1: CGPointMake(510, 684) controlPoint2: CGPointMake(560, 624)];
        [fromI35_3Path addCurveToPoint: CGPointMake(515, 551) controlPoint1: CGPointMake(558, 576) controlPoint2: CGPointMake(523, 560)];
        [fromI35_3Path addCurveToPoint: CGPointMake(495, 511) controlPoint1: CGPointMake(507, 542) controlPoint2: CGPointMake(498, 528)];
        [fromI35_3Path addCurveToPoint: CGPointMake(493, 420) controlPoint1: CGPointMake(492, 494) controlPoint2: CGPointMake(490, 425)];
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
        [fromI35_4Path addCurveToPoint: CGPointMake(495, 511) controlPoint1: CGPointMake(507, 542) controlPoint2: CGPointMake(498, 528)];
        [fromI35_4Path addCurveToPoint: CGPointMake(492, 408) controlPoint1: CGPointMake(492, 494) controlPoint2: CGPointMake(495, 431)];
        [fromI35_4Path addCurveToPoint: CGPointMake(470, 313) controlPoint1: CGPointMake(489, 385) controlPoint2: CGPointMake(469, 322)];
        [fromI35_4Path addCurveToPoint: CGPointMake(489, 332) controlPoint1: CGPointMake(471, 304) controlPoint2: CGPointMake(479.75, 311)];
        [fromI35_4Path addCurveToPoint: CGPointMake(507, 397) controlPoint1: CGPointMake(498.25, 353) controlPoint2: CGPointMake(509, 394)];
        [fromI35_4Path addCurveToPoint: CGPointMake(498, 399) controlPoint1: CGPointMake(505, 400) controlPoint2: CGPointMake(498, 399)];
        
        //// OutI35_1 Drawing
        //15
        UIBezierPath* outI35_1Path = UIBezierPath.bezierPath;
        [outI35_1Path moveToPoint: CGPointMake(501, 401)];
        [outI35_1Path addCurveToPoint: CGPointMake(521, 398) controlPoint1: CGPointMake(501, 401) controlPoint2: CGPointMake(520, 402)];
        [outI35_1Path addCurveToPoint: CGPointMake(513, 334) controlPoint1: CGPointMake(522, 394) controlPoint2: CGPointMake(530, 356)];
        [outI35_1Path addCurveToPoint: CGPointMake(455, 276) controlPoint1: CGPointMake(493.18, 308.35) controlPoint2: CGPointMake(458.26, 279.61)];
        [outI35_1Path addCurveToPoint: CGPointMake(385, 230) controlPoint1: CGPointMake(442.29, 261.94) controlPoint2: CGPointMake(397.19, 234.06)];
        [outI35_1Path addCurveToPoint: CGPointMake(265, 189) controlPoint1: CGPointMake(375.11, 226.7) controlPoint2: CGPointMake(319.5, 218.59)];
        [outI35_1Path addCurveToPoint: CGPointMake(135, 119) controlPoint1: CGPointMake(227.07, 168.41) controlPoint2: CGPointMake(177.27, 121.46)];
        [outI35_1Path addCurveToPoint: CGPointMake(51, 112) controlPoint1: CGPointMake(100.47, 116.99) controlPoint2: CGPointMake(78.81, 116.21)];
        [outI35_1Path addCurveToPoint: CGPointMake(-0, 72) controlPoint1: CGPointMake(18, 107) controlPoint2: CGPointMake(-0, 72)];
        outI35_1Path.lineCapStyle = kCGLineCapRound;
        
        //// OutI35_2 Drawing
        //16
        UIBezierPath* outI35_2Path = UIBezierPath.bezierPath;
        [outI35_2Path moveToPoint: CGPointMake(503, 394)];
        [outI35_2Path addCurveToPoint: CGPointMake(520, 394) controlPoint1: CGPointMake(503, 394) controlPoint2: CGPointMake(515.28, 393.89)];
        [outI35_2Path addCurveToPoint: CGPointMake(528, 405) controlPoint1: CGPointMake(523.8, 394.09) controlPoint2: CGPointMake(528.6, 399.58)];
        [outI35_2Path addCurveToPoint: CGPointMake(525, 427) controlPoint1: CGPointMake(527, 414) controlPoint2: CGPointMake(527.87, 425.94)];
        [outI35_2Path addCurveToPoint: CGPointMake(488, 438) controlPoint1: CGPointMake(518.25, 429.5) controlPoint2: CGPointMake(490, 443)];
        [outI35_2Path addCurveToPoint: CGPointMake(485, 405) controlPoint1: CGPointMake(486, 433) controlPoint2: CGPointMake(488.58, 423.67)];
        [outI35_2Path addCurveToPoint: CGPointMake(458, 297) controlPoint1: CGPointMake(477.26, 364.67) controlPoint2: CGPointMake(461.42, 301.1)];
        [outI35_2Path addCurveToPoint: CGPointMake(379, 242) controlPoint1: CGPointMake(438.53, 273.64) controlPoint2: CGPointMake(391.19, 246.06)];
        [outI35_2Path addCurveToPoint: CGPointMake(256, 199) controlPoint1: CGPointMake(369.11, 238.7) controlPoint2: CGPointMake(310.5, 228.59)];
        [outI35_2Path addCurveToPoint: CGPointMake(127, 131) controlPoint1: CGPointMake(218.07, 178.41) controlPoint2: CGPointMake(169.27, 133.46)];
        [outI35_2Path addCurveToPoint: CGPointMake(43, 124) controlPoint1: CGPointMake(92.47, 128.99) controlPoint2: CGPointMake(69.97, 129.06)];
        [outI35_2Path addCurveToPoint: CGPointMake(-8, 84) controlPoint1: CGPointMake(11, 118) controlPoint2: CGPointMake(-8, 84)];
        outI35_2Path.lineCapStyle = kCGLineCapRound;
        
        //// OutI35_3 Drawing
        //17
        UIBezierPath* outI35_3Path = UIBezierPath.bezierPath;
        [outI35_3Path moveToPoint: CGPointMake(501, 392)];
        [outI35_3Path addCurveToPoint: CGPointMake(525, 395) controlPoint1: CGPointMake(501, 392) controlPoint2: CGPointMake(519, 389.5)];
        [outI35_3Path addCurveToPoint: CGPointMake(529, 413) controlPoint1: CGPointMake(531, 400.5) controlPoint2: CGPointMake(529.5, 410.5)];
        [outI35_3Path addCurveToPoint: CGPointMake(523, 427) controlPoint1: CGPointMake(528.5, 415.5) controlPoint2: CGPointMake(525, 426)];
        [outI35_3Path addCurveToPoint: CGPointMake(512, 434) controlPoint1: CGPointMake(522.12, 427.44) controlPoint2: CGPointMake(517.45, 431.71)];
        [outI35_3Path addCurveToPoint: CGPointMake(498, 438) controlPoint1: CGPointMake(505, 436.94) controlPoint2: CGPointMake(500, 435)];
        [outI35_3Path addCurveToPoint: CGPointMake(499, 491) controlPoint1: CGPointMake(496, 441) controlPoint2: CGPointMake(499, 491)];
        [outI35_3Path addCurveToPoint: CGPointMake(502, 515) controlPoint1: CGPointMake(499, 491) controlPoint2: CGPointMake(500, 508)];
        [outI35_3Path addCurveToPoint: CGPointMake(515, 542) controlPoint1: CGPointMake(504, 522) controlPoint2: CGPointMake(504.25, 529.25)];
        [outI35_3Path addCurveToPoint: CGPointMake(545, 566) controlPoint1: CGPointMake(525.75, 554.75) controlPoint2: CGPointMake(534, 556)];
        [outI35_3Path addCurveToPoint: CGPointMake(563, 589) controlPoint1: CGPointMake(556, 576) controlPoint2: CGPointMake(559, 578)];
        [outI35_3Path addCurveToPoint: CGPointMake(562, 616) controlPoint1: CGPointMake(567, 600) controlPoint2: CGPointMake(565, 608)];
        [outI35_3Path addCurveToPoint: CGPointMake(523, 681) controlPoint1: CGPointMake(559, 624) controlPoint2: CGPointMake(523, 681)];
        [outI35_3Path addCurveToPoint: CGPointMake(516, 695) controlPoint1: CGPointMake(523, 681) controlPoint2: CGPointMake(518, 690)];
        [outI35_3Path addCurveToPoint: CGPointMake(521, 769) controlPoint1: CGPointMake(514, 700) controlPoint2: CGPointMake(521, 769)];
        [UIColor.blackColor setStroke];
        
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
        [toI30_1Path addCurveToPoint: CGPointMake(527, 415) controlPoint1: CGPointMake(517, 416) controlPoint2: CGPointMake(530.75, 409.5)];
        [toI30_1Path addCurveToPoint: CGPointMake(500, 437) controlPoint1: CGPointMake(523.25, 420.5) controlPoint2: CGPointMake(517, 438)];
        [toI30_1Path addCurveToPoint: CGPointMake(499, 467) controlPoint1: CGPointMake(493.59, 436.62) controlPoint2: CGPointMake(497.86, 451.97)];
        [toI30_1Path addCurveToPoint: CGPointMake(503, 527) controlPoint1: CGPointMake(500.88, 491.86) controlPoint2: CGPointMake(502.99, 525.59)];
        [toI30_1Path addCurveToPoint: CGPointMake(486.29, 555.73) controlPoint1: CGPointMake(503.09, 535.14) controlPoint2: CGPointMake(498.13, 545.76)];
        [toI30_1Path addCurveToPoint: CGPointMake(441.5, 574.5) controlPoint1: CGPointMake(478.07, 562.65) controlPoint2: CGPointMake(464.35, 569.26)];
        [toI30_1Path addCurveToPoint: CGPointMake(291, 603.5) controlPoint1: CGPointMake(385.75, 587.28) controlPoint2: CGPointMake(349.1, 593.88)];
        [toI30_1Path addCurveToPoint: CGPointMake(196, 640) controlPoint1: CGPointMake(232.9, 613.12) controlPoint2: CGPointMake(242, 633)];
        [toI30_1Path addCurveToPoint: CGPointMake(78, 610) controlPoint1: CGPointMake(150, 647) controlPoint2: CGPointMake(113, 619)];
        [toI30_1Path addCurveToPoint: CGPointMake(1.5, 603.5) controlPoint1: CGPointMake(43, 601) controlPoint2: CGPointMake(1.5, 603.5)];
        toI30_1Path.lineCapStyle = kCGLineCapRound;
        
        //// ToI30_2 Drawing
        //21
        UIBezierPath* toI30_2Path = UIBezierPath.bezierPath;
        [toI30_2Path moveToPoint: CGPointMake(506, 394)];
        [toI30_2Path addCurveToPoint: CGPointMake(515, 397) controlPoint1: CGPointMake(506, 394) controlPoint2: CGPointMake(514, 392)];
        [toI30_2Path addCurveToPoint: CGPointMake(515, 415) controlPoint1: CGPointMake(515.5, 399.5) controlPoint2: CGPointMake(512.98, 413.99)];
        [toI30_2Path addCurveToPoint: CGPointMake(527, 415) controlPoint1: CGPointMake(517, 416) controlPoint2: CGPointMake(530.75, 409.5)];
        [toI30_2Path addCurveToPoint: CGPointMake(500, 437) controlPoint1: CGPointMake(523.25, 420.5) controlPoint2: CGPointMake(517, 438)];
        [toI30_2Path addCurveToPoint: CGPointMake(499, 467) controlPoint1: CGPointMake(493.59, 436.62) controlPoint2: CGPointMake(497.86, 451.96)];
        [toI30_2Path addCurveToPoint: CGPointMake(506, 523) controlPoint1: CGPointMake(500.88, 491.86) controlPoint2: CGPointMake(504.25, 519.5)];
        [toI30_2Path addCurveToPoint: CGPointMake(530, 559) controlPoint1: CGPointMake(508.9, 528.81) controlPoint2: CGPointMake(518.94, 550.16)];
        [toI30_2Path addCurveToPoint: CGPointMake(570, 570) controlPoint1: CGPointMake(536.92, 564.52) controlPoint2: CGPointMake(555.08, 574.3)];
        [toI30_2Path addCurveToPoint: CGPointMake(610, 538) controlPoint1: CGPointMake(588.74, 564.6) controlPoint2: CGPointMake(601, 545)];
        [toI30_2Path addCurveToPoint: CGPointMake(723, 503) controlPoint1: CGPointMake(619, 531) controlPoint2: CGPointMake(717, 506)];
        [toI30_2Path addCurveToPoint: CGPointMake(762, 464) controlPoint1: CGPointMake(729, 500) controlPoint2: CGPointMake(750, 472)];
        [toI30_2Path addCurveToPoint: CGPointMake(789, 454) controlPoint1: CGPointMake(774, 456) controlPoint2: CGPointMake(789, 454)];
        [toI30_2Path addCurveToPoint: CGPointMake(824, 452) controlPoint1: CGPointMake(789, 454) controlPoint2: CGPointMake(806.25, 455)];
        [toI30_2Path addCurveToPoint: CGPointMake(857, 441) controlPoint1: CGPointMake(841.75, 449) controlPoint2: CGPointMake(850, 446)];
        [toI30_2Path addCurveToPoint: CGPointMake(878, 401) controlPoint1: CGPointMake(864, 436) controlPoint2: CGPointMake(872, 408)];
        [toI30_2Path addCurveToPoint: CGPointMake(932, 350) controlPoint1: CGPointMake(884, 394) controlPoint2: CGPointMake(921, 359)];
        [toI30_2Path addCurveToPoint: CGPointMake(1025, 337) controlPoint1: CGPointMake(943, 341) controlPoint2: CGPointMake(1025, 337)];
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
		pathItem.pathSpeed = pathSpeed;
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
		pathItem.pathSpeed = pathSpeed;
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
		pathItem.pathDelay = inDelay;
		pathItem.pathColor = inPathColor;
		pathItem.pathSpeed = pathSpeed;
		pathItem.pathWidth = pathWidth;
		pathItem.embPath = fromI35_2Path;
		[_bezierPaths addObject:pathItem];
        
        //13
        pathItem = [[embBezierPathItem alloc] init];
        pathItem.pathDelay = inDelay;
        pathItem.pathColor = inPathColor;
        pathItem.pathSpeed = pathSpeed;
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
		pathItem.pathSpeed = pathSpeed;
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
		pathItem.pathColor = inPathColor;
		pathItem.pathSpeed = pathSpeed;
		pathItem.pathWidth = pathWidth;
		pathItem.embPath = city_To_AirPortPath;
		[_bezierPaths addObject:pathItem];
        
        //23
        pathItem = [[embBezierPathItem alloc] init];
        pathItem.pathDelay = inDelay;
        pathItem.pathColor = inPathColor;
        pathItem.pathSpeed = pathSpeed;
        pathItem.pathWidth = pathWidth;
        pathItem.embPath = city_To_LoveFieldPath;
        [_bezierPaths addObject:pathItem];
	}
	
	return self;
}

@end
