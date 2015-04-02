//
//  direction_Neighborhood.m
//  victoryCenter
//
//  Created by Xiaohe Hu on 3/31/15.
//  Copyright (c) 2015 Neoscape. All rights reserved.
//

#import "direction_Neighborhood.h"
#import "UIColor+Extensions.h"
@implementation direction_Neighborhood
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
        
        ////////////////////////////////Neighborhood////////////////////////////////
        
        //// Neighborhood_tollway1 Drawing
        //0
        UIBezierPath* neighborhood_tollway1Path = UIBezierPath.bezierPath;
        [neighborhood_tollway1Path moveToPoint: CGPointMake(368.5, 0.5)];
        [neighborhood_tollway1Path addCurveToPoint: CGPointMake(388, 83) controlPoint1: CGPointMake(370.37, 9.84) controlPoint2: CGPointMake(377.02, 46.99)];
        [neighborhood_tollway1Path addCurveToPoint: CGPointMake(411, 129) controlPoint1: CGPointMake(400.53, 124.1) controlPoint2: CGPointMake(411, 129)];
        [neighborhood_tollway1Path addCurveToPoint: CGPointMake(453, 161) controlPoint1: CGPointMake(411, 129) controlPoint2: CGPointMake(420, 133)];
        [neighborhood_tollway1Path addCurveToPoint: CGPointMake(593, 319) controlPoint1: CGPointMake(486, 189) controlPoint2: CGPointMake(593, 319)];
        [neighborhood_tollway1Path addCurveToPoint: CGPointMake(534, 370) controlPoint1: CGPointMake(593, 319) controlPoint2: CGPointMake(560, 352)];
        [neighborhood_tollway1Path addCurveToPoint: CGPointMake(499, 385) controlPoint1: CGPointMake(508, 388) controlPoint2: CGPointMake(503, 376)];
        [neighborhood_tollway1Path addCurveToPoint: CGPointMake(507, 445) controlPoint1: CGPointMake(495, 394) controlPoint2: CGPointMake(507, 445)];
        [neighborhood_tollway1Path addLineToPoint: CGPointMake(492, 449)];
        neighborhood_tollway1Path.lineCapStyle = kCGLineCapRound;
        
        //// Neighborhood_tollway2 Drawing
        //1
        UIBezierPath* neighborhood_tollway2Path = UIBezierPath.bezierPath;
        [neighborhood_tollway2Path moveToPoint: CGPointMake(408, -5)];
        [neighborhood_tollway2Path addCurveToPoint: CGPointMake(367, 56) controlPoint1: CGPointMake(408, 5.25) controlPoint2: CGPointMake(378.39, 39.35)];
        [neighborhood_tollway2Path addCurveToPoint: CGPointMake(328, 138) controlPoint1: CGPointMake(354, 75) controlPoint2: CGPointMake(324, 128)];
        [neighborhood_tollway2Path addCurveToPoint: CGPointMake(379, 179) controlPoint1: CGPointMake(332, 148) controlPoint2: CGPointMake(358, 154)];
        [neighborhood_tollway2Path addCurveToPoint: CGPointMake(415, 261) controlPoint1: CGPointMake(400, 204) controlPoint2: CGPointMake(413, 252)];
        [neighborhood_tollway2Path addCurveToPoint: CGPointMake(458, 266) controlPoint1: CGPointMake(417, 270) controlPoint2: CGPointMake(453, 261)];
        [neighborhood_tollway2Path addCurveToPoint: CGPointMake(512, 442) controlPoint1: CGPointMake(463, 271) controlPoint2: CGPointMake(513, 439)];
        [neighborhood_tollway2Path addCurveToPoint: CGPointMake(498, 447) controlPoint1: CGPointMake(511, 445) controlPoint2: CGPointMake(498, 447)];
        neighborhood_tollway2Path.lineCapStyle = kCGLineCapRound;
        
        //// Neighborhood_tollway3 Drawing
        //2
        UIBezierPath* neighborhood_tollway3Path = UIBezierPath.bezierPath;
        [neighborhood_tollway3Path moveToPoint: CGPointMake(369, 0)];
        [neighborhood_tollway3Path addLineToPoint: CGPointMake(406, 148)];
        [neighborhood_tollway3Path addCurveToPoint: CGPointMake(420, 206) controlPoint1: CGPointMake(406, 148) controlPoint2: CGPointMake(417.5, 178)];
        [neighborhood_tollway3Path addCurveToPoint: CGPointMake(440, 330) controlPoint1: CGPointMake(422.5, 234) controlPoint2: CGPointMake(440, 330)];
        [neighborhood_tollway3Path addCurveToPoint: CGPointMake(460, 438) controlPoint1: CGPointMake(440, 330) controlPoint2: CGPointMake(459, 425)];
        [neighborhood_tollway3Path addCurveToPoint: CGPointMake(465, 490) controlPoint1: CGPointMake(461, 451) controlPoint2: CGPointMake(461, 483)];
        [neighborhood_tollway3Path addCurveToPoint: CGPointMake(515, 484) controlPoint1: CGPointMake(469, 497) controlPoint2: CGPointMake(511, 489)];
        [neighborhood_tollway3Path addCurveToPoint: CGPointMake(507, 443) controlPoint1: CGPointMake(519, 479) controlPoint2: CGPointMake(509, 447)];
        [neighborhood_tollway3Path addCurveToPoint: CGPointMake(491, 443) controlPoint1: CGPointMake(505, 439) controlPoint2: CGPointMake(491, 443)];
        neighborhood_tollway3Path.lineCapStyle = kCGLineCapRound;
        
        //// OutNeighborhood_tollway1 Drawing
        //3
        UIBezierPath* outNeighborhood_tollway1Path = UIBezierPath.bezierPath;
        [outNeighborhood_tollway1Path moveToPoint: CGPointMake(491, 439)];
        [outNeighborhood_tollway1Path addCurveToPoint: CGPointMake(507, 439) controlPoint1: CGPointMake(491, 439) controlPoint2: CGPointMake(505, 435)];
        [outNeighborhood_tollway1Path addCurveToPoint: CGPointMake(515, 484) controlPoint1: CGPointMake(509, 443) controlPoint2: CGPointMake(519, 479)];
        [outNeighborhood_tollway1Path addCurveToPoint: CGPointMake(557, 484) controlPoint1: CGPointMake(511, 489) controlPoint2: CGPointMake(548, 478)];
        [outNeighborhood_tollway1Path addCurveToPoint: CGPointMake(535, 523) controlPoint1: CGPointMake(560.99, 486.66) controlPoint2: CGPointMake(554.17, 510.85)];
        [outNeighborhood_tollway1Path addCurveToPoint: CGPointMake(468, 533) controlPoint1: CGPointMake(510.88, 538.29) controlPoint2: CGPointMake(471, 535)];
        [outNeighborhood_tollway1Path addCurveToPoint: CGPointMake(463, 443) controlPoint1: CGPointMake(466.89, 532.26) controlPoint2: CGPointMake(470.73, 489.2)];
        [outNeighborhood_tollway1Path addCurveToPoint: CGPointMake(440, 330) controlPoint1: CGPointMake(453.84, 388.26) controlPoint2: CGPointMake(440, 330)];
        [outNeighborhood_tollway1Path addCurveToPoint: CGPointMake(416, 197) controlPoint1: CGPointMake(440, 330) controlPoint2: CGPointMake(418.5, 225)];
        [outNeighborhood_tollway1Path addCurveToPoint: CGPointMake(365, -1) controlPoint1: CGPointMake(413.5, 169) controlPoint2: CGPointMake(365, -1)];
        outNeighborhood_tollway1Path.lineCapStyle = kCGLineCapRound;
        
        
        //// OutNeighborhood_tollway2 Drawing
        //4
        UIBezierPath* outNeighborhood_tollway2Path = UIBezierPath.bezierPath;
        [outNeighborhood_tollway2Path moveToPoint: CGPointMake(488, 439)];
        [outNeighborhood_tollway2Path addCurveToPoint: CGPointMake(507, 439) controlPoint1: CGPointMake(488, 439) controlPoint2: CGPointMake(507, 434)];
        [outNeighborhood_tollway2Path addCurveToPoint: CGPointMake(507, 445) controlPoint1: CGPointMake(507, 444) controlPoint2: CGPointMake(507, 441)];
        [outNeighborhood_tollway2Path addCurveToPoint: CGPointMake(544, 450) controlPoint1: CGPointMake(507, 449) controlPoint2: CGPointMake(538, 445)];
        [outNeighborhood_tollway2Path addCurveToPoint: CGPointMake(537, 369) controlPoint1: CGPointMake(550, 455) controlPoint2: CGPointMake(541, 377)];
        [outNeighborhood_tollway2Path addCurveToPoint: CGPointMake(622, 289) controlPoint1: CGPointMake(533, 361) controlPoint2: CGPointMake(620, 303)];
        [outNeighborhood_tollway2Path addCurveToPoint: CGPointMake(516, 173) controlPoint1: CGPointMake(623.34, 279.63) controlPoint2: CGPointMake(561.78, 214.91)];
        [outNeighborhood_tollway2Path addCurveToPoint: CGPointMake(468, 140) controlPoint1: CGPointMake(493.35, 152.26) controlPoint2: CGPointMake(489, 150)];
        [outNeighborhood_tollway2Path addCurveToPoint: CGPointMake(398, 118) controlPoint1: CGPointMake(447, 130) controlPoint2: CGPointMake(405, 127)];
        [outNeighborhood_tollway2Path addCurveToPoint: CGPointMake(369, 0) controlPoint1: CGPointMake(391, 109) controlPoint2: CGPointMake(369, 0)];
        
        //// Neighborhood_Wooddall Drawing
        //5
        UIBezierPath* neighborhood_WooddallPath = UIBezierPath.bezierPath;
        [neighborhood_WooddallPath moveToPoint: CGPointMake(874, 1)];
        [neighborhood_WooddallPath addCurveToPoint: CGPointMake(882, 185) controlPoint1: CGPointMake(878, 61) controlPoint2: CGPointMake(884, 167)];
        [neighborhood_WooddallPath addCurveToPoint: CGPointMake(790, 272) controlPoint1: CGPointMake(881.11, 193.01) controlPoint2: CGPointMake(836.42, 229.54)];
        [neighborhood_WooddallPath addCurveToPoint: CGPointMake(617, 434) controlPoint1: CGPointMake(752.87, 305.96) controlPoint2: CGPointMake(670, 381.7)];
        [neighborhood_WooddallPath addCurveToPoint: CGPointMake(568, 487) controlPoint1: CGPointMake(587.32, 463.29) controlPoint2: CGPointMake(570.15, 488.44)];
        [neighborhood_WooddallPath addCurveToPoint: CGPointMake(545, 482) controlPoint1: CGPointMake(562, 483) controlPoint2: CGPointMake(547, 486)];
        [neighborhood_WooddallPath addCurveToPoint: CGPointMake(545, 446) controlPoint1: CGPointMake(543, 478) controlPoint2: CGPointMake(551, 452)];
        [neighborhood_WooddallPath addCurveToPoint: CGPointMake(495, 446) controlPoint1: CGPointMake(539, 440) controlPoint2: CGPointMake(498, 449)];
        neighborhood_WooddallPath.lineCapStyle = kCGLineCapRound;
        
        //// Neighborhood_Wooddall 2 Drawing
        //6
        UIBezierPath* neighborhood_Wooddall2Path = UIBezierPath.bezierPath;
        [neighborhood_Wooddall2Path moveToPoint: CGPointMake(874, 1)];
        [neighborhood_Wooddall2Path addCurveToPoint: CGPointMake(882, 185) controlPoint1: CGPointMake(878, 61) controlPoint2: CGPointMake(884, 167)];
        [neighborhood_Wooddall2Path addCurveToPoint: CGPointMake(790, 272) controlPoint1: CGPointMake(881.11, 193.01) controlPoint2: CGPointMake(836.42, 229.54)];
        [neighborhood_Wooddall2Path addCurveToPoint: CGPointMake(617, 429) controlPoint1: CGPointMake(732.08, 324.98) controlPoint2: CGPointMake(628, 426)];
        [neighborhood_Wooddall2Path addCurveToPoint: CGPointMake(567, 346) controlPoint1: CGPointMake(606, 432) controlPoint2: CGPointMake(573, 351)];
        [neighborhood_Wooddall2Path addCurveToPoint: CGPointMake(534, 370) controlPoint1: CGPointMake(561, 341) controlPoint2: CGPointMake(545, 363)];
        [neighborhood_Wooddall2Path addCurveToPoint: CGPointMake(499, 385) controlPoint1: CGPointMake(523, 377) controlPoint2: CGPointMake(501, 380)];
        [neighborhood_Wooddall2Path addCurveToPoint: CGPointMake(507, 433) controlPoint1: CGPointMake(497, 390) controlPoint2: CGPointMake(508, 429)];
        [neighborhood_Wooddall2Path addCurveToPoint: CGPointMake(495, 436) controlPoint1: CGPointMake(506, 437) controlPoint2: CGPointMake(495, 436)];
        neighborhood_Wooddall2Path.lineCapStyle = kCGLineCapRound;
        
        //// OutNeighborhood_Wooddall1 Drawing
        //7
        UIBezierPath* outNeighborhood_Wooddall1Path = UIBezierPath.bezierPath;
        [outNeighborhood_Wooddall1Path moveToPoint: CGPointMake(495, 441)];
        [outNeighborhood_Wooddall1Path addCurveToPoint: CGPointMake(545, 448) controlPoint1: CGPointMake(495, 441) controlPoint2: CGPointMake(541, 442)];
        [outNeighborhood_Wooddall1Path addCurveToPoint: CGPointMake(545, 482) controlPoint1: CGPointMake(549, 454) controlPoint2: CGPointMake(537, 476)];
        [outNeighborhood_Wooddall1Path addCurveToPoint: CGPointMake(571, 482) controlPoint1: CGPointMake(548.76, 484.82) controlPoint2: CGPointMake(558.8, 494.73)];
        [outNeighborhood_Wooddall1Path addCurveToPoint: CGPointMake(790, 272) controlPoint1: CGPointMake(594, 458) controlPoint2: CGPointMake(732.08, 324.98)];
        [outNeighborhood_Wooddall1Path addCurveToPoint: CGPointMake(882, 185) controlPoint1: CGPointMake(836.42, 229.54) controlPoint2: CGPointMake(881.11, 193.01)];
        [outNeighborhood_Wooddall1Path addCurveToPoint: CGPointMake(874, 1) controlPoint1: CGPointMake(884, 167) controlPoint2: CGPointMake(878, 61)];
        outNeighborhood_Wooddall1Path.lineCapStyle = kCGLineCapRound;

        
        //// OutNeighborhood_Wooddall2 Drawing
        //8
        UIBezierPath* outNeighborhood_Wooddall2Path = UIBezierPath.bezierPath;
        [outNeighborhood_Wooddall2Path moveToPoint: CGPointMake(495, 441)];
        [outNeighborhood_Wooddall2Path addCurveToPoint: CGPointMake(549, 445) controlPoint1: CGPointMake(517, 439) controlPoint2: CGPointMake(542, 447)];
        [outNeighborhood_Wooddall2Path addCurveToPoint: CGPointMake(537, 369) controlPoint1: CGPointMake(556, 443) controlPoint2: CGPointMake(531, 373)];
        [outNeighborhood_Wooddall2Path addCurveToPoint: CGPointMake(567, 346) controlPoint1: CGPointMake(543, 365) controlPoint2: CGPointMake(560, 345)];
        [outNeighborhood_Wooddall2Path addCurveToPoint: CGPointMake(617, 434) controlPoint1: CGPointMake(574, 347) controlPoint2: CGPointMake(611, 439)];
        [outNeighborhood_Wooddall2Path addCurveToPoint: CGPointMake(879, 193) controlPoint1: CGPointMake(623, 429) controlPoint2: CGPointMake(870, 200)];
        [outNeighborhood_Wooddall2Path addCurveToPoint: CGPointMake(872, -1) controlPoint1: CGPointMake(888, 186) controlPoint2: CGPointMake(872, -1)];
        
        //// Neighborhood_KatyRail Drawing
        //9
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

        //// To_Neighborhood_KatyRail Drawing
        //10
        UIBezierPath* to_Neighborhood_KatyRailPath = UIBezierPath.bezierPath;
        [to_Neighborhood_KatyRailPath moveToPoint: CGPointMake(497, 441)];
        [to_Neighborhood_KatyRailPath addCurveToPoint: CGPointMake(544, 445) controlPoint1: CGPointMake(497, 441) controlPoint2: CGPointMake(540.92, 447.69)];
        [to_Neighborhood_KatyRailPath addCurveToPoint: CGPointMake(540, 362) controlPoint1: CGPointMake(552, 438) controlPoint2: CGPointMake(545, 379)];
        [to_Neighborhood_KatyRailPath addCurveToPoint: CGPointMake(434, 176) controlPoint1: CGPointMake(526.15, 314.9) controlPoint2: CGPointMake(445, 221)];
        [to_Neighborhood_KatyRailPath addCurveToPoint: CGPointMake(625, 23) controlPoint1: CGPointMake(421.3, 124.03) controlPoint2: CGPointMake(585.49, 50.66)];
        [to_Neighborhood_KatyRailPath addCurveToPoint: CGPointMake(644, -2) controlPoint1: CGPointMake(645, 9) controlPoint2: CGPointMake(641.94, 0.22)];
        to_Neighborhood_KatyRailPath.lineCapStyle = kCGLineCapRound;


        //// Neighborhood_I35_1 Drawing
        //11
        UIBezierPath* neighborhood_I35_1Path = UIBezierPath.bezierPath;
        [neighborhood_I35_1Path moveToPoint: CGPointMake(0, 1)];
        [neighborhood_I35_1Path addCurveToPoint: CGPointMake(105, 32) controlPoint1: CGPointMake(22.02, 7.94) controlPoint2: CGPointMake(59.39, 21.26)];
        [neighborhood_I35_1Path addCurveToPoint: CGPointMake(214, 60) controlPoint1: CGPointMake(134.99, 39.06) controlPoint2: CGPointMake(178.3, 44.93)];
        [neighborhood_I35_1Path addCurveToPoint: CGPointMake(404, 198) controlPoint1: CGPointMake(304, 98) controlPoint2: CGPointMake(393, 176)];
        [neighborhood_I35_1Path addCurveToPoint: CGPointMake(452, 222) controlPoint1: CGPointMake(415, 220) controlPoint2: CGPointMake(440, 216)];
        [neighborhood_I35_1Path addCurveToPoint: CGPointMake(507, 299) controlPoint1: CGPointMake(458.28, 225.14) controlPoint2: CGPointMake(485.74, 263.32)];
        [neighborhood_I35_1Path addCurveToPoint: CGPointMake(540, 362) controlPoint1: CGPointMake(526.39, 331.54) controlPoint2: CGPointMake(542, 357)];
        [neighborhood_I35_1Path addCurveToPoint: CGPointMake(521, 378) controlPoint1: CGPointMake(538, 367) controlPoint2: CGPointMake(531.25, 372.25)];
        [neighborhood_I35_1Path addCurveToPoint: CGPointMake(499, 385) controlPoint1: CGPointMake(510.75, 383.75) controlPoint2: CGPointMake(501, 380)];
        [neighborhood_I35_1Path addCurveToPoint: CGPointMake(507, 444) controlPoint1: CGPointMake(497, 390) controlPoint2: CGPointMake(512, 439)];
        [neighborhood_I35_1Path addCurveToPoint: CGPointMake(492, 449) controlPoint1: CGPointMake(502, 449) controlPoint2: CGPointMake(492, 449)];
        neighborhood_I35_1Path.lineCapStyle = kCGLineCapRound;
        
        //// Neighborhood_I35_2 Drawing
        //12
        UIBezierPath* neighborhood_I35_2Path = UIBezierPath.bezierPath;
        [neighborhood_I35_2Path moveToPoint: CGPointMake(0, 1)];
        [neighborhood_I35_2Path addCurveToPoint: CGPointMake(105, 32) controlPoint1: CGPointMake(22.02, 7.94) controlPoint2: CGPointMake(59.39, 21.26)];
        [neighborhood_I35_2Path addCurveToPoint: CGPointMake(214, 60) controlPoint1: CGPointMake(134.99, 39.06) controlPoint2: CGPointMake(178.3, 44.93)];
        [neighborhood_I35_2Path addCurveToPoint: CGPointMake(396, 185) controlPoint1: CGPointMake(304, 98) controlPoint2: CGPointMake(381, 163)];
        [neighborhood_I35_2Path addCurveToPoint: CGPointMake(427, 268) controlPoint1: CGPointMake(402.18, 194.06) controlPoint2: CGPointMake(416.59, 229.29)];
        [neighborhood_I35_2Path addCurveToPoint: CGPointMake(469, 434) controlPoint1: CGPointMake(435.6, 299.97) controlPoint2: CGPointMake(451.14, 374.92)];
        [neighborhood_I35_2Path addCurveToPoint: CGPointMake(476, 527) controlPoint1: CGPointMake(482, 477) controlPoint2: CGPointMake(467, 527)];
        [neighborhood_I35_2Path addCurveToPoint: CGPointMake(522, 516) controlPoint1: CGPointMake(491.51, 527) controlPoint2: CGPointMake(510.87, 522)];
        [neighborhood_I35_2Path addCurveToPoint: CGPointMake(544, 498) controlPoint1: CGPointMake(536.7, 508.08) controlPoint2: CGPointMake(544, 498)];
        [neighborhood_I35_2Path addCurveToPoint: CGPointMake(544, 450) controlPoint1: CGPointMake(544, 498) controlPoint2: CGPointMake(546, 458)];
        [neighborhood_I35_2Path addCurveToPoint: CGPointMake(498, 447) controlPoint1: CGPointMake(542, 442) controlPoint2: CGPointMake(498, 447)];
        neighborhood_I35_2Path.lineCapStyle = kCGLineCapRound;
        
        //// Neighborhood_I35_3 Drawing
        //13
        UIBezierPath* neighborhood_I35_3Path = UIBezierPath.bezierPath;
        [neighborhood_I35_3Path moveToPoint: CGPointMake(505, 768)];
        [neighborhood_I35_3Path addCurveToPoint: CGPointMake(489, 734) controlPoint1: CGPointMake(505, 768) controlPoint2: CGPointMake(500, 757)];
        [neighborhood_I35_3Path addCurveToPoint: CGPointMake(475, 493) controlPoint1: CGPointMake(478, 711) controlPoint2: CGPointMake(472, 498)];
        [neighborhood_I35_3Path addCurveToPoint: CGPointMake(545, 482) controlPoint1: CGPointMake(478, 488) controlPoint2: CGPointMake(541, 485)];
        [neighborhood_I35_3Path addCurveToPoint: CGPointMake(543, 447) controlPoint1: CGPointMake(549, 479) controlPoint2: CGPointMake(545, 452)];
        [neighborhood_I35_3Path addCurveToPoint: CGPointMake(495, 445) controlPoint1: CGPointMake(541, 442) controlPoint2: CGPointMake(495, 445)];
        
        //// Neighborhood_I35_4 Drawing
        //14
        UIBezierPath* neighborhood_I35_4Path = UIBezierPath.bezierPath;
        [neighborhood_I35_4Path moveToPoint: CGPointMake(505, 768)];
        [neighborhood_I35_4Path addCurveToPoint: CGPointMake(485, 732) controlPoint1: CGPointMake(505, 768) controlPoint2: CGPointMake(489, 740)];
        [neighborhood_I35_4Path addCurveToPoint: CGPointMake(475, 493) controlPoint1: CGPointMake(481, 724) controlPoint2: CGPointMake(479, 576)];
        [neighborhood_I35_4Path addCurveToPoint: CGPointMake(423, 251) controlPoint1: CGPointMake(471, 410) controlPoint2: CGPointMake(417, 257)];
        [neighborhood_I35_4Path addCurveToPoint: CGPointMake(475, 299) controlPoint1: CGPointMake(429, 245) controlPoint2: CGPointMake(459, 280)];
        [neighborhood_I35_4Path addCurveToPoint: CGPointMake(492, 384) controlPoint1: CGPointMake(483.53, 309.13) controlPoint2: CGPointMake(485.33, 348.81)];
        [neighborhood_I35_4Path addCurveToPoint: CGPointMake(507, 444) controlPoint1: CGPointMake(497.84, 414.81) controlPoint2: CGPointMake(509.33, 442.13)];
        [neighborhood_I35_4Path addCurveToPoint: CGPointMake(492, 449) controlPoint1: CGPointMake(502, 448) controlPoint2: CGPointMake(492, 449)];
        
        //// OutNeighborhood_I35_1 Drawing
        //15
        UIBezierPath* outNeighborhood_I35_1Path = UIBezierPath.bezierPath;
        [outNeighborhood_I35_1Path moveToPoint: CGPointMake(497, 441)];
        [outNeighborhood_I35_1Path addCurveToPoint: CGPointMake(524, 450) controlPoint1: CGPointMake(497, 441) controlPoint2: CGPointMake(511.13, 450.15)];
        [outNeighborhood_I35_1Path addCurveToPoint: CGPointMake(549, 445) controlPoint1: CGPointMake(535.31, 449.87) controlPoint2: CGPointMake(548.53, 448.74)];
        [outNeighborhood_I35_1Path addCurveToPoint: CGPointMake(540, 362) controlPoint1: CGPointMake(550, 437) controlPoint2: CGPointMake(544, 381)];
        [outNeighborhood_I35_1Path addCurveToPoint: CGPointMake(444, 210) controlPoint1: CGPointMake(536, 343) controlPoint2: CGPointMake(503, 272)];
        [outNeighborhood_I35_1Path addCurveToPoint: CGPointMake(404, 198) controlPoint1: CGPointMake(402.66, 166.56) controlPoint2: CGPointMake(417.6, 214.07)];
        [outNeighborhood_I35_1Path addCurveToPoint: CGPointMake(214, 60) controlPoint1: CGPointMake(371, 159) controlPoint2: CGPointMake(304, 98)];
        [outNeighborhood_I35_1Path addCurveToPoint: CGPointMake(105, 32) controlPoint1: CGPointMake(178.3, 44.93) controlPoint2: CGPointMake(134.99, 39.06)];
        [outNeighborhood_I35_1Path addCurveToPoint: CGPointMake(5, -4) controlPoint1: CGPointMake(59.39, 21.26) controlPoint2: CGPointMake(27.02, 2.94)];
        outNeighborhood_I35_1Path.lineCapStyle = kCGLineCapRound;
        
        
        //// OutNeighborhood_I35_2 Drawing
        //16
        UIBezierPath* outNeighborhood_I35_2Path = UIBezierPath.bezierPath;
        [outNeighborhood_I35_2Path moveToPoint: CGPointMake(497, 441)];
        [outNeighborhood_I35_2Path addCurveToPoint: CGPointMake(547, 448) controlPoint1: CGPointMake(497, 441) controlPoint2: CGPointMake(544, 442)];
        [outNeighborhood_I35_2Path addCurveToPoint: CGPointMake(547, 507) controlPoint1: CGPointMake(550, 454) controlPoint2: CGPointMake(547, 507)];
        [outNeighborhood_I35_2Path addCurveToPoint: CGPointMake(522, 527) controlPoint1: CGPointMake(547, 507) controlPoint2: CGPointMake(536.7, 519.08)];
        [outNeighborhood_I35_2Path addCurveToPoint: CGPointMake(480, 535) controlPoint1: CGPointMake(510.87, 533) controlPoint2: CGPointMake(495.51, 535)];
        [outNeighborhood_I35_2Path addCurveToPoint: CGPointMake(469, 434) controlPoint1: CGPointMake(471, 535) controlPoint2: CGPointMake(482.1, 485.67)];
        [outNeighborhood_I35_2Path addCurveToPoint: CGPointMake(427, 268) controlPoint1: CGPointMake(451, 363) controlPoint2: CGPointMake(435.6, 299.97)];
        [outNeighborhood_I35_2Path addCurveToPoint: CGPointMake(396, 185) controlPoint1: CGPointMake(416.59, 229.29) controlPoint2: CGPointMake(402.18, 194.06)];
        [outNeighborhood_I35_2Path addCurveToPoint: CGPointMake(214, 60) controlPoint1: CGPointMake(381, 163) controlPoint2: CGPointMake(304, 98)];
        [outNeighborhood_I35_2Path addCurveToPoint: CGPointMake(105, 32) controlPoint1: CGPointMake(178.3, 44.93) controlPoint2: CGPointMake(134.99, 39.06)];
        [outNeighborhood_I35_2Path addCurveToPoint: CGPointMake(-8, -3) controlPoint1: CGPointMake(59.39, 21.26) controlPoint2: CGPointMake(14.02, 3.94)];
        outNeighborhood_I35_2Path.lineCapStyle = kCGLineCapRound;
        
        //// OutNeighborhood_I35_3 Drawing
        //17
        UIBezierPath* outNeighborhood_I35_3Path = UIBezierPath.bezierPath;
        [outNeighborhood_I35_3Path moveToPoint: CGPointMake(491, 443)];
        [outNeighborhood_I35_3Path addCurveToPoint: CGPointMake(510.5, 450.5) controlPoint1: CGPointMake(491, 443) controlPoint2: CGPointMake(508, 449)];
        [outNeighborhood_I35_3Path addCurveToPoint: CGPointMake(516, 484) controlPoint1: CGPointMake(513, 452) controlPoint2: CGPointMake(514, 482)];
        [outNeighborhood_I35_3Path addCurveToPoint: CGPointMake(563, 484) controlPoint1: CGPointMake(518, 486) controlPoint2: CGPointMake(564, 475)];
        [outNeighborhood_I35_3Path addCurveToPoint: CGPointMake(529, 526) controlPoint1: CGPointMake(562.49, 488.58) controlPoint2: CGPointMake(549.96, 512.44)];
        [outNeighborhood_I35_3Path addCurveToPoint: CGPointMake(477, 540) controlPoint1: CGPointMake(508.73, 539.11) controlPoint2: CGPointMake(480, 534)];
        [outNeighborhood_I35_3Path addCurveToPoint: CGPointMake(480, 664) controlPoint1: CGPointMake(475.2, 543.6) controlPoint2: CGPointMake(475.68, 610.74)];
        [outNeighborhood_I35_3Path addCurveToPoint: CGPointMake(489, 734) controlPoint1: CGPointMake(482.88, 699.57) controlPoint2: CGPointMake(487, 728)];
        [outNeighborhood_I35_3Path addCurveToPoint: CGPointMake(505, 775) controlPoint1: CGPointMake(491, 740) controlPoint2: CGPointMake(505, 775)];
        
        //// Neighhorhood_I30_1 Drawing
        //18
        UIBezierPath* neighhorhood_I30_1Path = UIBezierPath.bezierPath;
        [neighhorhood_I30_1Path moveToPoint: CGPointMake(476, 769)];
        [neighhorhood_I30_1Path addCurveToPoint: CGPointMake(479.45, 759.37) controlPoint1: CGPointMake(477.41, 765.2) controlPoint2: CGPointMake(478.81, 761.97)];
        [neighhorhood_I30_1Path addCurveToPoint: CGPointMake(485, 732) controlPoint1: CGPointMake(480.76, 754.05) controlPoint2: CGPointMake(481.45, 751.53)];
        [neighhorhood_I30_1Path addCurveToPoint: CGPointMake(482, 685) controlPoint1: CGPointMake(487, 721) controlPoint2: CGPointMake(483.96, 707.94)];
        [neighhorhood_I30_1Path addCurveToPoint: CGPointMake(476, 527) controlPoint1: CGPointMake(481.03, 673.61) controlPoint2: CGPointMake(474, 525)];
        [neighhorhood_I30_1Path addCurveToPoint: CGPointMake(509, 522) controlPoint1: CGPointMake(476.97, 527.97) controlPoint2: CGPointMake(492.77, 526.1)];
        [neighhorhood_I30_1Path addCurveToPoint: CGPointMake(547, 489) controlPoint1: CGPointMake(526.27, 517.64) controlPoint2: CGPointMake(548, 502)];
        [neighhorhood_I30_1Path addCurveToPoint: CGPointMake(515, 484) controlPoint1: CGPointMake(546, 476) controlPoint2: CGPointMake(517, 492)];
        [neighhorhood_I30_1Path addCurveToPoint: CGPointMake(509, 447) controlPoint1: CGPointMake(513, 476) controlPoint2: CGPointMake(513, 450)];
        [neighhorhood_I30_1Path addCurveToPoint: CGPointMake(497, 447) controlPoint1: CGPointMake(505, 444) controlPoint2: CGPointMake(497, 447)];
        neighhorhood_I30_1Path.lineCapStyle = kCGLineCapRound;
        
        
        //// Neighhorhood_I30_2 Drawing
        //19
        UIBezierPath* neighhorhood_I30_2Path = UIBezierPath.bezierPath;
        [neighhorhood_I30_2Path moveToPoint: CGPointMake(503, 768)];
        [neighhorhood_I30_2Path addCurveToPoint: CGPointMake(485, 732) controlPoint1: CGPointMake(503, 768) controlPoint2: CGPointMake(486.99, 741)];
        [neighhorhood_I30_2Path addCurveToPoint: CGPointMake(482, 685) controlPoint1: CGPointMake(483, 723) controlPoint2: CGPointMake(482, 685)];
        [neighhorhood_I30_2Path addCurveToPoint: CGPointMake(469, 434) controlPoint1: CGPointMake(482, 685) controlPoint2: CGPointMake(476, 480)];
        [neighhorhood_I30_2Path addCurveToPoint: CGPointMake(426, 255) controlPoint1: CGPointMake(462, 388) controlPoint2: CGPointMake(422, 263)];
        [neighhorhood_I30_2Path addCurveToPoint: CGPointMake(472, 292) controlPoint1: CGPointMake(430, 247) controlPoint2: CGPointMake(467, 282)];
        [neighhorhood_I30_2Path addCurveToPoint: CGPointMake(507, 445) controlPoint1: CGPointMake(477, 302) controlPoint2: CGPointMake(515, 440)];
        [neighhorhood_I30_2Path addCurveToPoint: CGPointMake(492, 449) controlPoint1: CGPointMake(499, 450) controlPoint2: CGPointMake(492, 449)];
        neighhorhood_I30_2Path.lineCapStyle = kCGLineCapRound;
        
        //// To_Neighhorhood_I30 Drawing
        //20
        UIBezierPath* to_Neighhorhood_I30Path = UIBezierPath.bezierPath;
        [to_Neighhorhood_I30Path moveToPoint: CGPointMake(495, 445)];
        [to_Neighhorhood_I30Path addCurveToPoint: CGPointMake(544, 450) controlPoint1: CGPointMake(495, 445) controlPoint2: CGPointMake(542, 442)];
        [to_Neighhorhood_I30Path addCurveToPoint: CGPointMake(544, 480) controlPoint1: CGPointMake(545.22, 454.86) controlPoint2: CGPointMake(540.63, 471.72)];
        [to_Neighhorhood_I30Path addCurveToPoint: CGPointMake(563, 484) controlPoint1: CGPointMake(546.18, 485.34) controlPoint2: CGPointMake(559, 478)];
        [to_Neighhorhood_I30Path addCurveToPoint: CGPointMake(522, 527) controlPoint1: CGPointMake(567, 490) controlPoint2: CGPointMake(539.27, 522.64)];
        [to_Neighhorhood_I30Path addCurveToPoint: CGPointMake(477, 540) controlPoint1: CGPointMake(505.77, 531.1) controlPoint2: CGPointMake(477.97, 540.97)];
        [to_Neighhorhood_I30Path addCurveToPoint: CGPointMake(480, 683) controlPoint1: CGPointMake(475, 538) controlPoint2: CGPointMake(479.03, 671.61)];
        [to_Neighhorhood_I30Path addCurveToPoint: CGPointMake(483, 727) controlPoint1: CGPointMake(481.96, 705.94) controlPoint2: CGPointMake(484.13, 714.61)];
        [to_Neighhorhood_I30Path moveToPoint: CGPointMake(483, 727)];
        [to_Neighhorhood_I30Path addCurveToPoint: CGPointMake(476, 769) controlPoint1: CGPointMake(481, 749) controlPoint2: CGPointMake(477.41, 765.2)];
        to_Neighhorhood_I30Path.lineCapStyle = kCGLineCapRound;
        
        //// Neighborhood_To_airport Drawing
        //21
        UIBezierPath* neighborhood_To_airportPath = UIBezierPath.bezierPath;
        [neighborhood_To_airportPath moveToPoint: CGPointMake(498, 447)];
        [neighborhood_To_airportPath addCurveToPoint: CGPointMake(544, 450) controlPoint1: CGPointMake(498, 447) controlPoint2: CGPointMake(542, 442)];
        [neighborhood_To_airportPath addCurveToPoint: CGPointMake(544, 498) controlPoint1: CGPointMake(546, 458) controlPoint2: CGPointMake(544, 498)];
        [neighborhood_To_airportPath addCurveToPoint: CGPointMake(522, 516) controlPoint1: CGPointMake(544, 498) controlPoint2: CGPointMake(536.7, 508.08)];
        [neighborhood_To_airportPath addCurveToPoint: CGPointMake(476, 527) controlPoint1: CGPointMake(510.87, 522) controlPoint2: CGPointMake(491.51, 527)];
        [neighborhood_To_airportPath addCurveToPoint: CGPointMake(469, 434) controlPoint1: CGPointMake(467, 527) controlPoint2: CGPointMake(482, 477)];
        [neighborhood_To_airportPath addCurveToPoint: CGPointMake(427, 268) controlPoint1: CGPointMake(451.14, 374.92) controlPoint2: CGPointMake(435.6, 299.97)];
        [neighborhood_To_airportPath addCurveToPoint: CGPointMake(396, 185) controlPoint1: CGPointMake(416.59, 229.29) controlPoint2: CGPointMake(402.18, 194.06)];
        [neighborhood_To_airportPath addCurveToPoint: CGPointMake(214, 60) controlPoint1: CGPointMake(381, 163) controlPoint2: CGPointMake(304, 98)];
        [neighborhood_To_airportPath addCurveToPoint: CGPointMake(105, 32) controlPoint1: CGPointMake(178.3, 44.93) controlPoint2: CGPointMake(134.99, 39.06)];
        [neighborhood_To_airportPath addCurveToPoint: CGPointMake(0, 1) controlPoint1: CGPointMake(59.39, 21.26) controlPoint2: CGPointMake(22.02, 7.94)];
        neighborhood_To_airportPath.lineCapStyle = kCGLineCapRound;
        
        //// Neighborhood_To_LoveField Drawing
        //22
        UIBezierPath* neighborhood_To_LoveFieldPath = UIBezierPath.bezierPath;
        [neighborhood_To_LoveFieldPath moveToPoint: CGPointMake(497.5, 447)];
        [neighborhood_To_LoveFieldPath addCurveToPoint: CGPointMake(547, 443) controlPoint1: CGPointMake(497.5, 447) controlPoint2: CGPointMake(541, 451)];
        [neighborhood_To_LoveFieldPath addCurveToPoint: CGPointMake(533, 344) controlPoint1: CGPointMake(553, 435) controlPoint2: CGPointMake(539, 355)];
        [neighborhood_To_LoveFieldPath addCurveToPoint: CGPointMake(468, 243) controlPoint1: CGPointMake(529.25, 337.12) controlPoint2: CGPointMake(488, 267)];
        [neighborhood_To_LoveFieldPath addCurveToPoint: CGPointMake(414, 171) controlPoint1: CGPointMake(456.01, 228.61) controlPoint2: CGPointMake(426, 195)];
        [neighborhood_To_LoveFieldPath addCurveToPoint: CGPointMake(388, 83) controlPoint1: CGPointMake(402, 147) controlPoint2: CGPointMake(400.53, 124.1)];
        [neighborhood_To_LoveFieldPath addCurveToPoint: CGPointMake(368.5, 0.5) controlPoint1: CGPointMake(377.02, 46.99) controlPoint2: CGPointMake(370.37, 9.84)];
        neighborhood_To_LoveFieldPath.lineCapStyle = kCGLineCapRound;

        // END COPY FROM PAINT CODE
        
        
        
        // copy new paths from paint code above into array
        //CITY LEVEL
        //0
        pathItem = [[embBezierPathItem alloc] init];
        pathItem.pathDelay = inDelay;
        pathItem.pathColor = inPathColor;
        pathItem.pathSpeed = pathSpeed;
        pathItem.pathWidth = pathWidth;
        pathItem.embPath = neighborhood_tollway1Path;
        [_bezierPaths addObject:pathItem];
        
        //1
        pathItem = [[embBezierPathItem alloc] init];
        pathItem.pathDelay = inDelay;
        pathItem.pathColor = inPathColor;
        pathItem.pathSpeed = pathSpeed;
        pathItem.pathWidth = pathWidth;
        pathItem.embPath = neighborhood_tollway2Path;
        [_bezierPaths addObject:pathItem];
        
        //2
        pathItem = [[embBezierPathItem alloc] init];
        pathItem.pathDelay = inDelay;
        pathItem.pathColor = inPathColor;
        pathItem.pathSpeed = pathSpeed;
        pathItem.pathWidth = pathWidth;
        pathItem.embPath = neighborhood_tollway3Path;
        [_bezierPaths addObject:pathItem];
        
        //3
        pathItem = [[embBezierPathItem alloc] init];
        pathItem.pathDelay = outDelay;
        pathItem.pathColor = outPathColor;
        pathItem.pathSpeed = pathSpeed;
        pathItem.pathWidth = pathWidth;
        pathItem.embPath = outNeighborhood_tollway1Path;
        [_bezierPaths addObject:pathItem];
        
        //4
        pathItem = [[embBezierPathItem alloc] init];
        pathItem.pathDelay = outDelay;
        pathItem.pathColor = outPathColor;
        pathItem.pathSpeed = pathSpeed;
        pathItem.pathWidth = pathWidth;
        pathItem.embPath = outNeighborhood_tollway2Path;
        [_bezierPaths addObject:pathItem];
        
        //5
        pathItem = [[embBezierPathItem alloc] init];
        pathItem.pathDelay = inDelay;
        pathItem.pathColor = inPathColor;
        pathItem.pathSpeed = pathSpeed;
        pathItem.pathWidth = pathWidth;
        pathItem.embPath = neighborhood_WooddallPath;
        [_bezierPaths addObject:pathItem];
        
        //6
        pathItem = [[embBezierPathItem alloc] init];
        pathItem.pathDelay = inDelay;
        pathItem.pathColor = inPathColor;
        pathItem.pathSpeed = pathSpeed;
        pathItem.pathWidth = pathWidth;
        pathItem.embPath = neighborhood_Wooddall2Path;
        [_bezierPaths addObject:pathItem];
        
        //7
        pathItem = [[embBezierPathItem alloc] init];
        pathItem.pathDelay = outDelay;
        pathItem.pathColor = outPathColor;
        pathItem.pathSpeed = pathSpeed;
        pathItem.pathWidth = pathWidth;
        pathItem.embPath = outNeighborhood_Wooddall1Path;
        [_bezierPaths addObject:pathItem];
        
        //8
        pathItem = [[embBezierPathItem alloc] init];
        pathItem.pathDelay = outDelay;
        pathItem.pathColor = outPathColor;
        pathItem.pathSpeed = pathSpeed;
        pathItem.pathWidth = pathWidth;
        pathItem.embPath = outNeighborhood_Wooddall2Path;
        [_bezierPaths addObject:pathItem];
        
        //9
        pathItem = [[embBezierPathItem alloc] init];
        pathItem.pathDelay = inDelay;
        pathItem.pathColor = inPathColor;
        pathItem.pathSpeed = pathSpeed;
        pathItem.pathWidth = pathWidth;
        pathItem.embPath = neighborhood_KatyRailPath;
        [_bezierPaths addObject:pathItem];
        
        //10
        pathItem = [[embBezierPathItem alloc] init];
        pathItem.pathDelay = outDelay;
        pathItem.pathColor = outPathColor;
        pathItem.pathSpeed = pathSpeed;
        pathItem.pathWidth = pathWidth;
        pathItem.embPath = to_Neighborhood_KatyRailPath;
        [_bezierPaths addObject:pathItem];
        
        //11
        pathItem = [[embBezierPathItem alloc] init];
        pathItem.pathDelay = inDelay;
        pathItem.pathColor = inPathColor;
        pathItem.pathSpeed = pathSpeed;
        pathItem.pathWidth = pathWidth;
        pathItem.embPath = neighborhood_I35_1Path;
        [_bezierPaths addObject:pathItem];
        
        //Neighiborhood Level
        
        //12
        pathItem = [[embBezierPathItem alloc] init];
        pathItem.pathDelay = inDelay;
        pathItem.pathColor = inPathColor;
        pathItem.pathSpeed = pathSpeed;
        pathItem.pathWidth = pathWidth;
        pathItem.embPath = neighborhood_I35_2Path;
        [_bezierPaths addObject:pathItem];
        
        //13
        pathItem = [[embBezierPathItem alloc] init];
        pathItem.pathDelay = inDelay;
        pathItem.pathColor = inPathColor;
        pathItem.pathSpeed = pathSpeed;
        pathItem.pathWidth = pathWidth;
        pathItem.embPath = neighborhood_I35_3Path;
        [_bezierPaths addObject:pathItem];
        
        //14
        pathItem = [[embBezierPathItem alloc] init];
        pathItem.pathDelay = inDelay;
        pathItem.pathColor = inPathColor;
        pathItem.pathSpeed = pathSpeed;
        pathItem.pathWidth = pathWidth;
        pathItem.embPath = neighborhood_I35_4Path;
        [_bezierPaths addObject:pathItem];
        
        //15
        pathItem = [[embBezierPathItem alloc] init];
        pathItem.pathDelay = outDelay;
        pathItem.pathColor = outPathColor;
        pathItem.pathSpeed = pathSpeed;
        pathItem.pathWidth = pathWidth;
        pathItem.embPath = outNeighborhood_I35_1Path;
        [_bezierPaths addObject:pathItem];
        
        //16
        pathItem = [[embBezierPathItem alloc] init];
        pathItem.pathDelay = outDelay;
        pathItem.pathColor = outPathColor;
        pathItem.pathSpeed = pathSpeed;
        pathItem.pathWidth = pathWidth;
        pathItem.embPath = outNeighborhood_I35_2Path;
        [_bezierPaths addObject:pathItem];
        
        //17
        pathItem = [[embBezierPathItem alloc] init];
        pathItem.pathDelay = outDelay;
        pathItem.pathColor = outPathColor;
        pathItem.pathSpeed = pathSpeed;
        pathItem.pathWidth = pathWidth;
        pathItem.embPath = outNeighborhood_I35_3Path;
        [_bezierPaths addObject:pathItem];
        
        //18
        pathItem = [[embBezierPathItem alloc] init];
        pathItem.pathDelay = inDelay;
        pathItem.pathColor = inPathColor;
        pathItem.pathSpeed = pathSpeed;
        pathItem.pathWidth = pathWidth;
        pathItem.embPath = neighhorhood_I30_1Path;
        [_bezierPaths addObject:pathItem];
        
        //19
        pathItem = [[embBezierPathItem alloc] init];
        pathItem.pathDelay = inDelay;
        pathItem.pathColor = inPathColor;
        pathItem.pathSpeed = pathSpeed;
        pathItem.pathWidth = pathWidth;
        pathItem.embPath = neighhorhood_I30_2Path;
        [_bezierPaths addObject:pathItem];
        
        //20
        pathItem = [[embBezierPathItem alloc] init];
        pathItem.pathDelay = outDelay;
        pathItem.pathColor = outPathColor;
        pathItem.pathSpeed = pathSpeed;
        pathItem.pathWidth = pathWidth;
        pathItem.embPath = to_Neighhorhood_I30Path;
        [_bezierPaths addObject:pathItem];
        
        //21
        pathItem = [[embBezierPathItem alloc] init];
        pathItem.pathDelay = inDelay;
        pathItem.pathColor = inPathColor;
        pathItem.pathSpeed = pathSpeed;
        pathItem.pathWidth = pathWidth;
        pathItem.embPath = neighborhood_To_airportPath;
        [_bezierPaths addObject:pathItem];
        
        //22
        pathItem = [[embBezierPathItem alloc] init];
        pathItem.pathDelay = inDelay;
        pathItem.pathColor = inPathColor;
        pathItem.pathSpeed = pathSpeed;
        pathItem.pathWidth = pathWidth;
        pathItem.embPath = neighborhood_To_LoveFieldPath;
        [_bezierPaths addObject:pathItem];
    
    }
    
    return self;
}

@end
