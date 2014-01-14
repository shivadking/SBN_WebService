//
//  soapXMLparser.m
//  soapSample
//
//  Created by Thiruvengadam Krishnasamy on 28/12/13.
//  Copyright (c) 2013 TWILIGHT SOFTWARES. All rights reserved.
//

#import "soapXMLparser.h"

@implementation soapXMLparser
NSMutableDictionary *currentElement;
NSMutableString *curVal;
int flag=0;

-(NSMutableDictionary*) xmlParsingFunctions:(NSMutableData*) _responseData
{
    currentElement = [[NSMutableDictionary alloc] init];
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
    //NSLog(@"elementName Cur ==> %@",elementName);
    if ([elementName isEqualToString:@"Status"])
    {
        curVal = [[NSMutableString alloc] init];
        return;
    }
    if ([elementName isEqualToString:@"Message"])
    {
        curVal = [[NSMutableString alloc] init];
        return;
    }
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    NSLog(@"String ==> %@",string);
    [curVal appendString:string];
    //[currentElement appendString:string];
    
    
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
   // NSLog(@"elementName End ==> %@",elementName);
    if([elementName isEqualToString:@"Status"])
    {
        [currentElement setObject:curVal forKey:@"Status"];
        return;
    }
    if ([elementName isEqualToString:@"Message"])
    {
        [currentElement setObject:curVal forKey:@"Message"];
        return;
    }
}
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    NSLog(@"curElement => %@",currentElement);
}

@end
