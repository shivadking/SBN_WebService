//
//  ServerRequest.m
//  ClubManagement
//
//  Created by Gnanavadivelu on 10/08/12.
//  Copyright 2011. All rights reserved.
//

#import "ServerRequest.h"
#import "ASIHTTPRequest.h"

#define URLSOAP @"http://tempuri.org"
#define PageSize 20
#define TIMEOUT 60


@implementation ServerRequest

@synthesize delegate, object = _object, method = _method, params = _params;
@synthesize listData, resultCode;
@synthesize dictData;
@synthesize childList;
@synthesize resultString;

#pragma mark Static
static NSMutableArray * __requests;
+ (NSMutableArray *)requests {
	@synchronized([ServerRequest class]) {
		if (__requests == nil)
			__requests = [NSMutableArray new];
		return __requests;
	}
}

+ (void)cancelPendingRequestsForObject:(NSString *)object method:(NSString *)method {
	@synchronized([ServerRequest class]) {
		for (ServerRequest * server in [self requests]) {
			if ((object == nil || [server.object isEqualToString:object]) &&
				(method == nil || [server.method isEqualToString:method])) {
				[server abort];
			}
		}
	}
}

#pragma mark Helpers

- (void)abort {
	[_connection cancel];
}

+ (BOOL)pendingRequestsForObject:(NSString *)object method:(NSString *)method {
	@synchronized([ServerRequest class]) {
		for (ServerRequest *server in [self requests]) {
			if ((object == nil || [server.object isEqualToString:object]) &&
				(method == nil || [server.method isEqualToString:method])) {
				if (server->delegate != nil)
					return YES;
			}
		}
	}
	
	return NO;
}

- (NSString *)paramsAsKeyValuePairs:(NSDictionary *)params  keys:(NSMutableArray *)keys{
    
	NSMutableString * pairs = [[[NSMutableString alloc] initWithCapacity:[params count]] autorelease];
	for (NSString * key in keys) {
        [pairs appendFormat:@"<%@>%@</%@>\n",
         [key stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
         [[params objectForKey:key] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]],
         [key stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	}
	return pairs;
}

#pragma mark Public Methods


- (id)initWithMethod:(NSString *)method params:(NSString*)params
{
	assert (method != nil && [method length] > 0);
    
	self = [super init];
	if (self) {
        @synchronized([ServerRequest class]) {
			[[ServerRequest requests] addObject:self];
		}
		 
		_method = [method retain];
        
        NSMutableData *bodyData = [[[NSMutableData alloc] initWithData:[params dataUsingEncoding:NSUTF8StringEncoding]] autorelease];
        
        NSURL *requestURL = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"%@/%@",SERVER_URL,method]];
        
        request = [ASIHTTPRequest requestWithURL:requestURL];
        [request setRequestMethod:@"POST"];
        [request addRequestHeader:@"Content-Type" value:@"application/x-www-form-urlencoded"];
        [request addRequestHeader:@"Content-Length" value:[NSString stringWithFormat:@"%d", [params length]]];
        [request setTimeOutSeconds:60];
        [request setShouldAttemptPersistentConnection:NO];
        [request setPostBody:bodyData];
       
        
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
        [request setShouldContinueWhenAppEntersBackground:YES];
#endif
        
        [request setDelegate:self];
        [request setDidFailSelector:@selector(requestFail:)];
        [request setDidFinishSelector:@selector(requestFinished:)];
   
        [requestURL release];
	}
	return self;
}

- (id)initWithMethod:(NSString *)method params:(NSString*)params uploadProgress:(id)progress  {
	assert (method != nil && [method length] > 0);
	
    self = [super init];
	if (self) {
        @synchronized([ServerRequest class]) {
			[[ServerRequest requests] addObject:self];
		}
        
		_method = [method retain];
        
        NSMutableData *bodyData = [[[NSMutableData alloc] initWithData:[params dataUsingEncoding:NSUTF8StringEncoding]] autorelease];
        
        NSURL *requestURL = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"%@/%@",SERVER_URL,method]];
        
        request = [ASIHTTPRequest requestWithURL:requestURL];
        [request setRequestMethod:@"POST"];
        [request addRequestHeader:@"Content-Type" value:@"application/x-www-form-urlencoded"];
        [request addRequestHeader:@"Content-Length" value:[NSString stringWithFormat:@"%d", [params length]]];
        [request setTimeOutSeconds:60];
        [request setShouldAttemptPersistentConnection:NO];
        [request setPostBody:bodyData];
        [request setUploadProgressDelegate:progress];
        
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
        [request setShouldContinueWhenAppEntersBackground:YES];
#endif
        
        [request setDelegate:self];
        [request setDidFailSelector:@selector(requestFail:)];
        [request setDidFinishSelector:@selector(requestFinished:)];
        
        [requestURL release];
	}
	return self;
}



- (void)stopLoading
{
	[delegate release];
	delegate = nil;
}

- (void)startAsynchronous
{
    [request startAsynchronous];   
}

- (void)load
{
	assert (_connection != nil);
	assert (delegate != nil);
	//assert (_downloadedData == nil);
	
	[_connection start];
}

#pragma mark NSURLConnection Delegate Members

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	NSHTTPURLResponse * httpResponse = (NSHTTPURLResponse *)response;
	NSLog(@"%d",[httpResponse statusCode]);
	
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)dt {
	[_downloadedData appendData:dt];
	
}
-(void) connection:(NSURLConnection *)connection didFailWithError: (NSError *)error {
	[connection release];
	[_downloadedData release];
    
    if([delegate respondsToSelector:@selector(serverRequest:fail:)])
    {
       // [delegate serverRequest:self fail:YES];
        [self.delegate serverRequest:self didFailWithError:error];
    }
	
}
- (void) connectionDidFinishLoading: (NSURLConnection*) connection {
    
    NSString * data = [[[NSString alloc] initWithData:_downloadedData encoding:NSUTF8StringEncoding] autorelease];
	//NSLog(@"%@",data);
    
    self.resultString = data;
    NSLog(@"Result: %@",self.resultString);
    
    [self.delegate serverRequestDidFinishLoading:self];
    [self stopLoading];
}


#pragma mark ASIHTTPRequest delegate

-(void) requestFail:(ASIHTTPRequest*) __request
{    
    [self.delegate serverRequest:self didFailWithError:__request.error];
}

-(void) requestFinished:(ASIHTTPRequest*) __request
{
    self.resultString = [__request responseString];
    [self.delegate serverRequestDidFinishLoading:self];
}

#pragma mark NSObject Members

- (void)dealloc
{
    @synchronized([ServerRequest class])
    {
		[[ServerRequest requests] removeObject:self];
	}
    
    [soapMessage release];
	[_object release];
	[_method release];
	[_params release];
	[_connection cancel];
	[_connection release];
	[_downloadedData release];
	[delegate release];
	[_request release];
    [listData release];
    
	[super dealloc];
}

@end
