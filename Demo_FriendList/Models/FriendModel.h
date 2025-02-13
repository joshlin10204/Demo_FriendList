//
//  FriendModel.h
//  Demo_FriendList
//
//  Created by Josh on 2025/2/10.
//

#import <Foundation/Foundation.h>


@interface FriendModel : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, assign) BOOL isTop;
@property (nonatomic, strong) NSString *fid;
@property (nonatomic, strong) NSString *updateDate;

@end

