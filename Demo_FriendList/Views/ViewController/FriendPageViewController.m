//
//  FriendPageViewController.m
//  Demo_FriendList
//
//  Created by Josh on 2025/2/11.
//

#import "FriendPageViewController.h"
#import "CustomSegmentedView.h"
#import "FriendListViewController.h"
#import "ChatListViewController.h"


@interface FriendPageViewController ()<CustomSegmentedViewDelegate>
@property (nonatomic, strong) CustomSegmentedView *headerSegmentView;
@property (nonatomic, strong) UIPageViewController * pageViewController;
@property (nonatomic, strong) FriendListViewController * friendListViewController;
@property (nonatomic, strong) ChatListViewController * chatListViewController;
@property (nonatomic, strong) NSMutableArray *pagesViewControllersArray;


@end

@implementation FriendPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self initHeaderSegmentController];
    [self initPageViewController];
    
}

- (void) initHeaderSegmentController{
    

    CGFloat width = self.view.frame.size.width*0.3;
    CGFloat height = width *0.3;
    self.headerSegmentView = [[CustomSegmentedView alloc]initWithFrame:CGRectMake(0, 0, width,height)];
    self.headerSegmentView.delegate = self;

    [self.view addSubview:self.headerSegmentView];
}
- (void)didSelectSegmentAtIndex:(NSInteger)index{
    [self.pageViewController setViewControllers:@[self.pagesViewControllersArray[index]]
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:NO
                                     completion:nil];
    
}
- (void) initPageViewController{
    
    self.pagesViewControllersArray = [NSMutableArray arrayWithCapacity:1];
    self.friendListViewController = [[FriendListViewController alloc]init];
    self.chatListViewController = [[ChatListViewController alloc]init];
    [self.pagesViewControllersArray addObject:self.friendListViewController];
    [self.pagesViewControllersArray addObject:self.chatListViewController];

    NSDictionary *options = @{UIPageViewControllerOptionSpineLocationKey : @(UIPageViewControllerSpineLocationMin)};
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:options];

    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height - self.headerSegmentView.frame.size.height;
    self.pageViewController.view.frame = CGRectMake(0, self.headerSegmentView.frame.size.height, width,height);
    [self.pageViewController setViewControllers: @[self.pagesViewControllersArray.firstObject] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    [self addChildViewController:self.pageViewController];

    [self.view addSubview:self.pageViewController.view];
}


- (void) initFriendListViewController{
    
    
}
- (void) initChatListViewController{}



@end
