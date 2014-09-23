//
//  UIColor+Extensions.m
//  650mad
//
//  Created by Evan Buxton on 9/27/12.
//
//

#import "UIColor+Extensions.h"

@implementation UIColor (Extensions)

#pragma mark
#pragma mark description

+ (UIColor *)colorWithHueDegrees:(CGFloat)hue saturation:(CGFloat)saturation brightness:(CGFloat)brightness {
    return [UIColor colorWithHue:(hue/360) saturation:saturation brightness:brightness alpha:1.0];
}

+ (UIColor *)colorWithR:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue A:(CGFloat)alpha {
    return [UIColor colorWithRed:(red/255.0) green:(green/255.0) blue:(blue/255.0) alpha:alpha];
}

+ (UIColor *)vpLightBlue {
	return [UIColor colorWithRed: 68.0f/255.0f green: 118.0f/255.0f blue: 156.0f/255.0f alpha: 1];
}

+ (UIColor *)vpDarkBlue {
	return [UIColor colorWithRed: 123.0f/255.0f green: 179.0f/255.0f blue: 213.0f/255.0f alpha: 1];
}

+ (UIColor *)vpYellow {
	return [UIColor colorWithRed:235.0f/255.0f green:199.0f/255.0f blue:111.0f/255.0f alpha:1.0];
}

+ (UIColor *)vpShadowBlue {
	return [UIColor colorWithRed:93.0f/255.0f green:162.0f/255.0f blue:205.0f/255.0f alpha:1.0];
}

+ (UIColor *)vpTextBlue {
	return [UIColor colorWithRed:43.0f/255.0f green:55.0f/255.0f blue:86.0f/255.0f alpha:1.0];
}

+ (UIColor *)vpBGBlue {
	return [UIColor colorWithRed:52.0f/255.0f green:138.0f/255.0f blue:192.0f/255.0f alpha:1.0];
}

+ (UIColor *)vpDirectionBlue {
	return [UIColor colorWithRed:43.0f/255.0f green:56.0f/255.0f blue:140.0f/255.0f alpha:1.0];
}

+ (UIColor *)randomColor {
    return [self colorWithRed:((float)rand() / RAND_MAX)
                        green:((float)rand() / RAND_MAX)
                         blue:((float)rand() / RAND_MAX)
                        alpha:1.0f];
}

// use self.view.backgroundColor = highlight? [UIColor paleYellowColor] : [UIColor whitecolor];

@end
