//
//  FirstViewController.h
//  SampleImageUpload
//
//  Created by  on 1/6/14.
//  Copyright (c) 2014 Name. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface FirstViewController : UIViewController<UITextFieldDelegate>
{
    
    AppDelegate *parent;
    
    IBOutlet UITextField *m_txtGalleryID;
    IBOutlet UITextField *m_txtUserID;
    IBOutlet UIImageView *m_imageView;
}
- (IBAction)btnUploadClicked:(id)sender;
@end
