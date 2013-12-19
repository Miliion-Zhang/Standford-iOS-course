//
//  TextStatusViewController.m
//  Attributor
//
//  Created by Minlin Zhang on 12/19/13.
//  Copyright (c) 2013 Minlin Zhang. All rights reserved.
//

#import "TextStatusViewController.h"

@interface TextStatusViewController ()
@property (weak, nonatomic) IBOutlet UILabel *coloredCharactersLabel;
@property (weak, nonatomic) IBOutlet UILabel *outlinedCharactersLabel;
@end

@implementation TextStatusViewController

- (void)setAnalyzedAttributeString:(NSAttributedString *)analyzedAttributeString
{
    _analyzedAttributeString = analyzedAttributeString;
    [self updateUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}

- (NSAttributedString *)getAttributeStringByAttributeName:(NSString *)attributeName
{
    NSMutableAttributedString *value = [[NSMutableAttributedString alloc] init];
    
    int curpos = 0;
    while (curpos < [self.analyzedAttributeString length]) {
        NSRange range;
        id attribute = [self.analyzedAttributeString attribute:attributeName atIndex:curpos effectiveRange:&range];
        if (attribute) {
            [value appendAttributedString:
             [self.analyzedAttributeString attributedSubstringFromRange:range]];
            curpos = range.location + range.length;
        } else {
            curpos++;
        }
    }
    return value;
}

- (void)updateUI
{
    int coloredNum = [[self getAttributeStringByAttributeName:NSForegroundColorAttributeName] length];
    int outlinedNum = [[self getAttributeStringByAttributeName:NSStrokeWidthAttributeName] length];
    self.coloredCharactersLabel.text = [NSString stringWithFormat:@"%d colored characters!", coloredNum];
    self.outlinedCharactersLabel.text = [NSString stringWithFormat:@"%d outlined characters!", outlinedNum];
}

@end
