//
//  ViewController.h
//  soapSample
//
//  Created by Sivabalan J on 28/12/13.
//  Copyright (c) 2013 TWILIGHT SOFTWARES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "webService.h"

@interface ViewController : UIViewController<NSURLConnectionDelegate,NSXMLParserDelegate,webServiceSOAPDelegate>

@end
