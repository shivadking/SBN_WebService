//
//  FirstViewController.h
//  ImageUploadTest
//
//  Created by  on 7/24/13.
//  Copyright (c) 2013 Name. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface FirstViewController : UIViewController<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    IBOutlet UITextField *txtBaseURL;
    
    IBOutlet UITextView *txtResult;
    IBOutlet UITextField *txtParameter;
    IBOutlet UIImageView *mgView;
    BOOL isImageUploaded;
    AppDelegate *parent;
    NSString *strCachePath;
      NSMutableData *responseData;
}
- (IBAction)btnChooseImage:(UIButton *)sender;
- (IBAction)btnUploadClicked:(UIButton *)sender;

@end
