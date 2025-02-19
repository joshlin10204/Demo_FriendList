//
//  FriendListViewController.m
//  Demo_FriendList
//
//  Created by Josh on 2025/2/10.
//

#import "FriendsPage.h"
#import "UserInfoViewController.h"
#import "FriendPageViewController.h"


@interface FriendsPage ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView  *scrollView;
@property (nonatomic, strong) UserInfoViewController * userInfoViewController;
@property (nonatomic, strong) FriendPageViewController * friendPageViewController;
@property (nonatomic, strong) UITapGestureRecognizer * hideKeyboardTap;

@end

@implementation FriendsPage


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.barTintColor = [UIColor whiteColor];
    self.tabBarController.tabBar.translucent = NO;
    self.tabBarController.tabBar.shadowImage = [UIImage new];
    self.tabBarController.tabBar.backgroundImage =  [UIImage new];
//    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];


}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self initScrollView];
    [self initUserInfoViewController];
    [self initFriendPageViewController];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - Keyboard NSNotificationCenter

- (void)keyboardWillShow:(NSNotification *)notification {
//    CGFloat y = self.scrollView.frame.size.height*0.15;
    CGFloat y = self.userInfoViewController.view.frame.size.height + self.friendPageViewController.inviteListViewController.view.frame.size.height + self.friendPageViewController.headerSegmentView.frame.size.height+15;

    [self.scrollView setContentOffset:CGPointMake(0, y)];
    
    self.hideKeyboardTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:self.hideKeyboardTap];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    [self.scrollView setContentOffset:CGPointMake(0, 0)];
    [self.view removeGestureRecognizer:self.hideKeyboardTap];

}
- (void)dismissKeyboard {
    [self.view endEditing:YES];
}

#pragma mark - Init

- (void)initScrollView{
    CGFloat navBarHeight = self.navigationController.navigationBar.frame.size.height;
    CGFloat statusBarHeight = 0;
    CGFloat tabBarHeight = self.tabBarController.tabBar.frame.size.height;
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
    
    if(self.scrollView == nil){
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        self.scrollView.delegate = self;
        [self.scrollView setScrollEnabled:NO];
        self.scrollView.contentSize = CGSizeMake(self.scrollView.contentSize.width,height);
        [self.scrollView setShowsHorizontalScrollIndicator:NO];
        [self.scrollView setShowsVerticalScrollIndicator:NO];
        self.scrollView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:self.scrollView];
    }else{
        self.scrollView.frame = CGRectMake(x, y, width, height);
        self.scrollView.contentSize = CGSizeMake(self.scrollView.contentSize.width,height);
    }

}

- (void) initUserInfoViewController{
    
    CGFloat width = self.scrollView.frame.size.width;
    CGFloat height = self.scrollView.frame.size.height*0.1;
    CGFloat x = 0;
    CGFloat y = 0;
    if(self.userInfoViewController == nil){
        self.userInfoViewController = [[UserInfoViewController alloc]init];
        self.userInfoViewController.view.frame = CGRectMake(x, y, width, height);
        [self addChildViewController:self.userInfoViewController];
        [self.scrollView addSubview:self.userInfoViewController.view];
        [self.userInfoViewController didMoveToParentViewController:self];
    }else{
        self.userInfoViewController.view.frame = CGRectMake(x, y, width, height);
    }

}


- (void) initFriendPageViewController{
    CGFloat width = self.scrollView.frame.size.width;
    CGFloat height = self.scrollView.frame.size.height*0.9;
    CGFloat x = 0;
    CGFloat y = self.userInfoViewController.view.frame.size.height;
    
    
    if(self.friendPageViewController == nil){
        self.friendPageViewController = [[FriendPageViewController alloc]init];
        self.friendPageViewController.view.frame = CGRectMake(x, y, width, height);
        [self addChildViewController:self.friendPageViewController];
        [self.scrollView addSubview:self.friendPageViewController.view];
        [self.friendPageViewController didMoveToParentViewController:self];
    }else{
        self.friendPageViewController.view.frame = CGRectMake(x, y, width, height);
    }

}









@end
