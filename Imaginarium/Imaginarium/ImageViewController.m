//
//  ImageViewController.m
//  Imaginarium
//
//  Created by Minlin Zhang on 12/20/13.
//  Copyright (c) 2013 Minlin Zhang. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()   <UIScrollViewDelegate>
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIImage *image;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@end

@implementation ImageViewController

- (void)setImageURL:(NSURL *)imageURL
{
    _imageURL = imageURL;
    [self downloadImage];
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

- (UIImage *)image
{
    return self.imageView.image;
}

- (void)setImage:(UIImage *)image
{
    self.imageView.image = image;
    //[self.imageView sizeToFit];
    self.imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    self.scrollView.zoomScale = 1.0;
    self.scrollView.contentSize = self.image ? self.image.size : CGSizeZero;
    [self.indicator stopAnimating];
    NSLog(@"indicator stopAnimating has been called!");
}

- (void)setScrollView:(UIScrollView *)scrollView
{
    _scrollView = scrollView;
    self.scrollView.minimumZoomScale = 0.1;
    self.scrollView.maximumZoomScale = 2.0;
    self.scrollView.delegate = self;
    [self.scrollView setContentSize:self.image ? self.image.size : CGSizeZero];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (void)downloadImage
{
    self.image = nil;
    [self.indicator startAnimating];
    NSLog(@"indicator startAnimating has been called!");
        
    if (self.imageURL) {
        NSURLRequest *request = [NSURLRequest requestWithURL:self.imageURL];
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
        NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request
                                                        completionHandler:^(NSURL *localfile, NSURLResponse *response, NSError *error) {
                                                            if (!error) {
                                                                UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:localfile]];
                                                                if (![request.URL isEqual:self.imageURL]) return;
                                                                
                                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                                    self.image = image;
                                                                });
                                                            }
        }];
        [task resume];
        
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.scrollView addSubview:self.imageView];
}

@end
