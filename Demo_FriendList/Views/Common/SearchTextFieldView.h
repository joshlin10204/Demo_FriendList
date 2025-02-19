//
//  SearchTextFieldView.h
//  Demo_FriendList
//
//  Created by Josh on 2025/2/13.
//

#import <UIKit/UIKit.h>

@protocol SearchTextFieldViewDelegate<NSObject>
//@optional
@required

- (void) didSearchText:(NSString*)text;
- (void) textFieldDidBeginEditing:(UITextField*)textField;
- (void) textFieldDidEndEditing:(UITextField*)textField;

@end


@interface SearchTextFieldView : UIView
@property(nonatomic, weak) id<SearchTextFieldViewDelegate> delegate;

@end

