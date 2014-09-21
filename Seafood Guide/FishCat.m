//
//  FishCat.m
//  Seafood Guide
//
//  Created by Remote Admin on 6/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FishCat.h"


@implementation FishCat

@synthesize window = _window;
@synthesize caption, image;
@synthesize fetchedResultsController = __fetchedResultsController;
@synthesize managedObjectContext = __managedObjectContext;

-(id)initWithCaption:(NSString*)theCaption andImage:(UIImage*)theImage
{
    self = [super init];
    
    if(self)
    {
        self.caption = theCaption;
        self.image = theImage;
    }
    
    
    return self;
}

+(NSArray*)getSampleData
{
    
    FishCat* fish1 = [[FishCat alloc] initWithCaption:@"Mild Fish" andImage:[UIImage imageNamed:@"fish-1.jpeg"]];
    
    FishCat* fish2 = [[FishCat alloc] initWithCaption:@"Thicker & Flavorful" andImage:[UIImage imageNamed:@"fish-2.jpeg"]];
    
    FishCat* fish3 = [[FishCat alloc] initWithCaption:@"Steak Like Fish" andImage:[UIImage imageNamed:@"fish-3.jpeg"]];
    
    
    FishCat* fish4 = [[FishCat alloc] initWithCaption:@"Small Fish" andImage:[UIImage imageNamed:@"fish-4.jpeg"]];
    
    
    FishCat* fish5 = [[FishCat alloc] initWithCaption:@"Shell Fish" andImage:[UIImage imageNamed:@"fish-5.jpeg"]];
    
    
    FishCat* fish6 = [[FishCat alloc] initWithCaption:@"Other" andImage:[UIImage imageNamed:@"fish-6.jpeg"]];
    
    FishCat* fish7 = [[FishCat alloc] initWithCaption:@"All Fish" andImage:[UIImage imageNamed:@"allfish.jpeg"]];
    
    FishCat* fish8 = [[FishCat alloc] initWithCaption:@"Dirty Dozen" andImage:[UIImage imageNamed:@"donteat.jpeg"]];
    
    
    return [NSArray arrayWithObjects:fish1, fish2, fish3, fish4, fish5, fish6, fish7, fish8, nil];
}

@end
