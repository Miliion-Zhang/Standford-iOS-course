//
//  AttributorViewController.m
//  Attributor
//
//  Created by Minlin Zhang on 12/18/13.
//  Copyright (c) 2013 Minlin Zhang. All rights reserved.
//

#import "AttributorViewController.h"
#import "TextStatusViewController.h"

@interface AttributorViewController ()
@property (weak, nonatomic) IBOutlet UILabel *headline;
@property (weak, nonatomic) IBOutlet UITextView *body;
@property (weak, nonatomic) IBOutlet UIButton *outlineButton;
@end

@implementation AttributorViewController

- (IBAction)changBodySelectionFontColorToButtonBackgroundColor:(UIButton *)sender
{
    [self.body.textStorage addAttribute:NSForegroundColorAttributeName
                                  value:sender.backgroundColor
                                  range:self.body.selectedRange];
}

- (IBAction)outlineBodySelection:(UIButton *)sender
{
    [self.body.textStorage addAttributes:@{NSStrokeWidthAttributeName : @-3,
                                           NSStrokeColorAttributeName : [UIColor blackColor]}
                                   range:self.body.selectedRange];
}

- (IBAction)unoutlineBodySelection:(UIButton *)sender
{
    /*
    [self.body.textStorage addAttribute:NSStrokeWidthAttributeName
                                  value:@0
                                  range:self.body.selectedRange];
     */
    [self.body.textStorage removeAttribute:NSStrokeWidthAttributeName range:self.body.selectedRange];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Show Analyze Result"]) {
        if ([segue.destinationViewController isKindOfClass:[TextStatusViewController class]]) {
            TextStatusViewController *tsvc = (TextStatusViewController *)segue.destinationViewController;
            tsvc.analyzedAttributeString = self.body.textStorage;
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSMutableAttributedString *title =
    [[NSMutableAttributedString alloc] initWithString:self.outlineButton.titleLabel.text];
    [title setAttributes:@{NSStrokeWidthAttributeName: @3,
                           NSStrokeColorAttributeName: self.outlineButton.tintColor}
                   range:NSMakeRange(0, [title length])];
    [self.outlineButton setAttributedTitle:title forState:UIControlStateNormal];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self usePreferredFontSize];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(preferredFontChanged:)
                                                 name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIContentSizeCategoryDidChangeNotification
                                                  object:nil];
}

- (void)preferredFontChanged:(NSNotification *)notification
{
    [self usePreferredFontSize];
}

- (void)usePreferredFontSize
{
    self.headline.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    self.body.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
}


@end
