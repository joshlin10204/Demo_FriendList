//
//  InviteListViewController.h
//  Demo_FriendList
//
//  Created by Josh on 2025/2/11.
//

#import <UIKit/UIKit.h>
#import "InviteTableViewCell.h"
#import "FriendsViewModel.h"


@protocol InviteListViewControllerDelegate<NSObject>
//@optional
@required
- (void) didExpandTableView:(BOOL)isExpand;
@end


@interface InviteListViewController : UIViewController

+(InviteListViewController*) initInviteListViewControllerWithInvitelList:(NSArray<FriendModel*>*)list;
@property(nonatomic, weak) id<InviteListViewControllerDelegate> delegate;

@end

