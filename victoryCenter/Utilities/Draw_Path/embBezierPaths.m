//
//  embBezierPathItems.m
//  embAnimatedPath
//
//  Created by Evan Buxton on 2/19/14.
//  Copyright (c) 2014 neoscape. All rights reserved.
//

#import "embBezierPaths.h"
#import "UIColor+Extensions.h"
@implementation embBezierPaths

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

		//// Color Declarations
		
        //// Site_tollway_1 Drawing
        //0
        UIBezierPath* site_tollway_1Path = UIBezierPath.bezierPath;
        [site_tollway_1Path moveToPoint: CGPointMake(2, 17)];
        [site_tollway_1Path addCurveToPoint: CGPointMake(173, 55) controlPoint1: CGPointMake(15, 26) controlPoint2: CGPointMake(150, 47)];
        [site_tollway_1Path addCurveToPoint: CGPointMake(292, 267) controlPoint1: CGPointMake(196, 63) controlPoint2: CGPointMake(291, 237)];
        [site_tollway_1Path addCurveToPoint: CGPointMake(276, 359) controlPoint1: CGPointMake(292.31, 276.31) controlPoint2: CGPointMake(281.56, 323.42)];
        [site_tollway_1Path addCurveToPoint: CGPointMake(245, 534) controlPoint1: CGPointMake(263.65, 438.05) controlPoint2: CGPointMake(245, 534)];
        site_tollway_1Path.lineCapStyle = kCGLineCapRound;
        
        //// Site_tollway_2 Drawing
        //1
        UIBezierPath* site_tollway_2Path = UIBezierPath.bezierPath;
        [site_tollway_2Path moveToPoint: CGPointMake(0, 535)];
        [site_tollway_2Path addCurveToPoint: CGPointMake(265, 535) controlPoint1: CGPointMake(0, 535) controlPoint2: CGPointMake(246, 536)];
        [site_tollway_2Path addCurveToPoint: CGPointMake(476, 536) controlPoint1: CGPointMake(272.81, 534.59) controlPoint2: CGPointMake(372.08, 534.61)];
        [site_tollway_2Path addCurveToPoint: CGPointMake(707, 538) controlPoint1: CGPointMake(476, 536) controlPoint2: CGPointMake(705.23, 533.29)];
        [site_tollway_2Path addCurveToPoint: CGPointMake(709, 588) controlPoint1: CGPointMake(710, 546) controlPoint2: CGPointMake(709, 588)];
        site_tollway_2Path.lineCapStyle = kCGLineCapRound;
        
        //// Site_tollway_3 Drawing
        //2
        UIBezierPath* site_tollway_3Path = UIBezierPath.bezierPath;
        [site_tollway_3Path moveToPoint: CGPointMake(1024, 422)];
        [site_tollway_3Path addCurveToPoint: CGPointMake(903, 388) controlPoint1: CGPointMake(1023.75, 422) controlPoint2: CGPointMake(972.66, 414.12)];
        [site_tollway_3Path addCurveToPoint: CGPointMake(756, 335) controlPoint1: CGPointMake(835.32, 362.63) controlPoint2: CGPointMake(786, 333)];
        [site_tollway_3Path addCurveToPoint: CGPointMake(724, 423) controlPoint1: CGPointMake(743.91, 335.81) controlPoint2: CGPointMake(731.02, 375.54)];
        [site_tollway_3Path addCurveToPoint: CGPointMake(709, 588) controlPoint1: CGPointMake(713.59, 493.33) controlPoint2: CGPointMake(709, 587.4)];
        [UIColor.blackColor setStroke];
        
        //// Out_Site_tollway_1 Drawing
        //3
        UIBezierPath* out_Site_tollway_1Path = UIBezierPath.bezierPath;
        [out_Site_tollway_1Path moveToPoint: CGPointMake(709, 588)];
        [out_Site_tollway_1Path addCurveToPoint: CGPointMake(713, 526) controlPoint1: CGPointMake(709, 588) controlPoint2: CGPointMake(710, 548)];
        [out_Site_tollway_1Path addCurveToPoint: CGPointMake(729, 419) controlPoint1: CGPointMake(714.52, 514.89) controlPoint2: CGPointMake(719.56, 465.09)];
        [out_Site_tollway_1Path addCurveToPoint: CGPointMake(757, 328) controlPoint1: CGPointMake(738.24, 373.85) controlPoint2: CGPointMake(761.95, 339.38)];
        [out_Site_tollway_1Path addCurveToPoint: CGPointMake(672, 288) controlPoint1: CGPointMake(754.04, 321.18) controlPoint2: CGPointMake(721.8, 303.41)];
        [out_Site_tollway_1Path addCurveToPoint: CGPointMake(389, 232) controlPoint1: CGPointMake(628.79, 274.63) controlPoint2: CGPointMake(453, 243)];
        [out_Site_tollway_1Path addCurveToPoint: CGPointMake(293, 208) controlPoint1: CGPointMake(314.15, 219.13) controlPoint2: CGPointMake(299, 218)];
        [out_Site_tollway_1Path addCurveToPoint: CGPointMake(169, -3) controlPoint1: CGPointMake(269, 168) controlPoint2: CGPointMake(169, -3)];
        out_Site_tollway_1Path.lineCapStyle = kCGLineCapRound;

        
        //// Out_Site_tollway_2 Drawing
        //4
        UIBezierPath* out_Site_tollway_2Path = UIBezierPath.bezierPath;
        [out_Site_tollway_2Path moveToPoint: CGPointMake(709, 591)];
        [out_Site_tollway_2Path addCurveToPoint: CGPointMake(712, 536) controlPoint1: CGPointMake(709, 591) controlPoint2: CGPointMake(708, 538)];
        [out_Site_tollway_2Path addCurveToPoint: CGPointMake(876, 530) controlPoint1: CGPointMake(716, 534) controlPoint2: CGPointMake(865.19, 540.81)];
        [out_Site_tollway_2Path addCurveToPoint: CGPointMake(883, 461) controlPoint1: CGPointMake(881, 525) controlPoint2: CGPointMake(875.88, 487.72)];
        [out_Site_tollway_2Path addCurveToPoint: CGPointMake(915, 398) controlPoint1: CGPointMake(891.28, 429.95) controlPoint2: CGPointMake(902, 410)];
        [out_Site_tollway_2Path addCurveToPoint: CGPointMake(1024, 334) controlPoint1: CGPointMake(928, 386) controlPoint2: CGPointMake(1024, 334)];
        
        //// Woodall_Rodgers_1 Drawing
        //5
        UIBezierPath* woodall_Rodgers_1Path = UIBezierPath.bezierPath;
        [woodall_Rodgers_1Path moveToPoint: CGPointMake(870, 0)];
        [woodall_Rodgers_1Path addCurveToPoint: CGPointMake(978, 198) controlPoint1: CGPointMake(870, 0) controlPoint2: CGPointMake(982.57, 191.98)];
        [woodall_Rodgers_1Path addCurveToPoint: CGPointMake(762, 323) controlPoint1: CGPointMake(968.5, 210.5) controlPoint2: CGPointMake(765, 318)];
        [woodall_Rodgers_1Path addCurveToPoint: CGPointMake(724, 457) controlPoint1: CGPointMake(759, 328) controlPoint2: CGPointMake(735, 396)];
        [woodall_Rodgers_1Path addCurveToPoint: CGPointMake(709, 588) controlPoint1: CGPointMake(712.27, 522.02) controlPoint2: CGPointMake(709, 588)];
        woodall_Rodgers_1Path.lineCapStyle = kCGLineCapRound;
        
        //// Woodall_Rodgers_2 Drawing
        //6
        UIBezierPath* woodall_Rodgers_2Path = UIBezierPath.bezierPath;
        [woodall_Rodgers_2Path moveToPoint: CGPointMake(293, 0)];
        [woodall_Rodgers_2Path addCurveToPoint: CGPointMake(191, 55) controlPoint1: CGPointMake(293, 0) controlPoint2: CGPointMake(195, 44)];
        [woodall_Rodgers_2Path addCurveToPoint: CGPointMake(285, 238) controlPoint1: CGPointMake(187, 66) controlPoint2: CGPointMake(268.58, 212.46)];
        [woodall_Rodgers_2Path addCurveToPoint: CGPointMake(266, 421) controlPoint1: CGPointMake(294, 252) controlPoint2: CGPointMake(279.49, 348.61)];
        [woodall_Rodgers_2Path addCurveToPoint: CGPointMake(251, 533) controlPoint1: CGPointMake(254.89, 480.65) controlPoint2: CGPointMake(242.87, 532.1)];
        [woodall_Rodgers_2Path addCurveToPoint: CGPointMake(707, 538) controlPoint1: CGPointMake(269, 535) controlPoint2: CGPointMake(703, 531)];
        [woodall_Rodgers_2Path addCurveToPoint: CGPointMake(709, 588) controlPoint1: CGPointMake(711, 545) controlPoint2: CGPointMake(709, 588)];
        woodall_Rodgers_2Path.lineCapStyle = kCGLineCapRound;
        
        //// Out_Woodall_Rodgers_1 Drawing
        //7
        UIBezierPath* out_Woodall_Rodgers_1Path = UIBezierPath.bezierPath;
        [out_Woodall_Rodgers_1Path moveToPoint: CGPointMake(709, 588)];
        [out_Woodall_Rodgers_1Path addCurveToPoint: CGPointMake(724, 457) controlPoint1: CGPointMake(709, 588) controlPoint2: CGPointMake(712.27, 522.02)];
        [out_Woodall_Rodgers_1Path addCurveToPoint: CGPointMake(762, 323) controlPoint1: CGPointMake(735, 396) controlPoint2: CGPointMake(759, 328)];
        [out_Woodall_Rodgers_1Path addCurveToPoint: CGPointMake(978, 198) controlPoint1: CGPointMake(765, 318) controlPoint2: CGPointMake(968.5, 210.5)];
        [out_Woodall_Rodgers_1Path addCurveToPoint: CGPointMake(870, 0) controlPoint1: CGPointMake(982.57, 191.98) controlPoint2: CGPointMake(870, 0)];
        out_Woodall_Rodgers_1Path.lineCapStyle = kCGLineCapRound;
		
        //// Out_Woodall_Rodgers_2 Drawing
        //8
        UIBezierPath* out_Woodall_Rodgers_2Path = UIBezierPath.bezierPath;
        [out_Woodall_Rodgers_2Path moveToPoint: CGPointMake(709, 588)];
        [out_Woodall_Rodgers_2Path addCurveToPoint: CGPointMake(713, 526) controlPoint1: CGPointMake(709, 588) controlPoint2: CGPointMake(710, 548)];
        [out_Woodall_Rodgers_2Path addCurveToPoint: CGPointMake(729, 419) controlPoint1: CGPointMake(714.52, 514.89) controlPoint2: CGPointMake(719.56, 465.09)];
        [out_Woodall_Rodgers_2Path addCurveToPoint: CGPointMake(757, 328) controlPoint1: CGPointMake(738.24, 373.85) controlPoint2: CGPointMake(761.95, 339.38)];
        [out_Woodall_Rodgers_2Path addCurveToPoint: CGPointMake(672, 288) controlPoint1: CGPointMake(754.04, 321.18) controlPoint2: CGPointMake(721.8, 303.41)];
        [out_Woodall_Rodgers_2Path addCurveToPoint: CGPointMake(389, 232) controlPoint1: CGPointMake(628.79, 274.63) controlPoint2: CGPointMake(453, 243)];
        [out_Woodall_Rodgers_2Path addCurveToPoint: CGPointMake(293, 208) controlPoint1: CGPointMake(314.15, 219.13) controlPoint2: CGPointMake(299, 218)];
        [out_Woodall_Rodgers_2Path addCurveToPoint: CGPointMake(223, 65) controlPoint1: CGPointMake(269, 168) controlPoint2: CGPointMake(217, 73)];
        [out_Woodall_Rodgers_2Path addCurveToPoint: CGPointMake(337, 0) controlPoint1: CGPointMake(229, 57) controlPoint2: CGPointMake(337, 0)];
        out_Woodall_Rodgers_2Path.lineCapStyle = kCGLineCapRound;
        
        //// Site_katy Drawing
        //9
        UIBezierPath* site_katyPath = UIBezierPath.bezierPath;
        [site_katyPath moveToPoint: CGPointMake(159, -3)];
        [site_katyPath addCurveToPoint: CGPointMake(285, 218) controlPoint1: CGPointMake(159, -3) controlPoint2: CGPointMake(246.92, 182.16)];
        [site_katyPath addCurveToPoint: CGPointMake(530, 270) controlPoint1: CGPointMake(302, 234) controlPoint2: CGPointMake(378.42, 246.62)];
        [site_katyPath addCurveToPoint: CGPointMake(746, 337) controlPoint1: CGPointMake(718, 299) controlPoint2: CGPointMake(744.88, 325.81)];
        [site_katyPath addCurveToPoint: CGPointMake(723, 419) controlPoint1: CGPointMake(747, 347) controlPoint2: CGPointMake(730.84, 372.96)];
        [site_katyPath addCurveToPoint: CGPointMake(709, 537) controlPoint1: CGPointMake(715, 466) controlPoint2: CGPointMake(709.51, 527.4)];
        [site_katyPath addCurveToPoint: CGPointMake(709, 588) controlPoint1: CGPointMake(708, 556) controlPoint2: CGPointMake(709, 588)];
        site_katyPath.lineCapStyle = kCGLineCapRound;
        
        //// Out_Site_katy Drawing
        //10
        UIBezierPath* out_Site_katyPath = UIBezierPath.bezierPath;
        [out_Site_katyPath moveToPoint: CGPointMake(709, 588)];
        [out_Site_katyPath addCurveToPoint: CGPointMake(713, 526) controlPoint1: CGPointMake(709, 588) controlPoint2: CGPointMake(710, 548)];
        [out_Site_katyPath addCurveToPoint: CGPointMake(729, 419) controlPoint1: CGPointMake(714.52, 514.89) controlPoint2: CGPointMake(719.56, 465.09)];
        [out_Site_katyPath addCurveToPoint: CGPointMake(757, 328) controlPoint1: CGPointMake(738.24, 373.85) controlPoint2: CGPointMake(761.95, 339.38)];
        [out_Site_katyPath addCurveToPoint: CGPointMake(672, 288) controlPoint1: CGPointMake(754.04, 321.18) controlPoint2: CGPointMake(721.8, 303.41)];
        [out_Site_katyPath addCurveToPoint: CGPointMake(389, 232) controlPoint1: CGPointMake(628.79, 274.63) controlPoint2: CGPointMake(453, 243)];
        [out_Site_katyPath addCurveToPoint: CGPointMake(293, 208) controlPoint1: CGPointMake(314.15, 219.13) controlPoint2: CGPointMake(299, 218)];
        [out_Site_katyPath addCurveToPoint: CGPointMake(169, -3) controlPoint1: CGPointMake(269, 168) controlPoint2: CGPointMake(169, -3)];
        out_Site_katyPath.lineCapStyle = kCGLineCapRound;
        
        //// Site_I35_1 Drawing
        //11
        UIBezierPath* site_I35_1Path = UIBezierPath.bezierPath;
        [site_I35_1Path moveToPoint: CGPointMake(0, 535)];
        [site_I35_1Path addCurveToPoint: CGPointMake(265, 535) controlPoint1: CGPointMake(0, 535) controlPoint2: CGPointMake(246, 536)];
        [site_I35_1Path addCurveToPoint: CGPointMake(476, 536) controlPoint1: CGPointMake(272.81, 534.59) controlPoint2: CGPointMake(372.08, 534.61)];
        [site_I35_1Path addCurveToPoint: CGPointMake(707, 538) controlPoint1: CGPointMake(476, 536) controlPoint2: CGPointMake(705.23, 533.29)];
        [site_I35_1Path addCurveToPoint: CGPointMake(709, 588) controlPoint1: CGPointMake(710, 546) controlPoint2: CGPointMake(709, 588)];
        site_I35_1Path.lineCapStyle = kCGLineCapRound;
        
        //// Site_I35_2 Drawing
        //12
        UIBezierPath* site_I35_2Path = UIBezierPath.bezierPath;
        [site_I35_2Path moveToPoint: CGPointMake(1001, 767)];
        [site_I35_2Path addCurveToPoint: CGPointMake(883, 661) controlPoint1: CGPointMake(1001, 767) controlPoint2: CGPointMake(888, 677)];
        [site_I35_2Path addCurveToPoint: CGPointMake(878, 491) controlPoint1: CGPointMake(872.16, 626.32) controlPoint2: CGPointMake(868.73, 552.56)];
        [site_I35_2Path addCurveToPoint: CGPointMake(908, 394) controlPoint1: CGPointMake(885.83, 438.97) controlPoint2: CGPointMake(913.5, 397.66)];
        [site_I35_2Path addCurveToPoint: CGPointMake(757, 328) controlPoint1: CGPointMake(896, 386) controlPoint2: CGPointMake(766, 327)];
        [site_I35_2Path addCurveToPoint: CGPointMake(716, 459) controlPoint1: CGPointMake(752.59, 328.49) controlPoint2: CGPointMake(724.13, 400.51)];
        [site_I35_2Path addCurveToPoint: CGPointMake(709, 588) controlPoint1: CGPointMake(707.54, 519.83) controlPoint2: CGPointMake(709, 588)];
        site_I35_2Path.lineCapStyle = kCGLineCapRound;
        
        //// Site_I35_3 Drawing
        //13
        UIBezierPath* site_I35_3Path = UIBezierPath.bezierPath;
        [site_I35_3Path moveToPoint: CGPointMake(1, 261)];
        [site_I35_3Path addCurveToPoint: CGPointMake(76, 230) controlPoint1: CGPointMake(1, 261) controlPoint2: CGPointMake(50.17, 235.66)];
        [site_I35_3Path addCurveToPoint: CGPointMake(278, 230) controlPoint1: CGPointMake(147.44, 214.34) controlPoint2: CGPointMake(260.15, 218.1)];
        [site_I35_3Path addCurveToPoint: CGPointMake(291, 283) controlPoint1: CGPointMake(282.14, 232.76) controlPoint2: CGPointMake(293.26, 258.27)];
        [site_I35_3Path addCurveToPoint: CGPointMake(245, 534) controlPoint1: CGPointMake(283.42, 365.9) controlPoint2: CGPointMake(245, 534)];
        site_I35_3Path.lineCapStyle = kCGLineCapRound;
        
        //// Out_I35_2 Drawing
        //14
        UIBezierPath* out_I35_2Path = UIBezierPath.bezierPath;
        [out_I35_2Path moveToPoint: CGPointMake(709, 591)];
        [out_I35_2Path addCurveToPoint: CGPointMake(712, 536) controlPoint1: CGPointMake(709, 591) controlPoint2: CGPointMake(708, 538)];
        [out_I35_2Path addCurveToPoint: CGPointMake(876, 530) controlPoint1: CGPointMake(716, 534) controlPoint2: CGPointMake(865.19, 540.81)];
        [out_I35_2Path addCurveToPoint: CGPointMake(883, 461) controlPoint1: CGPointMake(881, 525) controlPoint2: CGPointMake(875.88, 487.72)];
        [out_I35_2Path addCurveToPoint: CGPointMake(915, 398) controlPoint1: CGPointMake(891.28, 429.95) controlPoint2: CGPointMake(902, 410)];
        [out_I35_2Path addCurveToPoint: CGPointMake(1024, 334) controlPoint1: CGPointMake(928, 386) controlPoint2: CGPointMake(1024, 334)];
        
        //// Out_I35_3 Drawing
        //15
        UIBezierPath* out_I35_3Path = UIBezierPath.bezierPath;
        [out_I35_3Path moveToPoint: CGPointMake(709, 588)];
        [out_I35_3Path addCurveToPoint: CGPointMake(712, 527) controlPoint1: CGPointMake(709, 588) controlPoint2: CGPointMake(708.68, 561.77)];
        [out_I35_3Path addCurveToPoint: CGPointMake(729, 419) controlPoint1: CGPointMake(715.15, 494.03) controlPoint2: CGPointMake(721.75, 453.42)];
        [out_I35_3Path addCurveToPoint: CGPointMake(754, 324) controlPoint1: CGPointMake(733, 400) controlPoint2: CGPointMake(759, 341)];
        [out_I35_3Path addCurveToPoint: CGPointMake(569, 264) controlPoint1: CGPointMake(752.95, 320.44) controlPoint2: CGPointMake(678.87, 287.78)];
        [out_I35_3Path addCurveToPoint: CGPointMake(249, 212) controlPoint1: CGPointMake(469.39, 242.44) controlPoint2: CGPointMake(338.01, 221.96)];
        [out_I35_3Path addCurveToPoint: CGPointMake(75, 220) controlPoint1: CGPointMake(165.02, 202.61) controlPoint2: CGPointMake(97.12, 215.15)];
        [out_I35_3Path addCurveToPoint: CGPointMake(-7, 248) controlPoint1: CGPointMake(49.17, 225.66) controlPoint2: CGPointMake(-7, 248)];
        out_I35_3Path.lineCapStyle = kCGLineCapRound;
        
        //// Site_to_airport Drawing
        //16
        UIBezierPath* site_to_airportPath = UIBezierPath.bezierPath;
        [site_to_airportPath moveToPoint: CGPointMake(709, 588)];
        [site_to_airportPath addCurveToPoint: CGPointMake(720, 459) controlPoint1: CGPointMake(709, 588) controlPoint2: CGPointMake(711.54, 519.83)];
        [site_to_airportPath addCurveToPoint: CGPointMake(755, 343) controlPoint1: CGPointMake(728.14, 400.51) controlPoint2: CGPointMake(750.1, 348.39)];
        [site_to_airportPath addCurveToPoint: CGPointMake(898, 401) controlPoint1: CGPointMake(765, 332) controlPoint2: CGPointMake(893, 398)];
        [site_to_airportPath addCurveToPoint: CGPointMake(881, 443) controlPoint1: CGPointMake(899.89, 402.13) controlPoint2: CGPointMake(887.15, 416.37)];
        [site_to_airportPath addCurveToPoint: CGPointMake(869, 578) controlPoint1: CGPointMake(874.42, 471.5) controlPoint2: CGPointMake(867.11, 522.21)];
        [site_to_airportPath addCurveToPoint: CGPointMake(881, 671) controlPoint1: CGPointMake(870.01, 607.95) controlPoint2: CGPointMake(870.58, 632.76)];
        [site_to_airportPath addCurveToPoint: CGPointMake(963, 768) controlPoint1: CGPointMake(893, 715) controlPoint2: CGPointMake(963, 768)];
        site_to_airportPath.lineCapStyle = kCGLineCapRound;
        
        //// Site_to_loveField Drawing
        //17
        UIBezierPath* site_to_loveFieldPath = UIBezierPath.bezierPath;
        [site_to_loveFieldPath moveToPoint: CGPointMake(709, 588)];
        [site_to_loveFieldPath addCurveToPoint: CGPointMake(712, 527) controlPoint1: CGPointMake(709, 588) controlPoint2: CGPointMake(708.68, 561.77)];
        [site_to_loveFieldPath addCurveToPoint: CGPointMake(729, 419) controlPoint1: CGPointMake(715.15, 494.03) controlPoint2: CGPointMake(721.75, 453.42)];
        [site_to_loveFieldPath addCurveToPoint: CGPointMake(754, 324) controlPoint1: CGPointMake(733, 400) controlPoint2: CGPointMake(759, 341)];
        [site_to_loveFieldPath addCurveToPoint: CGPointMake(569, 264) controlPoint1: CGPointMake(752.95, 320.44) controlPoint2: CGPointMake(678.87, 287.78)];
        [site_to_loveFieldPath addCurveToPoint: CGPointMake(249, 212) controlPoint1: CGPointMake(469.39, 242.44) controlPoint2: CGPointMake(338.01, 221.95)];
        [site_to_loveFieldPath addCurveToPoint: CGPointMake(75, 220) controlPoint1: CGPointMake(165.02, 202.61) controlPoint2: CGPointMake(97.12, 215.15)];
        [site_to_loveFieldPath addCurveToPoint: CGPointMake(-7, 248) controlPoint1: CGPointMake(49.17, 225.66) controlPoint2: CGPointMake(-7, 248)];
        site_to_loveFieldPath.lineCapStyle = kCGLineCapRound;
		// END COPY FROM PAINT CODE

		
		
		// copy new paths from paint code above into array
		// (reverse some of them as well)
        
        //0
		pathItem = [[embBezierPathItem alloc] init];
		pathItem.pathDelay = inDelay;
		pathItem.pathColor = inPathColor;
		pathItem.pathSpeed = pathSpeed;
		pathItem.pathWidth = pathWidth;
		pathItem.embPath = site_tollway_1Path;
		[_bezierPaths addObject:pathItem];
        
        //1
        pathItem = [[embBezierPathItem alloc] init];
        pathItem.pathDelay = inDelay;
        pathItem.pathColor = inPathColor;
        pathItem.pathSpeed = pathSpeed;
        pathItem.pathWidth = pathWidth;
        pathItem.embPath = site_tollway_2Path;
        [_bezierPaths addObject:pathItem];
        
        //2
        pathItem = [[embBezierPathItem alloc] init];
		pathItem.pathDelay = inDelay;
		pathItem.pathColor = inPathColor;
		pathItem.pathSpeed = pathSpeed;
		pathItem.pathWidth = pathWidth;
		pathItem.embPath = site_tollway_3Path;
		[_bezierPaths addObject:pathItem];
        
        //3
        pathItem = [[embBezierPathItem alloc] init];
        pathItem.pathDelay = outDelay;
        pathItem.pathColor = outPathColor;
        pathItem.pathSpeed = pathSpeed;
        pathItem.pathWidth = pathWidth;
        pathItem.embPath = out_Site_tollway_1Path;
        [_bezierPaths addObject:pathItem];
        
        //4
        pathItem = [[embBezierPathItem alloc] init];
		pathItem.pathDelay = outDelay;
		pathItem.pathColor = outPathColor;
		pathItem.pathSpeed = pathSpeed;
		pathItem.pathWidth = pathWidth;
		pathItem.embPath = out_Site_tollway_2Path;
		[_bezierPaths addObject:pathItem];
        
        //5
        pathItem = [[embBezierPathItem alloc] init];
        pathItem.pathDelay = inDelay;
        pathItem.pathColor = inPathColor;
        pathItem.pathSpeed = pathSpeed;
        pathItem.pathWidth = pathWidth;
        pathItem.embPath = woodall_Rodgers_1Path;
        [_bezierPaths addObject:pathItem];
        
        //6
        pathItem = [[embBezierPathItem alloc] init];
		pathItem.pathDelay = inDelay;
		pathItem.pathColor = inPathColor;
		pathItem.pathSpeed = pathSpeed;
		pathItem.pathWidth = pathWidth;
		pathItem.embPath = woodall_Rodgers_2Path;
		[_bezierPaths addObject:pathItem];
        
        //7
        pathItem = [[embBezierPathItem alloc] init];
        pathItem.pathDelay = outDelay;
        pathItem.pathColor = outPathColor;
        pathItem.pathSpeed = pathSpeed;
        pathItem.pathWidth = pathWidth;
        pathItem.embPath = out_Woodall_Rodgers_1Path;
        [_bezierPaths addObject:pathItem];
        
        //8
        pathItem = [[embBezierPathItem alloc] init];
        pathItem.pathDelay = outDelay;
        pathItem.pathColor = outPathColor;
        pathItem.pathSpeed = pathSpeed;
        pathItem.pathWidth = pathWidth;
        pathItem.embPath = out_Woodall_Rodgers_2Path;
        [_bezierPaths addObject:pathItem];
        
        //9
        pathItem = [[embBezierPathItem alloc] init];
        pathItem.pathDelay = inDelay;
        pathItem.pathColor = inPathColor;
        pathItem.pathSpeed = pathSpeed;
        pathItem.pathWidth = pathWidth;
        pathItem.embPath = site_katyPath;
        [_bezierPaths addObject:pathItem];
        
        //10
        pathItem = [[embBezierPathItem alloc] init];
        pathItem.pathDelay = outDelay;
        pathItem.pathColor = outPathColor;
        pathItem.pathSpeed = pathSpeed;
        pathItem.pathWidth = pathWidth;
        pathItem.embPath = out_Site_katyPath;
        [_bezierPaths addObject:pathItem];
        
        //11
        pathItem = [[embBezierPathItem alloc] init];
        pathItem.pathDelay = inDelay;
        pathItem.pathColor = inPathColor;
        pathItem.pathSpeed = pathSpeed;
        pathItem.pathWidth = pathWidth;
        pathItem.embPath = site_I35_1Path;
        [_bezierPaths addObject:pathItem];
        
        //12
        pathItem = [[embBezierPathItem alloc] init];
        pathItem.pathDelay = inDelay;
        pathItem.pathColor = inPathColor;
        pathItem.pathSpeed = pathSpeed;
        pathItem.pathWidth = pathWidth;
        pathItem.embPath = site_I35_2Path;
        [_bezierPaths addObject:pathItem];
        
        //13
        pathItem = [[embBezierPathItem alloc] init];
        pathItem.pathDelay = inDelay;
        pathItem.pathColor = inPathColor;
        pathItem.pathSpeed = pathSpeed;
        pathItem.pathWidth = pathWidth;
        pathItem.embPath = site_I35_3Path;
        [_bezierPaths addObject:pathItem];
        
        //14
        pathItem = [[embBezierPathItem alloc] init];
        pathItem.pathDelay = outDelay;
        pathItem.pathColor = outPathColor;
        pathItem.pathSpeed = pathSpeed;
        pathItem.pathWidth = pathWidth;
        pathItem.embPath = out_I35_2Path;
        [_bezierPaths addObject:pathItem];
        
        //15
        pathItem = [[embBezierPathItem alloc] init];
        pathItem.pathDelay = outDelay;
        pathItem.pathColor = outPathColor;
        pathItem.pathSpeed = pathSpeed;
        pathItem.pathWidth = pathWidth;
        pathItem.embPath = out_I35_3Path;
        [_bezierPaths addObject:pathItem];
        
        //16
        pathItem = [[embBezierPathItem alloc] init];
        pathItem.pathDelay = inDelay;
        pathItem.pathColor = inPathColor;
        pathItem.pathSpeed = pathSpeed;
        pathItem.pathWidth = pathWidth;
        pathItem.embPath = site_to_airportPath;
        [_bezierPaths addObject:pathItem];
        
        //17
        pathItem = [[embBezierPathItem alloc] init];
        pathItem.pathDelay = inDelay;
        pathItem.pathColor = inPathColor;
        pathItem.pathSpeed = pathSpeed;
        pathItem.pathWidth = pathWidth;
        pathItem.embPath = site_to_loveFieldPath;
        [_bezierPaths addObject:pathItem];
	}
	
	return self;
}

@end
