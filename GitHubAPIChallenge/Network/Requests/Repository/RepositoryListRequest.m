//
//  NSObject+RepositoryListRequest.m
//  GitHubAPIChallenge
//
//  Created by Giovanni Severo on 09/11/24.
//

#import "RepositoryListRequest.h"
#import "RepositoryListResponse.h"

@implementation RepositoryListRequest

- (instancetype)initWithUsername:(NSString *)username {
    self = [super init];
    if (self) {
        _username = [username copy];
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
    return [NSString stringWithFormat:@"/users/%@/repos", self.username];
}

- (nullable NSData *)body {
    return nil;
}

- (nullable NSDictionary *)headers {
    return @{ @"Accept": @"application/vnd.github+json" };
}

- (nullable NSDictionary *)queryItems {
    return nil;
}

- (Class<Response>)responseType {
    return [RepositoryListResponse class];
}

@end
