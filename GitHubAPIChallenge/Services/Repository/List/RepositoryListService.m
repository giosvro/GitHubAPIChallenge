//
//  RepositoryListService.m
//  GitHubAPIChallenge
//
//  Created by Giovanni Severo on 12/11/24.
//

#import "RepositoryListService.h"

@implementation RepositoryListService

- (instancetype)init {
    NetworkManager *defaultNetworkManager = [[NetworkManager alloc] init];
    return [self initWithNetworkManager:defaultNetworkManager];
}

- (instancetype)initWithNetworkManager:(NetworkManager *)networkManager {
    self = [super init];
    if (self) {
        _networkManager = networkManager;
    }
    
    return self;
}

- (void)fetchRepositoriesForUsername:(nonnull NSString *)username completion:(nonnull void (^)(NSArray<Repository *> * _Nullable __strong, NSError * _Nullable __strong))completion {
    
    RepositoryListRequest *request = [[RepositoryListRequest alloc] initWithUsername:username];
    
    [self.networkManager performRequestWithConfig:request completion:^(id  _Nullable parsedObject, NSError * _Nullable error) {
        if (error) {
            completion(nil, error);
            return;
        }
        
        if (![parsedObject isKindOfClass:[RepositoryListResponse class]]) {
            NSError *typeError = [NSError errorWithDomain:@"RepositoryServiceErrorDomain" code:500 userInfo:@{NSLocalizedDescriptionKey: @"Unexpected response type"}];
            completion(nil, typeError);
            return;
        }

        RepositoryListResponse *response = (RepositoryListResponse *)parsedObject;
        completion(response.repositories, nil);
    }];
}

@end
