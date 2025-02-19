//
//  FriendPageViewController.m
//  Demo_FriendList
//
//  Created by Josh on 2025/2/11.
//

#import "FriendPageViewController.h"
#import "FriendListViewController.h"
#import "ChatListViewController.h"
#import "FriendsViewModel.h"


@interface FriendPageViewController ()<InviteListViewControllerDelegate,CustomSegmentedViewDelegate>
@property (nonatomic, strong) FriendsViewModel *friendsViewModel;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

@property (nonatomic, strong) FriendListViewController * friendListViewController;
@property (nonatomic, strong) ChatListViewController * chatListViewController;
@property (nonatomic, strong) NSMutableArray *pagesViewControllersArray;

@property (nonatomic, strong) NSArray *friendsList;
@property (nonatomic, strong) NSArray *inviteList;

@property (nonatomic, assign) NSInteger friendsBadgeCount;


@end

@implementation FriendPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.friendsBadgeCount = 0;
    self.demoType = [DemoViewModel sharedInstance].currentDemoType;
    [self fetchFriendListDate];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initActivityIndicatorView];


}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    [self fetchFriendListDate];

}

#pragma mark - Load Data

- (void)fetchFriendListDate{
    self.friendsViewModel = [[FriendsViewModel alloc]init];
    [self.friendsViewModel fetchFriendsDataWithDemoType:self.demoType withSuccess:^(NSArray *friendsList,NSArray*inviteList) {
        self.friendsList = friendsList;
        self.inviteList = inviteList;
        [self reloadData];

    } withFail:^{
        self.friendsList = @[];
        self.inviteList = @[];
        [self reloadData];

    }];
}

- (void)reloadData{
    dispatch_async(dispatch_get_main_queue(), ^() {
        [self.activityIndicator stopAnimating];
        [self initInviteListViewController];
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
    if(self.activityIndicator == nil){
        self.activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(x,y,width,height)];
        [self.activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleLarge];
        [self.activityIndicator startAnimating];
        [self.view addSubview:self.activityIndicator];
    }else{
        self.activityIndicator.frame = CGRectMake(x,y,width,height);
    }
    
    
}

- (void) initInviteListViewController{
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.inviteList.count == 0 ?0: InviteTableViewCellHeight;
    CGFloat x = 0;
    CGFloat y = 0;
    self.inviteListViewController = [InviteListViewController initInviteListViewControllerWithInvitelList:self.inviteList];
    self.inviteListViewController.view.frame = CGRectMake(x, y, width, height);
    self.inviteListViewController.delegate = self;
    [self addChildViewController:self.inviteListViewController];
    [self.view addSubview:self.inviteListViewController.view];
    [self.inviteListViewController didMoveToParentViewController:self];
}


- (void) initHeaderSegmentController{
    
    CGFloat x = 0;
    CGFloat y = self.inviteListViewController.view.frame.size.height+15;
    CGFloat width = self.view.frame.size.width*0.35;
    CGFloat height = width *0.3;
    self.headerSegmentView = [[CustomSegmentedView alloc]initWithFrame:CGRectMake(x, y, width,height)];
    self.headerSegmentView.delegate = self;
    self.friendsBadgeCount = [self.friendsViewModel  getFriendBadgeCount:self.friendsList];
    [self.headerSegmentView updatFriendBadge:self.friendsBadgeCount withChatBadge:100];
    
    [self.view addSubview:self.headerSegmentView];
    
}

- (void) initPageViewController{
    
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height - self.headerSegmentView.frame.size.height - self.inviteListViewController.view.frame.size.height;
    CGFloat x = 0;
    CGFloat y = self.headerSegmentView.frame.origin.y + self.headerSegmentView.frame.size.height;
    self.pagesViewControllersArray = [NSMutableArray arrayWithCapacity:1];
    self.friendListViewController = [FriendListViewController initFriendListViewControllerWithFriendsList:self.friendsList];
    self.chatListViewController = [[ChatListViewController alloc]init];
    [self.pagesViewControllersArray addObject:self.friendListViewController];
    [self.pagesViewControllersArray addObject:self.chatListViewController];

    NSDictionary *options = @{UIPageViewControllerOptionSpineLocationKey : @(UIPageViewControllerSpineLocationMin)};
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:options];

    self.pageViewController.view.frame = CGRectMake(x,y , width,height);
    [self.pageViewController setViewControllers: @[self.pagesViewControllersArray.firstObject] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    [self addChildViewController:self.pageViewController];

    [self.view addSubview:self.pageViewController.view];
}



- (void)didSelectSegmentAtIndex:(NSInteger)index{
    [self.pageViewController setViewControllers:@[self.pagesViewControllersArray[index]]
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:NO
                                     completion:nil];
    
}


#pragma mark - InviteListViewControllerDelegate

- (void) didExpandTableView:(BOOL)isExpand{
    dispatch_async(dispatch_get_main_queue(), ^() {
        
        CGFloat expandHight = self.inviteList.count >3? InviteTableViewCellHeight*3 :InviteTableViewCellHeight* self.inviteList.count;
        CGFloat inviteListViewHeight = isExpand? expandHight : InviteTableViewCellHeight;
        
        
        
        
        [UIView animateWithDuration:0.2 animations:^{
            self.inviteListViewController.view.frame = CGRectMake(self.inviteListViewController.view.frame.origin.x,
                                                                  self.inviteListViewController.view.frame.origin.y,
                                                                  self.inviteListViewController.view.frame.size.width,
                                                                  inviteListViewHeight);
            
            self.headerSegmentView.frame = CGRectMake(self.headerSegmentView.frame.origin.x,
                                                      self.inviteListViewController.view.frame.size.height+15,
                                                     self.headerSegmentView.frame.size.width,
                                                     self.headerSegmentView.frame.size.height);
            
            self.pageViewController.view.frame = CGRectMake(self.pageViewController.view.frame.origin.x,
                                                            self.headerSegmentView.frame.origin.y + self.headerSegmentView.frame.size.height,
                                                            self.pageViewController.view.frame.size.width,
                                                            self.view.frame.size.height - self.headerSegmentView.frame.size.height - self.inviteListViewController.view.frame.size.height);

        }];

        

    });
}
@end
