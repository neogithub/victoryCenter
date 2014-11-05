//
//  embDrawPath.m
//  embAnimatedPath
//
//  Created by Evan Buxton on 12/12/13.
//  Copyright (c) 2013 neoscape. All rights reserved.
//

#import "embDrawPath.h"
#import "UIColor+Extensions.h"

@implementation embDrawPath

@synthesize delegate;

- (void)baseInit {
	_animationSpeed = 3.0;
	_pathLineWidth = 8.0;
	_pathFillColor = nil;
	_pathStrokeColor = [UIColor redColor];
	_pathCapImage = nil;
	_animated = YES;
	_isTappable = YES;
	polyPaths = [[NSMutableArray alloc] init];
	arr_shapeLayers = [[NSMutableArray alloc] init];
	arr_strokeCapLayers = [[NSMutableArray alloc] init];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self baseInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self baseInit];
    }
    return self;
}

#pragma mark - DELEGATE MESSAGES
-(void)embDrawPathShouldRemove
{
	[self removeFromSuperview];
}

-(void)pathTappedAtIndex:(int)i
{
//	NSLog(@"should %i", i);
	if ([delegate respondsToSelector:@selector(embDrawPath:indexOfTapped:)]) {
		[self fadePaths];
		[delegate embDrawPath:self indexOfTapped:i];
	}
	//NSLog(@"done %lu", (unsigned long)arr_shapeLayers.count);
}

-(void)didFinishAnimatingPath {
	if ([delegate respondsToSelector:@selector(didFinishAnimatingPath:)])
		return [delegate didFinishAnimatingPath:self];
}

-(void)didFinishAllAnimations {
	if ([delegate respondsToSelector:@selector(didFinishAllAnimations:)])
		return [delegate didFinishAllAnimations:self];
}

-(void)pathAnimating:(embDrawPath*)animating {
	if ([delegate respondsToSelector:@selector(pathAnimating:)])
		return [delegate pathAnimating:self];
}

-(NSString*)pathString
{
	NSString *myStr = _pathString;
	return myStr;
}

-(UIBezierPath*)myPath
{
	UIBezierPath *myStr = _myPath;
	return myStr;
}

- (void)startAnimationFromIndex:(int)index afterDelay:(CGFloat)afterDelay
{	
//	NSLog(@"startAnimationFromIndex in embdrawpath");
	CAShapeLayer *shapeLayer = [CAShapeLayer layer];
	//shapeLayer.path = [self buildPath].CGPath;
	UIBezierPath *myStr = _myPath;
	UIBezierPath *path = nil;
	if(!path){
		path = [UIBezierPath bezierPath];
		path = myStr;
	}
	
	[polyPaths addObject:path];
	
	shapeLayer.path = path.CGPath;
	
	shapeLayer.strokeColor = [UIColor redColor].CGColor;
	shapeLayer.fillColor = _pathFillColor.CGColor;
	shapeLayer.lineWidth = _pathLineWidth;
	shapeLayer.lineJoin = kCALineJoinRound;
	shapeLayer.opacity = 0.0;
	[arr_shapeLayers addObject:shapeLayer];

	if (_isTappable) {
		UITapGestureRecognizer *menuFingerTap = [[UITapGestureRecognizer alloc]
												 initWithTarget:self
												 action:@selector(mainMenuTapped:)];
		[self addGestureRecognizer:menuFingerTap];
	}
	
	[self.layer addSublayer:shapeLayer];
	self.pathLayer = shapeLayer;
	
	if (_pathCapImage) {
		UIImage *tipImage = _pathCapImage;
		CALayer *penLayer = [CALayer layer];
		penLayer.contents = (id)tipImage.CGImage;
		penLayer.anchorPoint = CGPointMake(0.5, 0.5);
		penLayer.frame = CGRectMake(0.0f, 0.0f, tipImage.size.width, tipImage.size.height);
		[_pathLayer addSublayer:penLayer];
		self.penLayer = penLayer;
		[arr_strokeCapLayers addObject:self.penLayer];
	}
	
	if (!_animated) {
		shapeLayer.opacity = 1.0;
		return;
	}

	// otherwise start DRAWING!!
	CABasicAnimation *pathOpacity = [CABasicAnimation animationWithKeyPath:@"opacity"];
    pathOpacity.duration = 0.33;
	[pathOpacity setBeginTime:CACurrentMediaTime()+afterDelay];
    pathOpacity.fromValue = @(0.0f);
    pathOpacity.toValue = @(1.0f);
	pathOpacity.fillMode = kCAFillModeForwards;
	pathOpacity.removedOnCompletion = NO;
    [self.pathLayer addAnimation:pathOpacity forKey:@"opacity"];
	
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
	pathAnimation.delegate=self;
    pathAnimation.duration = _animationSpeed;
	[pathAnimation setBeginTime:CACurrentMediaTime()+afterDelay];
	pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    pathAnimation.fromValue = @(0.0f);
    pathAnimation.toValue = @(1.0f);
	[pathAnimation setValue:@"strokeEnd" forKey:@"id"];
    [self.pathLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
	
	// iOS 7 breaks this so I comment out
	// DOES NOT FUNCTION RIGHT IN iOS 7
	
	CAKeyframeAnimation *penAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
	[penAnimation setBeginTime:CACurrentMediaTime()];
	penAnimation.duration = _animationSpeed;
	[penAnimation setBeginTime:CACurrentMediaTime()+afterDelay];
	penAnimation.path = self.pathLayer.path;
	penAnimation.calculationMode = kCAAnimationPaced;
	penAnimation.rotationMode = kCAAnimationRotateAuto;
	penAnimation.fillMode = kCAFillModeForwards;
	penAnimation.removedOnCompletion = NO;
	penAnimation.delegate = self;
	self.penLayer.opacity = 0.0;
	[self.penLayer addAnimation:penAnimation forKey:@"position"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if([[anim valueForKey:@"id"] isEqual:@"strokeEnd"]) {
		[self didFinishAnimatingPath];
		pathCompleted++;
		[self checkFinished];
		for (CAShapeLayer *strokeCap in arr_strokeCapLayers) {
			strokeCap.opacity = 1.0;
		}
    }
}

-(void)animationDidStart:(CAAnimation *)anim {
	[self pathAnimating:self];
}

-(void)checkFinished {
	//NSLog(@"%i",pathCompleted);
	//NSLog(@"%i",arr_shapeLayers.count);
	
	if (pathCompleted == arr_shapeLayers.count) {
		[self didFinishAllAnimations];
	}
}

-(void)fadePaths
{
	[UIView animateWithDuration:0.33
					 animations:^{
						 
						 [polyPaths enumerateObjectsUsingBlock:^(UIBezierPath *obj, NSUInteger idx, BOOL *stop) {
							 // clear already highlighted
							 for (int i=0; i<[arr_shapeLayers count]; i++) {
								 CAShapeLayer *myShapeLayer = [CAShapeLayer layer];
								 myShapeLayer = arr_shapeLayers[idx];
								 myShapeLayer.path = obj.CGPath;
								 myShapeLayer.fillColor = [[UIColor clearColor] CGColor];
								 myShapeLayer.strokeColor = [[UIColor clearColor] CGColor];
								 myShapeLayer.opacity = 1.0;
							 }
						 }];
						 
					 }
					 completion:^(BOOL  completed){
						 [UIView animateWithDuration:0.3
										  animations:^{ }
										  completion:^(BOOL  completed){  }];}];
	
}

-(void)highlightFromParent:(int)index
{
	[polyPaths enumerateObjectsUsingBlock:^(UIBezierPath *obj, NSUInteger idx, BOOL *stop) {
		// clear already highlighted
		for (int i=0; i<[arr_shapeLayers count]; i++) {
			CAShapeLayer *myShapeLayer = [CAShapeLayer layer];
			myShapeLayer = arr_shapeLayers[idx];
			myShapeLayer.path = obj.CGPath;
			myShapeLayer.fillColor = [[UIColor clearColor] CGColor];
			myShapeLayer.strokeColor = _pathStrokeColor.CGColor;
			myShapeLayer.opacity = 1.0;
		}
	}];
	
	CAShapeLayer *myShapeLayer = [CAShapeLayer layer];
	myShapeLayer = arr_shapeLayers[index];
	UIBezierPath*patth = polyPaths[index];
	myShapeLayer.path = patth.CGPath;
	myShapeLayer.fillColor = [[UIColor redColor] CGColor];
	myShapeLayer.strokeColor = _pathStrokeColor.CGColor;
	myShapeLayer.opacity = 1.0;
}

-(void)mainMenuTapped:(UIGestureRecognizer*)recognizer
{
	NSLog(@"mainMenuTapped");
	CGPoint touchPoint = [recognizer locationInView: self];
	//[self fadePaths];
	[polyPaths enumerateObjectsUsingBlock:^(UIBezierPath *obj, NSUInteger idx, BOOL *stop) {
		if( [obj containsPoint:touchPoint] ){
			[self pathTappedAtIndex:(int)idx];
			CAShapeLayer *myShapeLayer = [CAShapeLayer layer];
			myShapeLayer = arr_shapeLayers[idx];
			myShapeLayer.path = obj.CGPath;
			//myShapeLayer.fillColor = [[[UIColor redColor] colorWithAlphaComponent:0.5] CGColor];
			myShapeLayer.fillColor = [[UIColor colorWithRed:235.0f/255.0f green:199.0f/255.0f blue:111.0f/255.0f alpha:1.0] CGColor];
			//myShapeLayer.strokeColor = [[UIColor whiteColor] CGColor] ;
			myShapeLayer.strokeColor = [[UIColor colorWithRed: 123.0f/255.0f green: 179.0f/255.0f blue: 213.0f/255.0f alpha: 1] CGColor];
			myShapeLayer.opacity = 1.0;
			return;
		}
	}];
}

#pragma mark - utility
- (UIBezierPath *)buildPath {

	UIBezierPath *path = nil;
	if(!path){
		path = [UIBezierPath bezierPath];
		path = _myPath;
	}
	
	[polyPaths addObject:path];
    return path;
}

@end
