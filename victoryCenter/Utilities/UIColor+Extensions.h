//
//  UIColor+Extensions.h
//  650mad
//
//  Created by Evan Buxton on 9/27/12.
//
//

#import <UIKit/UIKit.h>

@interface UIColor (Extensions)

+ (UIColor *)colorWithHueDegrees:(CGFloat)hue saturation:(CGFloat)saturation brightness:(CGFloat)brightness;
+ (UIColor *)colorWithR:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue A:(CGFloat)alpha;
+ (UIColor *)vcLightBlue;
+ (UIColor *)vcDarkBlue;
+ (UIColor *)vclightbluemenu;
+ (UIColor *)vcdarkmenu;
+ (UIColor *)vccyanmenu;
+ (UIColor *)vcmediummenu;
+ (UIColor *)vcButtonBorder;
+ (UIColor *)vcTeamLogoBg;
//+ (UIColor *)vpShadowBlue;
//+ (UIColor *)vpYellow;
//+ (UIColor *)vpTextBlue;
//+ (UIColor *)randomColor;
//+ (UIColor *)vpBGBlue;
//+ (UIColor *)vpDirectionBlue;
@end
