//
//  NewsViewController.m
//  Oodeo
//
//  Created by paul favier on 15/11/13.
//  Copyright (c) 2013 MonCocoPilote. All rights reserved.
//

#import "NewsViewController.h"
#import "TableViewCellNews.h"
#import <Social/Social.h>
#import "RXMLElement.h"
#import "DetailNewsViewController.h"
#import "config.h"

#define IS_IPAD (( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ) ? YES : NO)
#define IS_IPHONE_5 (([UIScreen mainScreen].scale == 2.f && [UIScreen mainScreen].bounds.size.height == 568)?YES:NO)
#define IS_RETINA_DISPLAY_DEVICE (([UIScreen mainScreen].scale == 2.f)?YES:NO)

@interface NewsViewController ()

@end

@implementation NewsViewController
@synthesize NewsTbView,imageArray,descArray,titleArray,directionsButton;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Do any additional setup after loading the view from its nib.
    self.imageArray = [[NSMutableArray alloc]init];
    self.descArray = [[NSMutableArray alloc]init];
    self.titleArray = [[NSMutableArray alloc]init];
    
    // Add these right after creating the UITableView
    NewsTbView.delegate = self;
    NewsTbView.dataSource = self;
    
    UIImage * backgroundPattern = [UIImage imageNamed:@"Whitey"];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:backgroundPattern]];
    
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"Whitey"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
    [self refresh];
}

-(void)refresh
{
    // Create the request.
    //NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[config getFeedNEWS]]];
    
    // Create url connection and fire request
    //NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    RXMLElement *rootXML = [RXMLElement elementFromXMLFile:@"ios-news.xml"];
    
    RXMLElement *rxmlNews = [rootXML child:@"news"];
    
    NSArray *rxmlIndividualNew = [rxmlNews children:@"new"];
    
    //NSLog(@"test nsarray : %@",[[rxmlIndividualNew objectAtIndex:0] child:@"imageurl"]);
    
    for (int i=0; i<rxmlIndividualNew.count; i++) {
        //NSLog(@"i = %d",i);
        
        //NSURL *imgUrl = [NSURL URLWithString:[[rxmlIndividualNew objectAtIndex:i] child:@"imageurl"].text];
        NSString *imgUrl = [NSString stringWithFormat:@"%@" , [[rxmlIndividualNew objectAtIndex:i] child:@"imageurl"].text];
        
        //UIImage *img1 = [UIImage imageWithData:[NSData dataWithContentsOfURL:imgUrl]];
        UIImage *img1 = [UIImage imageNamed:imgUrl];
        
        NSString *title = [NSString stringWithString:[[rxmlIndividualNew objectAtIndex:i] child:@"titlenews"].text];
        NSString *desc = [NSString stringWithString:[[rxmlIndividualNew objectAtIndex:i] child:@"descnews"].text];
        
        [imageArray addObject:img1];
        [titleArray addObject:title];
        [descArray addObject:desc];
    }
    
    [NewsTbView reloadData];
    
}

#pragma mark NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    _responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    [_responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    
    // You can parse the stuff in your instance variable now
    //RXMLElement *rootXML = [RXMLElement elementFromXMLData:_responseData];
    RXMLElement *rootXML = [RXMLElement elementFromXMLFile:@"ios-news.xml"];
    
    RXMLElement *rxmlNews = [rootXML child:@"news"];
    
    NSArray *rxmlIndividualNew = [rxmlNews children:@"new"];
    
    //NSLog(@"test nsarray : %@",[[rxmlIndividualNew objectAtIndex:0] child:@"imageurl"]);
    
    for (int i=0; i<rxmlIndividualNew.count; i++) {
        //NSLog(@"i = %d",i);
        
        //NSURL *imgUrl = [NSURL URLWithString:[[rxmlIndividualNew objectAtIndex:i] child:@"imageurl"].text];
        NSString *imgUrl = [NSString stringWithFormat:@"%@" , [[rxmlIndividualNew objectAtIndex:i] child:@"imageurl"].text];
        
        //UIImage *img1 = [UIImage imageWithData:[NSData dataWithContentsOfURL:imgUrl]];
        UIImage *img1 = [UIImage imageNamed:imgUrl];
        
        NSString *title = [NSString stringWithString:[[rxmlIndividualNew objectAtIndex:i] child:@"titlenews"].text];
        NSString *desc = [NSString stringWithString:[[rxmlIndividualNew objectAtIndex:i] child:@"descnews"].text];
        
        [imageArray addObject:img1];
        [titleArray addObject:title];
        [descArray addObject:desc];
    }
    
    
    [NewsTbView reloadData];
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

bool isShown = true;

- (IBAction)btnToggleClick:(id)sender {
    
    if (!isShown) {
        _cautionView.frame =  CGRectMake(130, 20, 0, 0);
        [UIView animateWithDuration:0.25 animations:^{
            
            if(IS_IPHONE_5)
            {
                //do stuff for 4 inch iPhone screen
                _cautionView.frame =  CGRectMake(0, 0, 320, 520);
            }
            else
            {
                //do stuff for 3.5 inch iPhone screen
                _cautionView.frame =  CGRectMake(0, 0, 320, 430);
            }
            
            
        
        }];
        
        UIButton *refreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [refreshButton setFrame:CGRectMake(0,0,25,25)];
        refreshButton.userInteractionEnabled = TRUE;
        
        [refreshButton setImage:[[UIImage imageNamed:@"Remove@2x.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];

        
        //[refreshButton setImage:[UIImage imageNamed:@"Remove@2x.png"] forState:UIControlStateNormal];
        
        // ASSIGNING THE BUTTON WITH IMAGE TO BACK BAR BUTTON
        
        #define setTurqoiseColor [UIColor colorWithRed:68.0f/255.0f green:181.0f/255.0f blue:223.0f/255.0f alpha:1.0]
        
        UIBarButtonItem *refreshBarButton = [[UIBarButtonItem alloc] initWithCustomView:refreshButton];
        
        self.navigationItem.leftBarButtonItem = refreshBarButton;
        
        [refreshButton addTarget:self action:@selector(btnToggleClick:) forControlEvents:UIControlEventTouchDown];

        
        isShown = true;
    } else {
        [UIView animateWithDuration:0.25 animations:^{
            
            if(IS_IPHONE_5)
            {
                //do stuff for 4 inch iPhone screen
                _cautionView.frame =  CGRectMake(0, 0, 320, 525);
            }
            else
            {
                //do stuff for 3.5 inch iPhone screen
                _cautionView.frame =  CGRectMake(0, 0, 320, 430);
            }
            
            _cautionView.frame =  CGRectMake(130, 20, 0, 0);
        }];
        
        UIButton *refreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [refreshButton setFrame:CGRectMake(0,0,25,5)];
        refreshButton.userInteractionEnabled = TRUE;
        
        [refreshButton setImage:[[UIImage imageNamed:@"More@2x.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
        
        // ASSIGNING THE BUTTON WITH IMAGE TO BACK BAR BUTTON
        
        UIBarButtonItem *refreshBarButton = [[UIBarButtonItem alloc] initWithCustomView:refreshButton];
        self.navigationItem.leftBarButtonItem = refreshBarButton;
        [refreshButton addTarget:self action:@selector(btnToggleClick:) forControlEvents:UIControlEventTouchDown];
        
        isShown = false;
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return imageArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIndent";
    TableViewCellNews *cell = (TableViewCellNews *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSString *CellName;
    
    CellName = @"TableViewCellNews";
    
    if (cell == nil) {
        
        UIViewController *c = [[UIViewController alloc] initWithNibName:CellName bundle:nil];
        
        cell = (TableViewCellNews *)c.view;
    }
    
    cell.textLabel.numberOfLines = 0;
    cell.image.image = [imageArray objectAtIndex:indexPath.row];
    cell.text.text = [titleArray objectAtIndex:indexPath.row];
    cell.image.contentMode = UIViewContentModeScaleToFill;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell.image setAlpha:0];
    [cell.imagetitle setAlpha:0];
    [cell.text setAlpha:0];
    [cell.facebookButton setAlpha:0];
    [cell.twitterButton setAlpha:0];
    [UIView beginAnimations:@"ResizeAnimation" context:NULL];
    [UIView setAnimationDuration:0.5f];
    [cell.image setAlpha:.7];
    [cell.text setAlpha:1];
    [cell.imagetitle setAlpha:1];
    [cell.facebookButton setAlpha:1];
    [cell.twitterButton setAlpha:1];
    [UIView commitAnimations];
    
   // [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
    
    [cell.twitterButton    addTarget:self
                              action:@selector(postToTwitter:)
                    forControlEvents:UIControlEventTouchUpInside];
    cell.twitterButton.tag = indexPath.row;
    
    [cell.facebookButton    addTarget:self
                               action:@selector(postToFacebook:)
                     forControlEvents:UIControlEventTouchUpInside];
    cell.facebookButton.tag = indexPath.row;

    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    

    
DetailNewsViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"detailview"];
    
    if (_detailNewsViewController == nil) {
        
        NSString * storyboardName = @"Main_iPhone";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        self.detailNewsViewController = [storyboard instantiateViewControllerWithIdentifier:@"detailview"];

    }

    
    controller.image = [imageArray objectAtIndex:indexPath.row];
    controller.lblTitle = [titleArray objectAtIndex:indexPath.row];
    controller.txtProject = [descArray objectAtIndex:indexPath.row];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationController pushViewController:controller animated:YES];
    

}


- (IBAction)postToTwitter:(id)sender {
    
    [self urlMkr:@"http://www.google.com"];
    
    NSInteger tid = ((UIControl *) sender).tag;
    
    SLComposeViewController *tweetSheet = [SLComposeViewController
                                           composeViewControllerForServiceType:SLServiceTypeTwitter];
    
    [tweetSheet setInitialText:[titleArray objectAtIndex:tid]];
    //[tweetSheet addURL:object.link];
    [tweetSheet addImage:[imageArray objectAtIndex:tid]];
    [self presentViewController:tweetSheet animated:YES completion:nil];
    
}

- (IBAction)postToFacebook:(id)sender {
    
    [self urlMkr:@"http://www.google.com"];
    
    NSInteger tid = ((UIControl *) sender).tag;
   
    
    SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    
      [controller setInitialText:[descArray objectAtIndex:tid]];
  //  [controller addURL:object.link];
    [controller addImage:[imageArray objectAtIndex:tid]];
    [self presentViewController:controller animated:YES completion:Nil];
    
}

-(void)urlMkr:(NSString *)makeURL
{
    
    // Set URL String
    
    NSURL *myURL = [NSURL URLWithString:makeURL]; // gets url from string
    NSURLRequest *req = [NSURLRequest requestWithURL:myURL];
    
    // Make the Request
    
    NSURLResponse *resp;
    NSData *data = [NSURLConnection sendSynchronousRequest:req returningResponse:&resp error:NULL];
    
    // for ASYNC[[NSURLConnection alloc] initWithRequest:req delegate:self startImmediately:YES];
    
    if(!data){
        
        UIViewController *myError = [[UIViewController alloc]init];
        myError.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        myError.modalPresentationStyle = UIModalPresentationFormSheet;
        myError.view.backgroundColor = [UIColor blackColor];
        //[self presentModalViewController:myError animated:YES];
        [self presentViewController:myError animated:YES completion:nil];
        
        UILabel *myLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2 - 146,
                                                                     40,
                                                                     472, 260)];
        myLabel.text = @"\n This \n Requires \n A Network \n Connection.";
        myLabel.font = [UIFont boldSystemFontOfSize:48];
        myLabel.backgroundColor = [UIColor clearColor];
        myLabel.shadowColor = [UIColor grayColor];
        myLabel.shadowOffset = CGSizeMake(1,1);
        myLabel.textColor = [UIColor whiteColor];
        myLabel.textAlignment = NSTextAlignmentCenter;
        myLabel.lineBreakMode = NSLineBreakByWordWrapping;
        myLabel.numberOfLines = 18;
        [myLabel sizeToFit];
        [myError.view addSubview:myLabel];
        //[self.myLabel release];
        
        self.directionsButton = [self createButtonWithFrame:CGRectMake(22, 395, 276, 52) andLabel:@"Go Back"];
        
        [myError.view addSubview:directionsButton];
        
        [self.directionsButton addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    
}

-(UIButton*)createButtonWithFrame:(CGRect)frame andLabel:(NSString*)label
{
    
    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    
    [button setTitleShadowColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.shadowOffset = CGSizeMake(0, -1);
    button.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    
    [button setTitle:label forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [[button layer] setBorderWidth:1.0f];
    [[button layer] setBorderColor:[UIColor whiteColor].CGColor];
    [[button layer] setMasksToBounds:YES];
    [[button layer] setCornerRadius:4.0]; //when radius is 0, the border is a rectangle
    [[button layer] setBorderWidth:1.0];
    
    return button;
}

-(void)closeView
{
    //[self dismissModalViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}


@end
