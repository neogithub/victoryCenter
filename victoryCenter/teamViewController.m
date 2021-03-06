//
//  teamViewController.m
//  victoryCenter
//
//  Created by Xiaohe Hu on 9/23/14.
//  Copyright (c) 2014 Neoscape. All rights reserved.
//

#import "teamViewController.h"
#import "UIColor+Extensions.h"
#import "xhPopTipsView.h"
#import "GAIDictionaryBuilder.h"

static float kDropSpeed		= 0.33;
static float kAnimaDelay	= 0.2;
static float kCardWidth     = 183.0;
//static float kCardsGap      = 12.0;
static float kCardsGap      = 30.0;
@interface teamViewController ()

@property (weak, nonatomic) IBOutlet UIImageView            *uiiv_teamBg;

@property (nonatomic, strong) NSArray                       *arr_teamText;
@property (nonatomic, strong) NSArray                       *arr_logoImg;
@property (nonatomic, strong) NSMutableArray                *arr_teamTextView;
@property (nonatomic, strong) NSMutableArray                *arr_cards;

@property (nonatomic, strong) UIView                        *uiv_bluryView;
@property (nonatomic, strong) UIView                        *uiv_teamDetailContainer;
@property (nonatomic, strong) UILabel                       *uil_close;
// Help tip view
@property (nonatomic, strong) xhPopTipsView                 *uiv_helpView;
@property (nonatomic, strong) NSMutableArray                *arr_helpText;
@property (nonatomic, strong) NSMutableArray                *arr_helpTargetViews;

@end

@implementation teamViewController

- (void)viewWillAppear:(BOOL)animated
{
    self.view.frame = screenRect;
    [self prepareHlepData];

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if(![defaults objectForKey:@"firstTeam"])
    {
        [self performSelector:@selector(loadHelpViews) withObject:nil afterDelay:0.5];
    }
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"Victory Center Team View"];
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];
}

- (void)viewDidAppear:(BOOL)animated
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"NO" forKey:@"firstTeam"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _arr_cards = [[NSMutableArray alloc] init];
        _arr_logoImg = [[NSArray alloc] initWithObjects:@"team_hines_logo.png", @"team_cousins_logo.png", @"team_cushman_logo.png", nil];
    [self createTextViews];
    for (int i = 0; i < _arr_logoImg.count; i++) {
        [self createItemBox:_arr_logoImg[i] andText:_arr_teamTextView[i] andX:(208 + i * (kCardsGap + kCardWidth)) andTag:i];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideAndUnhideHelp:) name:@"hideAndUnhideHelp" object:nil];
    
    self.screenName = @"Victory Center Team View";
}

- (void)createTextViews
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"teamText" ofType:@"plist"];
    _arr_teamText = [[NSArray alloc] initWithContentsOfFile:path];
    _arr_teamTextView = [[NSMutableArray alloc] init];
    for (int i = 0; i < _arr_teamText.count; i++) {
        UIView *uiv_textContainer = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, kCardWidth, 286.0)];
        uiv_textContainer.backgroundColor = [UIColor clearColor];
        UITextView *uitv_teamText = [[UITextView alloc] initWithFrame:CGRectMake(5.0, 0.0, kCardWidth-10, 286.0)];
        uitv_teamText.backgroundColor = [UIColor clearColor];
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineHeightMultiple = 17.0f;
        paragraphStyle.maximumLineHeight = 17.0f;
        paragraphStyle.minimumLineHeight = 17.0f;
        
        NSDictionary *ats = @{
                              NSFontAttributeName : [UIFont fontWithName:@"Raleway-Medium" size:9.0f],
                              NSParagraphStyleAttributeName : paragraphStyle,
                              };
        NSString *text = _arr_teamText[i];
        uitv_teamText.attributedText = [[NSAttributedString alloc] initWithString:text attributes:ats];
        [uitv_teamText setTextColor:[UIColor vcDarkBlue]];
        uitv_teamText.editable = NO;
        uitv_teamText.selectable = NO;
        [_arr_teamTextView addObject: uitv_teamText];
        [uiv_textContainer addSubview:uitv_teamText];
    }
}

/*  Create team member's card
    
    Need input:
    1. logo image's name
    2. Text image's name
    3. card's x value      
 */
- (void)createItemBox:(NSString *)logoName andText:(UITextView *)textView andX:(float)x_value andTag:(int)index
{
    //UIView *uiv_cardContainer = [[UIView alloc] initWithFrame:CGRectMake(x_value, 180.0, kCardWidth, 428.0)];
    UIView *uiv_cardContainer = [[UIView alloc] initWithFrame:CGRectMake(x_value, 300.0, kCardWidth, 142.0)];
    uiv_cardContainer.tag = index+50;
	// 1. add logo
    UIView *uiv_logo = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, kCardWidth, 142.0)];
    uiv_logo.tag = 1;
    [uiv_logo setBackgroundColor:[UIColor vcTeamLogoBg]];
    UIImageView *uiiv_logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed: logoName]];
    uiiv_logo.frame = CGRectMake(0.0, 0.0, kCardWidth, 142.0);
    [uiv_logo addSubview:uiiv_logo];
    [uiv_cardContainer insertSubview:uiv_logo atIndex:2];
    
	// 2. add text
//    UIView *uiv_text = [[UIView alloc] initWithFrame:CGRectMake(0.0, 142.0, kCardWidth, 286.0)];
//    uiv_text.tag = 2;
//    uiv_text.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.8];
//    textView.tag = 1;
//    [uiv_text addSubview:textView];
//    [uiv_cardContainer insertSubview:uiv_text belowSubview:uiv_logo];
//    CGAffineTransform t1 = CGAffineTransformMakeScale(1.0, 0.5);
//    uiv_text.transform = CGAffineTransformTranslate(t1, 0.0, -427.0);
    
    // 3. add blue bar
    UIView *uiv_bar = [[UIView alloc] initWithFrame:CGRectMake(0.0, 124.0, kCardWidth, 18.0)];
    uiv_bar.tag = 3;
    UIImageView *uiiv_bar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"team_logoBtmBar_withPlus.png"]];
    uiiv_bar.frame = CGRectMake(0.0, 0.0, kCardWidth, 18.0);
    [uiv_bar addSubview: uiiv_bar];
    uiv_bar.hidden = YES;
    [uiv_cardContainer addSubview: uiv_bar];
    uiv_bar.transform = CGAffineTransformMakeTranslation(0.0, 18);
    
    uiv_cardContainer.alpha = 0.0;
    [self.view addSubview: uiv_cardContainer];
    uiv_cardContainer.transform = CGAffineTransformMakeTranslation(0.0, -40);
    [_arr_cards addObject:uiv_cardContainer];
    
    UITapGestureRecognizer *tapOnCard = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnCard:)];
    tapOnCard.numberOfTapsRequired = 1;
    [uiv_cardContainer addGestureRecognizer:tapOnCard];
    
	// Do animiation by index order
    [self performSelector:@selector(animateArray:) withObject:_arr_cards afterDelay:0.0];
    [self performSelector:@selector(showNeoLogo) withObject:nil afterDelay:kDropSpeed *5 - kAnimaDelay];
    [self performSelector:@selector(setVersionLabel) withObject:nil afterDelay:kDropSpeed *5 - kAnimaDelay];
}

#pragma mark - Deal with Card's interaction
- (void)tapOnCard:(UIGestureRecognizer *)gesture
{
    UIView *tmp = gesture.view;
    int index = (int)tmp.tag%50;
    if (index == 2) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"loadContact" object:nil];
        return;
    }
    
    if (_uiv_teamDetailContainer) {
        [_uiv_teamDetailContainer removeFromSuperview];
        _uiv_teamDetailContainer = nil;
        
        [_uiv_bluryView removeFromSuperview];
        _uiv_bluryView = nil;
    }
    // Define frame sizes for info panel, logo, and text view
    CGRect detailFrame = CGRectMake(68.0, 265.0, 888.0, 237.0);
    CGRect detailLogoFrame = CGRectMake(10.0, 10.0, 218, 217);
    CGRect detailTextFrame = CGRectMake(detailLogoFrame.origin.x + detailLogoFrame.size.width + 20, 10.0, detailFrame.size.width - detailLogoFrame.origin.x - detailLogoFrame.size.width - 30, detailFrame.size.height - 20);
    
    // Create blury background view
    _uiv_bluryView = [[UIView alloc] initWithFrame:screenRect];
    _uiv_bluryView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    _uiv_bluryView.alpha = 0.0;
    [self.view addSubview: _uiv_bluryView];
    [UIView animateWithDuration:0.5 animations:^{
        _uiv_bluryView.alpha = 1.0;
    }];
    
    _uiv_teamDetailContainer = [[UIView alloc] initWithFrame:detailFrame];
    _uiv_teamDetailContainer.transform = CGAffineTransformMakeTranslation(0.0, -detailFrame.origin.y - detailFrame.size.height - 30);
    _uiv_teamDetailContainer.backgroundColor = [UIColor whiteColor];
    _uiv_teamDetailContainer.layer.borderColor = [UIColor vcDarkBlue].CGColor;
    _uiv_teamDetailContainer.layer.borderWidth = 2.0;
    [_uiv_teamDetailContainer addSubview: [self createDetailLogoFrame:detailLogoFrame andIndex:index]];
    [_uiv_teamDetailContainer addSubview: [self createDetailTextFrame:detailTextFrame andIndex:index]];
    [self.view addSubview: _uiv_teamDetailContainer];
    
    [self addCloseLabelToDetail];
    
    //Add tap gesture to detail panel
    UITapGestureRecognizer *tapOnDetailPanel = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeDetailInfo:)];
    tapOnDetailPanel.numberOfTapsRequired = 1;
    _uiv_teamDetailContainer.userInteractionEnabled = YES;
    [_uiv_teamDetailContainer addGestureRecognizer:tapOnDetailPanel];
    
    // Set the parameters to be passed into the animation
    CGFloat duration = 0.8f;
    CGFloat damping = 0.75;
    CGFloat velocity = 0.5;
    // int to hold UIViewAnimationOption
    NSInteger option;
    option = UIViewAnimationCurveEaseInOut;
    
    [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:damping initialSpringVelocity:velocity options:option animations:^{
        _uiv_teamDetailContainer.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished){      }];
    
    UITapGestureRecognizer *tapOnDetail = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeDetailInfo:)];
    tapOnDetail.numberOfTapsRequired = 1;
    [_uiv_bluryView addGestureRecognizer:tapOnDetail];
}

#pragma mark - Create logo image view of detail info's panel
- (UIView *)createDetailLogoFrame:(CGRect)frame andIndex:(int)index
{
    UIImageView *uiiv_detailLogo = [[UIImageView alloc] initWithFrame:frame];
    [uiiv_detailLogo setImage:[UIImage imageNamed:_arr_logoImg[index]]];
    uiiv_detailLogo.contentMode = UIViewContentModeScaleAspectFit;
    uiiv_detailLogo.backgroundColor = [UIColor vcTeamLogoBg];
    
    // Enlarge the bottom bar accroding to scale ratio
    UIImageView *uiiv_btmBar = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, frame.size.height-18*1.2, frame.size.width, 18*1.2)];
    uiiv_btmBar.image = [UIImage imageNamed:@"team_logoBtmBar.png"];
    [uiiv_detailLogo addSubview: uiiv_btmBar];
    return  uiiv_detailLogo;
}

#pragma mark - Create text view of detail info's panel
- (UIView *)createDetailTextFrame:(CGRect)frame andIndex:(int)index
{
    UITextView *uitv_detailText = [[UITextView alloc] initWithFrame:frame];
    uitv_detailText.backgroundColor = [UIColor whiteColor];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineHeightMultiple = 30.0f;
    paragraphStyle.maximumLineHeight = 30.0f;
    paragraphStyle.minimumLineHeight = 30.0f;
    
    NSDictionary *ats = @{
                          NSFontAttributeName : [UIFont fontWithName:@"Raleway-Medium" size:15.0f],
                          NSParagraphStyleAttributeName : paragraphStyle,
                          };
    NSString *text = _arr_teamText[index];
    uitv_detailText.attributedText = [[NSAttributedString alloc] initWithString:text attributes:ats];
    [uitv_detailText setTextColor:[UIColor vcDarkBlue]];
    uitv_detailText.editable = NO;
    uitv_detailText.selectable = NO;
    
    return  uitv_detailText;
}

- (void)addCloseLabelToDetail
{
    if (_uil_close) {
        [_uil_close removeFromSuperview];
        _uil_close = nil;
    }
    _uil_close = [[UILabel alloc] initWithFrame:CGRectMake(788.0, 200.0, 100.0, 37.0)];
    _uil_close.backgroundColor = [UIColor lightGrayColor];
    [_uil_close setText:@"CLOSE"];
    [_uil_close setTextAlignment:NSTextAlignmentCenter];
    _uil_close.textColor = [UIColor whiteColor];
    [_uiv_teamDetailContainer addSubview: _uil_close];
}

- (void)removeDetailInfo:(UIGestureRecognizer *)gesture
{
    [UIView animateWithDuration:0.33 animations:^{
        _uiv_teamDetailContainer.transform = CGAffineTransformMakeTranslation(0.0, -265-237);
        _uiv_bluryView.alpha = 0.0;
    } completion:^(BOOL finished){
        [_uiv_bluryView removeFromSuperview];
        _uiv_bluryView = nil;
        
        [_uiv_teamDetailContainer removeFromSuperview];
        _uiv_teamDetailContainer = nil;
    }];
}

#pragma mark - Animate all cards by the order of the index
//Read all cards in the array by index
// Need input arrary of cards(uiview)

-(void)animateArray:(NSMutableArray *)viewArray
{
    for (int i = 0; i < viewArray.count; i++) {
        UIView *tmpView = [viewArray objectAtIndex:i];
        [self performSelector:@selector(animateCard:) withObject:tmpView afterDelay:(kAnimaDelay*i)];
    }
}


/*  Animate one card
 
    input: UIView (team member's card)
    
    animtion order:
    1. make the logo part alpha = 1.0
 
    2. Make the card's container moving down to the correct Y value
 
    3. Reveal text image view from back of the logo image
 
    4. Call the function to animate the bar between logo and text
*/
- (void)animateCard:(UIView *)container
{
    UIView *text = [container viewWithTag:2];
    UIView *textImg = [text viewWithTag:1];
    [UIView animateWithDuration:kDropSpeed animations:^{
        container.alpha = 1.0;
        container.transform = CGAffineTransformIdentity;
        text.transform = CGAffineTransformIdentity;
        textImg.tintColor = [UIColor clearColor];
    } completion:^(BOOL finished){
        [self performSelector:@selector(animateBar:) withObject:container afterDelay:kDropSpeed-kAnimaDelay];
    }];
}

/*  Animate the bar between logo and text image
 
    input: UIView (team member's card)
 
    animtion order:
    1. change the order of views inside of the card's container:
        a. logo -> bottom
        b. bar -> middle
        c. text -> top
    
    2. Move the bar to the correct position from back of text
 
*/
- (void)animateBar:(UIView *)container
{
    UIView *logo = [container viewWithTag:1];
    UIView *text = [container viewWithTag:2];
    UIView *bar = [container viewWithTag:3];
    logo.layer.zPosition = 0;
    bar.layer.zPosition = 1;
    text.layer.zPosition = 2;
    bar.hidden = NO;
    [UIView animateWithDuration:kDropSpeed delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        bar.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished){
        
    }];
}


#pragma mark - Add neoscape label
//add Neoscape's logo after all cards droping down

- (void)showNeoLogo
{
    UIView *uiv_neoContainer = [[UIView alloc] initWithFrame:CGRectMake(774.0, 730.0, 211.0, 38.0)];
    uiv_neoContainer.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    
    UILabel *uil_neoLogo = [[UILabel alloc] initWithFrame:uiv_neoContainer.bounds];
    uil_neoLogo.backgroundColor = [UIColor clearColor];
    [uil_neoLogo setText:@"DESIGNED BY NEOSCAPE®"];
    [uil_neoLogo setTextAlignment:NSTextAlignmentCenter];
    uil_neoLogo.font = [UIFont fontWithName:@"Raleway-Medium" size:12.0];
    [uil_neoLogo setTextColor:[UIColor colorWithWhite:1.0 alpha:0.6]];
	// uil_neoLogo.alpha = 0.7;
    [uiv_neoContainer addSubview: uil_neoLogo];

    uiv_neoContainer.transform = CGAffineTransformMakeTranslation(0.0, uiv_neoContainer.frame.size.height);
    [self.view addSubview: uiv_neoContainer];
    
    [UIView animateWithDuration:0.2 animations:^{
        uiv_neoContainer.transform = CGAffineTransformIdentity;
    }];
}

#pragma mark - Add version # label
- (void)setVersionLabel
{
    UILabel *uil_version = [[UILabel alloc] initWithFrame:CGRectZero];
    NSString * version = [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"];
	//NSString * build = [[NSBundle mainBundle] objectForInfoDictionaryKey: (NSString *)kCFBundleVersionKey];

	uil_version.text = [NSString stringWithFormat:@"2015 v%@",version];
    uil_version.font = [UIFont fontWithName:@"Raleway-Medium" size:14.0];
    uil_version.textColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    uil_version.textAlignment = NSTextAlignmentRight;
    CGSize size = [uil_version.text sizeWithAttributes:@{NSFontAttributeName:
                                                             uil_version.font}];
    uil_version.frame = CGRectMake(774-20-size.width, 730 + (38 - size.height)/2 - 2, size.width, size.height);
    uil_version.transform = CGAffineTransformMakeTranslation(0.0, uil_version.frame.size.height);
    [self.view addSubview: uil_version];
    
    [UIView animateWithDuration:0.2 animations:^{
        uil_version.transform = CGAffineTransformIdentity;
    }];
}

#pragma mark - Add Help view
- (void)hideAndUnhideHelp:(NSNotification *)pNotification
{
    if (_uiv_helpView.onScreen) {
        [UIView animateWithDuration:0.33 animations:^{
            _uiv_helpView.alpha = 0.0;
        } completion:^(BOOL finsihed){
            [_uiv_helpView removeFromSuperview];
            _uiv_helpView = nil;
        }];
    }
    else {
        [self loadHelpViews];
    }
}

- (void)prepareHlepData
{
    [_arr_helpText removeAllObjects];
    _arr_helpText = nil;
    _arr_helpText = [[NSMutableArray alloc] initWithObjects:
                     @"Tap to load main menu",
                     @"Tap logo for more info",
                     nil];
    
    [_arr_helpTargetViews removeAllObjects];
    _arr_helpTargetViews = nil;
    UIButton *homeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 45.0, 45.0)];
    UIView *tmp = _arr_cards[2];
    CGRect frame = CGRectMake(tmp.frame.origin.x + tmp.frame.size.width/2, tmp.frame.origin.y + tmp.frame.size.height/4, tmp.frame.size.width, tmp.frame.size.height);
    UIView *tmp2 = [[UIView alloc] initWithFrame:frame];
    _arr_helpTargetViews = [[NSMutableArray alloc] initWithObjects:homeBtn, tmp2, nil];
}

- (void)loadHelpViews
{
    if (_uiv_helpView) {
        [_uiv_helpView removeFromSuperview];
        _uiv_helpView = nil;
    }
    _uiv_helpView = [[xhPopTipsView alloc] initWithFrame:screenRect andText:_arr_helpText andViews:_arr_helpTargetViews];
    [self.view addSubview: _uiv_helpView];
}
#pragma mark - Memory cleaning & warning

- (void)viewWillDisappear:(BOOL)animated
{
    _arr_teamText = nil;
    
    _arr_logoImg = nil;
    
    for (UIView __strong *tmp in _arr_teamTextView) {
        [tmp removeFromSuperview];
        tmp = nil;
    }
    
    _arr_teamTextView = nil;
    
    for (UIView __strong *tmp in _arr_cards) {
        
        [tmp removeFromSuperview];
        tmp = nil;
    }
    [_arr_cards removeAllObjects];
    _arr_cards = nil;
    
    [_uiv_bluryView removeFromSuperview];
    _uiv_bluryView = nil;
    
    [_uiv_teamDetailContainer removeFromSuperview];
    _uiv_teamDetailContainer = nil;
    
    [_uiiv_teamBg removeFromSuperview];
    _uiiv_teamBg = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"hideAndUnhideHelp" object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
