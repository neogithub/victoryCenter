//
//  embDrawPath.h
//  embAnimatedPath
//
//  Created by Evan Buxton on 12/12/13.
//  Copyright (c) 2013 neoscape. All rights reserved.
//  (UIBezierPath *)buildPath from Sean Tierney

#import <UIKit/UIKit.h>
#import "embBezierPathItem.h"

@class embDrawPath;

@protocol embDrawPathDelegate <NSObject>
@optional
-(void)embDrawPath:(embDrawPath *)path indexOfTapped:(int)i;
-(void)pathAnimating:(embDrawPath*)animating;
-(void)didFinishAnimatingPath:(embDrawPath*)finished;
-(void)didFinishAllAnimations:(embDrawPath*)finished;
@end

@interface embDrawPath : UIView <UIGestureRecognizerDelegate> {
	__weak id <embDrawPathDelegate> delegate;
	NSUInteger cPath;
	NSMutableArray *polyPaths;
	NSMutableArray *arr_shapeLayers;
	NSMutableArray *arr_strokeCapLayers;
	embBezierPathItem *pathItem;
	NSUInteger pathCompleted;
}

@property (nonatomic, retain) CAShapeLayer *pathLayer;
@property (nonatomic, retain) NSString *pathString;
@property (nonatomic, assign) CGFloat animationSpeed;
@property (nonatomic, assign) CGFloat pathLineWidth;
@property (nonatomic, retain) UIColor *pathStrokeColor;
@property (nonatomic, retain) UIColor *pathFillColor;
@property (nonatomic, assign) UIImage *pathCapImage;
@property (nonatomic, strong) CALayer *penLayer;
@property (nonatomic, strong) UIBezierPath *myPath;

@property (assign) BOOL animated;
@property (assign) BOOL isTappable;
@property __weak id <embDrawPathDelegate> delegate;


- (id)initWithFrame:(CGRect)frame;
- (void)embDrawPathShouldRemove;
- (void)didFinishAnimatingPath;
- (void)didFinishAllAnimations;
- (void)startAnimationFromIndex:(int)index afterDelay:(CGFloat)afterDelay;
- (void)pathTappedAtIndex:(int)i;
- (NSString*)pathString;
-(void)highlightFromParent:(int)index;
- (UIBezierPath*)myPath;
;
@end
