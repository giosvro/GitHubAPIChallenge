//
//  NetworkManager.h
//  GitHubAPIChallenge
//
//  Created by Giovanni Severo on 11/11/24.
//

#import <Foundation/Foundation.h>
#import "RequestTypeProtocol.h"
#import "CacheManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface NetworkManager : NSObject

@property (nonatomic, strong) NSURLSession *session;

@property (nonatomic, strong) CacheManager *cacheManager;

- (instancetype)initWithSession:(NSURLSession *)session cacheManager:(CacheManager *)cacheManager;

- (instancetype)init;

- (void)performRequestWithConfig:(id<RequestTypeProtocol>)config
                      completion:(void(^)(id _Nullable parsedObject, NSError * _Nullable error))completion;

@end

NS_ASSUME_NONNULL_END
