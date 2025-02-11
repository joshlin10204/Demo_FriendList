//
//  FriendsViewModel.m
//  Demo_FriendList
//
//  Created by Josh on 2025/2/10.
//

#import "FriendsViewModel.h"
#import "NetworkingManager.h"

#define FriendList1URL @"https://dimanyen.github.io/friend1.json"
#define FriendList2URL @"https://dimanyen.github.io/friend2.json"

@implementation FriendsViewModel


- (void)fetchFriendsDataWithSuccess:(void (^)(void))success withFail:(void (^)(void))fail{

    
    NetworkingManager *manager = [[NetworkingManager alloc]init];
    [manager connectWithUrl:FriendList1URL withHTTPType:GET parameter:nil success:^(id responseObject) {
        success();
    } fail:^(NSError *error) {
        fail();
    }];
}

@end
