//
//  webService.h
//  soapSample
//
//  Created by Thiruvengadam Krishnasamy on 28/12/13.
//  Copyright (c) 2013 TWILIGHT SOFTWARES. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface webService : NSObject<NSURLConnectionDelegate>
-(NSMutableData*) callWebService:(NSString*) urlStringVal withParams:(NSString*) params;
@end
