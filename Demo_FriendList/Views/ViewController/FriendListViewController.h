//
//  SubFriendListViewController.h
//  Demo_FriendList
//
//  Created by Josh on 2025/2/11.
//

#import <UIKit/UIKit.h>
#import "FriendsViewModel.h"


@interface FriendListViewController : UIViewController

+(FriendListViewController*) initFriendListViewControllerWithDemoType:(DemoType)type withFriendsList:(NSArray<FriendModel*>*)list;
@end

