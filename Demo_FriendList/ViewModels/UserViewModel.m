//
//  UserViewModel.m
//  Demo_FriendList
//
//  Created by Josh on 2025/2/10.
//

#import "UserViewModel.h"
#import "NetworkingManager.h"

#define UserInfoURL @"https://dimanyen.github.io/man.json"


@implementation UserViewModel



- (void)fetchUserDataWithSuccess:(void (^)(void))success withFail:(void (^)(void))fail{

    
    NetworkingManager *manager = [[NetworkingManager alloc]init];
    [manager connectWithUrl:UserInfoURL withHTTPType:GET parameter:nil success:^(id responseObject) {
        NSDictionary *response = (NSDictionary*)responseObject[@"response"][0];
        self.userInfo = [[UserModel alloc]init];
        self.userInfo.name = response[@"name"];
        self.userInfo.kokoid = response[@"kokoid"];
        success();
    } fail:^(NSError *error) {
        fail();
    }];
}

@end
