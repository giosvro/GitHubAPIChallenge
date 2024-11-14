//
//  RepositoryTagsService.m
//  GitHubAPIChallenge
//
//  Created by Giovanni Severo on 12/11/24.
//

#import "RepositoryTagsService.h"
#import "NetworkManager.h"
#import "RepositoryTagsRequest.h"
#import "RepositoryTagsResponse.h"

@interface RepositoryTagsService ()

@property (nonatomic, strong) NetworkManager *networkManager;

@end

@implementation RepositoryTagsService

- (nonnull instancetype)init {
    self = [super init];
    
    if (self) {
        NetworkManager *networkManager = [[NetworkManager alloc] init];
        _networkManager = networkManager;
    }
    
    return self;
    
}

- (nonnull instancetype)initWithNetworkManager:(nonnull NetworkManager *)networkManager {
    self = [super init];
    if (self) {
        _networkManager = networkManager;
    }
    
    return self;
}

- (void)fetchRepositoryTagsWith:(nonnull NSString *)username repo:(nonnull NSString *)repo completion:(nonnull void (^)(NSArray<Tag *> * _Nullable __strong, NSError * _Nullable __strong))completion {
    
    RepositoryTagsRequest *request = [[RepositoryTagsRequest alloc]
                                      initWithRepositoryName:repo
                                      ownerName:username];
    
    [self.networkManager performRequestWithConfig:request completion:^(id  _Nullable parsedObject, NSError * _Nullable error) {
        if (error) {
            completion(nil, error);
            return;
        }
        
        if (![parsedObject isKindOfClass:[RepositoryTagsResponse class]]) {
            NSError *typeError = [NSError errorWithDomain:@"RepositoryServiceErrorDomain" code:500 userInfo:@{NSLocalizedDescriptionKey: @"Unexpected response type"}];
            completion(nil, typeError);
            return;
        }

        RepositoryTagsResponse *response = (RepositoryTagsResponse *)parsedObject;
        completion(response.tags, nil);
    }];
}

@end
