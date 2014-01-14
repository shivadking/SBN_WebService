//
//  soapXMLparser.m
//  soapSample
//
//  Created by Thiruvengadam Krishnasamy on 28/12/13.
//  Copyright (c) 2013 TWILIGHT SOFTWARES. All rights reserved.
//

#import "soapXMLparser.h"
#import "SBN_RSSReader.h"

@implementation soapXMLparser
NSMutableString *currentElement;

-(NSMutableString*) xmlParsingFunctions:(NSMutableData*) _responseData
{
    NSXMLParser *parser=[[NSXMLParser alloc] initWithData:_responseData];
    [parser setDelegate:self];
    [parser parse];
    
    NSLog(@"Ended ==> ");
    return currentElement;
}

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    NSLog(@"Parser start");
}
- (void) parser: (NSXMLParser *) parser didStartElement: (NSString *) elementName
   namespaceURI: (NSString *) namespaceURI qualifiedName: (NSString *) qName attributes: (NSDictionary *) attributeDict
{
    if ([elementName isEqualToString:@"Status"])
    {
        currentElement = [[NSMutableString alloc] init];
        return;
    }
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    [currentElement appendString:string];

}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if([elementName isEqualToString:@"Status"])
    {
        return;
    }
}
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    NSLog(@"curElement => %@",currentElement);
}

@end
