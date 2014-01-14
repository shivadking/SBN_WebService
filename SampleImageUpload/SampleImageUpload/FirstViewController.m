//
//  FirstViewController.m
//  SampleImageUpload
//
//  Created by  on 1/6/14.
//  Copyright (c) 2014 Name. All rights reserved.
//
#import "NSDataAdditions.h"
#import "UIImageExtras.h"
#import "FirstViewController.h"
#import "JSONKit.h"

#define ADD_GALLERY_URL @"http://virbac.plscheckitout.com/Users.php?type=Galleryadd"
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
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)btnUploadClicked:(id)sender {
    [parent ShowNetWorkIndicatoWithLabel:@"Uploading..."];
    [self DoUploadImage];
}

-(void)DoUploadImage
{
    DQ_
    UIImage *thumbImage =[m_imageView.image cropCenterAndScaleImageToSize:CGSizeMake(150, 150)];
    //[selectedImage ScaleImageToRect:selectedImage displaySize:CGSizeMake(160, 160)];
    
    
    
    NSData *data =UIImageJPEGRepresentation(thumbImage,0.7);
    NSLog(@"mgLen:%d",data.length/1024);
    NSString *parameter =[NSString stringWithFormat:@"{\"imageDetails\":[{\"user_id\":\"%@\",\"gallerygroup_id\":\"%@\",\"image\":\"%@\"}]}",m_txtUserID.text,m_txtGalleryID.text,[data base64Encoding]];
    NSLog(@"Image:%@",parameter);
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:m_txtUserID.text forKey:@"user_id"];
    [dic setObject:m_txtGalleryID.text forKey:@"gallerygroup_id"];
    [dic setObject:[data base64Encoding] forKey:@"image"];
    [arr addObject:dic];
    
    dic = [[NSMutableDictionary alloc] init];
    [dic setObject:arr forKey:@"imageDetails"];
    
    NSLog(@"params => %@",[dic JSONString]);
    
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:ADD_GALLERY_URL]];
    [request setTimeoutInterval:20];
    [request setHTTPMethod:@"POST"];
    NSLog(@"%@",request);
    NSString *sample =[NSString stringWithFormat:@"gallerydetails=%@",[dic JSONString]];
    //NSLog(@"Sample:%@",sample);
    
    NSData * postData=[[sample stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableData *body = [NSMutableData data];
    [body appendData:postData];
    [request setValue:@"application/x-www-form-urlencoded " forHTTPHeaderField:@"Content-Type"];
    //[request setValue:SetInt( postData.length) forHTTPHeaderField:@"Content-Length"];
    
    [request setHTTPBody:body];
    NSLog(@"Req:%@",request);
    NSData *responseObject =[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSLog(@"Getting response:%@",responseObject);
    
    
    if(responseObject!=nil && [responseObject isKindOfClass:[NSData class]])
    {
        NSDictionary * resultDic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        NSLog(@"res:%@",resultDic);
        if(resultDic && [resultDic isKindOfClass:[NSDictionary class]])
        {
            
            int result =[[resultDic objectForKey:@"result"] integerValue];
            if(result>0)
            {
                NSLog(@"IMAGE UPLOADED");
            }
            
        }
    }
    [parent RemoveNetworkIndicator];
    _DQ
    
  
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView  animateWithDuration:0.2 animations:^{
        
    
    CGRect frame =self.view.frame;
    frame.origin.y=-210;
    self.view.frame=frame;
    }];
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
      [UIView  animateWithDuration:0.2 animations:^{
    CGRect frame =self.view.frame;
    frame.origin.y=10;
    self.view.frame=frame;
 }];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [m_imageView release];
    [m_txtUserID release];
    [m_txtGalleryID release];
    [super dealloc];
}

@end
