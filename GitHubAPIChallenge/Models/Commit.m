//
//  Commit.m
//  GitHubAPIChallenge
//
//  Created by Giovanni Severo on 09/11/24.
//

#import "Commit.h"

@implementation Commit

- (nonnull instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _sha = [dictionary[@"sha"] isKindOfClass:[NSString class]] ? [dictionary[@"sha"] copy] : @"";
        _url = [dictionary[@"url"] isKindOfClass:[NSString class]] ? [dictionary[@"url"] copy] : @"";
    }
    return self;
}

@end
