//
//  embKenBurns.m
//  riverpoint
//
//  Created by Evan Buxton on 7/30/13.
//  Copyright (c) 2013 Seamus O'Mahoney. All rights reserved.
//

#import "embKenBurns.h"

// Private interface
@interface embKenBurns ()

@property (nonatomic) int currentImage;
@property (nonatomic) BOOL animationInCurse;
- (void) animate:(NSNumber*)num;
- (void) _startAnimations:(NSArray*)images;
@end

@implementation embKenBurns

@synthesize imagesArray, timeTransition, isLoop, isLandscape;
@synthesize animationInCurse, currentImage, delegate;

-(id)init
{
    self = [super init];
    if (self) {
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void) animateWithImages:(NSMutableArray *)images transitionDuration:(float)duration loop:(BOOL)shouldLoop isLandscape:(BOOL)inLandscape;
{
    self.imagesArray      = images;
    self.timeTransition   = duration;
    self.isLoop           = shouldLoop;
    self.isLandscape      = inLandscape;
	imgIndex = 0;
    self.animationInCurse = NO;
    self.layer.masksToBounds = YES;
		
	_myThread = [[NSThread alloc] initWithTarget:self selector:@selector(_startAnimations:) object:images];
	[_myThread start];
	_isPaused=YES;
}

-(void)_startAnimations:(NSArray *)images
{
    
//	NSInteger myLength		= [images count]; //10
//	NSInteger startIndex	= 2;
//	
//	NSMutableArray *indexd = [[NSMutableArray alloc] init];
//	
//	NSInteger g = startIndex;
//	for (NSInteger i = startIndex; i <= myLength ; i++) {
//		//NSLog(@"%li",(long)g++);
//		[indexd addObject: [NSNumber numberWithInt: g++]];
//	}
//	
//	if (startIndex > 0 ) {
//		for (NSInteger i = 0; i < startIndex ; i++) {
//			//NSLog(@"=%i",i);
//			[indexd addObject: [NSNumber numberWithInt: i]];
//		}
//	}
//	
//	NSLog(@"== %@", [indexd description]);
	
	for (NSInteger i = imgIndex; i < [images count]; i++) {
		
		dispatch_async(dispatch_get_main_queue(),^ {
			 if (_isPaused!=NO) {
				 [self animate:[NSNumber numberWithInteger:i]];
			 }
		} );

        sleep(self.timeTransition);
        
        i = (i == [images count] - 1) && isLoop ? -1 : i;
	}
}

-(void)animate:(NSNumber*)num {
	
//	NSLog(@"animate");
	
	UIImage* image = [self.imagesArray objectAtIndex:[num intValue]];
    UIImageView *imageView;
	imgIndex = [num integerValue];

	resizeRatio   = -1;
    widthDiff     = -1;
    heightDiff    = -1;
    originX       = -1;
    originY       = -1;
    zoomInX       = -1;
    zoomInY       = -1;
    moveX         = -1;
    moveY         = -1;
    frameWidth    = isLandscape? self.frame.size.width : self.frame.size.height;
    frameHeight   = isLandscape? self.frame.size.height : self.frame.size.width;
	
	
    // Widder than screen
    if (image.size.width > frameWidth)
    {
        widthDiff  = image.size.width - frameWidth;
        
        // Higher than screen
        if (image.size.height > frameHeight)
        {
            heightDiff = image.size.height - frameHeight;
            
            if (widthDiff > heightDiff)
                resizeRatio = frameHeight / image.size.height;
            else
                resizeRatio = frameWidth / image.size.width;
            
            // No higher than screen
        }
        else
        {
            heightDiff = frameHeight - image.size.height;
            
            if (widthDiff > heightDiff)
                resizeRatio = frameWidth / image.size.width;
            else
                resizeRatio = self.bounds.size.height / image.size.height;
        }
        
        // No widder than screen
    }
    else
    {
        widthDiff  = frameWidth - image.size.width;
        
        // Higher than screen
        if (image.size.height > frameHeight)
        {
            heightDiff = image.size.height - frameHeight;
            
            if (widthDiff > heightDiff)
                resizeRatio = image.size.height / frameHeight;
            else
                resizeRatio = frameWidth / image.size.width;
            
            // No higher than screen
        }
        else
        {
            heightDiff = frameHeight - image.size.height;
            
            if (widthDiff > heightDiff)
                resizeRatio = frameWidth / image.size.width;
            else
                resizeRatio = frameHeight / image.size.height;
        }
    }
    
    // Resize the image.
    float optimusWidth  = (image.size.width * resizeRatio) * 1.2;
    float optimusHeight = (image.size.height * resizeRatio) * 1.2;
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, optimusWidth, optimusHeight)];
    
    // Calcule the maximum move allowed.
    float maxMoveX = optimusWidth - frameWidth;
    float maxMoveY = optimusHeight - frameHeight;
    
    rotation = (arc4random() % 9) / 100;
    
    switch (arc4random() % 4) {
        case 0:
            originX = 0;
            originY = 0;
            zoomInX = 1.25;
            zoomInY = 1.25;
            moveX   = -maxMoveX;
            moveY   = -maxMoveY;
			break;
    
        case 1:
            originX = 0;
            originY = frameHeight - optimusHeight;
            zoomInX = 1.10;
            zoomInY = 1.10;
            moveX   = -maxMoveX;
            moveY   = maxMoveY;
            break;
            
            
        case 2:
            originX = frameWidth - optimusWidth;
            originY = 0;
            zoomInX = 1.30;
            zoomInY = 1.30;
            moveX   = maxMoveX;
            moveY   = -maxMoveY;
            break;
            
        case 3:
            originX = frameWidth - optimusWidth;
            originY = frameHeight - optimusHeight;
            zoomInX = 1.20;
            zoomInY = 1.20;
            moveX   = maxMoveX;
            moveY   = maxMoveY;
            break;
            
        default:
            NSLog(@"def");
            break;
    }

    CALayer *picLayer    = [CALayer layer];
    picLayer.contents    = (id)image.CGImage;
    picLayer.anchorPoint = CGPointMake(0, 0);
    picLayer.bounds      = CGRectMake(0, 0, optimusWidth, optimusHeight);
    picLayer.position    = CGPointMake(originX, originY);
    
    [imageView.layer addSublayer:picLayer];
    
    CATransition *animation = [CATransition animation];
    [animation setDuration:1];
    [animation setType:kCATransitionFade];
    [[self layer] addAnimation:animation forKey:nil];
    
    // Remove the previous view
    if ([[self subviews] count] > 0){
        [[[self subviews] objectAtIndex:0] removeFromSuperview];
    }
    
    [self addSubview:imageView];
	[self doAnimation:imageView];
}

- (void)doAnimation:(UIImageView*)img
{
	[UIView animateWithDuration:self.timeTransition+2
                          delay: 0.0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
						 CGAffineTransform rotate    = CGAffineTransformMakeRotation(rotation);
						 CGAffineTransform moveRight = CGAffineTransformMakeTranslation(moveX, moveY);
						 CGAffineTransform combo1    = CGAffineTransformConcat(rotate, moveRight);
						 CGAffineTransform zoomIn    = CGAffineTransformMakeScale(zoomInX, zoomInY);
						 CGAffineTransform transform = CGAffineTransformConcat(zoomIn, combo1);
						 img.transform = transform;
                     }
                     completion:^(BOOL finished){
                     }];
	
    [UIView commitAnimations];
}

- (void)isPaused:(BOOL)paused;
{
	NSLog(@"isPaused = %@\n", (paused ? @"NO" : @"YES"));
	_isPaused=paused;
	if (_isPaused==YES) {
		[self.myThread cancel];
		self.myThread = nil;
		NSLog(@"Should restart/reset");
	}
}

-(void)loadPrev
{
	if (imgIndex==0)
		imgIndex = [imagesArray count];
	[self animate:[NSNumber numberWithInteger:imgIndex-1]];
}

-(void)loadNext
{
	NSLog(@"loadNext");
	
	// Remove the previous view
    if ([[self subviews] count] > 0){
		[[[self subviews] objectAtIndex:0] removeFromSuperview];
	}
	
	for (UIView *v in [self subviews]) {
		if ([v isKindOfClass:[UIImageView class]]) {
			[v removeFromSuperview];
		}
	}
	
	self.layer.sublayers = nil;
	
	[self.myThread cancel];
	self.myThread = nil;
	
//	NSInteger myLength		= [imagesArray count]; //10
//	NSInteger startIndex	= imgIndex;
//	
//	NSMutableArray *indexd = [[NSMutableArray alloc] init];
//	
//	NSInteger g = startIndex;
//	for (NSInteger i = startIndex; i <= myLength ; i++) {
//		//NSLog(@"%li",(long)g++);
//		[indexd addObject: [NSNumber numberWithInt: g++]];
//	}
//	
//	if (startIndex > 0 ) {
//		for (NSInteger i = 0; i < startIndex ; i++) {
//			//NSLog(@"=%i",i);
//			[indexd addObject: [NSNumber numberWithInt: i]];
//		}
//	}
//	
//	NSLog(@"== %@", [indexd description]);
//	NSLog(@"start @ %i", [indexd[0] integerValue]);

	//for (uint i = [indexd[0] integerValue]; i < [indexd count]; i++) {
		
	//dispatch_async(dispatch_get_main_queue(),^ {
	//	if (_isPaused!=NO) {
	
	if (imgIndex==[imagesArray count])
		imgIndex = 0;
	else {
		imgIndex++;
	}
	
	[NSObject cancelPreviousPerformRequestsWithTarget:self];
	[self.myThread cancel];

	//[self restartThread];

	
//	for (uint i = imgIndex; i < [imagesArray count]; i++) {
//		
//		dispatch_async(dispatch_get_main_queue(),^ {
//			if (_isPaused!=NO) {
//				[self animate:[NSNumber numberWithInt:[indexd[i] integerValue]]];
//			}
//		} );
//		NSLog(@"dispatch @ %i", [indexd[i] integerValue]);
//
//        sleep(self.timeTransition);
//        
//        i = (i == [imagesArray count] - 1) && isLoop ? -1 : i;
//	}
	
	//[self animate:[NSNumber numberWithInt:imgIndex+1]];
	//		}
//	} );
		
	//   sleep(self.timeTransition);
        
	//   i = (i == [imagesArray count] - 1) && isLoop ? -1 : i;
	//}
}

-(void)restartThread
{
	_myThread = [[NSThread alloc] initWithTarget:self selector:@selector(_startAnimations:) object:imagesArray];
	[_myThread start];
	_isPaused=YES;
}

@end
