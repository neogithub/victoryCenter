//
//  embKenBurns.h
//  riverpoint
//
//  Created by Evan Buxton on 7/30/13.
//  Copyright (c) 2013 Seamus O'Mahoney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@class embKenBurns;

#pragma - embKenBurnsDelegate
@protocol embKenBurnsDelegate <NSObject>
@optional
- (void)didShowImageAtIndex:(NSUInteger)index;
- (void)didFinishAllAnimations;
- (void)isPaused:(BOOL)pauseState;
@end

@interface embKenBurns : UIView
{
NSMutableArray *imagesArray;
	float timeTransition;
	BOOL isLoop;
	BOOL isLandscape;
	__weak id <embKenBurnsDelegate> delegate;
	float resizeRatio	;
	float widthDiff		;
	float heightDiff	;
	float originX       ;
	float originY       ;
	float zoomInX       ;
	float zoomInY       ;
	float moveX         ;
	float moveY         ;
	float frameWidth    ;
	float frameHeight   ;
	float rotation		;
	NSInteger imgIndex;
}

@property (nonatomic, assign) float timeTransition;
@property (nonatomic, retain) NSMutableArray *imagesArray;
@property (nonatomic) BOOL isLoop;
@property (nonatomic) BOOL isLandscape;
@property (nonatomic) BOOL isPaused;
@property (weak) id<embKenBurnsDelegate> delegate;
@property (nonatomic, strong) NSThread *myThread;

- (void) animateWithImages:(NSArray *)images transitionDuration:(float)time loop:(BOOL)isLoop isLandscape:(BOOL)isLandscape;
- (void) isPaused:(BOOL)paused;
- (void) loadNext;
- (void) loadPrev;

@end
