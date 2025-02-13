//
//  FriendListViewController.h
//  Demo_FriendList
//
//  Created by Josh on 2025/2/10.
//

#import <UIKit/UIKit.h>
#import "DemoModel.h"


@interface FriendsPage : UIViewController

+(FriendsPage*) initFriendsPageWithDemoType:(DemoType)type;
@property (nonatomic, assign) DemoType  demoType;

@end

