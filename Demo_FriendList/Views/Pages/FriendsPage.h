//
//  FriendListViewController.h
//  Demo_FriendList
//
//  Created by Josh on 2025/2/10.
//

#import <UIKit/UIKit.h>
typedef enum{
    DemoTypeNoFriend = 0,  // 0
    DemoTypeHasFriend  = 1,  // 1
    DemoTypeInviteFriend  = 2,  // 2
}DemoType;

@interface FriendsPage : UIViewController

+(FriendsPage*) initFriendsPageWithDemoType:(DemoType)type;

@end

