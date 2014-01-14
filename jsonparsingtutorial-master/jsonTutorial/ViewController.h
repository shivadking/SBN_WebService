//
//  ViewController.h
//  jsonTutorial
//
//  Created by iffytheperfect on 9/27/12.
//  Copyright (c) 2012 iffytheperfect. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, NSURLConnectionDataDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

- (IBAction)getTop10Button:(id)sender;

@end
