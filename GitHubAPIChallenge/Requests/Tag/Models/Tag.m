//
//  Tag.m
//  GitHubAPIChallenge
//
//  Created by Giovanni Severo on 09/11/24.
//

#import "Tag.h"

@implementation Tag

- (nonnull instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _name = [dictionary[@"name"] isKindOfClass:[NSString class]] ? [dictionary[@"name"] copy] : @"";
        NSDictionary *commitDict = dictionary[@"commit"];
        _commit = [[Commit alloc] initWithDictionary:commitDict];
    }
    return self;
}

@end
