//
//  webService.h
//  soapSample
//
//  Created by Sivbalan J on 28/12/13.
//  Copyright (c) 2013 TWILIGHT SOFTWARES. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol webServiceSOAPDelegate <NSObject>

-(void) getResponseData:(NSMutableData*) responseData;

@end

@interface webService : NSObject<NSURLConnectionDelegate>
-(NSMutableData*) callWebService:(NSString*) urlStringVal withParams:(NSString*) params withMethodType:(NSString*) method;

@property (weak) id<webServiceSOAPDelegate> delegate;
@property (assign) id paresntClass;
@end
