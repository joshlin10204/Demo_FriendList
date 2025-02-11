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

#import "FriendsViewModel.h"
#import "UserViewModel.h"


#define UserInfoViewHeight self.view.frame.size.height*0.12
#define InviteListViewHeight self.view.frame.size.height*0.3
#define SubFriendListViewHeight self.view.frame.size.height*0.85


@interface FriendsPage (){

    FriendsViewModel *_friendsViewModel;
    UserViewModel *_userViewModel;
}
@property (nonatomic, strong) UIScrollView  *scrollView;
@property (nonatomic, strong) UserInfoViewController * userInfoViewController;
@property (nonatomic, strong) InviteListViewController * inviteListViewController;
@property (nonatomic, strong) FriendPageViewController * friendPageViewController;

@end

@implementation FriendsPage


+(FriendsPage*) initFriendsPageWithDemoType:(DemoType)type{
    
    FriendsPage *friendsPage  = [[FriendsPage alloc]init];
    NSLog(@"%u",type);

    return  friendsPage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self initNavigationBarItem];
    [self initScrollView];
    [self initUserInfoViewController];
    [self initSubFriendListViewController];


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
    
    CGFloat width = self.view.frame.size.width*0.9;
    CGFloat x = self.view.center.x - width*0.5;
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(x, 0, width, self.view.frame.size.height)];
    self.scrollView.contentSize = CGSizeMake(self.scrollView.contentSize.width,self.scrollView.frame.size.height);
    [self.scrollView setShowsHorizontalScrollIndicator:NO];
    [self.scrollView setShowsVerticalScrollIndicator:NO];//
//    self.scrollView.contentSize = self.view.frame.size;
    [self.view addSubview:self.scrollView];
}

- (void) initUserInfoViewController{
    
//    CGFloat navBarHeight = self.navigationController.navigationBar.frame.size.height;
//    CGFloat statusBarHeight = UIApplication.sharedApplication.statusBarFrame.size.height;
//    CGFloat topPadding = navBarHeight + statusBarHeight;
    self.userInfoViewController = [[UserInfoViewController alloc]init];
    self.userInfoViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width*0.9, UserInfoViewHeight);
    [self addChildViewController:self.userInfoViewController];
    [self.scrollView addSubview:self.userInfoViewController.view];

    [self.userInfoViewController didMoveToParentViewController:self];
}

- (void) initInviteListViewController{
    CGFloat y = UserInfoViewHeight;

    self.inviteListViewController = [[InviteListViewController alloc]init];
    self.inviteListViewController.view.frame = CGRectMake(0, y, self.view.frame.size.width*0.9, InviteListViewHeight);
    [self addChildViewController:self.inviteListViewController];
    [self.scrollView addSubview:self.inviteListViewController.view];
    [self.inviteListViewController didMoveToParentViewController:self];
}

- (void) initSubFriendListViewController{
//    CGFloat y = UserInfoViewHeight + InviteListViewHeight;
    CGFloat y = UserInfoViewHeight;

    self.friendPageViewController = [[FriendPageViewController alloc]init];
    self.friendPageViewController.view.frame = CGRectMake(0, y, self.view.frame.size.width*0.9, SubFriendListViewHeight);
    [self addChildViewController:self.friendPageViewController];
    [self.scrollView addSubview:self.friendPageViewController.view];
    [self.friendPageViewController didMoveToParentViewController:self];
}




- (void)reloadFriendListDate{
    _friendsViewModel = [[FriendsViewModel alloc]init];
    [_friendsViewModel fetchFriendsDataWithSuccess:^{
        
    } withFail:^{
        
    }];

}


@end
