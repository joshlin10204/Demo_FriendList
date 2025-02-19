//
//  DemoViewModel.h
//  Demo_FriendList
//
//  Created by Josh on 2025/2/18.
//

#import <Foundation/Foundation.h>
#import "DemoModel.h"


@interface DemoViewModel : NSObject

+ (instancetype)sharedInstance; 

@property (nonatomic, assign) DemoType currentDemoType;

@end

