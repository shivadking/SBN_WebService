//
//  soapXMLparser.h
//  soapSample
//
//  Created by Sivabalan J on 28/12/13.
//  Copyright (c) 2013 TWILIGHT SOFTWARES. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface soapXMLparser : NSObject<NSXMLParserDelegate>
-(NSMutableString*) xmlParsingFunctions:(NSMutableData*) _responseData;
@end
