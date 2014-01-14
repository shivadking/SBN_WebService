//
//  AppDelegate.h
//  ImageUploadTest
//
//  Created by  on 7/24/13.
//  Copyright (c) 2013 Name. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

#define MQ_ dispatch_async( dispatch_get_main_queue(), ^(void) {
#define _MQ });

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
      MBProgressHUD *hud;
}
@property (strong, nonatomic) UIWindow *window;
+(AppDelegate *)GetDelegate;
+(void)ShowAlertTitle:(NSString *)title andwithMessage:(NSString *)strMessage;
-(void)RemoveNetworkIndicatorLabel:(UIView *)view;
-(void)ShowImNetWorkIndicator:(UIView *) view;
-(void)ShowNetWorkIndicator:(UIView *) view :(NSString *)Message;
@end
