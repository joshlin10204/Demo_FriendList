//
//  DemoViewModel.m
//  Demo_FriendList
//
//  Created by Josh on 2025/2/18.
//

#import "DemoViewModel.h"

@implementation DemoViewModel
+ (instancetype)sharedInstance{
    
    static DemoViewModel *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
        sharedInstance.currentDemoType = DemoTypeNoFriend; // 預設狀態
    });
    return sharedInstance;
    
}
@end
