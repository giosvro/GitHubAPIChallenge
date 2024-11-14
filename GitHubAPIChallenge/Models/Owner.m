//
//  Owner.m
//  GitHubAPIChallenge
//
//  Created by Giovanni Severo on 14/11/24.
//

#import "Owner.h"

@implementation Owner

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _login = [dictionary[@"login"] copy];
    }
    return self;
}

@end
