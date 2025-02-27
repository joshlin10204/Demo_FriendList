//
//  FriendPageViewController.h
//  Demo_FriendList
//
//  Created by Josh on 2025/2/11.
//

#import <UIKit/UIKit.h>
#import "DemoViewModel.h"
#import "InviteListViewController.h"
#import "CustomSegmentedView.h"

@interface FriendPageViewController : UIViewController
@property (nonatomic, assign) DemoType  demoType;
@property (nonatomic, strong) InviteListViewController * inviteListViewController;
@property (nonatomic, strong) CustomSegmentedView *headerSegmentView;
@property (nonatomic, strong) UIPageViewController * pageViewController;
@end

