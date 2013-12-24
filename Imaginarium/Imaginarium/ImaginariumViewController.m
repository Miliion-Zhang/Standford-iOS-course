//
//  ImaginariumViewController.m
//  Imaginarium
//
//  Created by Minlin Zhang on 12/20/13.
//  Copyright (c) 2013 Minlin Zhang. All rights reserved.
//

#import "ImaginariumViewController.h"
#import "ImageViewController.h"

@interface ImaginariumViewController ()

@end

@implementation ImaginariumViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[ImageViewController class]]) {
        ImageViewController *ivc = (ImageViewController *)segue.destinationViewController;
        ivc.imageURL = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://images.apple.com/v/iphone-5s/gallery/a/images/download/%@.jpg", segue.identifier]];
        ivc.title = segue.identifier;
    }
}

@end
