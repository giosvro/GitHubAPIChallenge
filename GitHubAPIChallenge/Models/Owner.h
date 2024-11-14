//
//  Owner.h
//  GitHubAPIChallenge
//
//  Created by Giovanni Severo on 14/11/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Owner : NSObject

@property (nonatomic, readonly, copy) NSString *login;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
