//
//  FriendListViewController.m
//  Demo_FriendList
//
//  Created by Josh on 2025/2/10.
//

#import "FriendsPage.h"
#import "UserInfoViewController.h"
#import "InviteListViewController.h"
#import "FriendPageViewController.h"


@interface FriendsPage ()
@property (nonatomic, strong) UIScrollView  *scrollView;
@property (nonatomic, strong) UserInfoViewController * userInfoViewController;
@property (nonatomic, strong) InviteListViewController * inviteListViewController;
@property (nonatomic, strong) FriendPageViewController * friendPageViewController;

@end

@implementation FriendsPage


+(FriendsPage*) initFriendsPageWithDemoType:(DemoType)type{
    
    FriendsPage *friendsPage  = [[FriendsPage alloc]init];
    friendsPage.demoType = type;
    return  friendsPage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self initNavigationBarItem];
    [self initScrollView];
    [self initUserInfoViewController];
    [self initFriendPageViewController];


}

- (void)initNavigationBarItem{
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icNavibarBack"] style:UIBarButtonItemStylePlain target:self action:@selector(onClickBackItem)];
    
    UIBarButtonItem *atmItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icNavPinkWithdraw"]style:UIBarButtonItemStylePlain target:self action:nil];
    UIBarButtonItem *transferItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icNavPinkTransfer"]style:UIBarButtonItemStylePlain target:self action:nil];
    UIBarButtonItem *scanItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icNavPinkScan"]style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.leftBarButtonItems = @[backButtonItem,atmItem,transferItem];
    self.navigationItem.rightBarButtonItem = scanItem;
    
}
- (void)onClickBackItem{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initScrollView{
//    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    CGFloat navBarHeight = self.navigationController.navigationBar.frame.size.height;
    CGFloat statusBarHeight = 0;

    if (@available(iOS 13.0, *)) {
        UIStatusBarManager *statusBarManager = [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager;
        statusBarHeight = statusBarManager.statusBarFrame.size.height;
    }else{
        statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    }


    CGFloat height = self.view.frame.size.height - navBarHeight - statusBarHeight;
    CGFloat width = self.view.frame.size.width*0.9;
    CGFloat x = self.view.center.x - width*0.5;
    CGFloat y = navBarHeight + statusBarHeight;

    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(x, y, width, height)];
    self.scrollView.contentSize = CGSizeMake(self.scrollView.contentSize.width,height);
    [self.scrollView setShowsHorizontalScrollIndicator:NO];
    [self.scrollView setShowsVerticalScrollIndicator:NO];//
    [self.view addSubview:self.scrollView];
}

- (void) initUserInfoViewController{
    
    CGFloat width = self.scrollView.frame.size.width;
    CGFloat height = self.scrollView.frame.size.height*0.1;
    CGFloat x = 0;
    CGFloat y = 0;
    self.userInfoViewController = [[UserInfoViewController alloc]init];
    self.userInfoViewController.view.frame = CGRectMake(x, y, width, height);
    [self addChildViewController:self.userInfoViewController];
    [self.scrollView addSubview:self.userInfoViewController.view];

    [self.userInfoViewController didMoveToParentViewController:self];
}

- (void) initFriendPageViewController{
    CGFloat width = self.scrollView.frame.size.width;
    CGFloat height = self.scrollView.frame.size.height*0.9;
    CGFloat x = 0;
    CGFloat y = self.scrollView.frame.size.height*0.1;

    self.friendPageViewController = [FriendPageViewController initFriendPageViewControllerWithDemoType:self.demoType];
    self.friendPageViewController.view.frame = CGRectMake(x, y, width, height);
    [self addChildViewController:self.friendPageViewController];
    [self.scrollView addSubview:self.friendPageViewController.view];
    [self.friendPageViewController didMoveToParentViewController:self];
}







//- (void) initInviteListViewController{
//    CGFloat y = UserInfoViewHeight;
//
//    self.inviteListViewController = [[InviteListViewController alloc]init];
//    self.inviteListViewController.view.frame = CGRectMake(0, y, self.view.frame.size.width*0.9, InviteListViewHeight);
//    [self addChildViewController:self.inviteListViewController];
//    [self.scrollView addSubview:self.inviteListViewController.view];
//    [self.inviteListViewController didMoveToParentViewController:self];
//}
//

@end
