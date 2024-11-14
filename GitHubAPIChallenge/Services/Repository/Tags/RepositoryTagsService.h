//
//  RepositoryTagsService.h
//  GitHubAPIChallenge
//
//  Created by Giovanni Severo on 12/11/24.
//

#import <Foundation/Foundation.h>
#import "NetworkManager.h"
#import "RepositoryTagsRequest.h"
#import "RepositoryTagsResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface RepositoryTagsService : NSObject

@property (nonatomic, strong) NetworkManager *networkManager;

- (nonnull instancetype) init;

- (nonnull instancetype) initWithNetworkManager:(NetworkManager *)networkManager;

- (void)fetchRepositoryTagsWith:(NSString *)username
                           repo:(NSString *)repo
                     completion:(void(^)(NSArray<Tag *> * _Nullable tags, NSError * _Nullable error))completion;

@end

NS_ASSUME_NONNULL_END
