//
//  SubFriendListViewController.m
//  Demo_FriendList
//
//  Created by Josh on 2025/2/11.
//

#import "FriendListViewController.h"
#import "FriendTableViewCell.h"
#import "SearchTextFieldView.h"
#import "FriendListEmptyView.h"


#define SearchTextFieldViewHeight 36
#define SearchTextFieldViewPositionY 15

@interface FriendListViewController ()<SearchTextFieldViewDelegate,UITableViewDelegate, UITableViewDataSource>{
    
    BOOL isOnSearching;
}

@property (nonatomic, strong) SearchTextFieldView *searchTextFieldView;
@property (nonatomic, strong) FriendListEmptyView *friendListEmptyView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) NSArray<FriendModel*> *friendsArray;
@property (nonatomic, assign) DemoType  demoType;
@property (nonatomic, strong) NSMutableArray<FriendModel*> *showFriendsArray;
@property (nonatomic, strong) FriendsViewModel *friendsViewModel;


@end

@implementation FriendListViewController


+(FriendListViewController*) initFriendListViewControllerWithDemoType:(DemoType)type withFriendsList:(NSArray<FriendModel*>*)list{
    
    FriendListViewController *friendListViewController  = [[FriendListViewController alloc]init];
    friendListViewController.demoType =  type;
    friendListViewController.friendsArray = list;
    friendListViewController.showFriendsArray = [list mutableCopy];
    return  friendListViewController;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    isOnSearching = NO;
    if(self.friendsArray.count ==0){
        [self initEmptyFriendView];
    }else{
        [self initSearchTextFieldView];
        [self initFriendListTableView];
        [self initRefreshControl];
    }
}

- (void)viewWillLayoutSubviews{
    [super viewDidLayoutSubviews];
    if(self.friendsArray.count ==0){
        [self updateEmptyFriendView];
    }else{
        [self updateSearchTextFieldView];
        [self updateFriendListTableView];
    }
    




}

#pragma mark - Init

- (void)initSearchTextFieldView{
    CGFloat width = self.view.frame.size.width;
    CGFloat height = SearchTextFieldViewHeight;
    CGFloat x = 0;
    CGFloat y = SearchTextFieldViewPositionY;
    self.searchTextFieldView = [[SearchTextFieldView alloc]initWithFrame:CGRectMake(x, y, width, height)];
    self.searchTextFieldView.delegate = self;
    [self.view addSubview:self.searchTextFieldView];
}


- (void)initFriendListTableView{
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height - SearchTextFieldViewHeight - SearchTextFieldViewPositionY -10;
    CGFloat x = 0;
    CGFloat y = SearchTextFieldViewHeight+SearchTextFieldViewPositionY+10;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(x, y, width, height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[FriendTableViewCell class] forCellReuseIdentifier:@"FriendCell"];
    self.tableView.canCancelContentTouches = NO;

    [self.view addSubview:self.tableView];
}

- (void)initRefreshControl{
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshFriendListDate) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
}

- (void) initEmptyFriendView{
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    CGFloat x = 0;
    CGFloat y = 0;
    self.friendListEmptyView = [[FriendListEmptyView alloc]initWithFrame:CGRectMake(x, y, width, height)];
    [self.view addSubview:self.friendListEmptyView];
    
}

#pragma mark - Update Frame

- (void)updateSearchTextFieldView{
    CGFloat width = self.view.frame.size.width;
    CGFloat height = SearchTextFieldViewHeight;
    CGFloat x = 0;
    CGFloat y = SearchTextFieldViewPositionY;
    self.searchTextFieldView.frame = CGRectMake(x, y, width, height);
}


- (void)updateFriendListTableView{
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height - SearchTextFieldViewHeight - SearchTextFieldViewPositionY -10;
    CGFloat x = 0;
    CGFloat y = SearchTextFieldViewHeight+SearchTextFieldViewPositionY+10;
    
    self.tableView.frame = CGRectMake(x, y, width, height) ;
    [self.tableView reloadData];
    
}


- (void) updateEmptyFriendView{
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    CGFloat x = 0;
    CGFloat y = 0;
    self.friendListEmptyView.frame = CGRectMake(x, y, width, height);

    
}
#pragma mark - SearchTextField Delegate

- (void) didSearchText:(NSString*)text{
    
    if(text.length ==0){
        self.showFriendsArray = [self.friendsArray mutableCopy];
    }else{
        
        FriendsViewModel *viewModel = [[FriendsViewModel alloc]init];
        self.showFriendsArray = [[viewModel searchFriendWithSearchString:text withFriendsList:self.friendsArray]mutableCopy];
    }
    [self.tableView reloadData];    
    NSLog(@"%@",text);
}
- (void) textFieldDidBeginEditing:(UITextField*)textField{
    NSLog(@"textFieldDidBeginEditing");
    isOnSearching = YES;

}
- (void) textFieldDidEndEditing:(UITextField*)textField{
    NSLog(@"textFieldDidEndEditing");
    isOnSearching = NO;


}

#pragma mark - TableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return FriendTableViewCellHeight;
}

// 設定 TableView 有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.showFriendsArray.count;
}

// 設定 Cell 內容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FriendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendCell" forIndexPath:indexPath];

    FriendModel *friendModel = self.showFriendsArray[indexPath.row];
    [cell configureWithFriendModel:friendModel];

    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO; // 禁止左滑編輯（刪除）
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES; // 允許 TableView 與 ScrollView 同時處理手勢
}

#pragma mark - UIRefreshControl


- (void)refreshFriendListDate{
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//    });
    
    if(isOnSearching){
        [self.refreshControl endRefreshing];
        return;
    }
    self.friendsViewModel = [[FriendsViewModel alloc]init];
    [self.friendsViewModel fetchFriendsDataWithDemoType:self.demoType withSuccess:^(NSArray *friendsList,NSArray*inviteList) {
        self.friendsArray = friendsList;
        self.showFriendsArray = [friendsList mutableCopy];
        [self reloadData];
    } withFail:^{

        [self reloadData];
    }];

}

- (void)reloadData{
    dispatch_async(dispatch_get_main_queue(), ^() {
        
        [self.refreshControl endRefreshing];

    });
    
}


@end
