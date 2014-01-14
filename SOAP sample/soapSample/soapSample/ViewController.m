//
//  ViewController.m
//  soapSample
//
//  Created by Thiruvengadam Krishnasamy on 28/12/13.
//  Copyright (c) 2013 TWILIGHT SOFTWARES. All rights reserved.
//

#import "ViewController.h"
#import "soapXMLparser.h"
#import "SBN_RSSReader.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSString *urlString = @"http://103.8.116.50:94/TaxiMail.asmx/AirportPickUp";  //@"http://[URL]/[web_service_name.asmx]/[web_method]";
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod: @"POST"];
    
    //Setting parameters section Begin//http://103.8.116.50:94/TaxiMail.asmx
    
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
    NSData *requestData = [NSData dataWithBytes:[reqStringFUll UTF8String] length:[reqStringFUll length]];
    [request setHTTPBody: requestData];
    
    //Setting parameters section ends
    
    NSURLConnection *conn=[[NSURLConnection alloc]initWithRequest:request delegate:self ];
    
    NSLog(@"con End => Endended");
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
    NSString *mainTagName = @"Result";
    NSMutableArray *keys = [[NSMutableArray alloc] initWithObjects:@"Status",@"Message", nil];

    SBN_RSSReader *sbnRSS = [[SBN_RSSReader alloc] init];
    [sbnRSS SB_RSSReader_Call_NSMutableData:_responseData withMainTag:mainTagName withTagKeys:keys];
    
    /*soapXMLparser *soap = [[soapXMLparser alloc] init];
    currentElement = [soap xmlParsingFunctions:_responseData];
    NSLog(@"fromParser curEl => %@",currentElement);*/
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
    NSLog(@"Error : %@",[error localizedDescription]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
