//
//  NetworkingManager.m
//  Demo_FriendList
//
//  Created by Josh on 2025/2/10.
//

#import "NetworkingManager.h"
#import "AFHTTPSessionManager.h"


#define defaultTimeout 10


@interface NetworkingManager()

@property (strong, nonatomic) AFHTTPSessionManager *manager;

@end


@implementation NetworkingManager


-(id) init{
    
    self = [super init];
    if(self){
        self = [self initAFHTTPSessionManagerWithTimeOut:defaultTimeout];
    }
    return self;
}

-(id) initAFHTTPSessionManagerWithTimeOut:(NSInteger)timeout{
    
    self = [super init];
    if(self){
        self.manager = [AFHTTPSessionManager manager];
        self.manager.securityPolicy.allowInvalidCertificates = NO;
        [self.manager.securityPolicy setValidatesDomainName:NO];
        self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [self.manager.requestSerializer setTimeoutInterval:timeout];
        
        self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
        [self.manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:
                                                                    @"application/json",
                                                                    @"text/json",
                                                                    @"text/plain",
                                                                    @"text/javascript",
                                                                    @"text/xml", nil]];
    }
    return self;
}

-(void) connectWithUrl:(NSString * )url withHTTPType:(HTTPType) type parameter:(NSDictionary *)parameter success:(void (^)(id responseObject))success fail:(void (^)(NSError *error))fail{
    
    
    switch (type) {
        case GET:
            
            [self getWithUrl:url parameter:parameter success:success fail:fail];

            break;
        case POST:
            [self getWithUrl:url parameter:parameter success:success fail:fail];
            
            break;
        default:
            break;
    }
}

-(void) getWithUrl:(NSString *)url parameter:(NSDictionary *)parameterDic success:(void (^)(id responseObject))success fail:(void (^)(NSError *error))fail{
  
    
    [self.manager GET:url parameters:parameterDic headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *responseDic = (NSDictionary *) responseObject;

        NSLog(@"NetworkingManager URL : %@, Get Response : %@", task.currentRequest.URL.absoluteString, responseDic);
        success(responseDic);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"failure");

        fail(error);
    }];

}
@end
