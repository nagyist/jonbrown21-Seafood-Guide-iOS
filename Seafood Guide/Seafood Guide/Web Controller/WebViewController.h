//
//  WebViewController.h
//  Oodeo
//
//  Created by Jon Brown on 8/25/14.
//  Copyright (c) 2014 Jon Brown Designs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController <UINavigationBarDelegate, UIWebViewDelegate, UIAlertViewDelegate> {
    NSURL *theURL;
    NSString *theTitle;
    IBOutlet UIWebView *webView;
    IBOutlet UINavigationItem *webTitle;
    
}

- (id)initWithURL:(NSURL *)url;
- (id)initWithURL:(NSURL *)url andTitle:(NSString *)string;
- (IBAction) done:(id)sender;

@end
