//
//  SubFriendListViewController.h
//  Demo_FriendList
//
//  Created by Josh on 2025/2/11.
//

#import <UIKit/UIKit.h>
#import "FriendModel.h"


@interface FriendListViewController : UIViewController

+(FriendListViewController*) initFriendListViewControllerWithFriendModelList:(NSArray<FriendModel *>*)list;

@end

