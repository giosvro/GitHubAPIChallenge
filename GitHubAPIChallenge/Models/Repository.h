//
//  Repository.h
//  GitHubAPIChallenge
//
//  Created by Giovanni Severo on 09/11/24.
//

#import <Foundation/Foundation.h>
#import <GitHubAPIChallenge/Owner.h>

NS_ASSUME_NONNULL_BEGIN

@interface Repository: NSObject

@property (nonatomic, readonly, copy) NSString *name;
@property (nonatomic, readonly, copy) NSString *fullName;
@property (nonatomic, readonly, copy, nullable) NSString *repositoryDescription;
@property (nonatomic, readonly, assign) NSInteger stargazersCount;
@property (nonatomic, readonly, assign) NSInteger watchersCount;
@property (nonatomic, readonly, copy, nullable) NSString *language;
@property (nonatomic, readonly, strong, nullable) Owner *owner;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
