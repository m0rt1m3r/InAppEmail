//
// InAppEmail.m
//
// Created by Damian/MORT on 01/11/2011.
//
// Visit our blog(s): http://spritebandits.wordpress.com/
//                    http://notatkiprogramisty.blox.pl/html
//
// findParentViewController and getTopViewController based on similar methods 
// available in ShareKit http://getsharekit.com/
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

#import "InAppEmail.h"

@interface InAppEmail ()
    -(void) showEmailComposeModalView;
    -(UIViewController *) findParentViewController;
    -(UIViewController *) getTopViewController;
@end

@implementation InAppEmail

@synthesize parentViewController = _parentViewController;
@synthesize recipients = _recipients;
@synthesize delegate = _delegate;

- (void)dealloc
{
    [_parentViewController release];
    [_recipients release];
    [super dealloc];
}

-(void)send {
    if ([MFMailComposeViewController canSendMail] == NO) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedStringFromTable(@"Cannot Send Emails", @"InAppEmail", @"Error message when email not configured or disabled.") delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];
		[alert show];
		return;
	}
    [self showEmailComposeModalView];
}

-(void) showEmailComposeModalView {
    MFMailComposeViewController *composeEmailViewController = [[MFMailComposeViewController alloc] init];
    
    NSArray *toRecipients = [[[NSArray alloc] init] autorelease];
    if (self.recipients == nil) {
        NSString *toRecipientsCSV = SEND_TO;
        toRecipients = [toRecipientsCSV componentsSeparatedByString:@","];
    } else {
        toRecipients = self.recipients;
    }
    //very important step if you want feedbacks on what the user did with your email sheet
    composeEmailViewController.mailComposeDelegate = (self.delegate == nil ? self : self.delegate); 
    [composeEmailViewController setSubject:SUBJECT];
    [composeEmailViewController setToRecipients:toRecipients];
    [composeEmailViewController setMessageBody:BODY isHTML:SEND_AS_HTML];
    
    composeEmailViewController.navigationBar.barStyle = NAVIGATIONBARSTYLE;
    
    
    [[self findParentViewController] presentModalViewController:composeEmailViewController animated:YES];
    
    //not needed with ARC
    [composeEmailViewController release];
}

//Dismisses the email moval view when user taps Cancel or Send.
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{ 
    if (self.delegate != nil) {
        [self.delegate mailComposeController:controller didFinishWithResult:result error:error];
    } else {
    // Notifies users about errors associated with the interface
        switch (result)
        {
            case MFMailComposeResultCancelled:
                NSLog(@"MFMailComposeResultCancelled");
                break;
            case MFMailComposeResultSaved:
                NSLog(@"MFMailComposeResultSaved");
                break;
            case MFMailComposeResultSent:
                NSLog(@"MFMailComposeResultSent");
                break;
            case MFMailComposeResultFailed:
                NSLog(@"MFMailComposeResultFailed");
                break;
            
            default:
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"Email Error", @"InAppEmail", @"Email Error Alert Message Title") 
                                                                    message:NSLocalizedStringFromTable(@"Email Send Error", @"InAppEmail", @"Error message when email cannot be sent due to an error.")
                                                                   delegate:self
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles: nil];
                    [alert show];
                    //not needed with ARC
                    [alert release];
                }
                break;
        }
        [self.parentViewController dismissModalViewControllerAnimated:YES];
    }
}

-(UIViewController *) findParentViewController;
{	
    UIViewController *parentViewControler;
    
    if (self.parentViewController == nil) {
        //Try to find the parent view controller programmically
        //Find the top window (that is not an alert view or other window)
		UIWindow *topWindow = [[UIApplication sharedApplication] keyWindow];
		if (topWindow.windowLevel != UIWindowLevelNormal)
		{
			NSArray *windows = [[UIApplication sharedApplication] windows];
			for(topWindow in windows)
			{
				if (topWindow.windowLevel == UIWindowLevelNormal)
					break;
			}
		}
		
		UIView *rootView = [[topWindow subviews] objectAtIndex:0];	
		id nextResponder = [rootView nextResponder];
		
		if ([nextResponder isKindOfClass:[UIViewController class]])
			self.parentViewController = nextResponder;
		
		else
			NSAssert(NO, @"InAppEmail: Could not find parent view controller. You can assign one manually by calling [InAppEmail setParentViewController:YOURVIEWCONTROLLER].");
	
        // Find the top most view controller being displayed (so we can add the modal view to it and not one that is hidden)
        UIViewController *topViewController = [self getTopViewController];	
        if (topViewController == nil)
            NSAssert(NO, @"InAppEmail: There is no view controller to display from");
        
        parentViewControler = topViewController;
        
    } else{
        parentViewControler = self.parentViewController;
    }
    
    return parentViewControler;
}

- (UIViewController *)getTopViewController
{
	UIViewController *topViewController = self.parentViewController;
	while (topViewController.modalViewController != nil)
		topViewController = topViewController.modalViewController;
	return topViewController;
}

@end
