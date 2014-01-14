//
//  AppDelegate.h
//  SampleImageUpload
//
//  Created by  on 1/6/14.
//  Copyright (c) 2014 Name. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "defs.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
MBProgressHUD *hud;
}
@property (strong, nonatomic) UIWindow *window;
+(AppDelegate *)GetDelegate;
-(void)RemoveNetworkIndicatorLabel:(UIView *)view;
-(void)ShowImNetWorkIndicator:(UIView *) view;
-(void)ShowNetWorkIndicator:(UIView *) view :(NSString *)Message;
-(void)RemoveNetworkIndicator;
-(void)ShowNetWorkIndicatoWithLabel:(NSString *)message;
@end
