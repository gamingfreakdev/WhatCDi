//
//  AboutTable.m
//  What.CD
//
//  Created by What on 01/01/15.
//  Copyright (c) 2013 What. All rights reserved.
//

#import "AboutTable.h"
#import "Constants.h"
#import "AboutTablePersonalCell.h"
#import "AboutTableSiteCell.h"
#import "AppDelegate.h"

@interface AboutTable () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation AboutTable

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        self.backgroundView = nil;
        self.backgroundColor = [UIColor colorFromHexString:cMenuTableBackgroundColor];
        self.separatorColor = [UIColor colorFromHexString:cMenuTableSeparatorColor];
        self.scrollsToTop = NO;
        
        if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
            [self setSeparatorInset:UIEdgeInsetsZero];
        }
    }
    return self;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    static NSString *MyCellIdentifier = @"MyCell";
    static NSString *SiteCellIdentifier = @"SiteCell";
    if (indexPath.row == 0) {
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.textLabel.textColor = [UIColor colorFromHexString:cMenuTableFontColor];
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            cell.textLabel.font = [Constants appFontWithSize:17.f bolded:YES];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        cell.textLabel.text = [NSString stringWithFormat:@"What.CD for iPhone v%@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];;
        return cell;
    }
    
    else if (indexPath.row == 1) {
        AboutTablePersonalCell *cell = (AboutTablePersonalCell *)[tableView dequeueReusableCellWithIdentifier:MyCellIdentifier];
        if (cell == nil) {
            cell = [[AboutTablePersonalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        return cell;
    }
    
    else {
        AboutTableSiteCell *cell = (AboutTableSiteCell *)[tableView dequeueReusableCellWithIdentifier:SiteCellIdentifier];
        if (cell == nil) {
            cell = [[AboutTableSiteCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            [cell.donateButton addTarget:self action:@selector(donationButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        }
        return cell;
    }
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setBackgroundColor:tableView.backgroundColor];
}

// Fixed height rows
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return 40.f;
    }
    else if (indexPath.row == 1) {
        return 227.f;
    }
    else {
        return 140.f;
    }
}

#pragma mark - Table view delegate

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.parentController scrollViewWillBeginDragging:scrollView];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.parentController scrollViewDidScroll:scrollView];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.parentController scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}

- (void)donationButtonPressed:(DonateButton *)button {
    if ([button.donatePath hasPrefix:@"http://"] || [button.donatePath hasPrefix:@"https://"])
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:button.donatePath]];
}

@end
