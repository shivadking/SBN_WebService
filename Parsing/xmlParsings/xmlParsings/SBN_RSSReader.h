//
//  SBN_RSSReader.h
//  xmlParsings
//
//  Created by Mini Mac i72 on 1/14/14.
//  Copyright (c) 2014 TWILIGHT SOFTWARES. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SBN_RSSReader : NSObject<NSXMLParserDelegate>
{
    UIActivityIndicatorView * activityIndicator;
	
	CGSize cellSize;
    
	NSXMLParser * rssParser;
	
	NSMutableArray *Mortgage_Rates;
    
    NSMutableArray *Real_Estate_Values;
    
    NSMutableArray *Insurance;
	BOOL isRSSDownloaded;
    
	
	// a temporary item; added to the "stories" array one at a time, and cleared for the next one
	NSMutableDictionary * item;
	
	// it parses through the document, from top to bottom...
	// we collect and cache each sub-element value, and then save each item to our array.
	// we use these to track each current item, until it's ready to be added to the "stories" array
	NSString * currentElement;
	NSMutableString * currentTitle, * currentDate, * currentSummary, * currentLink, *imgLink, *descText;
    
    
    NSMutableArray *colorsArray;
    NSMutableArray *array_globel;
}
- (void)SB_RSSReader_Call:(NSString *)URL withMainTag:(NSString*) MainTagName withTagKeys:(NSMutableArray*) keyArray;
@end
