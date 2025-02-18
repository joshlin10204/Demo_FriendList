//
//  InviteTableViewCell.h
//  Demo_FriendList
//
//  Created by Josh on 2025/2/18.
//

#import <UIKit/UIKit.h>
#import "FriendModel.h"
#define InviteTableViewCellHeight 70.0


@interface InviteTableViewCell : UITableViewCell
- (void)configureWithFriendModel:(FriendModel *)model;

@end


