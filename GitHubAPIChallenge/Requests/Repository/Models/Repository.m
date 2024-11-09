//
//  Repository.m
//  GitHubAPIChallenge
//
//  Created by Giovanni Severo on 09/11/24.
//

#import "Repository.h"

@implementation Repository

- (nonnull instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _name = [dictionary[@"name"] isKindOfClass:[NSString class]] ? [dictionary[@"name"] copy] : @"";
        _fullName = [dictionary[@"full_name"] isKindOfClass:[NSString class]] ? [dictionary[@"full_name"] copy] : @"";
        _repositoryDescription = [dictionary[@"description"] isKindOfClass:[NSString class]] ? [dictionary[@"description"] copy] : nil;
        _stargazersCount = [dictionary[@"stargazers_count"] isKindOfClass:[NSNumber class]] ? [dictionary[@"stargazers_count"] integerValue] : 0;
        _watchersCount = [dictionary[@"watchers_count"] isKindOfClass:[NSNumber class]] ? [dictionary[@"watchers_count"] integerValue] : 0;
        _language = [dictionary[@"language"] isKindOfClass:[NSString class]] ? [dictionary[@"language"] copy] : nil;
    }
    return self;
}

@end
