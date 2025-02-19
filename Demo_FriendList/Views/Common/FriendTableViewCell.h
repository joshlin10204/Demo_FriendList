//
//  FriendTableViewCell.h
//  Demo_FriendList
//
//  Created by Josh on 2025/2/12.
//

#import <UIKit/UIKit.h>
#import "FriendModel.h"

#define FriendTableViewCellHeight 60.0

@interface FriendTableViewCell : UITableViewCell


- (void)configureWithFriendModel:(FriendModel *)model;
@end

