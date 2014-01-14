//
//  SBN_RSSReader.m
//  xmlParsings
//
//  Created by Mini Mac i72 on 1/14/14.
//  Copyright (c) 2014 TWILIGHT SOFTWARES. All rights reserved.
//

#import "SBN_RSSReader.h"

@implementation SBN_RSSReader
NSMutableArray *keys;
NSMutableDictionary *dic;
NSString *mainTagName;

- (void)SB_RSSReader_Call:(NSString *)URL withMainTag:(NSString*) MainTagName withTagKeys:(NSMutableArray*) keyArray
{
    Mortgage_Rates = [[NSMutableArray alloc] init];
    mainTagName = MainTagName;
    dic = [[NSMutableDictionary alloc] init];
    keys = keyArray;
	
    //you must then convert the path to a proper NSURL or it won't work
    NSURL *xmlURL = [NSURL URLWithString:URL];
	
    // here, for some reason you have to use NSClassFromString when trying to alloc NSXMLParser, otherwise you will get an object not found error
    // this may be necessary only for the toolchain
    rssParser = [[NSXMLParser alloc] initWithContentsOfURL:xmlURL];
	
    // Set self as the delegate of the parser so that it will receive the parser delegate methods callbacks.
    [rssParser setDelegate:self];
	
    // Depending on the XML document you're parsing, you may want to enable these features of NSXMLParser.
    [rssParser setShouldProcessNamespaces:NO];
    [rssParser setShouldReportNamespacePrefixes:NO];
    [rssParser setShouldResolveExternalEntities:NO];
	
    [rssParser parse];
	
}

- (void)SB_RSSReader_Call_NSMutableData:(NSMutableData*) _responseData withMainTag:(NSString*) MainTagName withTagKeys:(NSMutableArray*) keyArray
{
    Mortgage_Rates = [[NSMutableArray alloc] init];
    mainTagName = MainTagName;
    dic = [[NSMutableDictionary alloc] init];
    keys = keyArray;
	
	rssParser=[[NSXMLParser alloc] initWithData:_responseData];
    // Set self as the delegate of the parser so that it will receive the parser delegate methods callbacks.
    [rssParser setDelegate:self];
	
    // Depending on the XML document you're parsing, you may want to enable these features of NSXMLParser.
    [rssParser setShouldProcessNamespaces:NO];
    [rssParser setShouldReportNamespacePrefixes:NO];
    [rssParser setShouldResolveExternalEntities:NO];
	
    [rssParser parse];
	
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
	NSString * errorString = [NSString stringWithFormat:@"Unable to download story feed from web site (Error code %i )", [parseError code]];
	//NSLog(@"error parsing XML: %@", errorString);
    
	UIAlertView * errorAlert = [[UIAlertView alloc] initWithTitle:@"Error loading content" message:errorString delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[errorAlert show];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
	currentElement = [elementName copy];
	if ([elementName isEqualToString:mainTagName]) {
		// clear out our story item caches...
		item = [[NSMutableDictionary alloc] init];
		for(int i=0; i<[keys count]; i++)
        {
            [dic setObject:@"" forKey:[keys objectAtIndex:i]];
        }
        
	}
	
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
	if ([elementName isEqualToString:mainTagName]) {
		// save values to an item, then store that item into the array...
        for(int i=0; i<[keys count]; i++)
        {
            [item setObject:[dic objectForKey:[keys objectAtIndex:i]] forKey:[keys objectAtIndex:i]];
        }
        
        [Mortgage_Rates addObject:[item copy]];
	}
	
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
	// save the characters for the current item...
    for(int i=0; i<[keys count]; i++)
    {
        if ([currentElement isEqualToString:[keys objectAtIndex:i]]) {
            NSMutableString *str = [dic objectForKey:[keys objectAtIndex:i]];
            [dic setObject:[NSString stringWithFormat:@"%@%@",str,string] forKey:[keys objectAtIndex:i]];
        }
    }
    
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
	
	[activityIndicator stopAnimating];
	[activityIndicator removeFromSuperview];
    
    NSLog(@"Mortgage_Rates ==> %@",Mortgage_Rates);
    NSLog(@"Mortgage_Rates ==> %@",[[Mortgage_Rates objectAtIndex:0] objectForKey:@"title"]);
}


@end
