//
//  RepositoryListService.h
//  GitHubAPIChallenge
//
//  Created by Giovanni Severo on 12/11/24.
//

#import <Foundation/Foundation.h>
#import <GitHubAPIChallenge/Repository.h>

NS_ASSUME_NONNULL_BEGIN

@interface RepositoryListService : NSObject

- (instancetype)init;

- (void)fetchRepositoriesForUsername:(NSString *)username
                          completion:(void(^)(NSArray<Repository *> * _Nullable repositories, NSError * _Nullable error))completion;

@end

NS_ASSUME_NONNULL_END
