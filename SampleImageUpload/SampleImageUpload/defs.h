//
//  defs.h
//  
//
//  Created by  on 7/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#ifndef defs_h
#define defs_h

#define DEBUG_LOG //No need we added this in macro

#define FACBOOK_LIMIT 150
#define TWITTER_LIMIT 140
//void XLLog(NSString *format, ...);
#define DB_LATEST_VERSION 13
static inline void FLog(NSString *format, ...)
{
#ifdef DEBUG_LOG
    va_list args;
    va_start(args, format);
    NSLogv(format, args);
    va_end(args);
#else
    // do nothing! or something that makes sense in a release version
#endif
}
enum
{
    kSynchTypeNew=1,
    kSynchTypeEdited,
    kSynchTypeNewProcess,
    kSynchTypeEditPorcess,
    
    kSynchTypeUpdated,
    kSynchTypeDeleted,
   kSynchTypeServerDeleted,
}
kSynchType;

void exceptionHandler(NSException *exception);

#define WITH_SERVICE

#ifdef DEBUG_LOG
#define XLog(FORMAT, ...)  printf("%s [Line %d]: %s\n",__PRETTY_FUNCTION__, __LINE__,[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else 
#define XLog(FORMAT, ...)
#endif

enum {
    kTabBarIndexRecent=0,
    kTabBarIndexComment,
    kTabBarIndexSearch,
    kTabBarIndexEmail,
    kTabBarIndexFacebook,
    kTabBarIndexTwitter,
    kTabBarIndexInfo,
};

enum
{
    kAlarmTypeSingle=0,
    kAlarmTypeEveryDay,
    kAlarmTypeWeekly,
    kAlarmTypeMonthly,
    kAlarmTypeYearly,
}kAlarmType;

enum  {
    kSignInEmailId = 0,
    kSignInPassword,
    kSignInCNFPassword,
    };

enum
{
    MINUID			=	0x100,			// min valid vnsid
	MINULID		=	0x1000,		// min valid vnsid
    

};

#define IMAGE_QULITY 0.8



typedef unichar bytew;
typedef unsigned char byte;
typedef unsigned short word;
typedef unsigned int dword;
typedef unsigned long long qword;
typedef unsigned char *BP;
typedef unsigned short *WP;
typedef unsigned int *DP;
typedef unsigned long long *QP;
typedef const void *CVP;
typedef void *VP;

#define GetFBImage(x) [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large",x]
#define IS_WIDESCREEN (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)568) < DBL_EPSILON)
#define IS_IPHONE (([[[UIDevice currentDevice] model] isEqualToString:@"iPhone"]) || ([[[UIDevice currentDevice] model] isEqualToString: @"iPhone Simulator"]))
#define IS_IPOD   ([[[UIDevice currentDevice]model] isEqualToString:@"iPod touch"])
#define IS_IPHONE_5 ((IS_IPHONE || IS_IPOD) && IS_WIDESCREEN)

#define R_size CGSizeMake(320, MAXFLOAT)
#define Append(x,y) [x stringByAppendingString:y]
#define _trim(x) [x stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]
#define Destroy(x)  if(x!=nil){if([x respondsToSelector:@selector(retainCount)] && [x retainCount]>0){[x release];}x=nil;}

#define DestroyMutableArray(x){if(x!=nil){if([x count]>0){[x removeAllObjects];}Destroy(x) }}
#define _trim(x) [x stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]
#define _enc(x)  [_trim(x) stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]
#define LoadXIB(object,class,xibname)  if(UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad) object =[[class alloc]initWithNibName:xibname bundle:nil];else object =[[class alloc]init];

#define ASSET_BY_SCREEN_HEIGHT(regular, longScreen) (([[UIScreen mainScreen] bounds].size.height <= 480.0) ? regular : longScreen)

#define GetImage(reqular,longScreen,extension) [UIImage imageNamed:Append( ASSET_BY_SCREEN_HEIGHT(reqular, longScreen), extension)]

#define GetAutoImage(reqular,extension) [UIImage imageNamed:Append( ASSET_BY_SCREEN_HEIGHT(reqular,Append(reqular, @"-568h@2x") ), extension)];

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define _rq(x)[x stringByReplacingOccurrencesOfString:@"\"" withString:@""]
#define _rn(x)[_rq(x) stringByReplacingOccurrencesOfString:@"\n" withString:@""]

#define WSset  [NSCharacterSet whitespaceAndNewlineCharacterSet]
#define trim(x) [x stringByTrimmingCharactersInSet:WSset]
#define SetInt(x) [NSString stringWithFormat:@"%d",x]
#define Set5Float(x) [NSString stringWithFormat:@"%0.5f",x]
#define SetFloat(x) [NSString stringWithFormat:@"%0.2f",x]
#define SetSingleFloat(x) [NSString stringWithFormat:@"%0.1f",x]
#define SetMiles(x) [NSString stringWithFormat:@"%0.1f Miles ",x]
#define SetPrice(x) [NSString stringWithFormat:@"€%0.2f",x]
#define SetSavedPrice(x) [NSString stringWithFormat:@"SAVE $%0.2f",x]
#define SetString(x) [NSString stringWithFormat:@"%@",x];
#define SetTableText(x) [NSString stringWithFormat:@"   %@",x];
#define SetSubTableText(x) [NSString stringWithFormat:@"    %@",x];
#define SetImage(x) [UIImage imageNamed:x]
#define GetImageName(x) [NSString stringWithFormat:@"%d.png",x]
#define GetImageNameS(x) [NSString stringWithFormat:@"%@.png",x]
#define _F2S(x)  NSStringFromCGRect(x)
#define _SZ2S(x) NSStringFromCGSize(x)
#define PrintFrame(x)  NSLog(@"%@",NSStringFromCGRect(x));
#define RGB(x) x/255.0f
#define BLUE_COLOR [UIColor colorWithRed:0 green:RGB(134) blue:RGB(227) alpha:1]
#define GRAY_COLOR [UIColor colorWithRed:RGB(77) green:RGB(77) blue:RGB(77) alpha:1]
#define DQ_  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
#define _DQ });
#define MQ_ dispatch_async( dispatch_get_main_queue(), ^(void) {
#define _MQ });
#define _set(x) x=nil;
#define _reset(x) x=0;
#define _PRC(x)  NSLog(@"%d",[x retainCount]);

#define MAIN_FRAME [[UIScreen mainScreen]bounds]
#define SCREEN_WIDTH [[UIScreen mainScreen]bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen]bounds].size.height

#define _dec(x) [x stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]


#define ALPHANUMERICSYMBOLS @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890.&_-*@!()<>&$#%^*+=/?'\";:\\~`¥£€[]{}| "
#define DATEFORMAT @"0123456789/"
#define ALPHANUMERIC @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_.@-!*() "
#define ALPHA	@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz.&_ "
#define ALPHA1	@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
#define PHONENUMBER	@"0123456789+()- "
#define ZIPCODE @"1234567890 "
#define EMAIL @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_.@-"
#define NUMERIC @"1234567890"
#define RATE @"1234567890."
#define PARTNUMBER @"1234567890.,-()*&%#!@"
#define PASSWORD @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890._-*@!()"
#define SCREENNAME @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 "



#define yPush(x) [self.navigationController pushViewController:x animated:YES];
#define yPop()  [self.navigationController popViewControllerAnimated:YES];
#define having(x,y) x && [x respondsToSelector:@selector(y)]
#define _center(frame)  CGPointMake(frame.size.width/2, frame.size.height/2)
#define _centerY(point,frame)  CGPointMake(point.x, frame.size.height/2)
#define _centerX(point,frame)  CGPointMake(frame.size.width/2, point.y)
#define validStr(strValue)  strValue!=nil && ![strValue isKindOfClass:[NSNull class]] && strValue.length>0


#define RUN_MAIN(x,y,z) [x performSelectorOnMainThread:@selector(y) withObject:z waitUntilDone:YES];

#define RUN_BKG(x,y,z) [x performSelectorInBackground:@selector(y) withObject:z];

#define TITLE_COLOR [UIColor colorWithRed:RGB(77) green:RGB(77) blue:RGB(77) alpha:1]

static NSString * _sty(NSString *x)
{
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
        return x;
    else return Append(x,@"-iPad");
    
}


#endif
