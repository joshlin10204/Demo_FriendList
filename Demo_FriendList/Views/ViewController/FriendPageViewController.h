//
//  FriendPageViewController.h
//  Demo_FriendList
//
//  Created by Josh on 2025/2/11.
//

#import <UIKit/UIKit.h>
#import "DemoModel.h"

@interface FriendPageViewController : UIViewController
+(FriendPageViewController*) initFriendPageViewControllerWithDemoType:(DemoType)type;
@property (nonatomic, assign) DemoType  demoType;

@end

