//
//  NetworkingManager.h
//  Demo_FriendList
//
//  Created by Josh on 2025/2/10.
//

#import <Foundation/Foundation.h>

typedef enum {
    GET = 0,
    POST
} HTTPType;


@interface NetworkingManager : NSObject



/*
 * Url：Url位址
 * Method：POST 、GET
 * parameter：參數
 */
-(void) connectWithUrl:(NSString * )url withHTTPType:(HTTPType) type parameter:(NSDictionary *)parameter success:(void (^)(id responseObject))success fail:(void (^)(NSError *error))fail;

@end

