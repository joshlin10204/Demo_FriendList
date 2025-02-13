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
#import "FriendsViewModel.h"


@interface FriendPageViewController ()<CustomSegmentedViewDelegate>
@property (nonatomic, strong) FriendsViewModel *friendsViewModel;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) CustomSegmentedView *headerSegmentView;
@property (nonatomic, strong) UIPageViewController * pageViewController;
@property (nonatomic, strong) FriendListViewController * friendListViewController;
@property (nonatomic, strong) ChatListViewController * chatListViewController;
@property (nonatomic, strong) NSMutableArray *pagesViewControllersArray;

@property (nonatomic, strong) NSArray *friendsList;


@end

@implementation FriendPageViewController

+(FriendPageViewController*) initFriendPageViewControllerWithDemoType:(DemoType)type{
    
    FriendPageViewController *friendPageViewController  = [[FriendPageViewController alloc]init];
    friendPageViewController.demoType = type;
    return  friendPageViewController;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];

    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initActivityIndicatorView];
    [self fetchFriendListDate];

}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    [self fetchFriendListDate];

}

#pragma mark - Load Data

- (void)fetchFriendListDate{
    self.friendsViewModel = [[FriendsViewModel alloc]init];
    [self.friendsViewModel fetchFriendsDataWithDemoType:self.demoType withSuccess:^(NSArray *friendsList) {
        self.friendsList = friendsList;
        [self reloadData];

    } withFail:^{
        [self reloadData];

    }];
}

- (void)reloadData{
    dispatch_async(dispatch_get_main_queue(), ^() {
        [self.activityIndicator stopAnimating];
        [self initHeaderSegmentController];
        [self initPageViewController];
    });
    
}
#pragma mark - Init

- (void)initActivityIndicatorView{
    
    CGFloat width = 100;
    CGFloat height = 100;
    CGFloat x = self.view.center.x - width*0.5;
    CGFloat y = self.view.center.y - height*0.5;
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(x,y,width,height)];
    [self.activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleLarge];
//    self.activityIndicator.center = self.view.center;
    [self.activityIndicator startAnimating];
    [self.view addSubview:self.activityIndicator];
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
    
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height - self.headerSegmentView.frame.size.height;
    self.pagesViewControllersArray = [NSMutableArray arrayWithCapacity:1];
    self.friendListViewController = [FriendListViewController initFriendListViewControllerWithFriendModelList:self.friendsList];
    self.chatListViewController = [[ChatListViewController alloc]init];
    [self.pagesViewControllersArray addObject:self.friendListViewController];
    [self.pagesViewControllersArray addObject:self.chatListViewController];

    NSDictionary *options = @{UIPageViewControllerOptionSpineLocationKey : @(UIPageViewControllerSpineLocationMin)};
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:options];

    self.pageViewController.view.frame = CGRectMake(0, self.headerSegmentView.frame.size.height, width,height);
    [self.pageViewController setViewControllers: @[self.pagesViewControllersArray.firstObject] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    [self addChildViewController:self.pageViewController];

    [self.view addSubview:self.pageViewController.view];
}


- (void) initFriendListViewController{
    
    
}
- (void) initChatListViewController{}



@end
