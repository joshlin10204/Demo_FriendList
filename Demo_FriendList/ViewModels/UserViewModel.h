//
//  UserViewModel.h
//  Demo_FriendList
//
//  Created by Josh on 2025/2/10.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"



@interface UserViewModel : NSObject
@property (nonatomic, strong) UserModel *userInfo;

- (void)fetchUserDataWithSuccess:(void (^)(void))success withFail:(void (^)(void))fail;

@end

