//
//  xhPanoramicView.h
//  xh_AccelerMonitor
//
//  Created by Xiaohe Hu on 6/2/14.
//  Copyright (c) 2014 Xiaohe Hu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

@interface xhPanoramicView : UIView <UIScrollViewDelegate> {
    float       imageWidth;
    float       imageHeight;
    BOOL        withDirection;
}


@property (strong, nonatomic) CMMotionManager   *motionManager;
@property (nonatomic,strong)  UIScrollView      *uis_panoramic;
@property (nonatomic, readwrite)    float       offSetValue;

- (id)initWithFrame:(CGRect)frame andImageName:(NSString *)imageName andDirection:(BOOL)direction;
-(void)stopMotionManager;
@end
