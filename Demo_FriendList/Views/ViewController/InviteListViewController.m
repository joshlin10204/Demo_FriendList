//
//  InviteListViewController.m
//  Demo_FriendList
//
//  Created by Josh on 2025/2/11.
//

#import "InviteListViewController.h"

@interface InviteListViewController ()<UITableViewDelegate, UITableViewDataSource>{
    
    BOOL isExpand;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<FriendModel*> *inviteArray;

@end

@implementation InviteListViewController

+(InviteListViewController*) initInviteListViewControllerWithInvitelList:(NSArray<FriendModel*>*)list{
    
    InviteListViewController *inviteListViewController  = [[InviteListViewController alloc]init];
    inviteListViewController.inviteArray = list;
    return  inviteListViewController;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    isExpand = NO;
    [self initInviteListTableView];


}

-(void)viewWillLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self updateInviteListTableView];
}

#pragma mark - Init


- (void)initInviteListTableView{
    
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    CGFloat x = 0;
    CGFloat y = 0;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(x, y, width, height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[InviteTableViewCell class] forCellReuseIdentifier:@"InviteTableViewCell"];
    self.tableView.delaysContentTouches = NO;
    [self.view addSubview:self.tableView];
}

#pragma mark - Update Frame


- (void)updateInviteListTableView{
    
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    CGFloat x = 0;
    CGFloat y = 0;
    
    self.tableView.frame = CGRectMake(x, y, width, height);
    [self.tableView reloadData];
}

#pragma mark - TableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return InviteTableViewCellHeight;  
}

// 設定 TableView 有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return isExpand?self.inviteArray.count:1;
}

// 設定 Cell 內容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    InviteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InviteTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    FriendModel *friendModel = self.inviteArray[indexPath.row];
    [cell configureWithFriendModel:friendModel];

    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(isExpand){
        isExpand = NO;
        [self.tableView reloadData];
    }else{
        isExpand = YES;
    }
    [self.delegate didExpandTableView:isExpand];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO; // 禁止左滑編輯（刪除）
}

@end
