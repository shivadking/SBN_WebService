//
//  ViewController.m
//  xmlParsings
//
//  Created by Thiruvengadam Krishnasamy on 09/01/14.
//  Copyright (c) 2014 TWILIGHT SOFTWARES. All rights reserved.
//

#import "ViewController.h"
#import "SBN_RSSReader.h"

@interface ViewController ()

@end

@implementation ViewController

NSMutableArray *keys;
NSMutableDictionary *dic;
NSString *mainTagName;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self LoadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - RSS feed loading Data
-(void)LoadData
{
    NSString * path = @"https://news.google.com/news/feeds?pz=1&cf=all&ned=us&hl=en&q=mortgage+rates&output=rss";
    SBN_RSSReader *sbRSS = [[SBN_RSSReader alloc] init];
    mainTagName = @"item";
    keys = [[NSMutableArray alloc] initWithObjects:@"title",@"link",@"description",@"pubDate", nil];
    [sbRSS SB_RSSReader_Call:path withMainTag:mainTagName withTagKeys:keys];
}



@end
