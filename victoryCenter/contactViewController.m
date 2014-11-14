//
//  contactViewController.m
//  victoryCenter
//
//  Created by Xiaohe Hu on 10/21/14.
//  Copyright (c) 2014 Neoscape. All rights reserved.
//

#import "contactViewController.h"
#import "UIColor+Extensions.h"
#import <MessageUI/MessageUI.h>
#import "embEmailData.h"
#import "CMPopTipView.h"
#import "xhPopTipsView.h"
#import "neoCalendarUtilities.h"

static float kContactWidth = 261;
static float kContactHeight = 100;
static float kContactGap = 4;
static int morningTime = 5;
static int eveningTime = 17;

@interface contactViewController ()<MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate>
{
    NSArray         *arr_names;
    NSArray         *arr_phone;
    NSArray         *arr_mobile;
    NSArray         *arr_email;
}
@property (weak, nonatomic) IBOutlet UIView                 *uiv_titleContainer;
@property (weak, nonatomic) IBOutlet UITextView             *uitv_titleText;
@property (weak, nonatomic) IBOutlet UIImageView            *uiiv_bgImg;

@property (nonatomic, strong) NSMutableArray                *arr_contactCards;
@property (nonatomic, strong) embEmailData                  *emailData;
// Help tip view
@property (nonatomic, strong) xhPopTipsView                 *uiv_helpView;
@property (nonatomic, strong) NSMutableArray                *arr_helpText;
@property (nonatomic, strong) NSMutableArray                *arr_helpTargetViews;
@end

@implementation contactViewController

- (void)viewWillAppear:(BOOL)animated
{
    self.view.frame = screenRect;
    self.view.clipsToBounds = YES;
    [self prepareHlepData];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if(![defaults objectForKey:@"firstContact"])
    {
        [self performSelector:@selector(loadHelpViews) withObject:nil afterDelay:0.5];
    }
}

-(void)viewDidLayoutSubviews
{
	// create uiimageview
	
	//check hour
	NSString *hour = [NSString currentHour]; // returns military time
	
	//then change image accordingly
	if (([hour intValue]>morningTime) && ([hour intValue]<eveningTime)){ // 5 = 5am, 17 = 5pm
        
		_uiiv_bgImg.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"grfx_launching.png" ofType:nil]];
	} else {
		_uiiv_bgImg.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"grfx_launching_night.jpg" ofType:nil]];
	}
}

- (void)viewDidAppear:(BOOL)animated
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"NO" forKey:@"firstContact"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitleLabel];
    [self setTitleView];
    [self setContactCardsGroup];
    [self performSelector:@selector(animateContactCards) withObject:nil afterDelay:0.5];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideAndUnhideHelp:) name:@"hideAndUnhideHelp" object:nil];
}

#pragma  mark - Set top left title label
- (void)setTitleLabel
{
    UILabel *uil_titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(44.0, 0.0, 180.0, 44.0)];
    uil_titleLabel.backgroundColor = [UIColor whiteColor];
    uil_titleLabel.layer.borderWidth = 1.0;
    uil_titleLabel.layer.borderColor = [UIColor vcDarkBlue].CGColor;
    uil_titleLabel.text = @"CONTACT";
    uil_titleLabel.textAlignment = NSTextAlignmentCenter;
    uil_titleLabel.font = [UIFont fontWithName:@"Raleway-Medium" size:22];
    uil_titleLabel.textColor = [UIColor vcDarkBlue];
    [self.view addSubview: uil_titleLabel];
}

#pragma mark - Set top right title view

- (void)setTitleView
{
    _uiv_titleContainer.transform = CGAffineTransformMakeTranslation(0.0, -_uiv_titleContainer.frame.size.height);
    [_uitv_titleText setFont:[UIFont fontWithName:@"Raleway-Bold" size:12.0]];
    _uitv_titleText.textColor = [UIColor whiteColor];
}

#pragma mark - Set contact cards

- (void)setContactCardsGroup
{
    _arr_contactCards = [[NSMutableArray alloc] init];
    arr_names = [[NSArray alloc] initWithObjects:@"BILL BROKAW", @"CYNTHIA COWEN", @"MARK DICKENSON", nil];
    arr_phone = [[NSArray alloc] initWithObjects:@"T: +1 (972) 663-9618", @"T: +1 (972) 663-9617", @"T: +1 (972) 663-9699", nil];
    arr_mobile = [[NSArray alloc] initWithObjects:@"M: +1 (214) 802-2455", @"M: +1 (214) 538-2106", @"M: +1 (214) 796-1336", nil];
    arr_email = [[NSArray alloc] initWithObjects:@"bill.brokaw@cushwake.com", @"cynthia.cowen@cushwake.com", @"mark.dickenson@cushwake.com", nil];
    
    for (int i = 0; i < arr_email.count; i++) {
        [self createContactCardwithName:arr_names[i] andPhone:arr_phone[i] andMobile:arr_mobile[i] andEmail:arr_email[i] andTag:i];
    }
}

#pragma mark Init contact card view

- (void)createContactCardwithName:(NSString *)name andPhone:(NSString *)phone andMobile:(NSString *)mobile andEmail:(NSString *)email andTag:(int)index
{
    UIView *uiv_contactCard = [[UIView alloc] initWithFrame:CGRectMake(720.0, 169+4.0 + (kContactGap + kContactHeight)*index, kContactWidth, kContactHeight)];
    uiv_contactCard.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.6];
    uiv_contactCard.tag = index+1;
    
    UILabel *uil_name = [[UILabel alloc] initWithFrame:CGRectMake(15.0, 10.0, kContactWidth - 15, 25.0)];
    uil_name.text = name.uppercaseString;
    uil_name.font = [UIFont fontWithName:@"Raleway-Bold" size:14.0];
    uil_name.textColor = [UIColor vcDarkBlue];
    uil_name.backgroundColor = [UIColor clearColor];
    uil_name.tag = 1;
    [uiv_contactCard addSubview: uil_name];
    
    UILabel *uil_phone = [[UILabel alloc] initWithFrame:CGRectMake(15.0, 35.0, kContactWidth - 15, 18.0)];
    uil_phone.backgroundColor = [UIColor clearColor];
    uil_phone.text = phone;
    uil_phone.font = [UIFont fontWithName:@"Raleway-Medium" size:11.0];
    uil_phone.textColor = [UIColor vcDarkBlue];
    uil_phone.tag = 2;
    [uiv_contactCard addSubview: uil_phone];
    
    UILabel *uil_mobile = [[UILabel alloc] initWithFrame:CGRectMake(15.0, 53.0, kContactWidth - 15, 18.0)];
    uil_mobile.backgroundColor = [UIColor clearColor];
    uil_mobile.text = mobile;
    uil_mobile.textColor = [UIColor vcDarkBlue];
    uil_mobile.font = [UIFont fontWithName:@"Raleway-Medium" size:11.0];
    uil_mobile.tag = 3;
    [uiv_contactCard addSubview: uil_mobile];
    
    UILabel *uil_email = [[UILabel alloc] initWithFrame:CGRectMake(15.0, 71.0, kContactWidth - 15, 18.0)];
    uil_email.backgroundColor = [UIColor clearColor];
    uil_email.text = email.uppercaseString;
    uil_email.textColor = [UIColor vcDarkBlue];
    uil_email.font = [UIFont fontWithName:@"Raleway-Medium" size:11.0];
    uil_email.tag = 3;
    [uiv_contactCard addSubview: uil_email];
    [_arr_contactCards addObject:uiv_contactCard];
    uiv_contactCard.transform = CGAffineTransformMakeTranslation(0.0, -uiv_contactCard.frame.size.height - uiv_contactCard.frame.origin.y);
    
    UIImageView *uiiv_mailIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"grfx_mailIcon.png"]];
    uiiv_mailIcon.frame = CGRectMake(200, 15, uiiv_mailIcon.frame.size.width, uiiv_mailIcon.frame.size.height);
    [uiv_contactCard addSubview:uiiv_mailIcon];
    
    UITapGestureRecognizer *tapOnCard = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnCard:)];
    tapOnCard.numberOfTapsRequired = 1;
    uiv_contactCard.userInteractionEnabled = YES;
    [uiv_contactCard addGestureRecognizer:tapOnCard];
    
    [self.view insertSubview:uiv_contactCard belowSubview:_uiv_titleContainer];
}

- (void)tapOnCard:(UIGestureRecognizer *)gesture
{
    int index = (int)gesture.view.tag;
    NSString *emailAddress = arr_email[index-1];
    NSLog(@"The view is %@", gesture.view.description);
    _emailData = [[embEmailData alloc] init];
    _emailData.to =[[NSArray alloc] initWithObjects:emailAddress, nil];
    _emailData.subject = nil;
    _emailData.body = nil;//kMAILBODY;
    [self prepareEmailData];
}

#pragma mark - Email Delegates
-(void)prepareEmailData
{
	if ([MFMailComposeViewController canSendMail] == YES) {
		
		MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
		picker.mailComposeDelegate = self; // &lt;- very important step if you want feedbacks on what the user did with your email sheet
        
		if(_emailData.to)
			[picker setToRecipients:_emailData.to];
		
		if(_emailData.cc)
			[picker setCcRecipients:_emailData.cc];
		
		if(_emailData.bcc)
			[picker setBccRecipients:_emailData.bcc];
		
		if(_emailData.subject)
			[picker setSubject:_emailData.subject];
		
		if(_emailData.body)
			[picker setMessageBody:_emailData.body isHTML:YES]; // depends. Mostly YES, unless you want to send it as plain text (boring)
		
        
		// attachment code
		if(_emailData.attachment) {
			
            NSLog(@"_receivedData.attachment");
            
            NSString	*filePath;
			NSString	*justFileName;
			NSData		*myData;
			UIImage		*pngImage;
			NSString	*newname;
            //			if (kshowNSLogBOOL) NSLog(@"%@",_receivedData.attachment);
            
			for (id file in _emailData.attachment)
			{
                
				// check if it is a uiimage and handle
				if ([file isKindOfClass:[UIImage class]]) {
					
					myData = UIImagePNGRepresentation(file);
					[picker addAttachmentData:myData mimeType:@"image/png" fileName:@"image.png"];
					
					// might be nsdata for pdf
				} else if ([file isKindOfClass:[NSData class]]) {
					NSLog(@"pdf");
					myData = [NSData dataWithData:file];
					NSString *mimeType;
					mimeType = @"application/pdf";
					newname = @"Brochure.pdf";
					[picker addAttachmentData:myData mimeType:mimeType fileName:newname];
					
					// it must be another file type?
				} else {
					
					justFileName = [[file lastPathComponent] stringByDeletingPathExtension];
					
					NSString *mimeType;
					// Determine the MIME type
					if ([[file pathExtension] isEqualToString:@"jpg"]) {
						mimeType = @"image/jpeg";
					} else if ([[file pathExtension] isEqualToString:@"png"]) {
						mimeType = @"image/png";
						pngImage = [UIImage imageNamed:file];
					} else if ([[file pathExtension] isEqualToString:@"doc"]) {
						mimeType = @"application/msword";
					} else if ([[file pathExtension] isEqualToString:@"ppt"]) {
						mimeType = @"application/vnd.ms-powerpoint";
					} else if ([[file pathExtension] isEqualToString:@"html"]) {
						mimeType = @"text/html";
					} else if ([[file pathExtension] isEqualToString:@"pdf"]) {
						mimeType = @"application/pdf";
					} else if ([[file pathExtension] isEqualToString:@"com"]) {
						mimeType = @"text/plain";
					}
					
					filePath= [[NSBundle mainBundle] pathForResource:justFileName ofType:[file pathExtension]];
					
					if (![[file pathExtension] isEqualToString:@"png"]) {
						myData = [NSData dataWithContentsOfFile:filePath];
						myData = [NSData dataWithContentsOfFile:filePath];
					} else {
						myData = UIImagePNGRepresentation(pngImage);
					}
					[picker addAttachmentData:myData mimeType:mimeType fileName:file];
				}
			}
		}
		
		picker.navigationBar.barStyle = UIBarStyleBlack; // choose your style, unfortunately, Translucent colors behave quirky.
        [self presentViewController:picker animated:YES completion:nil];
        
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Status" message:[NSString stringWithFormat:@"Email needs to be configured before this device can send email."]
                                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    // Notifies users about errors associated with the interface
    switch (result)
    {
        case MFMailComposeResultCancelled:
            break;
        case MFMailComposeResultSaved:
            break;
        case MFMailComposeResultSent:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thank you!" message:@"Email Sent Successfully"
                                                           delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
        }
            break;
        case MFMailComposeResultFailed:
            break;
            
        default:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Status" message:@"Sending Failed - Unknown Error"
                                                           delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
        }
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
	NSLog(@"FINISHED");
}

#pragma mark Animate the contact card
- (void)animateContactCards
{
    CGFloat duration = 0.5f;
    CGFloat damping = 0.6f;
    CGFloat velocity = 0.68f;
    // int to hold UIViewAnimationOption
    NSInteger option;
    option = UIViewAnimationCurveEaseInOut;
    
    [UIView animateWithDuration:duration*1.5 delay:0 usingSpringWithDamping:damping initialSpringVelocity:velocity options:option animations:^{
        _uiv_titleContainer.transform = CGAffineTransformIdentity;
        
        for (UIView *tmp in _arr_contactCards) {
            tmp.transform = CGAffineTransformIdentity;
        }
        
    } completion:^(BOOL finished){      }];
}

- (IBAction)closeBtnTapped:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"removeContact" object:nil];
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
                     @"Tap close button to return",
                     @"Tap box to send email",
                     nil];
    
    [_arr_helpTargetViews removeAllObjects];
    _arr_helpTargetViews = nil;
    UIButton *homeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 45.0, 45.0)];
    UIView *tmp2 = [[UIView alloc] initWithFrame:CGRectMake(860, 315, 233, 100)];
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

#pragma mark - Cleaning Memory

- (void)viewWillDisappear:(BOOL)animated
{
    [_uiv_titleContainer removeFromSuperview];
    _uiv_titleContainer = nil;
    
    for (UIView __strong *tmp in _arr_contactCards) {
        [tmp removeFromSuperview];
        tmp = nil;
    }
    
    [_arr_contactCards removeAllObjects];
    _arr_contactCards = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"hideAndUnhideHelp" object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
