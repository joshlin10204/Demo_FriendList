//
//  FriendsViewModel.h
//  Demo_FriendList
//
//  Created by Josh on 2025/2/10.
//

#import <Foundation/Foundation.h>
#import "FriendModel.h"


@interface FriendsViewModel : NSObject
@property (nonatomic, strong) NSArray *friendsArrary;
- (void)fetchFriendsDataWithSuccess:(void (^)(void))success withFail:(void (^)(void))fail;
@end
