//
//  SecondViewController.m
//  InAppMail-Example
//
// Created by Damian/MORT on 07/01/2012.
//
// Visit our blog(s): http://spritebandits.wordpress.com/
//                    http://notatkiprogramisty.blox.pl/html
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
// 


#import "SecondViewController.h"

@implementation SecondViewController

@synthesize feedbackEmail = _feedbackEmail;

- (void)dealloc
{
    [_feedbackEmail release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Second", @"Second");
        self.tabBarItem.image = [UIImage imageNamed:@"second"];
    }
    return self;
}
							
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.feedbackEmail = [[InAppEmail alloc] init];
//    self.parentViewController = self;
//    self.feedbackEmail.delegate = self;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

-(IBAction)sendFeedback:(id)sender {
    
//    NSArray *emailRecipients = [[NSArray alloc] initWithObjects:@"feedback@yourmail.com",@"oncall@yourmail.com", nil];
//    self.feedbackEmail.recipients = emailRecipients;
//    [emailRecipients release];
    
    [self.feedbackEmail send];
}

////Dismisses the email moval view when user taps Cancel or Send.
//- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
//{ 
//        // Notifies users about errors associated with the interface
//        switch (result)
//        {
//            case MFMailComposeResultCancelled:
//                NSLog(@"Self. MFMailComposeResultCancelled");
//                break;
//            case MFMailComposeResultSaved:
//                NSLog(@"Self. MFMailComposeResultSaved");
//                break;
//            case MFMailComposeResultSent:
//                NSLog(@"Self. MFMailComposeResultSent");
//                break;
//            case MFMailComposeResultFailed:
//                NSLog(@"Self. MFMailComposeResultFailed");
//                break;
//                
//            default:
//            {
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Email Error", @"Email Error Alert Message Title") 
//                                                                message:NSLocalizedString(@"Email Send Error", @"Error message when email cannot be sent due to an error.")
//                                                               delegate:self
//                                                      cancelButtonTitle:@"OK"
//                                                      otherButtonTitles: nil];
//                [alert show];
//                //not needed with ARC
//                [alert release];
//            }
//                break;
//        }
//        [self dismissModalViewControllerAnimated:YES];
//
//}


@end
