//
//  ServerRequest.h

//
//  Created by iPhone Developer.
//  Copyright 2011. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServerRequestDelegate.h"

@class ASIHTTPRequest;

@interface ServerRequest : NSObject
{
    NSMutableString *soapMessage;
    
    //
    NSXMLParser *_xmlParser;
    NSMutableString *_currentString;
    
    //
    NSURLConnection * _connection;
    NSMutableURLRequest * _request;
    NSMutableData * _downloadedData;
    
    NSString * _object;
    NSString * _method;
    NSDictionary * _params;
    
    id<ServerRequestDelegate> delegate;
    NSMutableArray *listData;
    NSInteger resultCode;
    ASIHTTPRequest *request;
}

@property (retain) NSMutableDictionary * dictData;
@property (assign) id<ServerRequestDelegate>delegate;
@property (readonly) NSString * object;
@property (readonly) NSString * method;
@property (readonly) NSDictionary * params;
@property (retain)  NSMutableArray *listData;
@property (retain)  NSMutableArray *childList;
@property (retain)  NSString *resultString;

@property  NSInteger resultCode;

- (void)abort;
- (void)load ;
- (void)startAsynchronous;
 


- (id)initWithObject:(NSString *)object method:(NSString *)method params:(NSDictionary *)params keys:(NSMutableArray *)keys;
- (id)initWithObject:(NSString *)object method:(NSString *)method message:(NSString*)message;
- (id)initWithMethod:(NSString *)method params:(NSString*)params;
- (id)initWithMethod:(NSString *)method params:(NSString*)params uploadProgress:(id)progress;
- (NSString *)paramsAsKeyValuePairs:(NSDictionary *)params keys:(NSMutableArray *)keys;

@end