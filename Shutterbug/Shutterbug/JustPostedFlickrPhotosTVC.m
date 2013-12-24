//
//  JustPostedFlickrPhotosTVC.m
//  Shutterbug
//
//  Created by Minlin Zhang on 12/21/13.
//  Copyright (c) 2013 Minlin Zhang. All rights reserved.
//

#import "JustPostedFlickrPhotosTVC.h"
#import "FlickrFetcher.h"

@interface JustPostedFlickrPhotosTVC ()

@end

@implementation JustPostedFlickrPhotosTVC

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self fetchPhotos];
}

- (IBAction)fetchPhotos
{
    [self.refreshControl beginRefreshing];
    NSURL *url = [FlickrFetcher URLforRecentGeoreferencedPhotos];
    dispatch_queue_t fetchQ = dispatch_queue_create("Flickr Fetcher", NULL);
    dispatch_async(fetchQ, ^{
        NSData *jsonData = [NSData dataWithContentsOfURL:url];
        NSDictionary *propertyList = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                     options:0
                                                                       error:NULL];
        
        //NSLog(@"Flickr photos results: %@", propertyList);
        NSArray *photos = [propertyList valueForKeyPath:FLICKR_RESULTS_PHOTOS];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.refreshControl endRefreshing];
            self.photos = photos;
        });
    });    
    
}

@end
