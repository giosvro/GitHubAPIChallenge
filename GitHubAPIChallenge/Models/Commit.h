//
//  Commit.h
//  GitHubAPIChallenge
//
//  Created by Giovanni Severo on 09/11/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Commit : NSObject

@property (nonatomic, readonly, copy) NSString *sha;
@property (nonatomic, readonly, copy) NSString *url;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
