//
//  AboutTablePersonalCell.m
//  What.CD
//
//  Created by What on 01/01/15.
//  Copyright (c) 2013 What. All rights reserved.
//

#import "AboutTablePersonalCell.h"
#import "UserSingleton.h"
#import "GitInfo.h"


static CGFloat const kAvatarWidth = 60.f;

@interface AboutTablePersonalCell ()

@property (nonatomic, strong) UIImageView *myImage;
@property (nonatomic, strong) UIImage *buttonImage;
@property (nonatomic, strong) UILabel *firstParagraphLabel;
@property (nonatomic, strong) UILabel *remainingParagraphsLabel;
@property (nonatomic, strong) UILabel *bitcoinLabel;
@property (nonatomic, strong) UILabel *gitVersionLabel;

@end

@implementation AboutTablePersonalCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        // Initialization code
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (!_myImage) {
            _myImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"../Images/carolina88.png"]];
            [_myImage setContentMode:UIViewContentModeScaleAspectFill];
            [_myImage setClipsToBounds:YES];
            _myImage.layer.masksToBounds = YES;
            _myImage.layer.borderColor = [[UIColor colorFromHexString:cFontWhiteColor] CGColor];
            _myImage.layer.borderWidth = 1.f;
            _myImage.layer.cornerRadius = 4.f;
            [self.contentView addSubview:_myImage];
        }
        
        if (!_firstParagraphLabel) {
            _firstParagraphLabel = [[UILabel alloc] init];
            _firstParagraphLabel.textColor = [UIColor colorFromHexString:cMenuTableFontColor];
            _firstParagraphLabel.font = [Constants appFontWithSize:12.f];
            _firstParagraphLabel.backgroundColor = [UIColor clearColor];
            _firstParagraphLabel.numberOfLines = 0;
            NSString *username = [UserSingleton sharedInstance].username;
            username = (username == nil ? @"there" : username);
            NSString *text = [NSString stringWithFormat:@"Hi %@! This is What.CD for iPhone (WhatCDi). Originally developed by carolina88, and later picked up by the What.CD community to get it back up and running.", username];
            if ([Constants iOSVersion] >= 6.0) {
                UIFont *boldFont = [Constants appFontWithSize:12.f bolded:YES];
                const NSRange range = NSMakeRange(0, 4+username.length);
                NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:text];
                [attributedText addAttribute:NSFontAttributeName value:boldFont range:range];
                
                [_firstParagraphLabel setAttributedText:attributedText];
            } else {
                [_firstParagraphLabel setText:text];
            }
            [self.contentView addSubview:_firstParagraphLabel];
        }
        
        if (!_remainingParagraphsLabel) {
            _remainingParagraphsLabel = [[UILabel alloc] init];
            _remainingParagraphsLabel.font = [Constants appFontWithSize:12.f];
            _remainingParagraphsLabel.textColor = [UIColor colorFromHexString:cMenuTableFontColor];
            _remainingParagraphsLabel.backgroundColor = [UIColor clearColor];
            _remainingParagraphsLabel.numberOfLines = 0;
            NSString *text = @"carolina88 worked really hard on WhatCDi which is appreciated. Hopefully the community will be able to continue the development of this application!\n\nBelow is some information from the git repository on it's version, and the branch that it was built from.";
            [_remainingParagraphsLabel setText:text];
            [self.contentView addSubview:_remainingParagraphsLabel];
        }
        
        if (!_gitVersionLabel)
        {
            _gitVersionLabel = [[UILabel alloc] init];
            _gitVersionLabel.font = [Constants appFontWithSize:12.f];
            _gitVersionLabel.textColor = [UIColor colorFromHexString:cMenuTableFontColor];
            _gitVersionLabel.backgroundColor = [UIColor clearColor];
            _gitVersionLabel.numberOfLines = 0;
            NSString *text = [NSString stringWithFormat: @"Git Version: %s\nGit Branch: %s", GIT_VERSION, GIT_BRANCH];
            if ([Constants iOSVersion] >= 6.0) {
                UIFont *boldFont = [Constants appFontWithSize:12.f bolded:YES];
                const NSRange boldRangeVersion = NSMakeRange(0, 12);
                const NSRange boldRangeBranch = NSMakeRange(13 + strlen(GIT_VERSION), 11);
                NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:text];
                [attributedText addAttribute:NSFontAttributeName value:boldFont range:boldRangeVersion];
                [attributedText addAttribute:NSFontAttributeName value:boldFont range:boldRangeBranch];
                [_gitVersionLabel setAttributedText:attributedText];
            } else {
                [_gitVersionLabel setText:text];
            }
            [self.contentView addSubview:_gitVersionLabel];
            
        }
        
        if (!_bitcoinLabel) {
            _bitcoinLabel = [[UILabel alloc] init];
            _bitcoinLabel.text = @"http://whatcdios.com/donations";
            _bitcoinLabel.textColor = [UIColor colorWithWhite:1.0 alpha:0.6];
            _bitcoinLabel.font = [Constants appFontWithSize:13.f];
            _bitcoinLabel.backgroundColor = [UIColor clearColor];
            _bitcoinLabel.numberOfLines = 1;
            [_bitcoinLabel setTextAlignment:NSTextAlignmentCenter];
            _bitcoinLabel.layer.shadowColor = [UIColor colorFromHexString:@"29607f"].CGColor;
            _bitcoinLabel.layer.shadowOffset = CGSizeMake(0, -1);
            _bitcoinLabel.layer.shadowRadius = 0.f;
            _bitcoinLabel.layer.shadowOpacity = 0.6f;
            [self.contentView addSubview:_bitcoinLabel];
        }
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.myImage.frame = CGRectMake(self.frame.size.width - CELL_PADDING - kAvatarWidth,
                                    CELL_PADDING,
                                    kAvatarWidth,
                                    kAvatarWidth);
    
    CGFloat firstParagraphWidth = self.frame.size.width - CELL_PADDING*4 - kAvatarWidth;
    self.firstParagraphLabel.frame = CGRectMake(CELL_PADDING,
                                                CELL_PADDING,
                                                firstParagraphWidth,
                                                0.f);
    [self.firstParagraphLabel sizeToFit];
    CGRect firstParagraphFrame = self.firstParagraphLabel.frame;
    firstParagraphFrame.size.width = firstParagraphWidth;
    self.firstParagraphLabel.frame = firstParagraphFrame;
    
    CGFloat remainingParagraphsWidth = self.frame.size.width - CELL_PADDING*2;
    self.remainingParagraphsLabel.frame = CGRectMake(CELL_PADDING,
                                                     self.firstParagraphLabel.frame.origin.y + self.firstParagraphLabel.frame.size.height + CELL_PADDING,
                                                     remainingParagraphsWidth,
                                                     0);
    [self.remainingParagraphsLabel sizeToFit];
    CGRect remainingParagraphsFrame = self.remainingParagraphsLabel.frame;
    remainingParagraphsFrame.size.width = remainingParagraphsWidth;
    self.remainingParagraphsLabel.frame = remainingParagraphsFrame;
    
    
    CGFloat gitVersionWidth = self.frame.size.width - CELL_PADDING*2;
    self.gitVersionLabel.frame = CGRectMake(CELL_PADDING,
                                            self.remainingParagraphsLabel.frame.origin.y + self.remainingParagraphsLabel.frame.size.height + CELL_PADDING,
                                            gitVersionWidth,
                                            0);
    [self.gitVersionLabel sizeToFit];
    CGRect gitVersionFrame = self.gitVersionLabel.frame;
    gitVersionFrame.size.width = gitVersionWidth;
    self.gitVersionLabel.frame = gitVersionFrame;
    
#ifdef DEBUG
    CGFloat cellHeight = self.gitVersionLabel.frame.origin.y + self.gitVersionLabel.frame.size.height + CELL_PADDING;
    NSLog(@"%@", [NSString stringWithFormat:@"[AboutTablePersonalCell.m] Cell Height: %.2f", cellHeight]);
#endif
    
}

@end
