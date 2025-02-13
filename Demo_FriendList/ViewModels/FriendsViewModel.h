//
//  FriendsViewModel.h
//  Demo_FriendList
//
//  Created by Josh on 2025/2/10.
//

#import <Foundation/Foundation.h>
#import "FriendModel.h"
#import "DemoModel.h"


@interface FriendsViewModel : NSObject
@property (nonatomic, strong) NSArray *friendsArrary;
- (void)fetchFriendsDataWithDemoType:(DemoType) type withSuccess:(void (^)(NSArray *friendsList))success withFail:(void (^)(void))fail;

- (NSArray*)searchFriendWithSearchString:(NSString*)searchString withFriendsList:(NSArray*) friendsList;

@end
