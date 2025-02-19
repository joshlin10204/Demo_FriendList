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

#define FriendListWithInviteURL @"https://dimanyen.github.io/friend3.json"
#define FriendListEmptyURL @"https://dimanyen.github.io/friend4.json"

@implementation FriendsViewModel


- (void)fetchFriendsDataWithDemoType:(DemoType) type withSuccess:(void (^)(NSArray *friendsList,NSArray *inviteList))success withFail:(void (^)(void))fail{

    
    NSString *url = @"";
    NSMutableArray *urls = [[NSMutableArray alloc]init];

    
    switch (type) {
        case DemoTypeNoFriend:
            [urls addObject:FriendListEmptyURL];
            break;
        case DemoTypeHasFriend:
            url = FriendList1URL;
            [urls addObject:FriendList1URL];
            [urls addObject:FriendList2URL];
            break;
        case DemoTypeInviteFriend:
            [urls addObject:FriendListWithInviteURL];

            break;
        default:
            break;
    }
    dispatch_group_t group = dispatch_group_create();
    NetworkingManager *manager = [[NetworkingManager alloc]init];
    NSMutableDictionary<NSString *, FriendModel *> *friendDict = [NSMutableDictionary dictionary];
    for (NSString *url in urls) {
            dispatch_group_enter(group);
            [manager connectWithUrl:url withHTTPType:GET parameter:nil success:^(id responseObject) {
                
                NSArray *responseList = (NSArray*)responseObject[@"response"];
                for (NSDictionary *info in responseList) {
                    NSString *fid = info[@"fid"] ?: @"";
                    NSString *updateDate = [info[@"updateDate"] stringByReplacingOccurrencesOfString:@"/" withString:@""]?:@"";
                    
                    FriendModel *model = [[FriendModel alloc] init];
                    model.fid = fid;
                    model.isTop = [info[@"isTop"] isEqual:@"0"] ? NO : YES;
                    model.name = info[@"name"] ?: @"";
                    model.status = info[@"status"] ?: 0;
                    model.updateDate = updateDate;
                    
                    FriendModel *existingModel = friendDict[fid];
                    if (!existingModel || [updateDate compare:existingModel.updateDate options:NSNumericSearch] == NSOrderedDescending) {
                        friendDict[fid] = model;
                    }
                }
                
                dispatch_group_leave(group);
                
            } fail:^(NSError *error) {
                dispatch_group_leave(group);
            }];
        }

        // 當所有請求都完成時
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        
            if (friendDict.count > 0) {
                NSArray *finalList = [friendDict allValues];
                NSArray *friendList = [self getFriendsList:finalList];
                NSArray *inviteList = [self getInviteList:finalList];
                success(friendList,inviteList);
            } else {
                fail();
            }
        });
}

- (NSArray*)searchFriendWithSearchString:(NSString*)searchString withFriendsList:(NSArray*) friendsList{
    if (searchString.length == 0) {
        return @[]; // 若關鍵字為空，回傳全部好友
    }
    NSMutableArray *searchList = [[NSMutableArray alloc]init];
    
    for(FriendModel *model in friendsList){
        
        if ([model.name rangeOfString:searchString options:NSCaseInsensitiveSearch].location != NSNotFound) {
            [searchList addObject:model];
        }
    }
    return [searchList copy];
    
}


- (NSArray *)getFriendsList:(NSArray*)list{
    
    NSMutableArray *friendsList = [[NSMutableArray alloc]init];
    for(FriendModel *model in list){
        
        if([model.status intValue] != 0 ){
            [friendsList addObject:model];
            
        }
        
    }
    return  [friendsList mutableCopy];
}

- (NSArray *)getInviteList:(NSArray*)list{
    
    NSMutableArray *inviteList = [[NSMutableArray alloc]init];
    for(FriendModel *model in list){
        
        if([model.status intValue] == 0 ){
            [inviteList addObject:model];
            
        }
        
    }
    return  [inviteList mutableCopy];
}

- (NSInteger)getFriendBadgeCount:(NSArray*) friendsList{
    
    NSInteger count = 0;
    for(FriendModel *model in friendsList){
        if([model.status intValue] == 2){
            count+=1;
        }
    }
    return  count;
}

@end
