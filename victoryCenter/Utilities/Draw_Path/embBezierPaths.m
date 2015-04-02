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
        [site_tollway_1Path moveToPoint: CGPointMake(0, 0)];
        [site_tollway_1Path addCurveToPoint: CGPointMake(188, 49) controlPoint1: CGPointMake(13, 9) controlPoint2: CGPointMake(158, 27)];
        [site_tollway_1Path addCurveToPoint: CGPointMake(296, 245) controlPoint1: CGPointMake(218, 71) controlPoint2: CGPointMake(295, 215)];
        [site_tollway_1Path addCurveToPoint: CGPointMake(254, 533) controlPoint1: CGPointMake(297, 275) controlPoint2: CGPointMake(236, 531)];
        [site_tollway_1Path addCurveToPoint: CGPointMake(708, 533) controlPoint1: CGPointMake(272, 535) controlPoint2: CGPointMake(702, 527)];
        [site_tollway_1Path addCurveToPoint: CGPointMake(712, 581) controlPoint1: CGPointMake(714, 539) controlPoint2: CGPointMake(712, 581)];
        site_tollway_1Path.lineCapStyle = kCGLineCapRound;
        
        //// Site_tollway_2 Drawing
        //1
        UIBezierPath* site_tollway_2Path = UIBezierPath.bezierPath;
        [site_tollway_2Path moveToPoint: CGPointMake(0, 535)];
        [site_tollway_2Path addCurveToPoint: CGPointMake(265, 535) controlPoint1: CGPointMake(0, 535) controlPoint2: CGPointMake(247, 533)];
        [site_tollway_2Path addCurveToPoint: CGPointMake(718, 543) controlPoint1: CGPointMake(283, 537) controlPoint2: CGPointMake(712, 537)];
        [site_tollway_2Path addCurveToPoint: CGPointMake(722, 591) controlPoint1: CGPointMake(724, 549) controlPoint2: CGPointMake(722, 591)];
        site_tollway_2Path.lineCapStyle = kCGLineCapRound;
        
        //// Site_tollway_3 Drawing
        //2
        UIBezierPath* site_tollway_3Path = UIBezierPath.bezierPath;
        [site_tollway_3Path moveToPoint: CGPointMake(1024, 432)];
        [site_tollway_3Path addCurveToPoint: CGPointMake(901, 393) controlPoint1: CGPointMake(1023.75, 432) controlPoint2: CGPointMake(970.66, 419.12)];
        [site_tollway_3Path addCurveToPoint: CGPointMake(757, 336) controlPoint1: CGPointMake(833.32, 367.63) controlPoint2: CGPointMake(789, 332)];
        [site_tollway_3Path addCurveToPoint: CGPointMake(712, 581) controlPoint1: CGPointMake(725, 340) controlPoint2: CGPointMake(712, 580)];
        [UIColor.blackColor setStroke];
        
        //// Out_Site_tollway_1 Drawing
        //3
        UIBezierPath* out_Site_tollway_1Path = UIBezierPath.bezierPath;
        [out_Site_tollway_1Path moveToPoint: CGPointMake(719, 582)];
        [out_Site_tollway_1Path addCurveToPoint: CGPointMake(713, 526) controlPoint1: CGPointMake(719, 582) controlPoint2: CGPointMake(710, 548)];
        [out_Site_tollway_1Path addCurveToPoint: CGPointMake(725, 422) controlPoint1: CGPointMake(714.52, 514.89) controlPoint2: CGPointMake(715.56, 468.09)];
        [out_Site_tollway_1Path addCurveToPoint: CGPointMake(749, 329) controlPoint1: CGPointMake(734.24, 376.85) controlPoint2: CGPointMake(753.95, 340.38)];
        [out_Site_tollway_1Path addCurveToPoint: CGPointMake(517, 264) controlPoint1: CGPointMake(743.46, 316.27) controlPoint2: CGPointMake(636.75, 278.47)];
        [out_Site_tollway_1Path addCurveToPoint: CGPointMake(295, 215) controlPoint1: CGPointMake(420.44, 252.33) controlPoint2: CGPointMake(312, 231)];
        [out_Site_tollway_1Path addCurveToPoint: CGPointMake(163, 1) controlPoint1: CGPointMake(256.92, 179.16) controlPoint2: CGPointMake(163, 1)];
        out_Site_tollway_1Path.lineCapStyle = kCGLineCapRound;

        
        //// Out_Site_tollway_2 Drawing
        //4
        UIBezierPath* out_Site_tollway_2Path = UIBezierPath.bezierPath;
        [out_Site_tollway_2Path moveToPoint: CGPointMake(713, 579)];
        [out_Site_tollway_2Path addCurveToPoint: CGPointMake(713, 530) controlPoint1: CGPointMake(713, 579) controlPoint2: CGPointMake(702, 536)];
        [out_Site_tollway_2Path addCurveToPoint: CGPointMake(873, 523) controlPoint1: CGPointMake(724, 524) controlPoint2: CGPointMake(861, 544)];
        [out_Site_tollway_2Path addCurveToPoint: CGPointMake(879, 460) controlPoint1: CGPointMake(878.55, 513.29) controlPoint2: CGPointMake(871.88, 486.72)];
        [out_Site_tollway_2Path addCurveToPoint: CGPointMake(906, 399) controlPoint1: CGPointMake(887.28, 428.95) controlPoint2: CGPointMake(891, 415)];
        [out_Site_tollway_2Path addCurveToPoint: CGPointMake(1024, 334) controlPoint1: CGPointMake(921, 383) controlPoint2: CGPointMake(1024, 334)];
        
        //// Woodall_Rodgers_1 Drawing
        //5
        UIBezierPath* woodall_Rodgers_1Path = UIBezierPath.bezierPath;
        [woodall_Rodgers_1Path moveToPoint: CGPointMake(866, 1)];
        [woodall_Rodgers_1Path addCurveToPoint: CGPointMake(975, 194) controlPoint1: CGPointMake(866, 1) controlPoint2: CGPointMake(984.5, 181.5)];
        [woodall_Rodgers_1Path addCurveToPoint: CGPointMake(756, 318) controlPoint1: CGPointMake(965.5, 206.5) controlPoint2: CGPointMake(759, 313)];
        [woodall_Rodgers_1Path addCurveToPoint: CGPointMake(720, 459) controlPoint1: CGPointMake(753, 323) controlPoint2: CGPointMake(732, 399)];
        [woodall_Rodgers_1Path addCurveToPoint: CGPointMake(712, 584) controlPoint1: CGPointMake(707.21, 522.96) controlPoint2: CGPointMake(712, 584)];
        woodall_Rodgers_1Path.lineCapStyle = kCGLineCapRound;
        
        //// Woodall_Rodgers_2 Drawing
        //6
        UIBezierPath* woodall_Rodgers_2Path = UIBezierPath.bezierPath;
        [woodall_Rodgers_2Path moveToPoint: CGPointMake(293, 0)];
        [woodall_Rodgers_2Path addCurveToPoint: CGPointMake(195, 53) controlPoint1: CGPointMake(293, 0) controlPoint2: CGPointMake(209, 30)];
        [woodall_Rodgers_2Path addCurveToPoint: CGPointMake(301, 249) controlPoint1: CGPointMake(181, 76) controlPoint2: CGPointMake(300, 219)];
        [woodall_Rodgers_2Path addCurveToPoint: CGPointMake(261, 537) controlPoint1: CGPointMake(302, 279) controlPoint2: CGPointMake(243, 535)];
        [woodall_Rodgers_2Path addCurveToPoint: CGPointMake(715, 537) controlPoint1: CGPointMake(279, 539) controlPoint2: CGPointMake(709, 531)];
        [woodall_Rodgers_2Path addCurveToPoint: CGPointMake(719, 585) controlPoint1: CGPointMake(721, 543) controlPoint2: CGPointMake(719, 585)];
        woodall_Rodgers_2Path.lineCapStyle = kCGLineCapRound;
        
        //// Out_Woodall_Rodgers_1 Drawing
        //7
        UIBezierPath* out_Woodall_Rodgers_1Path = UIBezierPath.bezierPath;
        [out_Woodall_Rodgers_1Path moveToPoint: CGPointMake(719, 582)];
        [out_Woodall_Rodgers_1Path addCurveToPoint: CGPointMake(727, 463) controlPoint1: CGPointMake(719, 582) controlPoint2: CGPointMake(715, 527)];
        [out_Woodall_Rodgers_1Path addCurveToPoint: CGPointMake(762, 323) controlPoint1: CGPointMake(738.26, 402.96) controlPoint2: CGPointMake(759, 328)];
        [out_Woodall_Rodgers_1Path addCurveToPoint: CGPointMake(984, 196) controlPoint1: CGPointMake(765, 318) controlPoint2: CGPointMake(976, 209)];
        [out_Woodall_Rodgers_1Path addCurveToPoint: CGPointMake(874, 0) controlPoint1: CGPointMake(992, 183) controlPoint2: CGPointMake(874, 0)];
        out_Woodall_Rodgers_1Path.lineCapStyle = kCGLineCapRound;
		
        //// Out_Woodall_Rodgers_2 Drawing
        //8
        UIBezierPath* out_Woodall_Rodgers_2Path = UIBezierPath.bezierPath;
        [out_Woodall_Rodgers_2Path moveToPoint: CGPointMake(719, 582)];
        [out_Woodall_Rodgers_2Path addCurveToPoint: CGPointMake(727, 463) controlPoint1: CGPointMake(719, 582) controlPoint2: CGPointMake(715, 527)];
        [out_Woodall_Rodgers_2Path addCurveToPoint: CGPointMake(762, 323) controlPoint1: CGPointMake(738.26, 402.96) controlPoint2: CGPointMake(770, 338)];
        [out_Woodall_Rodgers_2Path addCurveToPoint: CGPointMake(295, 215) controlPoint1: CGPointMake(754, 308) controlPoint2: CGPointMake(307, 231)];
        [out_Woodall_Rodgers_2Path addCurveToPoint: CGPointMake(220, 62) controlPoint1: CGPointMake(283, 199) controlPoint2: CGPointMake(207, 81)];
        [out_Woodall_Rodgers_2Path addCurveToPoint: CGPointMake(339, 1) controlPoint1: CGPointMake(233, 43) controlPoint2: CGPointMake(339, 1)];
        out_Woodall_Rodgers_2Path.lineCapStyle = kCGLineCapRound;
        
        //// Site_katy Drawing
        //9
        UIBezierPath* site_katyPath = UIBezierPath.bezierPath;
        [site_katyPath moveToPoint: CGPointMake(173, 11)];
        [site_katyPath addCurveToPoint: CGPointMake(305, 225) controlPoint1: CGPointMake(173, 11) controlPoint2: CGPointMake(266.92, 189.16)];
        [site_katyPath addCurveToPoint: CGPointMake(527, 274) controlPoint1: CGPointMake(322, 241) controlPoint2: CGPointMake(430.44, 262.33)];
        [site_katyPath addCurveToPoint: CGPointMake(759, 339) controlPoint1: CGPointMake(646.75, 288.47) controlPoint2: CGPointMake(753.46, 326.27)];
        [site_katyPath addCurveToPoint: CGPointMake(735, 432) controlPoint1: CGPointMake(763.95, 350.38) controlPoint2: CGPointMake(744.24, 386.85)];
        [site_katyPath addCurveToPoint: CGPointMake(723, 536) controlPoint1: CGPointMake(725.56, 478.09) controlPoint2: CGPointMake(724.52, 524.89)];
        [site_katyPath addCurveToPoint: CGPointMake(729, 592) controlPoint1: CGPointMake(720, 558) controlPoint2: CGPointMake(729, 592)];
        site_katyPath.lineCapStyle = kCGLineCapRound;
        
        //// Out_Site_katy Drawing
        //10
        UIBezierPath* out_Site_katyPath = UIBezierPath.bezierPath;
        [out_Site_katyPath moveToPoint: CGPointMake(719, 582)];
        [out_Site_katyPath addCurveToPoint: CGPointMake(713, 526) controlPoint1: CGPointMake(719, 582) controlPoint2: CGPointMake(710, 548)];
        [out_Site_katyPath addCurveToPoint: CGPointMake(729, 423) controlPoint1: CGPointMake(714.52, 514.89) controlPoint2: CGPointMake(719.56, 469.09)];
        [out_Site_katyPath addCurveToPoint: CGPointMake(752, 342) controlPoint1: CGPointMake(738.24, 377.85) controlPoint2: CGPointMake(756.95, 353.38)];
        [out_Site_katyPath addCurveToPoint: CGPointMake(516, 279) controlPoint1: CGPointMake(746.46, 329.27) controlPoint2: CGPointMake(635.75, 293.47)];
        [out_Site_katyPath addCurveToPoint: CGPointMake(300, 230) controlPoint1: CGPointMake(419.44, 267.33) controlPoint2: CGPointMake(317, 246)];
        [out_Site_katyPath addCurveToPoint: CGPointMake(162, 4) controlPoint1: CGPointMake(261.92, 194.16) controlPoint2: CGPointMake(162, 4)];
        out_Site_katyPath.lineCapStyle = kCGLineCapRound;
        
        //// Site_I35_1 Drawing
        //11
        UIBezierPath* site_I35_1Path = UIBezierPath.bezierPath;
        [site_I35_1Path moveToPoint: CGPointMake(0, 534.5)];
        [site_I35_1Path addCurveToPoint: CGPointMake(705, 535) controlPoint1: CGPointMake(525, 535.5) controlPoint2: CGPointMake(699, 524)];
        [site_I35_1Path addCurveToPoint: CGPointMake(712, 584) controlPoint1: CGPointMake(711, 546) controlPoint2: CGPointMake(712, 584)];
        site_I35_1Path.lineCapStyle = kCGLineCapRound;
        
        //// Site_I35_2 Drawing
        //12
        UIBezierPath* site_I35_2Path = UIBezierPath.bezierPath;
        [site_I35_2Path moveToPoint: CGPointMake(963, 768)];
        [site_I35_2Path addCurveToPoint: CGPointMake(881, 671) controlPoint1: CGPointMake(963, 768) controlPoint2: CGPointMake(887, 714)];
        [site_I35_2Path addCurveToPoint: CGPointMake(894, 396) controlPoint1: CGPointMake(857, 499) controlPoint2: CGPointMake(906, 409)];
        [site_I35_2Path addCurveToPoint: CGPointMake(750, 337) controlPoint1: CGPointMake(882, 383) controlPoint2: CGPointMake(760, 326)];
        [site_I35_2Path addCurveToPoint: CGPointMake(720, 459) controlPoint1: CGPointMake(745.1, 342.39) controlPoint2: CGPointMake(728.13, 400.51)];
        [site_I35_2Path addCurveToPoint: CGPointMake(712, 581) controlPoint1: CGPointMake(711.54, 519.83) controlPoint2: CGPointMake(712, 581)];
        site_I35_2Path.lineCapStyle = kCGLineCapRound;
        
        //// Site_I35_3 Drawing
        //13
        UIBezierPath* site_I35_3Path = UIBezierPath.bezierPath;
        [site_I35_3Path moveToPoint: CGPointMake(8, 239)];
        [site_I35_3Path addCurveToPoint: CGPointMake(75, 220) controlPoint1: CGPointMake(25.92, 239.03) controlPoint2: CGPointMake(49.17, 225.66)];
        [site_I35_3Path addCurveToPoint: CGPointMake(278, 220) controlPoint1: CGPointMake(146.44, 204.34) controlPoint2: CGPointMake(236.35, 187.99)];
        [site_I35_3Path addCurveToPoint: CGPointMake(258, 517) controlPoint1: CGPointMake(319.99, 252.27) controlPoint2: CGPointMake(214.59, 499.64)];
        [site_I35_3Path addCurveToPoint: CGPointMake(477, 529) controlPoint1: CGPointMake(333, 547) controlPoint2: CGPointMake(430.94, 529.56)];
        [site_I35_3Path addCurveToPoint: CGPointMake(715, 545) controlPoint1: CGPointMake(648.4, 526.9) controlPoint2: CGPointMake(711.33, 538.27)];
        [site_I35_3Path addCurveToPoint: CGPointMake(722, 594) controlPoint1: CGPointMake(721, 556) controlPoint2: CGPointMake(722, 594)];
        site_I35_3Path.lineCapStyle = kCGLineCapRound;
        
        //// Out_I35_2 Drawing
        //14
        UIBezierPath* out_I35_2Path = UIBezierPath.bezierPath;
        [out_I35_2Path moveToPoint: CGPointMake(715, 588)];
        [out_I35_2Path addCurveToPoint: CGPointMake(715, 532) controlPoint1: CGPointMake(721, 575) controlPoint2: CGPointMake(713.93, 556.59)];
        [out_I35_2Path addCurveToPoint: CGPointMake(871, 532) controlPoint1: CGPointMake(716, 509) controlPoint2: CGPointMake(849, 533)];
        [out_I35_2Path addCurveToPoint: CGPointMake(879, 460) controlPoint1: CGPointMake(882.28, 531.49) controlPoint2: CGPointMake(872.99, 493.94)];
        [out_I35_2Path addCurveToPoint: CGPointMake(906, 399) controlPoint1: CGPointMake(884.71, 427.75) controlPoint2: CGPointMake(883, 417)];
        [out_I35_2Path addCurveToPoint: CGPointMake(1024, 334) controlPoint1: CGPointMake(929, 381) controlPoint2: CGPointMake(1024, 334)];
        out_I35_2Path.lineCapStyle = kCGLineCapRound;
        
        //// Out_I35_3 Drawing
        //15
        UIBezierPath* out_I35_3Path = UIBezierPath.bezierPath;
        [out_I35_3Path moveToPoint: CGPointMake(719, 585)];
        [out_I35_3Path addCurveToPoint: CGPointMake(715, 537) controlPoint1: CGPointMake(719, 585) controlPoint2: CGPointMake(721, 548)];
        [out_I35_3Path addCurveToPoint: CGPointMake(723, 420) controlPoint1: CGPointMake(711.33, 530.27) controlPoint2: CGPointMake(717, 469)];
        [out_I35_3Path addCurveToPoint: CGPointMake(719, 308) controlPoint1: CGPointMake(724.61, 406.83) controlPoint2: CGPointMake(759, 342)];
        [out_I35_3Path addCurveToPoint: CGPointMake(249, 220) controlPoint1: CGPointMake(703.02, 294.42) controlPoint2: CGPointMake(436.19, 240.94)];
        [out_I35_3Path addCurveToPoint: CGPointMake(75, 220) controlPoint1: CGPointMake(165.02, 210.61) controlPoint2: CGPointMake(97.12, 215.15)];
        [out_I35_3Path addCurveToPoint: CGPointMake(-4, 255) controlPoint1: CGPointMake(49.17, 225.66) controlPoint2: CGPointMake(14, 248)];
        out_I35_3Path.lineCapStyle = kCGLineCapRound;
        
        //// Site_to_airport Drawing
        //16
        UIBezierPath* site_to_airportPath = UIBezierPath.bezierPath;
        [site_to_airportPath moveToPoint: CGPointMake(712, 581)];
        [site_to_airportPath addCurveToPoint: CGPointMake(720, 459) controlPoint1: CGPointMake(712, 581) controlPoint2: CGPointMake(711.54, 519.83)];
        [site_to_airportPath addCurveToPoint: CGPointMake(750, 337) controlPoint1: CGPointMake(728.14, 400.51) controlPoint2: CGPointMake(745.1, 342.39)];
        [site_to_airportPath addCurveToPoint: CGPointMake(894, 396) controlPoint1: CGPointMake(760, 326) controlPoint2: CGPointMake(882, 383)];
        [site_to_airportPath addCurveToPoint: CGPointMake(881, 671) controlPoint1: CGPointMake(906, 409) controlPoint2: CGPointMake(857, 499)];
        [site_to_airportPath addCurveToPoint: CGPointMake(963, 768) controlPoint1: CGPointMake(887, 714) controlPoint2: CGPointMake(963, 768)];
        site_to_airportPath.lineCapStyle = kCGLineCapRound;
        
        //// Site_to_loveField Drawing
        //17
        UIBezierPath* site_to_loveFieldPath = UIBezierPath.bezierPath;
        [site_to_loveFieldPath moveToPoint: CGPointMake(712, 581)];
        [site_to_loveFieldPath addCurveToPoint: CGPointMake(720, 459) controlPoint1: CGPointMake(712, 581) controlPoint2: CGPointMake(711.54, 519.83)];
        [site_to_loveFieldPath addCurveToPoint: CGPointMake(750, 337) controlPoint1: CGPointMake(728.14, 400.51) controlPoint2: CGPointMake(745.1, 342.39)];
        [site_to_loveFieldPath addCurveToPoint: CGPointMake(558, 273) controlPoint1: CGPointMake(754.49, 332.06) controlPoint2: CGPointMake(661.92, 297.16)];
        [site_to_loveFieldPath addCurveToPoint: CGPointMake(278, 220) controlPoint1: CGPointMake(430.43, 243.35) controlPoint2: CGPointMake(366, 237)];
        [site_to_loveFieldPath addCurveToPoint: CGPointMake(106, 217) controlPoint1: CGPointMake(190, 203) controlPoint2: CGPointMake(106, 217)];
        [site_to_loveFieldPath addLineToPoint: CGPointMake(-4, 255)];
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
