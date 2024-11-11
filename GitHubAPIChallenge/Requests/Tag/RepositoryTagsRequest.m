//
//  RepositoryTagsRequest.m
//  GitHubAPIChallenge
//
//  Created by Giovanni Severo on 10/11/24.
//

#import "RepositoryTagsRequest.h"
#import "RepositoryTagsResponse.h"

@implementation RepositoryTagsRequest

- (instancetype)initWithRepositoryName:(NSString *)repositoryName ownerName:(NSString *)ownerName {
    self = [super init];
    if (self) {
        _repositoryName = [repositoryName copy];
        _ownerName = [ownerName copy];
    }
    return self;
}

- (NSString *)httpMethod {
    return @"GET";
}

- (NSString *)baseUrl {
    return @"https://api.github.com";
}

- (NSString *)path {
    return [NSString stringWithFormat:@"/repos/%@/%@/tags", self.ownerName, self.repositoryName];
}

- (nullable NSData *)body {
    return nil;
}

- (nullable NSDictionary *)headers {
    return @{@"Accept": @"application/vnd.github.v3+json"};
}

- (nullable NSDictionary *)queryItems {
    return nil;
}

- (Class<Response>)responseType {
    return [RepositoryTagsResponse class];
}

@end
