//
//  RepositoryListService.h
//  GitHubAPIChallenge
//
//  Created by Giovanni Severo on 12/11/24.
//

#import <Foundation/Foundation.h>
#import <GitHubAPIChallenge/Repository.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * The `RepositoryListService` class provides functionality to fetch a list of repositories associated with a specific GitHub username.
 * This service interacts with the GitHub API to retrieve repository information based on the specified username.
 */
@interface RepositoryListService : NSObject

/**
 * Initializes a new instance of `RepositoryListService`.
 *
 * @return A new instance of `RepositoryListService`.
 */
- (instancetype)init;

/**
 * Fetches a list of repositories for a specified GitHub username.
 *
 * @param username The GitHub username for which to fetch the repositories.
 * @param completion A completion handler that is called when the request completes.
 *        - If successful, `repositories` contains an array of `Repository` objects representing the user’s repositories, and `error` is `nil`.
 *        - If an error occurs, `repositories` is `nil`, and `error` contains the error information.
 */
- (void)fetchRepositoriesForUsername:(NSString *)username
                          completion:(void(^)(NSArray<Repository *> * _Nullable repositories, NSError * _Nullable error))completion;

@end

NS_ASSUME_NONNULL_END

