//
//  webService.m
//  soapSample
//
//  Created by Thiruvengadam Krishnasamy on 28/12/13.
//  Copyright (c) 2013 TWILIGHT SOFTWARES. All rights reserved.
//

#import "webService.h"
#import "soapXMLparser.h"

@implementation webService

-(NSMutableData*) callWebService:(NSString*) urlStringVal withParams:(NSString*) params
{
    NSString *urlString = urlStringVal;  //@"http://[URL]/[web_service_name.asmx]/[web_method]";
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod: @"POST"];
    
    //Setting parameters section Begin
    
    NSString *reqStringFUll=params;
    NSData *requestData = [NSData dataWithBytes:[reqStringFUll UTF8String] length:[reqStringFUll length]];
    [request setHTTPBody: requestData];
    
    //Setting parameters section ends
    
    NSURLConnection *conn=[[NSURLConnection alloc]initWithRequest:request delegate:self ];
    
    return _responseData;
}

NSMutableData *_responseData;
NSMutableString *currentElement;
#pragma mark NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    _responseData = [[NSMutableData alloc] init];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    [_responseData appendData:data];
    NSLog(@"res  ==> %@",_responseData);
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    
    /*NSXMLParser *parser=[[NSXMLParser alloc] initWithData:_responseData];
     [parser setDelegate:self];
     [parser parse];*/
    
    NSLog(@"Finished Connections ==> Ended");
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
    NSLog(@"Error : %@",[error localizedDescription]);
}

- (void)didReceiveMemoryWarning
{
    // Dispose of any resources that can be recreated.
}


@end
