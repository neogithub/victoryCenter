//
//  xhPopTipsView.m
//  victoryCenter
//
//  Created by Xiaohe Hu on 11/11/14.
//  Copyright (c) 2014 Neoscape. All rights reserved.
//

#import "xhPopTipsView.h"
#import "UIColor+Extensions.h"

@interface xhPopTipsView()
// Help tip view
@property (nonatomic, strong) NSArray                *arr_helpText;
@property (nonatomic, strong) NSMutableArray         *visiblePopTipViews;
@property (nonatomic, strong) NSArray                *arr_helpTargetViews;
@property (nonatomic, strong) UIView                 *uiv_helpContianer;
@end

@implementation xhPopTipsView
@synthesize pointDirection;

- (id)initWithFrame:(CGRect)frame andText:(NSArray *)helpText andViews:(NSArray *)viewArray
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.frame = screenRect;
        _arr_helpText = [[NSArray alloc] initWithArray:helpText];
        _arr_helpTargetViews = [[NSArray alloc] initWithArray:viewArray];
        [self loadHelpView];
    }
    return self;
}

//- (void)prepareHlepData:(NSString *)name
//{
//    _arr_helpText = nil;
//    _arr_helpText = [[NSMutableArray alloc] initWithObjects:
//                     @"Tap close button to return.",
//                     @"Tap cell send email.",
//                     nil];
//    
//    [_arr_helpTargetViews removeAllObjects];
//    _arr_helpTargetViews = nil;
//    UIButton *homeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 45.0, 45.0)];
//    UIView *tmp2 = [[UIView alloc] initWithFrame:CGRectMake(860, 305, 233, 100)];
//    _arr_helpTargetViews = [[NSMutableArray alloc] initWithObjects:homeBtn, tmp2, nil];
//}

- (void)dismissAllPopTipViews
{
    [_uiv_helpContianer removeFromSuperview];
    _uiv_helpContianer = nil;
    for (CMPopTipView *popTipView in self.visiblePopTipViews) {
        [popTipView dismissAnimated:YES];
        [self.visiblePopTipViews removeObject:popTipView];
    }
    self.onScreen = NO;
}

- (void)loadHelpView
{
	[self dismissAllPopTipViews];
    _uiv_helpContianer = [[UIView alloc] initWithFrame:screenRect];
    _uiv_helpContianer.alpha = 0.0;
    for (int i = 0; i < _arr_helpText.count; i++) {
        NSString *contentMessage = nil;
        contentMessage = _arr_helpText[i];
        UIColor *backgroundColor = [UIColor vcHelpBackgroundColor];
        UIColor *textColor = [UIColor whiteColor];
        
        CMPopTipView *popTipView;
        popTipView = [[CMPopTipView alloc] initWithMessage:contentMessage];
        popTipView.delegate = self;
        /* Some options to try.
         */
        //popTipView.disableTapToDismiss = YES;
        //popTipView.preferredPointDirection = PointDirectionUp;
        //popTipView.hasGradientBackground = NO;
        //popTipView.cornerRadius = 2.0;
        //popTipView.sidePadding = 30.0f;
        //popTipView.topMargin = 20.0f;
        //popTipView.pointerSize = 50.0f;
        popTipView.hasShadow = NO;
        popTipView.borderColor = [UIColor clearColor];
        if (backgroundColor && ![backgroundColor isEqual:[NSNull null]]) {
            popTipView.backgroundColor = backgroundColor;
        }
        if (textColor && ![textColor isEqual:[NSNull null]]) {
            popTipView.textColor = textColor;
        }
        
        popTipView.animation = arc4random() % 2;
        popTipView.has3DStyle = NO;
        
        popTipView.dismissTapAnywhere = NO;
        //        [popTipView autoDismissAnimated:NO atTimeInterval:3.0];
        [popTipView presentPointingAtView:_arr_helpTargetViews[i] inView:_uiv_helpContianer animated:YES];
        
        [self.visiblePopTipViews addObject:popTipView];
    }
    [self addSubview: _uiv_helpContianer];
    self.onScreen = YES;
    UITapGestureRecognizer *tapOnHelp = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fadeOutPopViews:)];
    tapOnHelp.numberOfTapsRequired = 1;
    _uiv_helpContianer.userInteractionEnabled = YES;
    [_uiv_helpContianer addGestureRecognizer: tapOnHelp];
    [UIView animateWithDuration:0.33 animations:^{
        _uiv_helpContianer.alpha = 1.0;
    }];
}

- (void)fadeOutPopViews:(UIGestureRecognizer *)gesture
{
    [UIView animateWithDuration:0.33 animations:^{
        _uiv_helpContianer.alpha = 0.0;
    } completion:^(BOOL finished){
        [self dismissAllPopTipViews];
        [self removeFromSuperview];
    }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self fadeOutPopViews:nil];
}

#pragma mark - CMPopTipViewDelegate methods

- (void)popTipViewWasDismissedByUser:(CMPopTipView *)popTipView
{
	[self.visiblePopTipViews removeObject:popTipView];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
