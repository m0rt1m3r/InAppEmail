//
// InAppEmail.h
//
// Created by Damian/MORT on 01/11/2011.
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

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>

//config - see also Localizable.strings file
#define SUBJECT NSLocalizedStringFromTable(@"In App Email", @"InAppEmail", @"Feedback email subject line")
#define BODY NSLocalizedStringFromTable(@"Hello", @"InAppEmail", "Thank you for downloading our app. We are really appreciate your feedback\n---")
#define SEND_AS_HTML NO
//#define SEND_TO @"feedback@yourmail.com,oncall@yourmail.com"
#define SEND_TO @"notatkiprogramisty@gmail.com,spritebandits@gmail.com"

//ui config
#define NAVIGATIONBARSTYLE  UIBarStyleBlack

@interface InAppEmail : NSObject <MFMailComposeViewControllerDelegate> {
    UIViewController *_parentViewController;
    id <MFMailComposeViewControllerDelegate> _delegate;
    NSArray *_recipients;
}

@property (nonatomic, retain) UIViewController *parentViewController;
@property (nonatomic, retain) NSArray *recipients;
@property (assign) id delegate;

-(void) send;

@end


