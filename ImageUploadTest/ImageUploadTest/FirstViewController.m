//
//  FirstViewController.m
//  ImageUploadTest
//
//  Created by  on 7/24/13.
//  Copyright (c) 2013 Name. All rights reserved.
//

#import "FirstViewController.h"
#import "NSDataAdditions.h"

//http://localhost/Zoom/api/CallDetail/TokenInsertion?deviceToken=best%20of%20luck&toUser=1010

//#define DOMAIN_URL @"http://zomate.twilightsoftwares.com"
//#define DOMAIN_URL @"http://192.168.0.116:81"
#define DOMAIN_URL @"http://zomate.netsdi.com"
#define BASE_URL DOMAIN_URL@"/api/"
#define UPLOAD_PROF_IMAGE BASE_URL@"Settings/UpdateUserImage"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    parent=[AppDelegate GetDelegate];
    
    NSString * strParameter=[NSString stringWithFormat:@"Id=%d&LargeImageUrl=",45];
    txtParameter.text=strParameter;
    txtBaseURL.text=UPLOAD_PROF_IMAGE;
    txtResult.text=@"";
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnChooseImage:(UIButton *)sender {
    [txtBaseURL resignFirstResponder];
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.delegate=self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self.navigationController presentModalViewController:imagePicker animated:YES];
    [imagePicker release];
    
}

- (IBAction)btnUploadClicked:(UIButton *)sender {
    if(isImageUploaded==NO || mgView.image==nil)
    {
        [AppDelegate ShowAlertTitle:@"Chose image" andwithMessage:@"You should select an image then do upload"];
        return;
    }
    [txtBaseURL resignFirstResponder];
    
    [parent ShowNetWorkIndicator:parent.window :@"Updating.."];
    [self performSelector:@selector(ChangeProfilePicture) withObject:nil afterDelay:0.2];
    
    
}

-(void)imagePickerController:(UIImagePickerController *)pickerNew didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    [mgView setImage:image ];
    
  
    isImageUploaded=YES;
   
   [self.navigationController dismissModalViewControllerAnimated:YES];
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	[self.navigationController dismissModalViewControllerAnimated:YES];
}

-(void)ConfigureDictonaryPaths
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
	NSString *categoryFolder =[NSString stringWithFormat:@"%@",documentsDirectory];
   strCachePath=[[NSString alloc]initWithFormat:@"%@",categoryFolder];
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)ChangeProfilePicture
{
   
    NSData *data =nil;
    data= UIImagePNGRepresentation(mgView.image);
    
    NSString *strBase =txtBaseURL.text;
    if(strBase.length<5)
        strBase=UPLOAD_PROF_IMAGE;
    txtBaseURL.text=strBase;
    
    NSString *strParameter=[txtParameter.text stringByAppendingString:[data base64Encoding]];
    //NSLog(@"StrParameter - %@",strParameter);
    
    if(strParameter.length<5)
    {
        strParameter=[NSString stringWithFormat:@"Id=%d&LargeImageUrl=%@",45,[data base64Encoding]];
        txtParameter.text=strParameter;
    }
    //txtResult.text=[NSString stringWithFormat:@"BASE URL: %@ \n PARAM: %@ \n RESULT:",strBase,strParameter];
    
    //NSLog(@"param:%@",strParameter);
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
	[request setURL:[NSURL URLWithString:strBase]];
    NSLog(@"Request SetURL - %@",request);
    
	[request setHTTPMethod:@"POST"];
    
    NSLog(@"Request setHTTPMethod - %@",request);
    
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    NSLog(@"Request set Value - %@",request);
    
    NSMutableData *body = [NSMutableData data];
    NSLog(@"Body - %@",body);
    [body appendData:[strParameter dataUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"Body AppendData - %@",body);
    
    [request setHTTPBody:body];
    
    NSLog(@"Request set HTTp body - %@",request);
    [request setTimeoutInterval:60];
     NSLog(@"Request Timeout - %@",request);
    
    
    isImageUploaded=NO;
    NSURLConnection *conn=[[[NSURLConnection alloc]initWithRequest:request delegate:self] autorelease];
    if(conn)
    {
        NSLog(@"Connected with URL -- %@",conn);
        responseData=[[NSMutableData alloc]init];
        //NSLog(@"Connected with Response Data -- %@",responseData);

    }
    
}
#pragma mark - Connections
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    
    
    NSLog(@"Response received");
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"URL Connection DID REcieve data");
    [parent performSelectorOnMainThread:@selector(UpdateLabel:) withObject:@"Upload completed" waitUntilDone:YES];
    
    NSLog(@"Data -- %@",data);
    
    if(responseData==nil || ![responseData isKindOfClass:[NSData class]])
        responseData=[[NSMutableData alloc]init];
    [responseData appendData:data];
    NSLog(@"Completed Response - %@",responseData);
}


- (void)connection:(NSURLConnection *)connection   didSendBodyData:(NSInteger)bytesWritten
 totalBytesWritten:(NSInteger)totalBytesWritten
totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite
{
    float per =totalBytesWritten;
    per = per / totalBytesExpectedToWrite;
    per = per *100.0f;
    [parent performSelectorOnMainThread:@selector(UpdateLabel:) withObject:[NSString stringWithFormat:@"%0.2f %% Uploaded",per]  waitUntilDone:YES];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    [parent performSelectorOnMainThread:@selector(RemoveNetworkIndicatorLabel:) withObject:parent.window waitUntilDone:YES];
    
    if(responseData!=nil)
    {
        NSString *strPostID=[[NSString alloc]initWithData:responseData encoding:NSASCIIStringEncoding];
        txtResult.text=strPostID;
        NSLog(@"Result%@",strPostID);
        NSString *tempS=[strPostID stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        
        int postID=[tempS intValue];
        
        if(postID>0)
        {
            
            // [self performSelectorOnMainThread:@selector(UpdateProfile) withObject:nil waitUntilDone:YES];
        }
        NSLog(@"PostID:%d",postID);
        
        [responseData release];
        
        
    }
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    
    [parent performSelectorOnMainThread:@selector(UpdateLabel:) withObject:@"Server is not available." waitUntilDone:YES];
    // // NSLog(@"start receiving ");
    [parent RemoveNetworkIndicatorLabel:parent.window];
}

- (void)dealloc {
    [txtBaseURL release];
    [mgView release];
    [txtParameter release];
    [txtResult release];
    [super dealloc];
}
- (void)viewDidUnload {
    [txtParameter release];
    txtParameter = nil;
    [txtResult release];
    txtResult = nil;
    [super viewDidUnload];
}
@end
