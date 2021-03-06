//
//  DetailNewsViewController.h
//  Oodeo
//
//  Created by paul favier on 19/11/13.
//  Copyright (c) 2013 MonCocoPilote. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DetailNewsViewController : UIViewController <UINavigationBarDelegate, UINavigationControllerDelegate>

{
    NSString *str;
    NSString *lblTitle;
    NSString *txtProject;
    IBOutlet UIButton *customButton;
    IBOutlet UIWindow *window;

}

@property(nonatomic,retain) IBOutlet UIImageView *imgView;
@property(nonatomic,retain) IBOutlet UIImageView *backg;
@property(nonatomic,retain) IBOutlet UILabel *lbl;
@property(nonatomic,retain) IBOutlet UILabel *lblshare;
@property(nonatomic,retain) IBOutlet UITextView *txtView;
@property(nonatomic,retain) IBOutlet UIButton *fbButton;
@property(nonatomic,retain) IBOutlet UIButton *twButton;
@property (nonatomic, strong) IBOutlet UIButton* directionsButton;
@property (nonatomic, assign) long myInt;

@property (nonatomic, retain) UIImage *image;
@property (nonatomic, retain) NSString *lblTitle;
@property (nonatomic, retain) NSString *txtProject;


@end
