//
//  CustomSegmentedView.h
//  Demo_FriendList
//
//  Created by Josh on 2025/2/11.
//

#import <UIKit/UIKit.h>


@protocol CustomSegmentedViewDelegate<NSObject>
//@optional
@required
- (void) didSelectSegmentAtIndex:(NSInteger)index;
@end



@interface CustomSegmentedView : UIView


@property(nonatomic, weak) id<CustomSegmentedViewDelegate> delegate;

- (void)updatFriendBadge:(NSInteger)friendBadgeCount withChatBadge:(NSInteger)chatBadgeCount;
@end

