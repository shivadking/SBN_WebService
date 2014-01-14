//
//  ViewController.m
//  soapSample
//
//  Created by Thiruvengadam Krishnasamy on 28/12/13.
//  Copyright (c) 2013 TWILIGHT SOFTWARES. All rights reserved.
//

#import "ViewController.h"
#import "soapXMLparser.h"
#import "webService.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSString *urlString = @"http://103.8.116.50:94/TaxiMail.asmx/AirportPickUp";  //@"http://[URL]/[web_service_name.asmx]/[web_method]";
    
    NSString *myRequestString1 = @"airport"; // Attention HERE!!!!
    NSString *myParamString1=@"input1_value";
    
    NSString *myRequestString2 = @"flight"; // Attention HERE!!!!
    NSString *myParamString2=@"input2_value";
    
    NSString *myRequestString3 = @"date"; // Attention HERE!!!!
    NSString *myParamString3=@"input2_value";
    
    NSString *myRequestString4 = @"time"; // Attention HERE!!!!
    NSString *myParamString4=@"input2_value";
    
    NSString *myRequestString5 = @"phoneNumber"; // Attention HERE!!!!
    NSString *myParamString5=@"input2_value";
    
    NSString *myRequestString6 = @"destinationAddress"; // Attention HERE!!!!
    NSString *myParamString6=@"input2_value";
    
    NSString *myRequestString7 = @"noteForDriver"; // Attention HERE!!!!
    NSString *myParamString7=@"input2_value";
    
    NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@",myRequestString1,myParamString1,myRequestString2,myParamString2,myRequestString3,myParamString3,myRequestString4,myParamString4,myRequestString5,myParamString5,myRequestString6,myParamString6,myRequestString7,myParamString7];
    
    webService *web = [[webService alloc] init];
    web.delegate = self;
    web.paresntClass = self;
    [web callWebService:urlString withParams:reqStringFUll withMethodType:@"POST"];//@"POST"
    
    NSLog(@"con End => Endended");
}

NSMutableString *currentElement;
-(void) getResponseData:(NSMutableData *)responseData
{
    NSLog(@"resrPdaa => %@",responseData);
    
    soapXMLparser *soap = [[soapXMLparser alloc] init];
    currentElement = [soap xmlParsingFunctions:responseData];
    NSLog(@"fromParser curEl => %@",currentElement);
}

@end
